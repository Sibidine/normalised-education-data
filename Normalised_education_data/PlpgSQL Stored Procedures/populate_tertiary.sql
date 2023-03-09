create or replace procedure populate_post_sec()
as $$
declare
	country record;
	yr record;
	val record;
	col record;
	val_query text;
	insertion text;
begin
	for country in (select code from country_code)
	loop
		for yr in (select years from year_list)
		loop
			execute format('insert into metric_tert(country_code,year) values (' 
						   ||quote_literal(country.code::text)
						   || ','
						  || quote_literal(yr.years::text)
						  || ')');
			for col in (select * from indicator_column_map)
			loop
				val_query := 'select "'
				|| yr.years::text
				|| '"as value from tert_inter where country_code = '
				|| quote_literal(country.code::text)
				|| 'and indicator_name like '
				|| quote_literal(col.i_name);
				
				execute val_query into val;
				if val.value is not null
				then
				execute format('update metric_tert set '
				|| col.c_name::text
				|| ' = '
				|| quote_literal(val.value::text)
				|| 'where country_code = '
				|| quote_literal(country.code::text)
				|| 'and year = '
				|| yr.years::text);
				end if;
			end loop;
		end loop;
	end loop;
end
$$ language 'plpgsql'

--delete from metric_post_sec_non_tert where female is null and official_entrance_age is null and theoretical_duration is null;
