use umami;
use mysql;

CREATE ROLE 'mysql_dev', 'mysql_read', 'mysql_write';

GRANT ALL ON umami.* TO 'mysql_dev';
GRANT SELECT ON umami.* TO 'mysql_read';
GRANT INSERT, UPDATE, DELETE ON umami.* TO 'mysql_write';

CREATE USER 'dev1'@'localhost' IDENTIFIED BY '123456';
CREATE USER 'read_u1'@'localhost' IDENTIFIED BY '123456';
CREATE USER 'read_u2'@'localhost' IDENTIFIED BY '123456';
CREATE USER 'wr_user1'@'localhost' IDENTIFIED BY '123456';

GRANT 'mysql_dev' TO 'dev1'@'localhost';
GRANT 'mysql_read' TO 'read_u1'@'localhost', 'read_u2'@'localhost';
GRANT 'mysql_read', 'mysql_write' TO 'wr_user1'@'localhost';