CREATE TABLE standards (
    standard_id   INT AUTO_INCREMENT PRIMARY KEY,
    code          VARCHAR(20)  NOT NULL UNIQUE,   -- e.g. RL.K.5
    strand        VARCHAR(10)  NOT NULL,           -- RL | RI | RF
    grade         TINYINT      NOT NULL,           -- 0=K, 1–5
    standard_num  TINYINT      NOT NULL,           -- trailing number (e.g. 5)
    description   TEXT         NOT NULL,
    domain        VARCHAR(60)  NOT NULL,           -- e.g. Key Ideas
    created_at    DATETIME     DEFAULT CURRENT_TIMESTAMP
);

create table stories (
  story_id INT AUTO_INCREMENT PRIMARY KEY,
  title    TEXT NOT NULL,
  grade_level TINYINT,
  content TEXT NOT NULL,
  created_at timestamp default now()
); 

CREATE TABLE modules (
  module_id     INT AUTO_INCREMENT PRIMARY KEY,
  standard_id   INT          NOT NULL,
  story_id      INT          NOT NULL,
  FOREIGN KEY (standard_id)  REFERENCES standard(standard_id),
  FOREIGN KEY (story_id)     REFERENCES stories(story_id),
  title TEXT,
  total_points  SMALLINT     NOT NULL DEFAULT 20,
  is_active     BOOLEAN      NOT NULL DEFAULT TRUE,
  questions     TEXT[],
  rubric        TEXT[],
  created_at timestamp default now()
);

