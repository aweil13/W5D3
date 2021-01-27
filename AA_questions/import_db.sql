PRAGMA foreign_keys = ON;

CREATE TABLE users(
    id serial PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL,
);

CREATE TABLE questions(
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    associated_author_id INTEGER NOT NULL,

    FOREIGN KEY(associated_author_id) REFERENCES users(id)
);

CREATE TABLE question_follows(
    id serial PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(question_id) REFERENCES questions(id) ON DELETE CASCADE
);

CREATE TABLE replies(
    id serial PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    body TEXT NOT NULL,
    parent_id INTEGER -- Can be null if its the parent.  
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(question_id) REFERENCES questions(id) ON DELETE CASCADE,
    FOREIGN KEY(parent_id) REFERENCES replies(id) ON DELETE CASCADE
 );

 CREATE TABLE question_likes(
     id serial PRIMARY KEY,
     thumbs_up? BOOLEAN,
     user_id INTEGER,
     question_id INTEGER,

    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(question_id) REFERENCES questions(id) ON DELETE CASCADE     
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
    ('Car has no Battery', 'Where is the closest supercharger?', SELECT id FROM users WHERE fname = 'Elon'),
    ('Divorce lawyers near me', 'Any decent lawyers around DC?', SELECT id FROM users WHERE lname = 'Bezos');



