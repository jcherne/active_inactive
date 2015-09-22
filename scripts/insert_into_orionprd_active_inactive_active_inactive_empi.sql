insert into table orionprd_active_inactive.active_inactive_empi
(
  euid, 
  source,
  local_id, 
  first_name,
  last_name,
  middle_initial,
  dob,
  opt_in_status,
  run_date
  )
  select
  cast(euid as integer) as euid, 
  regexp_REPLACE(source,'"','') as source,
  regexp_REPLACE(local_id,'"','') as local_id, 
  regexp_REPLACE(first_name,'"','') as first_name,
  regexp_REPLACE(last_name,'"','') as last_name,
  regexp_REPLACE(middle_initial,'"','') as middle_initial,
  regexp_REPLACE(dob,'"','') as  dob,
  regexp_REPLACE(opt_in_status,'"','') as opt_in_status,
  now() as run_date
  from staging.active_inactive_empi;
  

  