import psycopg2
from datetime import datetime, timezone
from run_assessment import run_assessment

# Database connection
DB = {
    "host":     "localhost",
    "port":     5433,
    "dbname":   "wmu_reading",
    "user":     "wmuuser",
    "password": "wmupassword"
}

def connect():
    return psycopg2.connect(**DB)

# Database helpers
def get_skill_set(conn, code):
    with conn.cursor() as cur:
        cur.execute("""
            SELECT skill_set_code, prev_skill_set_code, next_skill_set_code, description
            FROM skill_sets WHERE skill_set_code = %s
        """, (code,))
        row = cur.fetchone()
        if not row:
            return None
        return {"code": row[0], "prev": row[1], "next": row[2], "desc": row[3]}

def get_module(conn, skill_code):
    with conn.cursor() as cur:
        cur.execute("""
            SELECT m.name, COUNT(ms.module_statements_id)
            FROM modules m
            LEFT JOIN module_statements ms ON ms.module_id = m.id
            WHERE m.skill_set_code = %s
            GROUP BY m.name
        """, (skill_code,))
        return cur.fetchone()

def get_assessment_info(conn, skill_code):
    with conn.cursor() as cur:
        cur.execute("""
            SELECT a.name, COUNT(aq.assessment_questions_id)
            FROM assessments a
            LEFT JOIN assessment_questions aq ON aq.assessment_id = a.id
            WHERE a.skill_set_code = %s
            GROUP BY a.name
        """, (skill_code,))
        return cur.fetchone()

def record_result(conn, student_name, skill_code, score, passed):
    with conn.cursor() as cur:
        cur.execute("""
            INSERT INTO assignment_results
            (student_id, assignment_code, skill_set_code, assignment_type, score, proficient, completed_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """, (
            hash(student_name) % 10000,
            f"{skill_code}.A",
            skill_code,
            "ASSESSMENT",
            score,
            passed,
            datetime.now(timezone.utc)
        ))
        conn.commit()

def get_student_history(conn, student_name):
    with conn.cursor() as cur:
        cur.execute("""
            SELECT skill_set_code, score, proficient, completed_at
            FROM assignment_results
            WHERE student_id = %s
            ORDER BY completed_at DESC
            LIMIT 10
        """, (hash(student_name) % 10000,))
        return cur.fetchall()

# Progression logic — drop back 2 prereq levels on fail
def drop_back(conn, skill, steps=2):
    current = skill
    for _ in range(steps):
        prev_code = current["prev"]
        if not prev_code or prev_code == current["code"]:
            break
        prev_skill = get_skill_set(conn, prev_code)
        if not prev_skill:
            break
        current = prev_skill
    return current

def progress(skill, passed, conn):
    if passed:
        next_code = skill["next"]
        if next_code == skill["code"]:
            return None, "top"
        return get_skill_set(conn, next_code), "advance"
    else:
        dropped = drop_back(conn, skill, steps=2)
        if dropped["code"] == skill["code"]:
            return skill, "remediate_same"
        return dropped, "remediate"

# Display helpers
def print_divider():
    print("\n" + "=" * 60)

def grade_label(code):
    grade = code.split(".")[0]
    return "Kindergarten" if grade == "K" else f"Grade {grade}"

def print_skill(skill, conn):
    module = get_module(conn, skill["code"])
    assessment = get_assessment_info(conn, skill["code"])

    print(f"\n  Skill Set : {skill['code']}")
    print(f"  Grade     : {grade_label(skill['code'])}")
    print(f"  Standard  : {skill['desc'][:80]}{'...' if len(skill['desc']) > 80 else ''}")
    print(f"  Module    : {module[0] + ' (' + str(module[1]) + ' statements)' if module else 'Not yet available'}")
    print(f"  Assessment: {assessment[0] + ' (' + str(assessment[1]) + ' questions)' if assessment else 'Not yet available'}")

def print_history(conn, student_name):
    history = get_student_history(conn, student_name)
    if not history:
        print("  No history yet.")
        return
    print(f"\n  {'Skill Set':<20} {'Score':>6}  {'Result':<8} {'Time'}")
    print(f"  {'-'*20} {'-'*6}  {'-'*8} {'-'*10}")
    for skill_code, score, proficient, ts in history:
        result = "PASSED" if proficient else "FAILED"
        print(f"  {skill_code:<20} {score*100:>5.0f}%  {result:<8} {ts.strftime('%H:%M:%S')}")

# Main loop
def run_demo():
    conn = connect()

    print_divider()
    print("INTERVENTIVE LEARNING READING")
    print_divider()

    student_name = input("\n  Enter student name: ").strip()
    start_code   = input("  Enter starting skill set (e.g., 4.RSLKID.1): ").strip()

    current = get_skill_set(conn, start_code)
    if not current:
        print(f"\n  '{start_code}' is not a valid skill set code.")
        conn.close()
        return

    while True:
        print_divider()
        print(f"\n  STUDENT : {student_name}")
        print(f"  LEVEL   : {current['code']} — {grade_label(current['code'])}")
        print_skill(current, conn)

        # Run the real assessment
        score = run_assessment(conn, current["code"])

        # If no assessment available
        if score is None:
            print("\n  No assessment for this level yet.")
            try:
                manual = input("  Enter score manually (0-100) or 'q' to quit: ").strip()
                if manual.lower() == 'q':
                    break
                score = min(float(manual), 100) / 100
            except:
                print("  Invalid input.")
                continue

        passed = score >= 0.70

        print(f"\n  {'─' * 55}")
        print(f"  Final Score : {score*100:.0f}%")
        print(f"  Result      : {'PASSED' if passed else 'FAILED'}")

        # Record in database
        record_result(conn, student_name, current["code"], score, passed)

        # Determine next step
        next_skill, action = progress(current, passed, conn)

        if action == "advance":
            print(f"\n  ADVANCING  →  {next_skill['code']} ({grade_label(next_skill['code'])})")
            current = next_skill

        elif action == "top":
            print(f"\n  MAX LEVEL REACHED — {current['code']}")
            break

        elif action == "remediate":
            print(f"\n  DROPPING BACK  →  {next_skill['code']} ({grade_label(next_skill['code'])})")
            current = next_skill

        elif action == "remediate_same":
            print(f"\n  STAYING AT SAME LEVEL: {current['code']}")

        cont = input("\n  Continue? (press Enter to continue, 'q' to quit): ").strip()
        if cont.lower() == 'q':
            break

    print_divider()
    print(f"\n  SESSION COMPLETE — {student_name}")
    print_history(conn, student_name)
    print_divider()

    conn.close()

if __name__ == "__main__":
    try:
        run_demo()
    except psycopg2.OperationalError as e:
        print(f"\n  ERROR: Cannot connect to database.")
        print(f"  Make sure Docker is running: docker ps")
        print(f"\n  Details: {e}")
