create or replace procedure populate_isced()
as $$
declare
	country record;
	yr record;
	col record;
	val record;
	cat record;
	val_query text;
	insertion text;
	loop_query text;
begin
	for country in (select code from country_code)
	loop
		for yr in (select years from year_list)
		loop
			for cat in (select distinct(category) as category from indicator_column_map)
			loop
            	execute format('insert into isced(country_code,year) values (' 
							   || quote_literal(country.code::text)
							  || ','
							  || quote_literal(yr.years::text)
							  || ')');
				loop_query := 'select * from indicator_column_map where category = '
										  || quote_literal(cat.category::text);
				for col in execute loop_query
				loop
                                val_query := 'select "'
                                || yr.years::text
                                || '"as value from isced_inter where country_code = '
                                || quote_literal(country.code::text)
                                || 'and indicator_name like '
                                || quote_literal(col.i_name);

                                execute val_query into val;
								if val.value is not null
								then
                                execute format('update isced set '
                                || col.c_name::text
                                || ' = '
                                || quote_literal(val.value::text)
                                || 'where country_code = '
                                || quote_literal(country.code::text)
                                || 'and year = '
                                || yr.years::text);
								end if;
					
				end loop;
				execute format('update isced set isced='
							  || quote_literal(cat.category::text)
							  || ' where year = '
							  || yr.years::text 
							  || ' and country_code = '
							  || quote_literal(country.code::text)
							  || ' and isced is null');
			end loop;
		end loop;
	end loop;
end;
$$ language 'plpgsql'