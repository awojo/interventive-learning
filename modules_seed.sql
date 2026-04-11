BEGIN;

-- MODULE 4.RSLKID.1
INSERT INTO modules (name, skill_set_code, module_code)
SELECT 'Megan Finds Happy (Reading Passage)', '4.RSLKID.1', '4.RSLKID.1.M'
WHERE NOT EXISTS (
    SELECT 1 FROM modules WHERE module_code = '4.RSLKID.1.M'
);

DELETE FROM module_statements
WHERE module_id = (
    SELECT id FROM modules WHERE module_code = '4.RSLKID.1.M'
);

INSERT INTO module_statements (
    module_id,
    statement,
    visual,
    student_responds,
    next_statement_id
)
VALUES (
    (SELECT id FROM modules WHERE module_code = '4.RSLKID.1.M'),

'--- MEGAN FINDS HAPPY ---

Megan was ten years old. She had just been adopted by Robert and Mary Ann Smith. They were kind to her and always smiled. Still, Megan felt nervous. She had lived in many homes before, and she wondered if this one would last.
One afternoon, Megan went outside to walk in the big backyard. The grass was green, and the sun was shining after a short rain. As she walked near the trees, she heard a small sound. "Hello?" Megan called. She followed the sound and found a tiny puppy lying in the grass. "Oh no," Megan said. The puppy was cold, wet, and shaking. He was very dirty and looked hungry.
"You poor puppy," Megan said as she knelt down. "Where is your home?" The puppy looked at her with big eyes and wagged his tail. Megan gently picked him up. He felt very light in her arms. "I''ll help you," she said.
Megan hurried back to the house. "Mrs. Smith! Look what I found!" Mary Ann came to the door and gasped. "Oh my. Where did he come from?" "I found him in the yard," Megan said. "He was all alone. Can we help him?" Mary Ann smiled. "Yes, we can."
They gave the puppy a warm bath. Megan laughed when he splashed water. After the bath, they wrapped him in a towel. Then they gave him food and water. The puppy ate very fast. "He must have been hungry," Mary Ann said.
Megan smiled. "Thank you, Mom." Mary Ann looked surprised. "You called me Mom," she said softly. Megan nodded. "You are my mom." Mary Ann wiped her eyes and smiled. "That makes me very happy."
The puppy barked and wagged his tail. "He looks happy," Megan said. "That should be his name — Happy!" Happy licked Megan''s cheek, and she laughed. "You have a forever home now," Megan whispered. "Just like me." Megan hugged Happy close and felt warm inside. She finally knew she belonged.

--- END OF STORY ---',

    'none',
    false,
    NULL
);

-- MODULE 5.RSLKID.1
INSERT INTO modules (name, skill_set_code, module_code)
SELECT 'Megan Finds Happy (Reading Passage)', '5.RSLKID.1', '5.RSLKID.1.M'
WHERE NOT EXISTS (
    SELECT 1 FROM modules WHERE module_code = '5.RSLKID.1.M'
);

DELETE FROM module_statements
WHERE module_id = (
    SELECT id FROM modules WHERE module_code = '5.RSLKID.1.M'
);

INSERT INTO module_statements (
    module_id,
    statement,
    visual,
    student_responds,
    next_statement_id
)
VALUES (
    (SELECT id FROM modules WHERE module_code = '5.RSLKID.1.M'),

'--- MEGAN FINDS HAPPY ---

Megan was ten years old. She had just been adopted by Robert and Mary Ann Smith. They were kind to her and always smiled. Still, Megan felt nervous. She had lived in many homes before, and she wondered if this one would last.
One afternoon, Megan went outside to walk in the big backyard. The grass was green, and the sun was shining after a short rain. As she walked near the trees, she heard a small sound. "Hello?" Megan called. She followed the sound and found a tiny puppy lying in the grass. "Oh no," Megan said. The puppy was cold, wet, and shaking. He was very dirty and looked hungry.
"You poor puppy," Megan said as she knelt down. "Where is your home?" The puppy looked at her with big eyes and wagged his tail. Megan gently picked him up. He felt very light in her arms. "I''ll help you," she said.
Megan hurried back to the house. "Mrs. Smith! Look what I found!" Mary Ann came to the door and gasped. "Oh my. Where did he come from?" "I found him in the yard," Megan said. "He was all alone. Can we help him?" Mary Ann smiled. "Yes, we can."
They gave the puppy a warm bath. Megan laughed when he splashed water. After the bath, they wrapped him in a towel. Then they gave him food and water. The puppy ate very fast. "He must have been hungry," Mary Ann said.
Megan smiled. "Thank you, Mom." Mary Ann looked surprised. "You called me Mom," she said softly. Megan nodded. "You are my mom." Mary Ann wiped her eyes and smiled. "That makes me very happy."
The puppy barked and wagged his tail. "He looks happy," Megan said. "That should be his name — Happy!" Happy licked Megan''s cheek, and she laughed. "You have a forever home now," Megan whispered. "Just like me." Megan hugged Happy close and felt warm inside. She finally knew she belonged.

--- END OF STORY ---',

    'none',
    false,
    NULL
);

COMMIT;
