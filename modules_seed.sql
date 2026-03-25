BEGIN;

-- MODULE 4.RSLKID.1
INSERT INTO modules (name, skill_set_code, module_code)
SELECT 'Explicit Details and Inferences: Megan Finds Happy', '4.RSLKID.1', '4.RSLKID.1.M'
WHERE NOT EXISTS (SELECT 1 FROM modules WHERE module_code = '4.RSLKID.1.M');

DELETE FROM module_statements WHERE module_id = (SELECT id FROM modules WHERE module_code = '4.RSLKID.1.M');

CREATE TEMP TABLE IF NOT EXISTS _stmt_ids (seq INT, id BIGINT);
DELETE FROM _stmt_ids;

INSERT INTO module_statements (module_id, statement, visual, student_responds, next_statement_id)
VALUES ((SELECT id FROM modules WHERE module_code = '4.RSLKID.1.M'), 'Today we will practice referring to details and examples in a text when explaining what it says explicitly — meaning directly — and when making inferences, which means figuring something out from clues.

Please read the story below carefully before we begin.

--- MEGAN FINDS HAPPY ---
Megan was ten years old. She had just been adopted by Robert and Mary Ann Smith. They were kind to her and always smiled. Still, Megan felt nervous. She had lived in many homes before, and she wondered if this one would last.

One afternoon, Megan went outside to walk in the big backyard. The grass was green, and the sun was shining after a short rain. As she walked near the trees, she heard a small sound. "Hello?" Megan called. She followed the sound and found a tiny puppy lying in the grass. "Oh no," Megan said. The puppy was cold, wet, and shaking. He was very dirty and looked hungry.

"You poor puppy," Megan said as she knelt down. "Where is your home?" The puppy looked at her with big eyes and wagged his tail. Megan gently picked him up. He felt very light in her arms. "I''''ll help you," she said.

Megan hurried back to the house. "Mrs. Smith! Look what I found!" Mary Ann came to the door and gasped. "Oh my. Where did he come from?" "I found him in the yard," Megan said. "He was all alone. Can we help him?" Mary Ann smiled. "Yes, we can."

They gave the puppy a warm bath. Megan laughed when he splashed water. After the bath, they wrapped him in a towel. Then they gave him food and water. The puppy ate very fast. "He must have been hungry," Mary Ann said.

Megan smiled. "Thank you, Mom." Mary Ann looked surprised. "You called me Mom," she said softly. Megan nodded. "You are my mom." Mary Ann wiped her eyes and smiled. "That makes me very happy."

The puppy barked and wagged his tail. "He looks happy," Megan said. "That should be his name — Happy!" Happy licked Megan''''s cheek, and she laughed. "You have a forever home now," Megan whispered. "Just like me." Megan hugged Happy close and felt warm inside. She finally knew she belonged.
--- END OF STORY ---', 'none', false, NULL);
INSERT INTO _stmt_ids VALUES (1, (SELECT module_statements_id FROM module_statements WHERE module_id = (SELECT id FROM modules WHERE module_code = '4.RSLKID.1.M') ORDER BY module_statements_id DESC LIMIT 1));

INSERT INTO module_statements (module_id, statement, visual, student_responds, next_statement_id)
VALUES ((SELECT id FROM modules WHERE module_code = '4.RSLKID.1.M'), 'Let''''s start with explicit information. Explicit means the author tells us something clearly and directly — we can point to the exact words.

Example: The text says ''''Megan was ten years old. She had just been adopted by Robert and Mary Ann Smith.'''' The author tells us her age and that she was adopted. No guessing needed.', 'none', false, NULL);
INSERT INTO _stmt_ids VALUES (2, (SELECT module_statements_id FROM module_statements WHERE module_id = (SELECT id FROM modules WHERE module_code = '4.RSLKID.1.M') ORDER BY module_statements_id DESC LIMIT 1));

