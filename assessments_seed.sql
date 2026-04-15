BEGIN;

-- KINDERGARTEN
INSERT INTO assessments (name, skill_set_code, item_code, sequence_index, passing_score)
VALUES ('Kindergarten Reading Assessment', 'K.RSLKID.1', 'K.RSLKID.1.A', 1, 0.7)
ON CONFLICT (item_code) DO UPDATE
SET name = EXCLUDED.name;

WITH a AS (
    SELECT id FROM assessments WHERE item_code = 'K.RSLKID.1.A'
)
DELETE FROM assessment_questions
WHERE assessment_id = (SELECT id FROM a);

INSERT INTO assessment_questions (
    assessment_id,
    question,
    answer,
    sequence_index
)
VALUES
((SELECT id FROM assessments WHERE item_code='K.RSLKID.1.A'),
'Who did Megan meet? [MCQ: A) Heather | B) Max | C) Miss Bye | D) Happy]', 'A', 1),
((SELECT id FROM assessments WHERE item_code='K.RSLKID.1.A'),
'[TF] Heather has a puppy named Max.', 'T', 2),
((SELECT id FROM assessments WHERE item_code='K.RSLKID.1.A'),
'Where did Megan sit? [MCQ: A) At school | B) On bus | C) At home | D) Park]', 'A', 3),
((SELECT id FROM assessments WHERE item_code='K.RSLKID.1.A'),
'[TF] Did Megan have a good day?', 'F', 4),
((SELECT id FROM assessments WHERE item_code='K.RSLKID.1.A'),
'What did Megan say? [MCQ: A) I am tired | B) I made a new friend! | C) I lost my puppy | D) I am sad]', 'B', 5);

-- GRADE 1
INSERT INTO assessments (name, skill_set_code, item_code, sequence_index, passing_score)
VALUES ('Grade 1 Reading Assessment', '1.RSLKID.1', '1.RSLKID.1.A', 2, 0.7)
ON CONFLICT (item_code) DO UPDATE
SET name = EXCLUDED.name;

WITH a AS (
    SELECT id FROM assessments WHERE item_code = '1.RSLKID.1.A'
)
DELETE FROM assessment_questions
WHERE assessment_id = (SELECT id FROM a);

INSERT INTO assessment_questions (
    assessment_id,
    question,
    answer,
    sequence_index
)
VALUES
((SELECT id FROM assessments WHERE item_code='1.RSLKID.1.A'),
'Who did Megan meet on the bus? [MCQ: A) Heather | B) Max | C) Mom | D) Miss Bye]', 'A', 1),
((SELECT id FROM assessments WHERE item_code='1.RSLKID.1.A'),
'[TF] Heather has a puppy named Max.', 'T', 2),
((SELECT id FROM assessments WHERE item_code='1.RSLKID.1.A'),
'Where did they sit together? [MCQ: A) Bus | B) School | C) Home | D) Park]', 'B', 3),
((SELECT id FROM assessments WHERE item_code='1.RSLKID.1.A'),
'[TF] Megan did not have a good day.', 'F', 4),
((SELECT id FROM assessments WHERE item_code='1.RSLKID.1.A'),
'What did Megan say at the end? [MCQ: A) I am lost | B) I made a new friend! | C) I am tired | D) I cried]', 'B', 5);

-- GRADE 2
INSERT INTO assessments (name, skill_set_code, item_code, sequence_index, passing_score)
VALUES ('Grade 2 Reading Assessment', '2.RSLKID.1', '2.RSLKID.1.A', 3, 0.7)
ON CONFLICT (item_code) DO UPDATE
SET name = EXCLUDED.name;

WITH a AS (
    SELECT id FROM assessments WHERE item_code = '2.RSLKID.1.A'
)
DELETE FROM assessment_questions
WHERE assessment_id = (SELECT id FROM a);

INSERT INTO assessment_questions (
    assessment_id,
    question,
    answer,
    sequence_index
)
VALUES
((SELECT id FROM assessments WHERE item_code='2.RSLKID.1.A'),
'Who did Megan meet on the bus? [MCQ: A) Heather | B) Teacher | C) Mom | D) Happy]', 'A', 1),
((SELECT id FROM assessments WHERE item_code='2.RSLKID.1.A'),
'What is Heather’s puppy’s name? [MCQ: A) Max | B) Happy | C) Buddy | D) Spot]', 'B', 2),
((SELECT id FROM assessments WHERE item_code='2.RSLKID.1.A'),
'[TF] Megan and Heather sat together.', 'T', 3),
((SELECT id FROM assessments WHERE item_code='2.RSLKID.1.A'),
'Where did they eat? [MCQ: A) Bus | B) At lunch | C) Home | D) Playground]', 'B', 4),
((SELECT id FROM assessments WHERE item_code='2.RSLKID.1.A'),
'[TF] Megan said her day was not good.', 'F', 5);

