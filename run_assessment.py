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


def parse_question(raw):
    """
    Strip [MCQ:] and [TF] tags for clean terminal display.
    Returns dict with type, text, options.
    """
    q = raw.strip()

    if q.startswith("[TF]"):
        return {
            "type": "tf",
            "text": q.replace("[TF]", "").strip(),
            "options": ["T / True", "F / False"]
        }

    mcq = re.search(r'\[MCQ:\s*(.*?)\]', q)
    if mcq:
        text = q[:q.index("[MCQ:")].strip()
        options = [o.strip() for o in mcq.group(1).split("|")]
        return {"type": "mcq", "text": text, "options": options}

    return {"type": "open", "text": q, "options": []}


def grade_answer(student_answer, correct_answers):
    """
    Handles:
    - MCQ: answer stored as single letter 'A', 'B', 'C', 'D'
    - TF: answer stored as 'true | T | t' or 'false | F | f' (pipe-separated)
    - Open-ended: answer stored as semicolon-separated key phrases
    """
    def normalize(text):
        text = text.lower()
        text = re.sub(r'[\"\'.,;!?()]+', '', text)
        return text.strip()

    student = normalize(student_answer)
    if not student:
        return False

    # Split on both ; (open-ended) and | (TF format)
    raw_options = re.split(r'[;|]', correct_answers)
    options = [opt.strip() for opt in raw_options if opt.strip()]

    for option in options:
        norm_option = normalize(option)
        if not norm_option:
            continue
        # Exact match (handles single letters A/B/C/D and T/F)
        if norm_option == student:
            return True
        # Student answer contains the option phrase (open-ended)
        if len(norm_option) > 3 and norm_option in student:
            return True

    return False


def run_assessment(conn, skill_code):
    questions = get_questions(conn, skill_code)

    if not questions:
        print("\n  No assessment available for this skill set.")
        print("  Skipping")
        return None

    correct = 0
    total = len(questions)

    print("\n" + "-" * 60)
    print("  ASSESSMENT")
    print("-" * 60)

    for i, (raw_question, answer) in enumerate(questions, 1):
        parsed = parse_question(raw_question)

        print(f"\n  Q{i}: {parsed['text']}")
        if parsed['options']:
            for opt in parsed['options']:
                print(f"       {opt}")

        while True:
            student_input = input("  Your answer: ").strip()
            if student_input:
                break
            print("  Please enter an answer.")

        if grade_answer(student_input, answer):
            print("  Correct")
            correct += 1
        else:
            print("  Incorrect")

    score = correct / total
    print(f"\n  Score: {score * 100:.0f}% ({correct}/{total})")

    return score