INSERT INTO modules (standard_code, story_id, title, total_points, questions, rubric)
VALUES
((SELECT standard_id FROM standards WHERE standard_code = '5.RSLKID.A.1'), 6, 'G5 - Analyzing Quotes From Text', 20, [
  {
    "type": "MC",
    "question": "Which quote best shows that Megan felt both nervous and excited about her first day?",
    "options": [
      "“The bus was full of talking and laughter.”",
      "“She held her backpack tightly.”",
      "“She felt both nervous and excited.”",
      "“The children sang and laughed.”"
    ],
  },
  {
    "type": "TF",
    "question": "Megan was worried she would not make any friends at her new school.",
  },
  {
    "type": "MC",
    "question": "What can you infer about Heather based on what she says and does?",
    "options": [
      "She is shy and quiet.",
      "She is unfriendly to new students.",
      "She is kind and outgoing.",
      "She does not like school."
    ],
  },
  {
    "type": "TF",
    "question": "Megan did not enjoy her first day at school.",
  },
  {
    "type": "MC",
    "question": "Which quote best supports the idea that Megan and Heather became friends quickly?",
    "options": [
      "“The sun was already shining through her window.”",
      "“They discovered they were in the same class.”",
      "“Heather and Megan sat together.”",
      "“At lunch, they shared snacks and talked about their families.”"
    ],
  }
]),
((SELECT standard_id FROM standards WHERE standard_code = '4.RSLKID.A.1'), 6, 'G4 - Making Inferences', 20, [
  {
    "type": "MC",
    "question": "Which detail from the story shows that Megan was nervous at the beginning of the day?",
    "options": [
      "“She smiled all the way.”",
      "“Butterflies in her stomach.”",
      "“Kids laughed and sang songs.”",
      "“She shared snacks at lunch.”"
    ],
    "answer": "“Butterflies in her stomach.”"
  },
  {
    "type": "TF",
    "question": "Megan and Heather met for the first time at school.",
    "answer": false
  },
  {
    "type": "MC",
    "question": "What can you infer about Megan and Heather’s friendship?",
    "options": [
      "They do not talk much.",
      "They quickly become friends.",
      "They do not like each other.",
      "They only speak during class."
    ],
    "answer": "They quickly become friends."
  },
  {
    "type": "TF",
    "question": "Megan enjoyed her first day at school.",
    "answer": true
  },
  {
    "type": "MC",
    "question": "Which detail best supports that Megan felt happy at the end of the day?",
    "options": [
      "“Her mother smiled.”",
      "“She had butterflies in her stomach.”",
      "“She smiled all the way.”",
      "“Heather had curly hair.”"
    ],
    "answer": "“She smiled all the way.”"
  }
]),
((SELECT standard_id FROM standards WHERE standard_code = '3.RSLKID.A.1'), 6, 'G3 - Making Inferences', 20, [
  {
    "type": "MC",
    "question": "Who did Megan meet on the bus?",
    "options": [
      "Miss Bye",
      "Her mom",
      "Heather",
      "Happy"
    ],
    "answer": "Heather"
  },
  {
    "type": "TF",
    "question": "Megan and Heather both have puppies.",
    "answer": true
  },
  {
    "type": "MC",
    "question": "What is the name of Megan’s puppy?",
    "options": [
      "Max",
      "Buddy",
      "Happy",
      "Spot"
    ],
    "answer": "Happy"
  },
  {
    "type": "TF",
    "question": "Megan did not like her teacher.",
    "answer": false
  },
  {
    "type": "MC",
    "question": "What did Megan say about her first day?",
    "options": [
      "It was boring.",
      "It was scary.",
      "It was the best first day ever!",
      "It was too long."
    ],
    "answer": "It was the best first day ever!"
  }
]),
((SELECT standard_id FROM standards WHERE standard_code = '2.RSLKID.A.1'), 6, 'G2 - 2.RL.1', 20, [
  {
    "type": "MC",
    "question": "Who did Megan meet on the bus?",
    "options": [
      "Her mom",
      "Miss Bye",
      "Heather",
      "Happy"
    ],
    "answer": "Heather"
  },
  {
    "type": "MC",
    "question": "What is the name of Heather’s puppy?",
    "options": [
      "Happy",
      "Max",
      "Buddy",
      "Spot"
    ],
    "answer": "Max"
  },
  {
    "type": "TF",
    "question": "Megan and Heather sat next to each other at school.",
    "answer": true
  },
  {
    "type": "MC",
    "question": "Where did Megan and Heather eat together?",
    "options": [
      "On the bus",
      "At lunch",
      "At home",
      "On the playground"
    ],
    "answer": "At lunch"
  },
  {
    "type": "TF",
    "question": "Megan said her first day was not good.",
    "answer": false
  }
]),
((SELECT standard_id FROM standards WHERE standard_code = '1.RSLKID.A.1'), 6, 'G1 - 1.RL.1', 20, [
  {
    "type": "MC",
    "question": "Who did Megan meet on the bus?",
    "options": [
      "Her mom",
      "Heather",
      "Miss Bye",
      "Happy"
    ],
    "answer": "Heather"
  },
  {
    "type": "TF",
    "question": "Heather has a puppy named Max.",
    "answer": true
  },
  {
    "type": "MC",
    "question": "Where did Megan and Heather sit together?",
    "options": [
      "On the bus",
      "At home",
      "At school",
      "At the park"
    ],
    "answer": "At school"
  },
  {
    "type": "TF",
    "question": "Megan did not have a good day.",
    "answer": false
  },
  {
    "type": "MC",
    "question": "What did Megan say at the end of the story?",
    "options": [
      "I am tired.",
      "I made a new friend!",
      "I don’t like school.",
      "I lost my puppy."
    ],
    "answer": "I made a new friend!"
  }
]),
((SELECT standard_id FROM standards WHERE standard_code = '1.RSLKID.A.1'), 6, 'G1 - 1.RL.1', 20, [
  {
    "type": "MC",
    "question": "Who is Megan’s new friend?",
    "options": [
      "Her mom",
      "Heather",
      "Max",
      "Happy"
    ],
    "answer": "Heather"
  },
  {
    "type": "TF",
    "question": "Heather has a puppy named Max.",
    "answer": true
  },
  {
    "type": "MC",
    "question": "What did Megan and Heather do together at school?",
    "options": [
      "They played outside",
      "They ate lunch together",
      "They went home",
      "They rode bikes"
    ],
    "answer": "They ate lunch together"
  },
  {
    "type": "TF",
    "question": "Megan sang songs on the bus home.",
    "answer": true
  },
  {
    "type": "MC",
    "question": "Who did Megan tell about her day?",
    "options": [
      "Her teacher",
      "Her friend",
      "Her mom and her puppy",
      "No one"
    ],
    "answer": "Her mom and her puppy"
  }
]);

create table responses (
  response_id INT AUTO_INCREMENT PRIMARY KEY,
  student_id  INT NOT NULL,
  FOREIGN KEY (student_id) REFERENCES student(student_id),
  answer_text text,
  created_at timestamp default now(),
  updated_at timestamp default now()
);

create table scores (
  score_id INT AUTO_INCREMENT PRIMARY KEY,
  response_id INT NOT NULL,
  FOREIGN KEY (response_id) REFERENCES responses(reference_id),
  rubric_level int,
  teacher_feedback text,
  ai_score int,
  ai_feedback text,
  created_at timestamp default now()
);

