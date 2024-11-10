CREATE OR REPLACE FUNCTION p_convert.str_interest(p_amount numeric)
 RETURNS character varying
 LANGUAGE plpgsql
 STABLE
AS $function$
DECLARE
    -- Преобразование процента с тест (0,5678999% (нуль цiлих i п'ять мiльйонiв шiстсот сiмдесят вiсiм тисяч дев'ятсот дев'яносто дев'ять десятимільйонних процента))
    p_result      varchar(255) := '';
    Fraction      numeric;
    FractionType  varchar(255);
    FractionT     varchar(255);
    FractionFM    varchar(255);
    p_last_amount numeric;

BEGIN
    Fraction := p_amount - Trunc(p_amount);
    FractionT := substr(p_convert.num_to_str(Fraction),3);
    FractionFM := 'FM999,999,999,990.00';
    if    length(FractionT) = 1 then
             FractionType := 'десятих';
             Fraction := Fraction * 10;
    elsif length(FractionT) = 2 then 
             FractionType := 'сотих';
             Fraction := Fraction * 100;
    elsif length(FractionT) = 3 then
             FractionType := 'тисячних';
             Fraction := Fraction * 1000;
             FractionFM := 'FM999,999,999,990.000';
    elsif length(FractionT) = 4 then 
             FractionType := 'десятитисячних';
             Fraction := Fraction * 10000;
             FractionFM := 'FM999,999,999,990.0000';
    elsif length(FractionT) = 5 then 
             FractionType := 'стотисячних';
             Fraction := Fraction * 100000;
             FractionFM := 'FM999,999,999,990.00000';
    elsif length(FractionT) = 6 then 
             FractionType := 'мільйонних';
             Fraction := Fraction * 1000000;
             FractionFM := 'FM999,999,999,990.000000';
    elsif length(FractionT) = 7 then 
             FractionType := 'десятимільйонних';
             Fraction := Fraction * 10000000;
             FractionFM := 'FM999,999,999,990.0000000';
    elsif length(FractionT) = 8 then 
             FractionType := 'стомільйонних';
             Fraction := Fraction * 100000000;
             FractionFM := 'FM999,999,999,990.00000000';
    elsif length(FractionT) > 8 
      then 
         return null;
    end if;

    if Fraction = 0
    then
      p_result := trim(both to_char(p_amount, FractionFM))||'% ('||p_convert.str_amount(p_amount, 'F');

      -- добавляем
      p_last_amount := (substr(p_amount::varchar, -1, 1))::numeric;
      if (p_last_amount in (0,5,6,7,8,9) or p_amount in (11,12,13,14,15,16,17,18,19)) then p_result := p_result||' процентiв)';
      elsif p_last_amount = 1 then p_result := p_result||' процент)';
      elsif p_last_amount in (2,3,4) then p_result := p_result||' процента)';
      else
         p_result := p_result||' процента)';
      end if;

    else
      p_result := trim(both to_char(p_amount, FractionFM))||'% ('||p_convert.str_amount(p_amount);

      if trunc(p_amount) = 1
      then
         p_result := p_result||' цiла i '||lower(p_convert.str_amount(Fraction))||' '||FractionType;
      else
         p_result := p_result||' цiлих i '||lower(p_convert.str_amount(Fraction))||' '||FractionType;
      end if;

      p_result := p_result||' процента)';
    end if;

    p_result := lower(p_result);

    -- замена
    if FractionType is not null and substr(p_convert.num_to_str(p_amount),-1) = '1'
        and substr(p_convert.num_to_str(p_amount),-2) != '11'
    then
        if    length(FractionT) = 1 then p_result := replace(p_result, 'десятих', 'десята');
        elsif length(FractionT) = 2 then p_result := replace(p_result, 'сотих', 'сота');
        elsif length(FractionT) = 3 then p_result := replace(p_result, 'тисячних', 'тисячна');
        elsif length(FractionT) = 4 then p_result := replace(p_result, 'десятитисячних', 'десятитисячна');
        elsif length(FractionT) = 5 then p_result := replace(p_result, 'стотисячних', 'стотисячна');
        elsif length(FractionT) = 6 then p_result := replace(p_result, 'мільйонних', 'мільйонна');
        elsif length(FractionT) = 7 then p_result := replace(p_result, 'десятимільйонних', 'десятимільйонна');
        elsif length(FractionT) = 8 then p_result := replace(p_result, 'стомільйонних', 'стомільйонна');
        end if;
    end if;

    return replace((trim(both substr(p_result, 1, 255))), '.', ',');

  exception when others
  then      
    return null;
  end;

$function$
;