-- GRADE 3
INSERT INTO assessments (name, skill_set_code, item_code, sequence_index, passing_score)
VALUES ('Grade 3 Reading Assessment', '3.RSLKID.1', '3.RSLKID.1.A', 4, 0.7)
ON CONFLICT (item_code) DO UPDATE
SET name = EXCLUDED.name;

WITH a AS (
    SELECT id FROM assessments WHERE item_code = '3.RSLKID.1.A'
)
DELETE FROM assessment_questions
WHERE assessment_id = (SELECT id FROM a);

INSERT INTO assessment_questions (
    assessment_id,
    question,
    answer,
    sequence_index
)
VALUES
((SELECT id FROM assessments WHERE item_code='3.RSLKID.1.A'),
'Who did Megan meet on the bus? [MCQ: A) Heather | B) Miss Bye | C) Mom | D) Happy]', 'A', 1),
((SELECT id FROM assessments WHERE item_code='3.RSLKID.1.A'),
'[TF] Megan and Heather both have puppies.', 'T', 2),
((SELECT id FROM assessments WHERE item_code='3.RSLKID.1.A'),
'What is Megan’s puppy’s name? [MCQ: A) Max | B) Buddy | C) Happy | D) Spot]', 'C', 3),
((SELECT id FROM assessments WHERE item_code='3.RSLKID.1.A'),
'[TF] Megan did not like her teacher.', 'F', 4),
((SELECT id FROM assessments WHERE item_code='3.RSLKID.1.A'),
'What did Megan say? [MCQ: A) It was boring | B) It was scary | C) It was the best first day ever! | D) I am sad]', 'C', 5);

-- GRADE 4
INSERT INTO assessments (name, skill_set_code, item_code, sequence_index, passing_score)
VALUES ('Grade 4 Inference Assessment', '4.RSLKID.1', '4.RSLKID.1.A', 5, 0.7)
ON CONFLICT (item_code) DO UPDATE
SET name = EXCLUDED.name;

WITH a AS (
    SELECT id FROM assessments WHERE item_code = '4.RSLKID.1.A'
)
DELETE FROM assessment_questions
WHERE assessment_id = (SELECT id FROM a);

INSERT INTO assessment_questions (
    assessment_id,
    question,
    answer,
    sequence_index
)
VALUES
((SELECT id FROM assessments WHERE item_code='4.RSLKID.1.A'),
'Which detail shows Megan was nervous? [MCQ: A) Smiling | B) Butterflies in her stomach | C) Singing | D) Laughing]', 'B', 1),
((SELECT id FROM assessments WHERE item_code='4.RSLKID.1.A'),
'[TF] Megan and Heather met for the first time at school.', 'F', 2),
((SELECT id FROM assessments WHERE item_code='4.RSLKID.1.A'),
'What can you infer? [MCQ: A) They hate each other | B) They become friends quickly | C) They ignore each other | D) They fight]', 'B', 3),
((SELECT id FROM assessments WHERE item_code='4.RSLKID.1.A'),
'[TF] Megan enjoyed her first day.', 'T', 4),
((SELECT id FROM assessments WHERE item_code='4.RSLKID.1.A'),
'Which detail shows happiness? [MCQ: A) Crying | B) Running away | C) She smiled all the way | D) Sleeping]', 'C', 5);

-- GRADE 5
INSERT INTO assessments (name, skill_set_code, item_code, sequence_index, passing_score)
VALUES ('Grade 5 Quote & Inference Assessment', '5.RSLKID.1', '5.RSLKID.1.A', 6, 0.7)
ON CONFLICT (item_code) DO UPDATE
SET name = EXCLUDED.name;

WITH a AS (
    SELECT id FROM assessments WHERE item_code = '5.RSLKID.1.A'
)
DELETE FROM assessment_questions
WHERE assessment_id = (SELECT id FROM a);

INSERT INTO assessment_questions (
    assessment_id,
    question,
    answer,
    sequence_index
)
VALUES
((SELECT id FROM assessments WHERE item_code='5.RSLKID.1.A'),
'Which quote shows nervous + excited? [MCQ: A) Bus was loud | B) She held backpack tightly | C) She smiled | D) She sang]', 'B', 1),
((SELECT id FROM assessments WHERE item_code='5.RSLKID.1.A'),
'[TF] Megan was worried she would not make friends.', 'T', 2),
((SELECT id FROM assessments WHERE item_code='5.RSLKID.1.A'),
'What can you infer? [MCQ: A) She is shy | B) She is outgoing | C) She is mean | D) She is angry]', 'B', 3),
((SELECT id FROM assessments WHERE item_code='5.RSLKID.1.A'),
'[TF] Megan did not enjoy her first day.', 'F', 4),
((SELECT id FROM assessments WHERE item_code='5.RSLKID.1.A'),
'Which shows friendship? [MCQ: A) They fought | B) They ignored each other | C) They shared snacks and talked | D) They left early]', 'C', 5);

COMMIT;
