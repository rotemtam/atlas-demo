-- atlas:checkpoint

-- Create "users" table
CREATE TABLE `users` (`id` int NOT NULL, `email` varchar(100) NULL, `name` varchar(100) NULL, PRIMARY KEY (`id`), UNIQUE INDEX `email` (`email`)) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
-- Create "blog_posts" table
CREATE TABLE `blog_posts` (`id` int NOT NULL, `title` varchar(100) NULL, `body` text NULL, `author_id` int NULL, `summary` varchar(100) NOT NULL, PRIMARY KEY (`id`), INDEX `author_id` (`author_id`), CONSTRAINT `blog_posts_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
-- Create "tags" table
CREATE TABLE `tags` (`id` int NOT NULL, `label` varchar(100) NULL, PRIMARY KEY (`id`)) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
-- Create "post_tags" table
CREATE TABLE `post_tags` (`post_id` int NULL, `tag_id` int NULL, UNIQUE INDEX `post_id` (`post_id`, `tag_id`), INDEX `tag_id` (`tag_id`), CONSTRAINT `post_tags_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `blog_posts` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, CONSTRAINT `post_tags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