CREATE TABLE answer_guide (
    answer_id           INT AUTO_INCREMENT PRIMARY KEY,
    question_id         INT          NOT NULL,
    correct_answer      TEXT         NOT NULL,
    accepted_variations TEXT,        -- JSON array, e.g. '["the hen","little red hen"]'
    evidence_required   BOOLEAN      NOT NULL DEFAULT FALSE,
    teacher_notes       TEXT,
    FOREIGN KEY (question_id) REFERENCES questions(question_id)
);

-- tentative (not sure if we'll need this...)
create table students (
  id uuid primary key default gen_random_uuid(),
  name text,
  email text unique,
  created_at timestamp default now()
);

INSERT INTO stories (title, grade_level, content)
VALUES
("A Great First Day at School", "K",
"It was Megan’s first day at school.
She met a new friend. Her name was Heather.
Heather had a puppy named Max. Megan had a puppy named Happy.
Megan and Heather sat together in class. They ate lunch together.
On the bus home, they sang songs.
At home, Megan told her mom and puppy all about her day."
),

("A Great First Day at School", 1,
"Megan went to a new school. She felt a little shy.
On the bus, she met a girl named Heather. Heather said, “Hi! I have a puppy named Max.” Megan said, “I have a puppy named Happy!”
At school, their teacher, Miss Bye, smiled and said, “Good morning!”
Megan and Heather sat next to each other. They ate lunch together and laughed.
After school, the bus was full of singing children. Megan sang, too.
At home, her mom asked, “Did you have a good day?”
“Yes!” said Megan. “I made a new friend!”
Then she told her puppy Happy all about her day."
),

("A Great First Day at School", 2,
"It was Megan’s first day at her new school. She felt nervous but happy.
On the bus, she met a new friend named Heather. Heather had a puppy named Max. Megan told her, “I have a puppy, too! His name is Happy.”
At school, their teacher, Miss Bye, smiled and said, “Welcome to class!” Megan and Heather sat next to each other.
At lunch, they ate together and talked. Megan said, “I like my new school.” Heather said, “Me too!”
On the bus home, everyone sang and laughed. Megan sang, too.
When she got home, her mom asked, “How was school?”
“It was great!” Megan said. “I met Heather and my teacher Miss Bye.”
Then Megan told her puppy Happy all about her day."
),

("A Great First Day at School", 3,
"Today was Megan’s first day at her new school. She was nervous but excited.
On the bus, she met Heather. Heather smiled and said, “Hi! I’m Heather.” Megan said, “I’m Megan.” The girls talked about their puppies. Heather’s puppy was named Max, and Megan’s puppy was named Happy.
At school, the girls were happy to find they were in the same class. Their teacher, Miss Bye, said, “Good morning, class!” Megan liked her right away.
At lunchtime, Megan and Heather sat together. They laughed and shared food. “I think we’ll be great friends,” said Heather.
After school, the children on the bus sang songs and laughed. Megan joined in.
When she got home, her mom asked, “How was your day?”
“It was the best first day ever!” said Megan. “I met Heather, and we both have puppies!”
Then Megan told Happy all about her day."
),

("A Great First Day at School", 4,
"Megan’s first day at her new school began with sunshine and butterflies in her stomach. Her mother smiled and said, “You’ll do great!”
On the bus, Megan met a friendly girl named Heather. Heather had curly hair and a big smile. She told Megan about her puppy, Max, who liked to chase his tail. Megan giggled. “I have a puppy, too! His name is Happy.”
At school, Megan and Heather found out they were in the same class. Their teacher, Miss Bye, welcomed everyone and said, “Let’s have a wonderful year together.”
The girls sat next to each other. During introductions, Heather said, “My puppy eats my socks!” Everyone laughed, including Megan. When it was Megan’s turn, she said, “My puppy likes to dig in the garden.”
At lunchtime, they shared snacks and talked. “I like it here,” Megan said. “Me too,” Heather replied.
On the bus home, kids laughed and sang songs. Megan joined in, smiling all the way.
When she got home, her mother asked about her day. “It was great! I made a new friend, Heather, and I like my teacher, Miss Bye.”
Megan ran to her puppy. “Guess what, Happy? Heather has a puppy named Max!” Happy wagged his tail, and Megan laughed."
),

("A Great First Day at School", 5, 
"Today was Megan’s first day at her new school, and she woke up extra early. The sun was already shining through her window, and she felt both nervous and excited. “It’s going to be a great day,” her mother said as she handed Megan her lunchbox.
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
Happy barked, and Megan hugged him. “Tomorrow, I’ll tell you more.”"
);

