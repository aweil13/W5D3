PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS question_likes; 
DROP TABLE IF EXISTS replies; 
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users; 

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);


CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    associated_author_id INTEGER NOT NULL,

    FOREIGN KEY (associated_author_id) REFERENCES users(id)
);

 
CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    body TEXT NOT NULL,
    parent_id INTEGER, -- Can be null if its the parent.  
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE,
    FOREIGN KEY (parent_id) REFERENCES replies(id) ON DELETE CASCADE
 );

 
 CREATE TABLE question_likes (
     id INTEGER PRIMARY KEY,
     thumbs_up BOOLEAN,
     user_id INTEGER,
     question_id INTEGER,

    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE     
 );


-- This is where we seed the database.
INSERT INTO
    users (fname, lname)
  VALUES
    ('Elon', 'Musk'),
    ('Jeff', 'Bezos');

INSERT INTO
    questions (title, body, associated_author_id)
  VALUES
    ('Car has no Battery', 'Where is the closest supercharger?', (SELECT id FROM users WHERE fname = 'Elon')),
    ('Divorce lawyers near me', 'Any decent lawyers around DC?', (SELECT id FROM users WHERE lname = 'Bezos'));

INSERT INTO
        question_follows (user_id, question_id)
      VALUES
        ((SELECT id FROM users WHERE id = 1), (SELECT id from questions WHERE associated_author_id = 1)),
        ((SELECT id FROM users WHERE id = 2), (SELECT id from questions WHERE associated_author_id = 2));

INSERT INTO 
        replies (user_id, question_id, body, parent_id)
    VALUES
      ((SELECT id FROM users WHERE id = 2), (SELECT id from questions WHERE id = 1), 'Around the corner!', NULL),
      ((SELECT id FROM users WHERE id = 1), (SELECT id from questions WHERE id = 2), 'Ask Donnie!', NULL);