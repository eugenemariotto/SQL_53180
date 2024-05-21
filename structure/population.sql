use umami;
SET GLOBAL local_infile = true;

LOAD DATA LOCAL INFILE '/structure/data-csv/area.csv' 
INTO TABLE area 
FIELDS TERMINATED BY ';'  
LINES TERMINATED BY '\n' IGNORE 1 ROWS;