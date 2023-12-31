-- Create "tag_popularity" view
CREATE VIEW `tag_popularity` (`tag_id`, `tag_label`, `article_count`) AS select `t`.`id` AS `tag_id`,`t`.`label` AS `tag_label`,count(`pt`.`post_id`) AS `article_count` from (`tags` `t` left join `post_tags` `pt` on((`t`.`id` = `pt`.`tag_id`))) group by `t`.`id`;
