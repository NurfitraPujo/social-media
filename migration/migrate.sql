CREATE USER IF NOT EXISTS 'ruby_dev'@'localhost' IDENTIFIED BY 'rubydev';

CREATE SCHEMA IF NOT EXISTS social_media;

GRANT ALL ON social_media.* TO 'ruby_dev'@'localhost';