create table year_list(
	year_id serial,
	years int
);

drop procedure if exists generate_year_lists();
create procedure generate_year_lists()
as $$
declare
	col record;
begin
	for col in (select column_name from information_schema.columns where table_name = 'edstats_data' and data_type in ('integer','numeric','float') )
	loop
		execute format('insert into year_list(years) values('
					  || quote_literal(col.column_name::text)
					  || ')');
	end loop;
end;
$$ language 'plpgsql'

call generate_year_lists();
