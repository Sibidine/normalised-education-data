/*create table indicator_column_map(
	icm_id serial,
	i_name text,
	c_name text
);*/

/*create or replace procedure filter_indicators()
as $$
declare
	ind record;
	col record;
	quer text;
	i integer;
	j integer;
begin
	--primary_edu
	i := 0;
	j := 0;
	for ind in (select distinct(indicator_name) as indname 
				from edstats_data 
				where indicator_name in 
				(select indicator_name 
				 from edstatsseries 
				 where topic = 'Primary' 
				 and indicator_name not like '%Africa Dataset%'
				)
			   )
	loop
		j := 0;
		for col in (select column_name from information_schema.columns where 
					table_name = 'primary_edu'
					and column_name not like 'year'
					and column_name not like 'country_code')
		loop
			quer := 'insert into indicator_column_map(i_name,c_name) values(' 
					  		|| quote_literal(ind.indname::text)
					  		|| ','
							|| quote_literal(col.column_name::text)
						    || ')';
			if i = j
			then
				execute quer;
			end if;
			j := j + 1;
		end loop;
		i := i + 1;
	end loop;
end;
$$ language 'plpgsql'*/

call filter_indicators();