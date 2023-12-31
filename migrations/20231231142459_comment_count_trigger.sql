-- Create trigger "increment_comment_count"
CREATE TRIGGER `increment_comment_count` AFTER INSERT ON `comments` FOR EACH ROW BEGIN
UPDATE `blog_posts` SET comment_count = comment_count + 1 WHERE id = NEW.post_id;
END;
