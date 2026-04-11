import unittest
from progression import progress, get_skill_set, connect


class progressFunction(unittest.TestCase):

    def test_student_pass_advance(self):
        skill = {"code": "4.RSLKID.1", "next": "5.RSLKID.1", "prev": "3.RSLKID.1"}

        self.assertEqual(
            progress(skill, True, connect),
            (get_skill_set(connect, "5.RSLKID.1"), "advance"),
        )

    def test_student_pass_top(self):
        skill = {"code": "5.RSLKID.1", "next": "5.RSLKID.1", "prev": "4.RSLKID.1"}

        self.assertEqual(progress(skill, True, connect), (None, "top"))

    def test_student_fail_remediate(self):
        skill = {"code": "4.RSLKID.1", "next": "5.RSLKID.1", "prev": "3.RSLKID.1"}

        self.assertEqual(
            progress(skill, False, connect),
            (get_skill_set(connect, "3.RSLKID.1"), "remediate"),
        )

    def test_student_fail_remediate_same(self):
        skill = {"code": "3.RSLKID.1", "next": "4.RSLKID.1", "prev": "3.RSLKID.1"}

        self.assertEqual(progress(skill, False, connect), (skill, "remediate_same"))


if __name__ == "__main__":
    unittest.main()
