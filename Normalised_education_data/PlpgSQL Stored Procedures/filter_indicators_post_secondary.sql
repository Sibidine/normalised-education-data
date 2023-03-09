create or replace procedure filter_indicators_post_sec()
as $$
declare
	col record;
	quer text;
begin
	for col in select distinct(indicator_name) from post_sec_inter
	loop
		quer := 'insert into indicator_column_map(i_name) values('
		|| quote_literal(col.indicator_name::text)
		|| ')';
		execute quer;
	end loop;
	
end
$$ language 'plpgsql'

--update indicator_column_map set c_name = 'official_entrance_age' where i_name like '%Official%';
--update indicator_column_map set c_name = 'theoretical_duration' where i_name like '%Theoretical%';
--update indicator_column_map set c_name = 'female' where i_name like '%female%'