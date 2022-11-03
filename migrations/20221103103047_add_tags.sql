CREATE TABLE tags (
  id int,
  name varchar(100),
  PRIMARY KEY(id)
);

CREATE TABLE post_tags (
   post_id int,
   tag_id int,
   unique (post_id, tag_id),
   foreign key (post_id) references posts(id),
   foreign key (tag_id) references tags(id)
);