INSERT INTO module_statements (module_id, statement, visual, student_responds, next_statement_id)
VALUES ((SELECT id FROM modules WHERE module_code = '4.RSLKID.1.M'), 'Now it is your turn.

What is one detail the author tells us directly about Megan at the beginning of the story?

Type your answer.', 'none', true, NULL);
INSERT INTO _stmt_ids VALUES (3, (SELECT module_statements_id FROM module_statements WHERE module_id = (SELECT id FROM modules WHERE module_code = '4.RSLKID.1.M') ORDER BY module_statements_id DESC LIMIT 1));

INSERT INTO module_statements (module_id, statement, visual, student_responds, next_statement_id)
VALUES ((SELECT id FROM modules WHERE module_code = '4.RSLKID.1.M'), 'Good. Now let''''s move to inferences. An inference is something we figure out using clues from the text plus what we already know — the author doesn''''t say it directly.

Example: ''''Still, Megan felt nervous. She had lived in many homes before, and she wondered if this one would last.''''

I can infer Megan is afraid of being moved again — the text tells me she has lived in many homes before, which is the clue.', 'none', false, NULL);
INSERT INTO _stmt_ids VALUES (4, (SELECT module_statements_id FROM module_statements WHERE module_id = (SELECT id FROM modules WHERE module_code = '4.RSLKID.1.M') ORDER BY module_statements_id DESC LIMIT 1));

INSERT INTO module_statements (module_id, statement, visual, student_responds, next_statement_id)
VALUES ((SELECT id FROM modules WHERE module_code = '4.RSLKID.1.M'), 'Try it yourself. Complete this sentence using details from the story:

''''I can infer that Megan feels ___ because the text says ___''''.', 'none', true, NULL);
INSERT INTO _stmt_ids VALUES (5, (SELECT module_statements_id FROM module_statements WHERE module_id = (SELECT id FROM modules WHERE module_code = '4.RSLKID.1.M') ORDER BY module_statements_id DESC LIMIT 1));

INSERT INTO module_statements (module_id, statement, visual, student_responds, next_statement_id)
VALUES ((SELECT id FROM modules WHERE module_code = '4.RSLKID.1.M'), 'Let''''s practice one more inference.

This sentence is from the story: ''''The puppy was cold, wet, and shaking.''''

Complete this sentence: ''''I can infer that the puppy is ___ because the text says ___''''.', 'none', true, NULL);
INSERT INTO _stmt_ids VALUES (6, (SELECT module_statements_id FROM module_statements WHERE module_id = (SELECT id FROM modules WHERE module_code = '4.RSLKID.1.M') ORDER BY module_statements_id DESC LIMIT 1));

INSERT INTO module_statements (module_id, statement, visual, student_responds, next_statement_id)
VALUES ((SELECT id FROM modules WHERE module_code = '4.RSLKID.1.M'), 'Strong readers also use text details to understand character feelings.

Look at this moment: Megan smiled. ''''Thank you, Mom.''''

How does Megan feel about Mary Ann at this point?

Complete: ''''Megan feels ___ because the text says ___''''.', 'none', true, NULL);
INSERT INTO _stmt_ids VALUES (7, (SELECT module_statements_id FROM module_statements WHERE module_id = (SELECT id FROM modules WHERE module_code = '4.RSLKID.1.M') ORDER BY module_statements_id DESC LIMIT 1));

INSERT INTO module_statements (module_id, statement, visual, student_responds, next_statement_id)
VALUES ((SELECT id FROM modules WHERE module_code = '4.RSLKID.1.M'), 'Great work today! You found explicit details and made inferences using text evidence.

Final question: At the very end, Megan whispers ''''You have a forever home now. Just like me.''''

What does this tell us about how Megan changed from the beginning to the end of the story? Use a detail from the text to support your answer.', 'none', true, NULL);
INSERT INTO _stmt_ids VALUES (8, (SELECT module_statements_id FROM module_statements WHERE module_id = (SELECT id FROM modules WHERE module_code = '4.RSLKID.1.M') ORDER BY module_statements_id DESC LIMIT 1));

-- Wire up linked list
UPDATE module_statements SET next_statement_id = (SELECT id FROM _stmt_ids WHERE seq = 2)
WHERE module_statements_id = (SELECT id FROM _stmt_ids WHERE seq = 1);
UPDATE module_statements SET next_statement_id = (SELECT id FROM _stmt_ids WHERE seq = 3)
WHERE module_statements_id = (SELECT id FROM _stmt_ids WHERE seq = 2);
UPDATE module_statements SET next_statement_id = (SELECT id FROM _stmt_ids WHERE seq = 4)
WHERE module_statements_id = (SELECT id FROM _stmt_ids WHERE seq = 3);
UPDATE module_statements SET next_statement_id = (SELECT id FROM _stmt_ids WHERE seq = 5)
WHERE module_statements_id = (SELECT id FROM _stmt_ids WHERE seq = 4);
UPDATE module_statements SET next_statement_id = (SELECT id FROM _stmt_ids WHERE seq = 6)
WHERE module_statements_id = (SELECT id FROM _stmt_ids WHERE seq = 5);
UPDATE module_statements SET next_statement_id = (SELECT id FROM _stmt_ids WHERE seq = 7)
WHERE module_statements_id = (SELECT id FROM _stmt_ids WHERE seq = 6);
UPDATE module_statements SET next_statement_id = (SELECT id FROM _stmt_ids WHERE seq = 8)
WHERE module_statements_id = (SELECT id FROM _stmt_ids WHERE seq = 7);

DROP TABLE IF EXISTS _stmt_ids;

-- MODULE 5.RSLKID.1
INSERT INTO modules (name, skill_set_code, module_code)
SELECT 'Accurate Quoting and Inference: Megan Finds Happy', '5.RSLKID.1', '5.RSLKID.1.M'
WHERE NOT EXISTS (SELECT 1 FROM modules WHERE module_code = '5.RSLKID.1.M');

DELETE FROM module_statements WHERE module_id = (SELECT id FROM modules WHERE module_code = '5.RSLKID.1.M');

CREATE TEMP TABLE IF NOT EXISTS _stmt_ids (seq INT, id BIGINT);
DELETE FROM _stmt_ids;

INSERT INTO module_statements (module_id, statement, visual, student_responds, next_statement_id)
VALUES ((SELECT id FROM modules WHERE module_code = '5.RSLKID.1.M'), 'Today we will practice referring to details and examples in a text when explaining what it says explicitly — meaning directly — and when making inferences, which means figuring something out from clues.

Please read the story below carefully before we begin.

--- MEGAN FINDS HAPPY ---
Megan was ten years old. She had just been adopted by Robert and Mary Ann Smith. They were kind to her and always smiled. Still, Megan felt nervous. She had lived in many homes before, and she wondered if this one would last.

One afternoon, Megan went outside to walk in the big backyard. The grass was green, and the sun was shining after a short rain. As she walked near the trees, she heard a small sound. "Hello?" Megan called. She followed the sound and found a tiny puppy lying in the grass. "Oh no," Megan said. The puppy was cold, wet, and shaking. He was very dirty and looked hungry.

"You poor puppy," Megan said as she knelt down. "Where is your home?" The puppy looked at her with big eyes and wagged his tail. Megan gently picked him up. He felt very light in her arms. "I''''ll help you," she said.

Megan hurried back to the house. "Mrs. Smith! Look what I found!" Mary Ann came to the door and gasped. "Oh my. Where did he come from?" "I found him in the yard," Megan said. "He was all alone. Can we help him?" Mary Ann smiled. "Yes, we can."

They gave the puppy a warm bath. Megan laughed when he splashed water. After the bath, they wrapped him in a towel. Then they gave him food and water. The puppy ate very fast. "He must have been hungry," Mary Ann said.

Megan smiled. "Thank you, Mom." Mary Ann looked surprised. "You called me Mom," she said softly. Megan nodded. "You are my mom." Mary Ann wiped her eyes and smiled. "That makes me very happy."

The puppy barked and wagged his tail. "He looks happy," Megan said. "That should be his name — Happy!" Happy licked Megan''''s cheek, and she laughed. "You have a forever home now," Megan whispered. "Just like me." Megan hugged Happy close and felt warm inside. She finally knew she belonged.
--- END OF STORY ---', 'none', false, NULL);
INSERT INTO _stmt_ids VALUES (1, (SELECT module_statements_id FROM module_statements WHERE module_id = (SELECT id FROM modules WHERE module_code = '5.RSLKID.1.M') ORDER BY module_statements_id DESC LIMIT 1));

INSERT INTO module_statements (module_id, statement, visual, student_responds, next_statement_id)
VALUES ((SELECT id FROM modules WHERE module_code = '5.RSLKID.1.M'), 'When information is explicit, the author states it directly and we quote the exact words.

Example: To explain how Megan feels at the start I quote accurately: ''''But still, Megan was nervous. She had lived in many homes before, and she wondered if this one would last.'''' That quote proves the idea because the author clearly states both the feeling and the reason.', 'none', false, NULL);
INSERT INTO _stmt_ids VALUES (2, (SELECT module_statements_id FROM module_statements WHERE module_id = (SELECT id FROM modules WHERE module_code = '5.RSLKID.1.M') ORDER BY module_statements_id DESC LIMIT 1));

INSERT INTO module_statements (module_id, statement, visual, student_responds, next_statement_id)
VALUES ((SELECT id FROM modules WHERE module_code = '5.RSLKID.1.M'), 'Your turn.

What is one thing the story tells us explicitly about the puppy when Megan finds him?

Find a sentence and type it inside quotation marks.', 'none', true, NULL);
INSERT INTO _stmt_ids VALUES (3, (SELECT module_statements_id FROM module_statements WHERE module_id = (SELECT id FROM modules WHERE module_code = '5.RSLKID.1.M') ORDER BY module_statements_id DESC LIMIT 1));

INSERT INTO module_statements (module_id, statement, visual, student_responds, next_statement_id)
VALUES ((SELECT id FROM modules WHERE module_code = '5.RSLKID.1.M'), 'Now let''''s practice inference. An inference is something the author does NOT say directly — we figure it out using text clues.

Example: The author never writes ''''Megan feels safe with Mary Ann,'''' but I can infer she does from this quote: ''''She looked at Mary Ann and smiled. Thanks, Mom.'''' Kids don''''t usually call someone Mom unless they feel trust and comfort.', 'none', false, NULL);
INSERT INTO _stmt_ids VALUES (4, (SELECT module_statements_id FROM module_statements WHERE module_id = (SELECT id FROM modules WHERE module_code = '5.RSLKID.1.M') ORDER BY module_statements_id DESC LIMIT 1));

INSERT INTO module_statements (module_id, statement, visual, student_responds, next_statement_id)
VALUES ((SELECT id FROM modules WHERE module_code = '5.RSLKID.1.M'), 'Your turn.

How can you infer that Megan finally feels like she belongs at the end?

Find a quote and explain: ''''I can infer ___ because the text states: ___''''.', 'none', true, NULL);
INSERT INTO _stmt_ids VALUES (5, (SELECT module_statements_id FROM module_statements WHERE module_id = (SELECT id FROM modules WHERE module_code = '5.RSLKID.1.M') ORDER BY module_statements_id DESC LIMIT 1));

INSERT INTO module_statements (module_id, statement, visual, student_responds, next_statement_id)
VALUES ((SELECT id FROM modules WHERE module_code = '5.RSLKID.1.M'), 'Strong readers connect explicit information and inference together.

Why do you think Megan names the puppy ''''Happy''''? The author doesn''''t explain this directly — you need to infer. But you still need a quote.

Find a quote and explain: what part is explicit, and what part is inference?', 'none', true, NULL);
INSERT INTO _stmt_ids VALUES (6, (SELECT module_statements_id FROM module_statements WHERE module_id = (SELECT id FROM modules WHERE module_code = '5.RSLKID.1.M') ORDER BY module_statements_id DESC LIMIT 1));

INSERT INTO module_statements (module_id, statement, visual, student_responds, next_statement_id)
VALUES ((SELECT id FROM modules WHERE module_code = '5.RSLKID.1.M'), 'Excellent work! You quoted accurately, explained explicit information, and supported inferences with text evidence.

Final challenge: Which moment in the story shows the biggest change in Megan from beginning to end?

Write your answer and include at least one accurate quote from the text.', 'none', true, NULL);
INSERT INTO _stmt_ids VALUES (7, (SELECT module_statements_id FROM module_statements WHERE module_id = (SELECT id FROM modules WHERE module_code = '5.RSLKID.1.M') ORDER BY module_statements_id DESC LIMIT 1));

-- Wire up linked list
UPDATE module_statements SET next_statement_id = (SELECT id FROM _stmt_ids WHERE seq = 2)
WHERE module_statements_id = (SELECT id FROM _stmt_ids WHERE seq = 1);
UPDATE module_statements SET next_statement_id = (SELECT id FROM _stmt_ids WHERE seq = 3)
WHERE module_statements_id = (SELECT id FROM _stmt_ids WHERE seq = 2);
UPDATE module_statements SET next_statement_id = (SELECT id FROM _stmt_ids WHERE seq = 4)
WHERE module_statements_id = (SELECT id FROM _stmt_ids WHERE seq = 3);
UPDATE module_statements SET next_statement_id = (SELECT id FROM _stmt_ids WHERE seq = 5)
WHERE module_statements_id = (SELECT id FROM _stmt_ids WHERE seq = 4);
UPDATE module_statements SET next_statement_id = (SELECT id FROM _stmt_ids WHERE seq = 6)
WHERE module_statements_id = (SELECT id FROM _stmt_ids WHERE seq = 5);
UPDATE module_statements SET next_statement_id = (SELECT id FROM _stmt_ids WHERE seq = 7)
WHERE module_statements_id = (SELECT id FROM _stmt_ids WHERE seq = 6);

DROP TABLE IF EXISTS _stmt_ids;

COMMIT;