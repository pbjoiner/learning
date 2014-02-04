-- splitstring
--
-- Returns the specified instance of a substring from a longer
-- string after dividing that string by instances of a shorter
-- string. Essentially, this duplicates the function of Perl's
-- split() function and allows the user to specify which bit 
-- they want.  

create or replace function splitstring (
	myString in varchar2,
	mySplitter in varchar2,
	myInstance in number
) return varchar2
is
	type array_v is table of varchar2(60);
	retArray   array_v;
	thisString varchar2(60) := myString;

begin
	
	retArray.delete;
	
	while (instr(thisString, mySplitter) > 0)
	loop
		retArray.extend;
		retArray(retArray.count) := substr(thisString, 1, instr(thisString, mySplitter));
		thisString := substr(thisString, instr(thisString, mySplitter) + 1);
	end loop;

	if retArray.count >= myInstance then
		return retArray(myInstance);
	
	else
		return '';
	end if;
end splitstring;
/
grant execute on splitstring to public;
