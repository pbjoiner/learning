/*
	remove a user space
*/
create or replace procedure dropUser (
	shortname char
)
authid current_user is

  ifTS  number;
  ifTTS number;
  ifUSR number;

begin

  select count(*)
  into   ifTS
  from   dba_tablespaces
  where  tablespace_name = UPPER(shortname);
  
  if ifTS > 0 then
    execute immediate 'drop tablespace ' || shortname ||
      ' including contents and datafiles cascade constraints';
  end if;

  select count(*)
  into   ifTTS
  from   dba_tablespaces
  where  tablespace_name = UPPER(shortname || '_temp');
  
  if ifTTS > 0 then
    execute immediate 'drop tablespace ' || shortname || '_temp ' ||
      'including contents and datafiles cascade constraints';
  end if;

  select count(*)
  into   ifUSR
  from   dba_users
  where  username = upper(shortname);
  
  if ifUSR > 0 then
    execute immediate 'drop user ' || shortname || ' cascade';
  end if;

end dropUser;
/
grant execute on dropUser to public;
