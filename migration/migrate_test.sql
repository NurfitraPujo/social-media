CREATE SCHEMA IF NOT EXISTS social_media_test;

GRANT ALL ON social_media_test.* TO 'ruby_dev'@'localhost';

USE social_media_test;

CREATE TABLE IF NOT EXISTS user (
    id INT AUTO_INCREMENT,
    username VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(50) NOT NULL UNIQUE,
    bio VARCHAR(255) DEFAULT '',
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS post (
    id INT AUTO_INCREMENT,
    username VARCHAR(20) NOT NULL,
    text VARCHAR(1000) NOT NULL,
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    FOREIGN KEY(username)
        REFERENCES user(username) 
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);