CREATE DATABASE IF NOT EXISTS lab3;
USE lab3;


DROP TABLE IF EXISTS game_on_platform;
DROP TABLE IF EXISTS game;
DROP TABLE IF EXISTS engine;
DROP TABLE IF EXISTS game_start;
DROP TABLE IF EXISTS steam;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS platform;
DROP TABLE IF EXISTS steam_has_game;


CREATE TABLE engine (
id INT AUTO_INCREMENT PRIMARY KEY,
engine_name VARCHAR(45) NOT NULL
)ENGINE = INNODB;

CREATE TABLE game(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(45) NOT NULL,
release_date VARCHAR(45) NULL,
engine_id INT NULL,
CONSTRAINT FK_game_engine_engine
	FOREIGN KEY (engine_id)
    REFERENCES engine(id)
    ON DELETE CASCADE ON UPDATE SET NULL
)ENGINE = INNODB;

CREATE TABLE platform(
id INT AUTO_INCREMENT PRIMARY KEY,
platform_name VARCHAR(45) NOT NULL
)ENGINE = INNODB;

CREATE TABLE game_on_platform(
platform_id INT NOT NULL,
game_id INT NOT NULL,
PRIMARY KEY (platform_id, game_id)
)ENGINE = INNODB;

CREATE TABLE user(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(45) NOT NULL,
email VARCHAR(45) NOT NULL,
username VARCHAR(45) NOT NULL,
phone VARCHAR(45) NOT NULL,
password VARCHAR(45) NOT NULL,
platform_id INT NULL,
CONSTRAINT FK_user_platform_platform
FOREIGN KEY (platform_id)
REFERENCES platform(id) 
ON DELETE CASCADE ON UPDATE SET NULL
)ENGINE = INNODB;

CREATE TABLE steam(
id INT AUTO_INCREMENT PRIMARY KEY,
vac_ban TINYINT NOT NULL,
money_on_account DECIMAL(10,2) NOT NULL,
user_id INT NULL,
CONSTRAINT FK_steam_user_user
FOREIGN KEY (user_id)
REFERENCES user(id)
ON DELETE CASCADE ON UPDATE SET NULL
)ENGINE = INNODB;

CREATE TABLE steam_has_game(
steam_id INT NOT NULL,
game_id INT NOT NULL,
PRIMARY KEY (steam_id, game_id)
)ENGINE = INNODB;

CREATE TABLE game_start(
id INT AUTO_INCREMENT PRIMARY KEY,
time_of_start DATE NULL,
steam_has_game_id INT NULL,
CONSTRAINT FK_game_start_steam_has_game_steam_has_game
FOREIGN KEY (steam_has_game_id)
REFERENCES steam_has_game(steam_id)
ON DELETE CASCADE ON UPDATE SET NULL
)ENGINE = INNODB;

INSERT INTO engine (id,engine_name) VALUES
(1,'Unity'),
(2,'Source'),
(3, 'Unreal Engine 5');

INSERT INTO platform (id, platform_name) VALUES
(1, 'Windows'),
(2, 'Mac OS'),
(3, 'Linux');

INSERT INTO game(id,name,release_date,engine_id) VALUES
(1,'CS:GO',NULL,2),
(2,'The Witcher', NULL, 3),
(3, 'Far Cry6', NULL, 1);

INSERT INTO game_on_platform( platform_id, game_id) VALUES
(1,2),
(1,1),
(1,3),
(2,2),
(2,3),
(3,1),
(3,2),
(3,3);

INSERT INTO user(id,name,email,username,phone,password,platform_id) VALUES
(1,'Alex', 'something', 'lolipop', '0968080808',22233311,1),
(2,'Roman','somemama','ronish', '0678120571','Ol12$%^',2),
(3,'Andrew', 'chuck norris', 'theatreDude','0236502750','ilovekebab', 1);
INSERT INTO steam(id,vac_ban,money_on_account,user_id) VALUES
(1,0,21222.12,1),
(2, 0, 694.2, 2),
(3, 1, 124, 3);

INSERT INTO steam_has_game( steam_id, game_id) VALUES
(1,2),
(1,3),
(2,2),
(2,3),
(3,1);

INSERT INTO game_start(id,time_of_start,steam_has_game_id) VALUES
(1,NULL, 1),
(2,NULL, 3);

CREATE INDEX has_vac_ban_x ON steam(vac_ban);
CREATE INDEX username_x ON user(username);

SHOW INDEX FROM steam;
SHOW INDEX FROM user;