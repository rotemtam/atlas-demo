create table comments
(
    id        int,
    post_id   int,
    author_id int,
    body      text,
    upvotes   int,
    primary key (id),
    foreign key (post_id) references blog_posts (id),
    foreign key (author_id) references users (id)
)