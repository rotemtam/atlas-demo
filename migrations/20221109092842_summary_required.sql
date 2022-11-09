UPDATE blog_posts SET summary = "" WHERE summary IS NULL;

alter table blog_posts modify column summary varchar(100) not null;