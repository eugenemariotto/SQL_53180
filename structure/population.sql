use umami;

SET GLOBAL local_infile = true;

-- LOAD DATA  LOCAL INFILE '/structure/data-csv/ajustes.csv'
-- INTO TABLE ajustes
-- FIELDS TERMINATED BY ';' 
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS


LOAD DATA  LOCAL INFILE '/structure/data-csv/area.csv'
INTO TABLE area
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA  LOCAL INFILE '/structure/data-csv/contrato.csv'
INTO TABLE contrato
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA  LOCAL INFILE '/structure/data-csv/zona.csv'
INTO TABLE zona
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA  LOCAL INFILE '/structure/data-csv/nivel.csv'
INTO TABLE nivel
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



