LOAD DATA 
  INFILE 'C:\DB\Lab18\import_data.txt'
  REPLACE
INTO TABLE LB18
FIELDS TERMINATED BY ","
(
id "round(:id, 2)",
text "upper(:text)",
date_value date "DD.MM.YYYY"
)