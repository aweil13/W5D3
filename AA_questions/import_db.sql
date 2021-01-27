PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL,
);

CREATE TABLE questions(
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT,

    FOREIGN KEY(user_id) REFERENCES users(id)
)

CREATE TABLE question_follows(

)


