drop table if exists orionprd_active_inactive.active_inactive_empi;
CREATE TABLE orionprd_active_inactive.active_inactive_empi
(
  euid integer, 
  source string,
  local_id STRING, 
  first_name string,
  last_name  string,
  middle_initial string,
  dob         string,
  opt_in_status   string,
  run_date timestamp

 ) 
 stored as parquet; 