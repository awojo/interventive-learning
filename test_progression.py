import pytest
import re
from progression import progress
from progression import drop_back
from progression import record_result
from progression import get_student_history
from progression import get_skill_set
import psycopg2
from datetime import datetime, timezone

#tests requirments 1 and 2
def test_progress_next_same():
    skill = {"code": "K.RSITKID.1", "next": "K.RSITKID.1"}
    result = progress(skill, True, None)
    assert result == (None, "top")

#tests requirements 1 and 3
def test_progress_passed_progression(monkeypatch):
    skill = {"code": "K.RSITKID.1", "next": "K.RSITKID.2"}
    def fake_get(conn, code):
        return {"code": "K.RSITKID.2"}
    monkeypatch.setattr("progression.get_skill_set", fake_get)
    result = progress(skill, True, None)
    assert result == ({"code": "K.RSITKID.2"}, "advance")

#tests requirements 4 and 5
def test_progress_drop_no_prev(monkeypatch):
    skill = {"code": "K.RSITKID.1", "next": "K.RSITKID.2"}
    def fake_drop(conn, skill, steps):
        return {"code": "K.RSITKID.1"}
    monkeypatch.setattr("progression.drop_back", fake_drop)
    result = progress(skill, False, None)
    assert result == (skill, "remediate_same")

#tests requirements 4 and 6
def test_progress_drop_back_prev(monkeypatch):
    skill = {"code": "K.RSITKID.1", "next": "K.RSITKID.2"}
    def fake_drop(conn, skill, steps):
        return {"code": "K.RSITKID.3"}
    monkeypatch.setattr("progression.drop_back", fake_drop)
    result = progress(skill, False, None)
    assert result == ({"code": "K.RSITKID.3"}, "remediate")

def test_drop_back_no_prev(monkeypatch):
    skill = {"code": "K.RSITKID.1", "prev": None}
    result = drop_back(None, skill)
    assert result == skill

def test_drop_back_prev_no_data(monkeypatch):
    skill = {"code": "K.RSITKID.1", "prev": "K.RSITKID.2"}
    monkeypatch.setattr("progression.get_skill_set", lambda c, x: None)
    result = drop_back(None, skill)
    assert result == skill

def test_drop_back_prev_exists(monkeypatch):
    skill = {"code": "K.RSITKID.1", "prev": "K.RSITKID.2"}
    def fake_get(conn, code):
        return {"code": "K.RSITKID.2", "prev": None}
    monkeypatch.setattr("progression.get_skill_set", fake_get)
    result = drop_back(None, skill)
    assert result["code"] == "K.RSITKID.2"


def test_record_result_pass(monkeypatch):
    class FakeCursor:
        def execute(self, *args): pass
        def __enter__(self): return self
        def __exit__(self, *a): pass

    class FakeConn:
        def cursor(self): return FakeCursor()
        def commit(self): pass

    conn = FakeConn()
    record_result(conn, "John", "A", 0.9, True)
    assert True

def test_record_result_fail(monkeypatch):
    class FakeCursor:
        def execute(self, *args): pass
        def __enter__(self): return self
        def __exit__(self, *a): pass

    class FakeConn:
        def cursor(self): return FakeCursor()
        def commit(self): pass

    conn = FakeConn()
    record_result(conn, "Smith", "A", 0.5, False)
    assert True

def test_get_student_history_nonexistent(monkeypatch):
    class FakeCursor:
        def fetchall(self): return []
        def execute(self, *args): pass
        def __enter__(self): return self
        def __exit__(self, *a): pass

    class FakeConn:
        def cursor(self): return FakeCursor()

    result = get_student_history(FakeConn(), "John")
    assert result == []

def test_get_student_history_existent(monkeypatch):
    class FakeCursor:
        def fetchall(self): return [("A", 0.9, True, "time")]
        def execute(self, *args): pass
        def __enter__(self): return self
        def __exit__(self, *a): pass

    class FakeConn:
        def cursor(self): return FakeCursor()

    result = get_student_history(FakeConn(), "Smith")
    assert len(result) == 1

def test_skill_set_exists(monkeypatch):
    class FakeCursor:
        def fetchone(self): return ("A", "B", "C", "desc")
        def execute(self, *args): pass
        def __enter__(self): return self
        def __exit__(self, *a): pass

    class FakeConn:
        def cursor(self): return FakeCursor()

    result = get_skill_set(FakeConn(), "A")
    assert result["code"] == "A"

def test_skill_set_nonexistent(monkeypatch):
    class FakeCursor:
        def fetchone(self): return None
        def execute(self, *args): pass
        def __enter__(self): return self
        def __exit__(self, *a): pass

    class FakeConn:
        def cursor(self): return FakeCursor()

    result = get_skill_set(FakeConn(), "X")
    assert result is None