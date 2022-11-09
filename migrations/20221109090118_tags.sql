create table tags
(
    id    int,
    label varchar(100),
    primary key (id)
);

create table post_tags
(
    post_id int references blog_posts (id),
    tag_id  int references tags (id),
    unique (post_id, tag_id)
);