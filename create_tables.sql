CREATE TABLE standards (
    standard_id BIGSERIAL PRIMARY KEY,
    standard_name TEXT,
    standard_code VARCHAR(50)
);

CREATE TABLE proficiencies (
    proficiency_id BIGSERIAL PRIMARY KEY,
    proficiency_name TEXT,
    standard_id BIGINT REFERENCES standards(standard_id),
    proficiency_code VARCHAR(50)
);

CREATE TABLE skill_sets (
    skill_set_code VARCHAR(50) PRIMARY KEY,
    prev_skill_set_code VARCHAR(50) NOT NULL,
    next_skill_set_code VARCHAR(50) NOT NULL,
    proficiency_id BIGINT REFERENCES proficiencies(proficiency_id),
    description TEXT
);

CREATE TABLE modules (
    id BIGSERIAL PRIMARY KEY,
    name TEXT,
    skill_set_code VARCHAR(50),
    module_code VARCHAR(50),
    item_code VARCHAR(50),
    sequence_index INTEGER
);

CREATE TABLE module_statements (
    module_statements_id BIGSERIAL PRIMARY KEY,
    module_id BIGINT REFERENCES modules(id),
    statement TEXT NOT NULL,
    visual VARCHAR(255) NOT NULL,
    student_responds BOOLEAN NOT NULL,
    next_statement_id BIGINT
);

CREATE TABLE assessments (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    skill_set_code VARCHAR(50),
    item_code VARCHAR(50),
    sequence_index INTEGER,
    passing_score DOUBLE PRECISION DEFAULT 0.8,
    remediation_code VARCHAR(50)
);

CREATE TABLE assessment_questions (
    assessment_questions_id BIGSERIAL PRIMARY KEY,
    assessment_id BIGINT REFERENCES assessments(id),
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    sequence_index INTEGER
);

CREATE TABLE student_proficiencies (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT,
    skill_set_code VARCHAR(50),
    status VARCHAR(50)
);

CREATE TABLE assignment_results (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL,
    assignment_code VARCHAR(255) NOT NULL,
    skill_set_code VARCHAR(50),
    assignment_type VARCHAR(50) NOT NULL,
    score DOUBLE PRECISION NOT NULL,
    proficient BOOLEAN NOT NULL,
    completed_at TIMESTAMP NOT NULL
);

CREATE TABLE pending_assignments (
    pending_assignments_id BIGSERIAL PRIMARY KEY,
    student_id BIGINT,
    skill_set_code VARCHAR(50),
    tracked_skill_set_code VARCHAR(50),
    received_timestamp TIMESTAMP
);

ALTER TABLE standards ADD CONSTRAINT uq_standard_code UNIQUE (standard_code);
ALTER TABLE proficiencies ADD CONSTRAINT uq_proficiency_code UNIQUE (proficiency_code);
ALTER TABLE modules ADD CONSTRAINT uq_module_code UNIQUE (module_code);
ALTER TABLE assessments ADD CONSTRAINT uq_assessment_code UNIQUE (item_code);
