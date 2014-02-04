--	$HeadURL: http://scm.corp.convio.com/svn/convio/design/trunk/Deployment_Source/Templates/SQL/Oracle/pivotview.sql $
--	$Id: pivotview.sql 272676 2014-02-04 16:29:45Z pjoiner@convio.com $
--
--	create pivot view of two columns
--	
--	depends upon sys.stragg string aggregation function

create or replace procedure pivotview (
	sourceTable in varchar2,
	sumCol      in varchar2,
	labelCol    in varchar2
)
authid current_user is

	colNames  varchar2(2048);
	
begin

	EXECUTE IMMEDIATE 'select
					substr(max(sys_connect_by_path('''''''' || rtrim(' || labelCol || ') || 
						'''''' as "'' || rtrim(' || labelCol || ') || ''"'', '', '')), 3)
				from (select
						row_number() over (order by 1) as counter,
						''connection'' as connection,
						' || labelCol || ',
						' || sumCol || '
					from ' || sourceTable || ')
				connect by prior
					counter = counter - 1
					and connection = connection'
		INTO colNames;

	EXECUTE IMMEDIATE 'create or replace view ' || sourceTable || 'view as ' ||
		'select * from ' || sourceTable || ' ' ||
		'pivot ( sum(' || sumCol ||') for ' || labelCol || ' in (' || colNames || ') )';

end;
/

grant execute on pivotview to public;
