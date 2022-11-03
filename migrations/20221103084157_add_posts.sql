create table posts (
  id int,
  title varchar(100),
  body text,
  description text,
  author_id int,
  FOREIGN KEY (author_id) REFERENCES users(id),
  PRIMARY KEY(id)
);
