drop procedure if exists populate_transpose();
create procedure populate_transpose()
as $$
declare
	t_code record;
	t_years record;
begin
	for t_code in (select code from country_code)
	loop
		for t_years in (select years from year_list)
		loop
			execute format('insert into primary_edu(country_code,year) values('
						  || quote_literal(t_code.code::text)
						  || ','
						  || quote_literal(t_years.years::text)
						  || ')');
			execute format('insert into secondary(country_code,year) values('
						  || quote_literal(t_code.code::text)
						  || ','
						  || quote_literal(t_years.years::text)
						  || ')');
			execute format('insert into isced(country_code,year) values('
						  || quote_literal(t_code.code::text)
						  || ','
						  || quote_literal(t_years.years::text)
						  || ')');
			execute format('insert into metric_post_sec_non_tert(country_code,year) values('
						  || quote_literal(t_code.code::text)
						  || ','
						  || quote_literal(t_years.years::text)
						  || ')');			  
			execute format('insert into metric_tert(country_code,year) values('
						  || quote_literal(t_code.code::text)
						  || ','
						  || quote_literal(t_years.years::text)
						  || ')');
			execute format('insert into subject_wise(country_code,year) values('
						  || quote_literal(t_code.code::text)
						  || ','
						  || quote_literal(t_years.years::text)
						  || ')');
		end loop;
	end loop;
end;
$$ language 'plpgsql'

call populate_transpose();