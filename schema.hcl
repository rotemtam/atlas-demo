table "blog_posts" {
  schema = schema.default
  column "id" {
    null = false
    type = int
  }
  column "title" {
    null = true
    type = varchar(100)
  }
  column "body" {
    null = true
    type = text
  }
  column "author_id" {
    null = true
    type = int
  }
  column "summary" {
    null = false
    type = varchar(100)
  }
  column "comment_count" {
    null    = true
    type    = int
    default = 0
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "blog_posts_ibfk_1" {
    columns     = [column.author_id]
    ref_columns = [table.users.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  index "author_id" {
    columns = [column.author_id]
  }
}
table "comments" {
  schema = schema.default
  column "id" {
    null           = false
    type           = int
    auto_increment = true
  }
  column "post_id" {
    null = false
    type = int
  }
  column "comment_text" {
    null = true
    type = text
  }
  column "created_at" {
    null    = true
    type    = datetime
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "comments_ibfk_1" {
    columns     = [column.post_id]
    ref_columns = [table.blog_posts.column.id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  index "post_id_idx" {
    columns = [column.post_id]
  }
}
table "post_tags" {
  schema = schema.default
  column "post_id" {
    null = true
    type = int
  }
  column "tag_id" {
    null = true
    type = int
  }
  foreign_key "post_tags_ibfk_1" {
    columns     = [column.post_id]
    ref_columns = [table.blog_posts.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "post_tags_ibfk_2" {
    columns     = [column.tag_id]
    ref_columns = [table.tags.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  index "post_id" {
    unique  = true
    columns = [column.post_id, column.tag_id]
  }
  index "tag_id" {
    columns = [column.tag_id]
  }
}
table "tags" {
  schema = schema.default
  column "id" {
    null = false
    type = int
  }
  column "label" {
    null = true
    type = varchar(100)
  }
  primary_key {
    columns = [column.id]
  }
}
table "users" {
  schema = schema.default
  column "id" {
    null = false
    type = int
  }
  column "email" {
    null = true
    type = varchar(100)
  }
  column "name" {
    null = true
    type = varchar(100)
  }
  primary_key {
    columns = [column.id]
  }
  index "email" {
    unique  = true
    columns = [column.email]
  }
}
view "author_most_engaged_post" {
  schema = schema.default
  column "author_id" {
    null = true
    type = int
  }
  column "post_id" {
    null = false
    type = int
  }
  column "title" {
    null = true
    type = varchar(100)
  }
  column "comment_count" {
    null = true
    type = int
  }
  as         = "select `bp`.`author_id` AS `author_id`,`bp`.`id` AS `post_id`,`bp`.`title` AS `title`,`bp`.`comment_count` AS `comment_count` from (`blog_posts` `bp` join (select `blog_posts`.`author_id` AS `author_id`,max(`blog_posts`.`comment_count`) AS `max_comments` from `blog_posts` group by `blog_posts`.`author_id`) `subq` on(((`bp`.`author_id` = `subq`.`author_id`) and (`bp`.`comment_count` = `subq`.`max_comments`))))"
  depends_on = [table.blog_posts]
}
view "tag_popularity" {
  schema = schema.default
  column "tag_id" {
    null = false
    type = int
  }
  column "tag_label" {
    null = true
    type = varchar(100)
  }
  column "article_count" {
    null = false
    type = bigint
  }
  as         = "select `t`.`id` AS `tag_id`,`t`.`label` AS `tag_label`,count(`pt`.`post_id`) AS `article_count` from (`tags` `t` left join `post_tags` `pt` on((`t`.`id` = `pt`.`tag_id`))) group by `t`.`id`"
  depends_on = [table.post_tags, table.tags]
}
trigger "increment_comment_count" {
  on = table.comments
  after {
    insert = true
  }
  foreach = ROW
  as      = <<-SQL
  BEGIN
  UPDATE `blog_posts` SET comment_count = comment_count + 1 WHERE id = NEW.post_id;
  END
  SQL
}
schema "default" {
  charset = "utf8mb4"
  collate = "utf8mb4_0900_ai_ci"
}
