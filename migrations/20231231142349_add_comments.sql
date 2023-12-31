-- Modify "blog_posts" table
ALTER TABLE `blog_posts` ADD COLUMN `comment_count` int NULL DEFAULT 0;
-- Create "comments" table
CREATE TABLE `comments` (`id` int NOT NULL AUTO_INCREMENT, `post_id` int NOT NULL, `comment_text` text NULL, `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY (`id`), INDEX `post_id_idx` (`post_id`), CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `blog_posts` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
