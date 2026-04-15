BEGIN;

-- MODULE K.RSLKID.1
INSERT INTO modules (name, skill_set_code, module_code)
SELECT 'A Great First Day at School (Story)', 'K.RSLKID.1', 'K.RSLKID.1.M'
WHERE NOT EXISTS (
    SELECT 1 FROM modules WHERE module_code = 'K.RSLKID.1.M'
);

DELETE FROM module_statements
WHERE module_id = (
    SELECT id FROM modules WHERE module_code = 'K.RSLKID.1.M'
);

INSERT INTO module_statements (
    module_id,
    statement,
    visual,
    student_responds,
    next_statement_id
)
VALUES (
    (SELECT id FROM modules WHERE module_code = 'K.RSLKID.1.M'),

'--- A Great First Day at School ---

It was Megan’s first day at school.
She met a new friend. Her name was Heather.
Heather had a puppy named Max. Megan had a puppy named Happy.
Megan and Heather sat together in class. They ate lunch together.
On the bus home, they sang songs.
At home, Megan told her mom and puppy all about her day.

--- END OF STORY ---',

    'none',
    false,
    NULL
);

-- MODULE 1.RSLKID.1
INSERT INTO modules (name, skill_set_code, module_code)
SELECT 'A Great First Day at School (Story)', '1.RSLKID.1', '1.RSLKID.1.M'
WHERE NOT EXISTS (
    SELECT 1 FROM modules WHERE module_code = '1.RSLKID.1.M'
);

DELETE FROM module_statements
WHERE module_id = (
    SELECT id FROM modules WHERE module_code = '1.RSLKID.1.M'
);

INSERT INTO module_statements (
    module_id,
    statement,
    visual,
    student_responds,
    next_statement_id
)
VALUES (
    (SELECT id FROM modules WHERE module_code = '1.RSLKID.1.M'),

'--- A Great First Day at School ---

Megan went to a new school. She felt a little shy.
On the bus, she met a girl named Heather. Heather said, “Hi! I have a puppy named Max.” Megan said, “I have a puppy named Happy!”
At school, their teacher, Miss Bye, smiled and said, “Good morning!”
Megan and Heather sat next to each other. They ate lunch together and laughed.
After school, the bus was full of singing children. Megan sang, too.
At home, her mom asked, “Did you have a good day?”
“Yes!” said Megan. “I made a new friend!”
Then she told her puppy Happy all about her day.

--- END OF STORY ---',

    'none',
    false,
    NULL
);


-- MODULE 2.RSLKID.1
INSERT INTO modules (name, skill_set_code, module_code)
SELECT 'A Great First Day at School (Story)', '2.RSLKID.1', '2.RSLKID.1.M'
WHERE NOT EXISTS (
    SELECT 1 FROM modules WHERE module_code = '2.RSLKID.1.M'
);

DELETE FROM module_statements
WHERE module_id = (
    SELECT id FROM modules WHERE module_code = '2.RSLKID.1.M'
);

INSERT INTO module_statements (
    module_id,
    statement,
    visual,
    student_responds,
    next_statement_id
)
VALUES (
    (SELECT id FROM modules WHERE module_code = '2.RSLKID.1.M'),

'--- A Great First Day at School ---

It was Megan’s first day at her new school. She felt nervous but happy.
On the bus, she met a new friend named Heather. Heather had a puppy named Max. Megan told her, “I have a puppy, too! His name is Happy.”
At school, their teacher, Miss Bye, smiled and said, “Welcome to class!” Megan and Heather sat next to each other.
At lunch, they ate together and talked. Megan said, “I like my new school.” Heather said, “Me too!”
On the bus home, everyone sang and laughed. Megan sang, too.
When she got home, her mom asked, “How was school?”
“It was great!” Megan said. “I met Heather and my teacher Miss Bye.”
Then Megan told her puppy Happy all about her day.

--- END OF STORY ---',

    'none',
    false,
    NULL
);

-- MODULE 3.RSLKID.1
INSERT INTO modules (name, skill_set_code, module_code)
SELECT 'A Great First Day at School (Story)', '3.RSLKID.1', '3.RSLKID.1.M'
WHERE NOT EXISTS (
    SELECT 1 FROM modules WHERE module_code = '3.RSLKID.1.M'
);

DELETE FROM module_statements
WHERE module_id = (
    SELECT id FROM modules WHERE module_code = '3.RSLKID.1.M'
);

