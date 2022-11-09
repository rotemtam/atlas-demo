create table tags
(
    id    int,
    label varchar(100),
    primary key (id)
);

create table post_tags
(
    post_id int,
    tag_id  int,
    unique (post_id, tag_id),
    foreign key (post_id) references blog_posts (id),
    foreign key (tag_id) references tags (id)
);