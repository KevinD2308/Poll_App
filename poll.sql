DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
    id SERIAL PRIMARY KEY,
    question VARCHAR NOT NULL
);

DROP TABLE IF EXISTS answers;

CREATE TABLE answers (
    id SERIAL PRIMARY KEY,
    question_id INT NOT NULL,
    answer VARCHAR NOT NULL,
    vote INT DEFAULT 0 NOT NULL
);

INSERT INTO questions (question) VALUES
('What is the capital city of Australia?'),
("Are we alone?");

INSERT INTO answers (question_id, answer, vote) VALUES
(1, 'Kevi', 18),
(1, 'Linda', 36),
(1, 'Brownie', 25),
(2, 'Kevin', 37),
(2, 'Brrrownie', 88),
(2, 'LindaPinda', 55),