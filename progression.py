import psycopg2
from datetime import datetime, timezone

# Database connection
DB = {
    "host": "localhost",
    "port": 5433,
    "dbname": "wmu_reading",
    "user": "wmuuser",
    "password": "wmupassword",
}


def connect():
    return psycopg2.connect(**DB)


# Database access
def get_skill_set(conn, code):
    with conn.cursor() as cur:
        cur.execute(
            """
            SELECT skill_set_code, prev_skill_set_code, next_skill_set_code, description
            FROM skill_sets WHERE skill_set_code = %s
        """,
            (code,),
        )
        row = cur.fetchone()
        if not row:
            return None
        return {"code": row[0], "prev": row[1], "next": row[2], "desc": row[3]}


def get_module(conn, skill_code):
    with conn.cursor() as cur:
        cur.execute(
            """
            SELECT m.name, COUNT(ms.module_statements_id) as stmt_count
            FROM modules m
            LEFT JOIN module_statements ms ON ms.module_id = m.id
            WHERE m.skill_set_code = %s
            GROUP BY m.name
        """,
            (skill_code,),
        )
        return cur.fetchone()


def get_assessment(conn, skill_code):
    with conn.cursor() as cur:
        cur.execute(
            """
            SELECT a.name, COUNT(aq.assessment_questions_id) as q_count
            FROM assessments a
            LEFT JOIN assessment_questions aq ON aq.assessment_id = a.id
            WHERE a.skill_set_code = %s
            GROUP BY a.name
        """,
            (skill_code,),
        )
        return cur.fetchone()


def record_result(conn, student_name, skill_code, score, passed):
    with conn.cursor() as cur:
        cur.execute(
            """
            INSERT INTO assignment_results
            (student_id, assignment_code, skill_set_code, assignment_type, score, proficient, completed_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """,
            (
                hash(student_name) % 10000,
                f"{skill_code}.A",
                skill_code,
                "ASSESSMENT",
                score,
                passed,
                datetime.now(timezone.utc),
            ),
        )
        conn.commit()


def get_student_history(conn, student_name):
    with conn.cursor() as cur:
        cur.execute(
            """
            SELECT skill_set_code, score, proficient, completed_at
            FROM assignment_results
            WHERE student_id = %s
            ORDER BY completed_at DESC
            LIMIT 10
        """,
            (hash(student_name) % 10000,),
        )
        return cur.fetchall()


# Progression logic
def progress(skill, passed, conn):
    if passed:
        next_code = skill["next"]
        # Terminal node (at highest level)
        if next_code == skill["code"]:
            return None, "top"
        return get_skill_set(conn, next_code), "advance"
    else:
        prev_code = skill["prev"]
        # Already at the bottom
        if prev_code == skill["code"]:
            return skill, "remediate_same"
        return get_skill_set(conn, prev_code), "remediate"


# Display
def print_divider():
    print("\n" + "=" * 60)


def print_skill(skill, conn):
    module = get_module(conn, skill["code"])
    assessment = get_assessment(conn, skill["code"])
    grade = skill["code"].split(".")[0]
    grade_label = "Kindergarten" if grade == "K" else f"Grade {grade}"

    print(f"\n  Skill Set : {skill['code']}")
    print(f"  Grade     : {grade_label}")
    print(
        f"  Standard  : {skill['desc'][:80]}{'...' if len(skill['desc']) > 80 else ''}"
    )
    if module:
        print(f"  Module    : {module[0]} ({module[1]} statements)")
    else:
        print(f"  Module    : Not yet available")
    if assessment:
        print(f"  Assessment: {assessment[0]} ({assessment[1]} questions)")
    else:
        print(f"  Assessment: Not yet available")


def print_history(conn, student_name):
    history = get_student_history(conn, student_name)
    if not history:
        print("  No history yet.")
        return
    print(f"\n  {'Skill Set':<20} {'Score':>6}  {'Result':<12} {'Time'}")
    print(f"  {'-'*20} {'-'*6}  {'-'*12} {'-'*20}")
    for skill_code, score, proficient, ts in history:
        result = "PASSED" if proficient else "FAILED"
        print(
            f"  {skill_code:<20} {score*100:>5.0f}%  {result:<12} {ts.strftime('%H:%M:%S')}"
        )


# Main demo
def run_demo():
    conn = connect()

    print_divider()
    print("  INTERVENTIVE LEARNING DEMO")
    print("  (Type scores to simulate student performance)")
    print_divider()

    student_name = input("\nEnter student name: ")
    start_code = input("Enter starting skill set (e.g., 4.RSLKID.1): ")

    current = get_skill_set(conn, start_code)

    if not current:
        print("Invalid skill set code.")
        return

    while True:
        print_divider()
        print(f"\n  STUDENT: {student_name}")
        print(f"  Current Level:")

        print_skill(current, conn)

        # User input score
        try:
            score_input = input("\nEnter score (0–100) or 'q' to quit: ")

            if score_input.lower() == "q":
                break

            score = min(float(score_input), 100) / 100

        except:
            print("Invalid input. Try again.")
            continue

        # Determine pass/fail
        passed = score >= 0.70

        print(f"\n  Result: {'PASSED' if passed else 'FAILED'}")

        # Record result
        record_result(conn, student_name, current["code"], score, passed)

        # Progression
        next_skill, action = progress(current, passed, conn)

        if action == "advance":
            print(f"\n  ADVANCING → {next_skill['code']}")
            current = next_skill

        elif action == "top":
            print(f"\n  MAX LEVEL REACHED ({current['code']})")
            break

        elif action == "remediate":
            print(f"\n  DROPPING BACK → {next_skill['code']}")
            current = next_skill

        elif action == "remediate_same":
            print(f"\n  STAYING AT SAME LEVEL")

    # Show history
    print_divider()
    print(f"\n  FINAL HISTORY FOR {student_name}")
    print_history(conn, student_name)

    conn.close()


if __name__ == "__main__":
    try:
        run_demo()
    except psycopg2.OperationalError as e:
        print(f"\n  ERROR: Could not connect to the database.")
        print(f"  Make sure Docker is running and wmu_reading_db is up.")
        print(f"  Run: docker ps")
        print(f"\n  Details: {e}")
