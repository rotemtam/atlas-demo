create table blog_posts
(
    id int,
    title varchar(100),
    body text,
    author_id int,
    foreign key (author_id) references users(id),
    primary key (id)
);