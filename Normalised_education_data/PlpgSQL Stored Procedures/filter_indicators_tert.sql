create or replace procedure filter_indicators_tert()
as $$
declare
	col record;
	quer text;
begin
	for col in select distinct(indicator_name) from tert_inter
	loop
		quer := 'insert into indicator_column_map(i_name) values('
		|| quote_literal(col.indicator_name::text)
		|| ')';
		execute quer;
	end loop;
	
end
$$ language 'plpgsql'

/*update indicator_column_map set c_name = 'enrol_private' where i_name like '%enrolment%';
update indicator_column_map set c_name = 'grad_female' where i_name like '%graduates%';
update indicator_column_map set c_name = 'female' where i_name like '%students%'*/