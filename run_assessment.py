import re

def get_questions(conn, skill_code):
    with conn.cursor() as cur:
        cur.execute("""
            SELECT aq.question, aq.answer
            FROM assessment_questions aq
            JOIN assessments a ON aq.assessment_id = a.id
            WHERE a.skill_set_code = %s
            ORDER BY aq.sequence_index
        """, (skill_code,))
        return cur.fetchall()

def grade_answer(student_answer, correct_answers):
    def normalize(text):
        text = text.lower()
        text = re.sub(r"[\"\'.,;!?()]+", "", text)
        return text.strip()

    student = normalize(student_answer)

    if not student:
        return False

    options = [opt.strip() for opt in correct_answers.split(";")]

    for option in options:
        key_phrases = [normalize(p) for p in option.split(",") if len(p.strip()) > 4]
        for phrase in key_phrases:
            if phrase and phrase in student:
                return True
        if normalize(option) in student:
            return True

    return False

def run_assessment(conn, skill_code):
    questions = get_questions(conn, skill_code)

    if not questions:
        print("\n  No assessment available for this skill set.")
        print("  Skipping")
        return None  # no assessment

    correct = 0
    total = len(questions)

    print("\n" + "-" * 60)
    print("  ASSESSMENT")
    print("-" * 60)

    for i, (question, answer) in enumerate(questions, 1):
        print(f"\n  Q{i}: {question}")

        while True:
            student_input = input("  Your answer: ").strip()
            if student_input:
                break
            print("  Please enter an answer.")

        if grade_answer(student_input, answer):
            print("Correct")
            correct += 1
        else:
            print("Incorrect")

    score = correct / total
    print(f"\n  Score: {score*100:.0f}% ({correct}/{total})")

    return score
