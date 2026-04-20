from flask import Flask, render_template, request, session, redirect, url_for
import psycopg2
import re
from datetime import datetime, timezone
from run_assessment import grade_answer  # ← import the working version

app = Flask(__name__)
app.secret_key = "ivl-demo"

DB = {
    "host": "localhost",
    "port": 5433,
    "dbname": "wmu_reading",
    "user": "wmuuser",
    "password": "wmupassword",
}

def connect():
    return psycopg2.connect(**DB)

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

def get_passage(conn, skill_code):
    with conn.cursor() as cur:
        cur.execute("""
            SELECT ms.statement
            FROM module_statements ms
            JOIN modules m ON ms.module_id = m.id
            WHERE m.skill_set_code = %s
            LIMIT 1
        """, (skill_code,))
        row = cur.fetchone()
        return row[0] if row else None

def has_module(conn, skill_code):
    with conn.cursor() as cur:
        cur.execute("SELECT 1 FROM modules WHERE skill_set_code = %s LIMIT 1", (skill_code,))
        return cur.fetchone() is not None

def get_questions(conn, skill_code):
    with conn.cursor() as cur:
        cur.execute("""
            SELECT aq.assessment_questions_id, aq.question, aq.answer
            FROM assessment_questions aq
            JOIN assessments a ON aq.assessment_id = a.id
            WHERE a.skill_set_code = %s
        """, (skill_code,))
        return cur.fetchall()

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
            datetime.now(timezone.utc),
        ))
        conn.commit()

def grade_label(code):
    g = code.split(".")[0]
    return "Kindergarten" if g == "K" else f"Grade {g}"

def parse_question(raw):
    q = raw.strip()

    if q.startswith("[TF]"):
        return {"type": "tf", "text": q.replace("[TF]", "").strip(), "options": ["True", "False"]}

    mcq = re.search(r'\[MCQ:\s*(.*?)\]', q)
    if mcq:
        text = q[:q.index("[MCQ:")].strip()
        options = [o.strip() for o in mcq.group(1).split("|")]
        return {"type": "mcq", "text": text, "options": options}

    return {"type": "open", "text": q, "options": []}


@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        session["student"] = request.form["name"]
        session["code"] = request.form["skill_code"]
        return redirect("/module")
    return render_template("index.html")

@app.route("/module")
def module():
    conn = connect()
    skill = get_skill_set(conn, session["code"])
    exists = has_module(conn, skill["code"])
    conn.close()

    return render_template("module.html",
        student=session["student"],
        skill=skill,
        module_exists=exists,
        grade=grade_label(skill["code"])
    )

@app.route("/assessment")
def assessment():
    conn = connect()
    code = session["code"]

    raw_qs = get_questions(conn, code)
    questions = []

    for qid, text, ans in raw_qs:
        parsed = parse_question(text)
        parsed["id"] = qid
        parsed["answer"] = ans
        questions.append(parsed)

    session["answers"] = [(q["id"], q["answer"]) for q in questions]

    passage = get_passage(conn, code)
    conn.close()

    return render_template("assessment.html",
        student=session["student"],
        grade=grade_label(code),
        questions=questions,
        passage=passage
    )

@app.route("/submit", methods=["POST"])
def submit():
    conn = connect()
    code = session["code"]

    correct = 0
    total = len(session["answers"])

    for qid, ans in session["answers"]:
        student_ans = request.form.get(f"q_{qid}", "")
        if grade_answer(student_ans, ans):  # ← now uses the imported version
            correct += 1

    score = correct / total if total else 1.0
    passed = score >= 0.70

    record_result(conn, session["student"], code, score, passed)

    skill = get_skill_set(conn, code)
    next_skill, action = progress(skill, passed, conn)

    conn.close()

    session["correct"] = correct
    session["total"] = total
    session["passed"] = passed
    session["action"] = action

    if next_skill:
        session["next_code"] = next_skill["code"]
        session["next_grade"] = grade_label(next_skill["code"])
    else:
        session["next_code"] = None
        session["next_grade"] = None

    return redirect("/result")

@app.route("/result")
def result():
    return render_template("result.html",
        student=session["student"],
        code=session["code"],
        grade=grade_label(session["code"]),
        correct=session["correct"],
        total=session["total"],
        passed=session["passed"],
        next_code=session.get("next_code"),
        next_grade=session.get("next_grade"),
    )

@app.route("/next")
def next_level():
    if session.get("next_code"):
        session["code"] = session["next_code"]
        return redirect("/module")
    return redirect("/")

@app.route("/manual_grade", methods=["POST"])
def manual():
    conn = connect()

    passed = request.form["grade"] == "pass"
    score = 1.0 if passed else 0.0

    record_result(conn, session["student"], session["code"], score, passed)

    skill = get_skill_set(conn, session["code"])
    next_skill, action = progress(skill, passed, conn)

    conn.close()

    session["correct"] = 1 if passed else 0
    session["total"] = 1
    session["passed"] = passed

    if next_skill:
        session["next_code"] = next_skill["code"]
        session["next_grade"] = grade_label(next_skill["code"])
    else:
        session["next_code"] = None
        session["next_grade"] = None

    return redirect("/result")

@app.route("/restart")
def restart():
    session.clear()
    return redirect("/")

if __name__ == "__main__":
    app.run(debug=True, port=5050)
    