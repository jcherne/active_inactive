drop table if exists ods.active_inactive;
CREATE TABLE ods.active_inactive
(
  extract_dt string, 
  payer_cd string,
  active_inactive STRING, 
  membership_start_date string , 
  membership_start_date_ts timestamp , 
  membership_start_date_int integer , 
  membership_expiration_date STRING,
  membership_expiration_date_ts timestamp,
  membership_expiration_date_int integer,
  opt_in_out_status string,
  first_name string,
  last_name  string,
  middle_name string,
  dob         string,
  payer_id    string,
  ng_euid     string,
  load_filename string
 ) 
 partitioned by ( yearmonth integer,run_date integer )  stored as parquet; 