INSERT INTO module_statements (
    module_id,
    statement,
    visual,
    student_responds,
    next_statement_id
)
VALUES (
    (SELECT id FROM modules WHERE module_code = '3.RSLKID.1.M'),

'--- A Great First Day at School ---

Today was Megan’s first day at her new school. She was nervous but excited.
On the bus, she met Heather. Heather smiled and said, “Hi! I’m Heather.” Megan said, “I’m Megan.” The girls talked about their puppies. Heather’s puppy was named Max, and Megan’s puppy was named Happy.
At school, the girls were happy to find they were in the same class. Their teacher, Miss Bye, said, “Good morning, class!” Megan liked her right away.
At lunchtime, Megan and Heather sat together. They laughed and shared food. “I think we’ll be great friends,” said Heather.
After school, the children on the bus sang songs and laughed. Megan joined in.
When she got home, her mom asked, “How was your day?”
“It was the best first day ever!” said Megan. “I met Heather, and we both have puppies!”
Then Megan told Happy all about her day.

--- END OF STORY ---',

    'none',
    false,
    NULL
);

-- MODULE 4.RSLKID.1
INSERT INTO modules (name, skill_set_code, module_code)
SELECT 'A Great First Day at School (Story)', '4.RSLKID.1', '4.RSLKID.1.M'
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

'--- A Great First Day at School ---

Megan’s first day at her new school began with sunshine and butterflies in her stomach. Her mother smiled and said, “You’ll do great!”
On the bus, Megan met a friendly girl named Heather. Heather had curly hair and a big smile. She told Megan about her puppy, Max, who liked to chase his tail. Megan giggled. “I have a puppy, too! His name is Happy.”
At school, Megan and Heather found out they were in the same class. Their teacher, Miss Bye, welcomed everyone and said, “Let’s have a wonderful year together.”
The girls sat next to each other. During introductions, Heather said, “My puppy eats my socks!” Everyone laughed, including Megan. When it was Megan’s turn, she said, “My puppy likes to dig in the garden.”
At lunchtime, they shared snacks and talked. “I like it here,” Megan said. “Me too,” Heather replied.
On the bus home, kids laughed and sang songs. Megan joined in, smiling all the way.
When she got home, her mother asked about her day. “It was great! I made a new friend, Heather, and I like my teacher, Miss Bye.”
Megan ran to her puppy. “Guess what, Happy? Heather has a puppy named Max!” Happy wagged his tail, and Megan laughed.

--- END OF STORY ---',

    'none',
    false,
    NULL
);

-- MODULE 5.RSLKID.1
INSERT INTO modules (name, skill_set_code, module_code)
SELECT 'A Great First Day at School (Story)', '5.RSLKID.1', '5.RSLKID.1.M'
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

Today was Megan’s first day at her new school, and she woke up extra early. The sun was already shining through her window, and she felt both nervous and excited. “It’s going to be a great day,” her mother said as she handed Megan her lunchbox.
When Megan stepped onto the big yellow bus, she held her backpack tightly. The bus was full of talking and laughter. She hoped she would make a friend. A girl with curly hair sat beside her and smiled.
“Hi! I’m Heather,” the girl said cheerfully.
“I’m Megan,” she answered, returning the smile.
Heather told her about her puppy, Max, who chased his tail and barked at butterflies. Megan laughed. “He sounds like my puppy, Happy!”
At school, they discovered they were in the same class. Their teacher, Miss Bye, greeted them warmly. “Good morning, everyone! I’m Miss Bye. Let’s make this year amazing!”
Heather and Megan sat together. During introductions, Heather said, “I have a puppy named Max who eats my socks!” The class laughed. Megan added, “My puppy Happy digs in the garden.”
At lunch, they shared snacks and talked about their families. “I like our teacher,” Megan said. Heather nodded. “I think this year will be fun.”
On the bus ride home, the children sang and laughed. Megan joined in, thinking, This really was a great first day.
When she got home, her mother asked, “How was it?”
“It was amazing! I met Heather, my new friend, and our teacher, Miss Bye. The bus ride was so fun!”
Her mother smiled. Megan knelt beside Happy, who wagged his tail. “You wouldn’t believe it,” she said. “Heather has a puppy, too!”
Happy barked, and Megan hugged him. “Tomorrow, I’ll tell you more.”

--- END OF STORY ---',

    'none',
    false,
    NULL
);

COMMIT;
