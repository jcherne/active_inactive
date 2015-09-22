drop table if exists staging.active_inactive_empi;
CREATE EXTERNAL TABLE staging.active_inactive_empi
(
  euid string, 
  source string,
  local_id STRING, 
  first_name string,
  last_name  string,
  middle_initial string,
  dob         string,
  opt_in_status   string
  ) 
 COMMENT 'This is the staging page view table'
 ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
 STORED AS TEXTFILE
 LOCATION ' /ftp_files/active_inactive/empi';