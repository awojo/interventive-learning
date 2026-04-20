import pytest
from run_assessment import grade_answer

#MR1 test cases
def test_case_invariance():
    base = grade_answer("megan", "megan")
    transformed = grade_answer("MEGAN", "megan")
    assert base == transformed


#MR2 test punctuation
def test_punctuation():
    base = grade_answer("it was megans first day at school", "it was megans first day at school")
    transformed = grade_answer("It was Megan's first day at school.", "it was megan's first day at school")
    assert base == transformed


#MR3 test input extension
def test_input_extension():
    base_answer = "it was megans first day"
    base = grade_answer(base_answer, base_answer)
    extended_input = "it was megans first day at her school"
    extended = grade_answer(extended_input, base_answer)
    assert base == extended


#MR4 test answer order independence
def test_answer_order_independence():
    a1 = grade_answer("dog", "cat;dog")
    a2 = grade_answer("dog", "dog;cat")
    assert a1 == a2


#MR5 test equivalent representations
def test_equivalent_representation():
    assert grade_answer("Cat.", "cat") == grade_answer("cat", "cat")