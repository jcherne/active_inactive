drop table if exists staging.active_inactive;
CREATE EXTERNAL TABLE staging.active_inactive
(
  extract_dt string, 
  payer_cd string,
  active_inactive STRING, 
  membership_start_date string , 
  membership_expiration_date STRING,
  opt_in_out_status string,
  first_name string,
  last_name  string,
  middle_name string,
  dob         string,
  payer_id    string,
  ng_euid     string 
 ) 
 COMMENT 'This is the staging page view table'
 ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
 STORED AS TEXTFILE
 LOCATION ' /ftp_files/active_inactive';