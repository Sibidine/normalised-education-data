create or replace procedure filter_indicators_secondary()
as $$
declare
	col record;
	quer text;
begin
	for col in (select distinct(indicator_name) as ind from edstats_data where indicator_name in (select indicator_name from edstatsseries where topic = 'Secondary' and indicator_name not like '%Africa%') and indicator_name like '%lower%')
	loop
		quer:= 'insert into indicator_column_map(i_name,category) values('
					  || quote_literal(col.ind::text) || ',' || quote_literal('lower') || ')';
		execute quer;
	end loop;
	
	for col in (select distinct(indicator_name) as ind from edstats_data where indicator_name in (select indicator_name from edstatsseries where topic = 'Secondary' and indicator_name not like '%Africa%') and indicator_name like '%upper%')
	loop
		quer:= 'insert into indicator_column_map(i_name,category) values('
					  || quote_literal(col.ind::text) || ',' || quote_literal('upper') || ')';
		execute quer;
	end loop;
	
	for col in (select distinct(indicator_name) as ind from edstats_data where indicator_name in (select indicator_name from edstatsseries where topic = 'Secondary' and indicator_name not like '%Africa%') and indicator_name not like '%lower%' and indicator_name not like '%upper%')
	loop
		quer:= 'insert into indicator_column_map(i_name,category) values('
					  || quote_literal(col.ind::text) || ',' || quote_literal('') || ')';
		execute quer;
	end loop;
end
$$ language 'plpgsql'