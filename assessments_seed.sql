BEGIN;

-- ASSESSMENT: 4.RSLKID.1
INSERT INTO assessments (name, skill_set_code, item_code, sequence_index, passing_score)
SELECT 'Explicit Details and Inferences Assessment', '4.RSLKID.1', '4.RSLKID.1.A', 20, 0.8
WHERE NOT EXISTS (SELECT 1 FROM assessments WHERE item_code = '4.RSLKID.1.A');

DO $$
DECLARE aid BIGINT;
BEGIN
  SELECT id INTO aid FROM assessments WHERE item_code = '4.RSLKID.1.A';
  DELETE FROM assessment_questions WHERE assessment_id = aid;
  INSERT INTO assessment_questions (assessment_id, question, answer, sequence_index)
  VALUES (aid, 'What is one detail the author states explicitly about Megan at the beginning of the story?', 'Megan was ten years old; She had just been adopted by Robert and Mary Ann Smith; She felt nervous; She had lived in many homes before', 1);
  INSERT INTO assessment_questions (assessment_id, question, answer, sequence_index)
  VALUES (aid, 'Using the sentence ''The puppy was cold, wet, and shaking,'' what can you infer about the puppy?', 'The puppy was lost or abandoned; The puppy needed help; The puppy was suffering from being outside in the cold and wet', 2);
  INSERT INTO assessment_questions (assessment_id, question, answer, sequence_index)
  VALUES (aid, 'Complete this sentence using evidence from the story: ''I can infer that Megan feels ___ because the text says ___.''', 'nervous / she had lived in many homes before and wondered if this one would last; worried / she wasn''t sure if this home would be forever', 3);
  INSERT INTO assessment_questions (assessment_id, question, answer, sequence_index)
  VALUES (aid, 'How does the text show that Megan starts to feel like she belongs? Use a detail from the story.', 'She whispered to Happy ''You have a forever home now. Just like me''; She finally knew she belonged; She called Mary Ann Mom', 4);
  INSERT INTO assessment_questions (assessment_id, question, answer, sequence_index)
  VALUES (aid, 'What is the difference between explicit information and an inference? Give one example of each from the story.', 'Explicit: something stated directly in the text such as Megan was ten years old. Inference: something figured out from clues such as Megan is afraid of being moved because she lived in many homes.', 5);
END $$;

-- ASSESSMENT: 5.RSLKID.1
INSERT INTO assessments (name, skill_set_code, item_code, sequence_index, passing_score)
SELECT 'Accurate Quoting and Inference Assessment', '5.RSLKID.1', '5.RSLKID.1.A', 20, 0.8
WHERE NOT EXISTS (SELECT 1 FROM assessments WHERE item_code = '5.RSLKID.1.A');

DO $$
DECLARE aid BIGINT;
BEGIN
  SELECT id INTO aid FROM assessments WHERE item_code = '5.RSLKID.1.A';
  DELETE FROM assessment_questions WHERE assessment_id = aid;
  INSERT INTO assessment_questions (assessment_id, question, answer, sequence_index)
  VALUES (aid, 'Find a sentence from the story that explicitly tells us how Megan feels at the beginning. Quote it accurately using quotation marks.', '''But still, Megan was nervous. She had lived in many homes before, and she wondered if this one would last.''', 1);
  INSERT INTO assessment_questions (assessment_id, question, answer, sequence_index)
  VALUES (aid, 'What is one thing the text explicitly tells us about the puppy when Megan finds him? Quote the text accurately.', '''The puppy was cold, wet, and shaking.''; ''He was very dirty and looked hungry.''', 2);
  INSERT INTO assessment_questions (assessment_id, question, answer, sequence_index)
  VALUES (aid, 'Using the quote ''Thank you, Mom,'' what inference can you make about Megan''s feelings toward Mary Ann? Explain your reasoning.', 'Megan is beginning to feel that Mary Ann is her real mother; Megan feels safe and loved; Megan trusts Mary Ann enough to call her Mom', 3);
  INSERT INTO assessment_questions (assessment_id, question, answer, sequence_index)
  VALUES (aid, 'Quote the sentence that best shows Megan feels she finally belongs. Then explain why you chose that quote.', '''She finally knew she belonged.''; ''You have a forever home now. Just like me.''', 4);
  INSERT INTO assessment_questions (assessment_id, question, answer, sequence_index)
  VALUES (aid, 'What is the difference between quoting explicitly and drawing an inference? Give one example of each from the story.', 'Explicit quote: states something directly written in the text with exact words. Inference: uses a quote as evidence to figure out something the author did not directly state. Examples vary.', 5);
END $$;

COMMIT;