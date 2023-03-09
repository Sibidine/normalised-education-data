create or replace procedure filter_isced()
as $$
declare
	i int;
	col record;
	loop_query text;
	quer text;
begin
	for i in 5..8
	loop
		loop_query := 'select distinct(indicator_name) from edstats_data where indicator_name in (select indicator_name from edstatsseries where topic = '
		|| quote_literal('Tertiary'::text) 
		|| ' and indicator_name like '
		|| quote_literal('%ISCED%'::text) 
		|| 'and indicator_name like'
		|| quote_literal('%' || i::text || '%')
		|| ')';
		for col in execute loop_query
		loop
			quer := 'insert into indicator_column_map(i_name,category) values ('
			|| quote_literal(col.indicator_name::text)
			|| ','
			|| quote_literal(i::text)
			|| ')';
			execute quer;
		end loop;
	end loop;
end
$$ language 'plpgsql'
--update indicator_column_map set c_name = 'grad_female' where i_name like '%graduates%';
--update indicator_column_map set c_name = 'enrol_female' where i_name like '%female%' and i_name not like '%graduates%';
--update indicator_column_map set c_name = 'enroll_male' where i_name like '%male%' and i_name not like '%female%';
