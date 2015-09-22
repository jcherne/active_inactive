drop table if exists staging.active_inactive_relationship;
CREATE EXTERNAL TABLE staging.active_inactive_relationship
(
  local_id STRING, 
  source string,
  related_entity string,
  relationship_type  string,
  start_date string,
  end_date         string
  ) 
 COMMENT 'This is the staging page view table'
 ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
 STORED AS TEXTFILE
 LOCATION ' /ftp_files/active_inactive/relationship';