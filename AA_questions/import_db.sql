PRAGMA foreign_keys = ON;

CREATE TABLE users(
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL,
);

CREATE TABLE questions(
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT,

    FOREIGN KEY(user_id) REFERENCES users(id)
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

 




