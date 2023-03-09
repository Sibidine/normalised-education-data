/*create or replace procedure filter_indicators_subjects()
as $$
declare
	col record;
	quer text;
begin
	/*for col in select distinct(indicator_name) from edstats_data where indicator_name in (select indicator_name from edstatsseries where topic = 'Tertiary' and indicator_name like '%programmes%' and indicator_name like '%graduates%' and indicator_name not like '%ISCED%')
	loop
		quer := 'insert into indicator_column_map(i_name) values(' || quote_literal(col.indicator_name::text) || ')';
		execute quer;
	end loop;
	
	for col in select distinct(indicator_name) from edstats_data where indicator_name in (select indicator_name from edstatsseries where topic = 'Tertiary' and indicator_name like '%programmes%' and indicator_name not like '%graduates%' and indicator_name not like '%ISCED%')
	loop
		quer := 'insert into indicator_column_map(i_name) values(' || quote_literal(col.indicator_name::text) || ')';
		execute quer;
	end loop;*/
	
	--quer := 'update indicator_column_map set c_name = ' || quote_literal('grad_female') || 'where i_name like ' || quote_literal('%graduate%');
	--quer := 'update indicator_column_map set c_name = ' || quote_literal('enroll_female') || 'where i_name not like ' || quote_literal('%graduate%');
	
	execute quer;
end;
$$ language 'plpgsql'*/

update indicator_column_map set category = 'science' where i_name like '%Science%' and i_name not like'%Technology%';