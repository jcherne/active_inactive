drop table if exists orionprd_active_inactive.active_inactive_relationship;
CREATE TABLE orionprd_active_inactive.active_inactive_relationship
(
  local_id STRING, 
  source string,
  related_entity string,
  relationship_type  string,
  start_date string,
  end_date   string,
  run_date timestamp

 ) 
 stored as parquet; 