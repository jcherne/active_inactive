insert into table orionprd_active_inactive.active_inactive_relationship
(
  local_id, 
  source,
  related_entity,
  relationship_type,
  start_date,
  end_date,
  run_date
  )
  select
  regexp_REPLACE(local_id,'"','') as local_id, 
  regexp_REPLACE(source,'"','') as source,
  regexp_REPLACE(related_entity,'"','') as related_entity,
  regexp_REPLACE(relationship_type,'"','') as relationship_type,
  start_date,
  end_date,
  now() as run_date
  from staging.active_inactive_relationship;
  

  