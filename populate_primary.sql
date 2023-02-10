create or replace procedure populate_primary()
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
			for col in (select * from indicator_column_map)
			loop
				val_query := 'select "'
				|| yr.years::text
				|| '"as value from primary_inter where country_code = '
				|| quote_literal(country.code::text)
				|| 'and indicator_name like '
				|| quote_literal(col.i_name);
				
				execute val_query into val;
				if val.value is not null
				then
				execute format('update primary_edu set '
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