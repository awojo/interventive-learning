CREATE TABLE standards (
    standard_id INT AUTO_INCREMENT PRIMARY KEY,
    standard_code VARCHAR(20) NOT NULL UNIQUE, -- e.g. RL.K.5
    strand VARCHAR(10) NOT NULL, -- RL | RI | RF
    grade TINYINT NOT NULL, -- 0=K, 1–5
    standard_num TINYINT NOT NULL, -- trailing number (e.g. 5)
    description TEXT NOT NULL,
    domain VARCHAR(60) NOT NULL, -- e.g. Key Ideas
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

create table stories (
    story_id INT AUTO_INCREMENT PRIMARY KEY,
    title TEXT NOT NULL,
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

-- tentative (not sure if we'll need this...)
create table students (
    student_id uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    student_name TEXT,
    email TEXT UNIQUE,
    created_at TIMESTAMP DEFAULT now()
);