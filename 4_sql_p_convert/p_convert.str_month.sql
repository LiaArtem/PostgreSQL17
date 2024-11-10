CREATE OR REPLACE FUNCTION p_convert.str_month(p_value integer)
 RETURNS character varying
 LANGUAGE plpgsql
 STABLE
AS $function$
DECLARE
    -- Описание (місяці)
    result       varchar(255);
    p_name_month varchar(255);
    MonthValue   integer;
    CResult      varchar(20);
    l            integer;
  begin
    MonthValue := Trunc(p_value);
    CResult := to_char(MonthValue);
    l := length(CResult);

    if ((l>1) and (to_number(substr(CResult,l-1,2))>10) and (to_number(substr(CResult,l-1,2))<20))
     then
       p_name_month := ' місяців ';
    elsif to_number(substr(CResult,l,1))=0
     then
       p_name_month := ' місяців ';
    elsif to_number(substr(CResult,l,1))=1
     then
       p_name_month := ' місяць ';
    elsif (to_number(substr(CResult,l,1))=2) or (to_number(substr(CResult,l,1))=3) or (to_number(substr(CResult,l,1))=4)
     then
       p_name_month:= ' місяці ';
    else
       p_name_month := ' місяців ';
    end if;

    Result := p_name_month;

    return (trim(substr(Result, 1, 255)));
  exception when others 
  then 
    return(Result);
  end;           
 
$function$
;
