CREATE OR REPLACE FUNCTION p_convert.str_days(p_value integer)
 RETURNS character varying
 LANGUAGE plpgsql
 STABLE
AS $function$
DECLARE
    -- Описание (дні)
    result     varchar(255);
    p_name_day varchar(255);
    DayValue   integer;
    CResult    varchar(20);
    l          integer;
begin	
    DayValue := Trunc(p_value);
    CResult := to_char(DayValue);
    l := length(CResult);

    if ((l>1) and (to_number(substr(CResult,l-1,2))>10) and (to_number(substr(CResult,l-1,2))<20))
     then
       p_name_day := ' днів ';
    elsif to_number(substr(CResult,l,1))=0
     then
       p_name_day := ' днів ';
    elsif to_number(substr(CResult,l,1))=1
     then
       p_name_day := ' день ';
    elsif (to_number(substr(CResult,l,1))=2) or (to_number(substr(CResult,l,1))=3) or (to_number(substr(CResult,l,1))=4)
     then
       p_name_day:= ' дні ';
    else
       p_name_day := ' днів ';
    end if;

    Result := p_name_day;

    return (trim(substr(Result, 1, 255)));
  exception when others
  then
    return(Result);
  end;              
  
$function$
;
