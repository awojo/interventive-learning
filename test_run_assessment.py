import pytest
import re
import psycopg2
from datetime import datetime, timezone
from run_assessment import run_assessment

def test_run_assessment_no_questions(monkeypatch):
    def fake_get_questions(conn, skill_code):
        return []
    monkeypatch.setattr("run_assessment.get_questions", fake_get_questions)
    result = run_assessment(None, "A")
    assert result is None

def test_run_assessment_all_correct(monkeypatch):
    def fake_get_questions(conn, skill_code):
        return [("Q1", "apple"), ("Q2", "banana")]
    def fake_input(prompt):
        answers = {
            "  Your answer: ": "apple",
        }
        return fake_input.answers.pop(0)
    fake_input.answers = ["apple", "banana"]
    monkeypatch.setattr("run_assessment.get_questions", fake_get_questions)
    monkeypatch.setattr("builtins.input", fake_input)
    result = run_assessment(None, "A")

def test_run_assessment_wrong_answers(monkeypatch):
    def fake_get_questions(conn, skill_code):
        return [("Q1", "apple")]
    def fake_input(prompt):
        return "wrong"
    monkeypatch.setattr("run_assessment.get_questions", fake_get_questions)
    monkeypatch.setattr("builtins.input", fake_input)
    result = run_assessment(None, "A")
    assert result == 0.0