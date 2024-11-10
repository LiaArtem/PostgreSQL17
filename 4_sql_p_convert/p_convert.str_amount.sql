CREATE OR REPLACE FUNCTION p_convert.str_amount(p_amount numeric, p_is_default character DEFAULT 'T'::bpchar)
 RETURNS character varying
 LANGUAGE plpgsql
 STABLE
AS $function$
DECLARE
    -- Преобразование суммы в текст    
    dig       varchar(255)[];
    dig_a     varchar(255)[];
    ten       varchar(255)[];
    hun       varchar(255)[];
    tis       varchar(255)[];
    mln       varchar(255)[];
    mlrd      varchar(255)[];
    i         numeric := 0;
    CurrValue numeric;
    S         numeric;
    p_result  varchar(255) := '';
    DIGIT     varchar(255) := '';
    RADIX     varchar(255) := '';

begin	
    CurrValue := trunc(p_amount);
    -- тысячи
    tis[0] := 'тисяч ';
    tis[1] := 'тисяча ';
    tis[2] := 'тисячi ';
    tis[3] := 'тисячi ';
    tis[4] := 'тисячi ';
    tis[5] := 'тисяч ';
    tis[6] := 'тисяч ';
    tis[7] := 'тисяч ';
    tis[8] := 'тисяч ';
    tis[9] := 'тисяч ';
    tis[10] := 'тисяч ';
    tis[11] := 'тисяч ';
    tis[12] := 'тисяч ';
    tis[13] := 'тисяч ';
    tis[14] := 'тисяч ';
    tis[15] := 'тисяч ';
    tis[16] := 'тисяч ';
    tis[17] := 'тисяч ';
    tis[18] := 'тисяч ';
    tis[19] := 'тисяч ';   
    -- мiльйон
    mln[0] := 'мiльйонiв ';
    mln[1] := 'мiльйон ';
    mln[2] := 'мiльйона ';
    mln[3] := 'мiльйона ';
    mln[4] := 'мiльйона ';
    mln[5] := 'мiльйонiв ';
    mln[6] := 'мiльйонiв ';
    mln[7] := 'мiльйонiв ';
    mln[8] := 'мiльйонiв ';
    mln[9] := 'мiльйонiв ';
    mln[10] := 'мiльйонiв ';
    mln[11] := 'мiльйонiв ';
    mln[12] := 'мiльйонiв ';
    mln[13] := 'мiльйонiв ';
    mln[14] := 'мiльйонiв ';
    mln[15] := 'мiльйонiв ';
    mln[16] := 'мiльйонiв ';
    mln[17] := 'мiльйонiв ';
    mln[18] := 'мiльйонiв ';
    mln[19] := 'мiльйонiв ';
    -- мiльярдiв
    mlrd[0] := ' ';
    mlrd[1] := 'мiльярд ';
    mlrd[2] := 'мiльярда ';
    mlrd[3] := 'мiльярда ';
    mlrd[4] := 'мiльярда ';
    mlrd[5] := 'мiльярдiв ';
    mlrd[6] := 'мiльярдiв ';
    mlrd[7] := 'мiльярдiв ';
    mlrd[8] := 'мiльярдiв ';
    mlrd[9] := 'мiльярдiв ';
    mlrd[10] := 'мiльярдiв ';
    mlrd[11] := 'мiльярдiв ';
    mlrd[12] := 'мiльярдiв ';
    mlrd[13] := 'мiльярдiв ';
    mlrd[14] := 'мiльярдiв ';
    mlrd[15] := 'мiльярдiв ';
    mlrd[16] := 'мiльярдiв ';
    mlrd[17] := 'мiльярдiв ';
    mlrd[18] := 'мiльярдiв ';
    mlrd[19] := 'мiльярдiв ';

    Dig[0] := '';
    dig[1] := 'один ';
    dig[2] := 'два ';
    dig[3] := 'три ';
    dig[4] := 'чотири ';
    dig[5] := 'п''ять ';
    dig[6] := 'шiсть ';
    dig[7] := 'сiм ';
    dig[8] := 'вiсiм ';
    dig[9] := 'дев''ять ';
    dig[10] := 'десять ';
    dig[11] := 'одинадцять ';
    dig[12] := 'дванадцять ';
    dig[13] := 'тринадцять ';
    dig[14] := 'чотирнадцять ';
    dig[15] := 'п''ятнадцять ';
    dig[16] := 'шiстнадцять ';
    dig[17] := 'сiмнадцять ';
    dig[18] := 'вiсiмнадцять ';
    dig[19] := 'дев''ятнадцять ';

    Dig_a[0] := '';
    dig_a[1] := 'одна ';
    dig_a[2] := 'двi ';
    dig_a[3] := 'три ';
    dig_a[4] := 'чотири ';
    dig_a[5] := 'п''ять ';
    dig_a[6] := 'шiсть ';
    dig_a[7] := 'сiм ';
    dig_a[8] := 'вiсiм ';
    dig_a[9] := 'дев''ять ';
    dig_a[10] := 'десять ';
    dig_a[11] := 'одинадцять ';
    dig_a[12] := 'дванадцять ';
    dig_a[13] := 'тринадцять ';
    dig_a[14] := 'чотирнадцять ';
    dig_a[15] := 'п''ятнадцять ';
    dig_a[16] := 'шiстнадцять ';
    dig_a[17] := 'сiмнадцять ';
    dig_a[18] := 'вiсiмнадцять ';
    dig_a[19] := 'дев''ятнадцять ';

    ten[0] := '';
    ten[1] := '';
    ten[2] := 'двадцять ';
    ten[3] := 'тридцять ';
    ten[4] := 'сорок ';
    ten[5] := 'п''ятдесят ';
    ten[6] := 'шiстдесят ';
    ten[7] := 'сiмдесят ';
    ten[8] := 'вiсiмдесят ';
    ten[9] := 'дев''яносто ';

    Hun[0] := '';
    Hun[1] := 'сто ';
    Hun[2] := 'двiстi ';
    Hun[3] := 'триста ';
    Hun[4] := 'чотириста ';
    Hun[5] := 'п''ятсот ';
    Hun[6] := 'шiстсот ';
    Hun[7] := 'сiмсот ';
    Hun[8] := 'вiсiмсот ';
    Hun[9] := 'дев''ятсот ';

    if Currvalue = 0
    then
      p_result := 'Нуль ';
    else
      while CurrValue > 0
      loop
        if (CurrValue % 1000) <> 0 
        then 
          S := CurrValue % 100;
          if S < 20 then

            if i <= 1 then
              if p_is_default = 'T' 
              then
                DIGIT := dig_a[s];
              else
                if i = 1 then
                  DIGIT := dig_a[s];
                else
                  DIGIT := dig[s];
                end if;
              end if;
            else
              DIGIT := dig[s];
            end if;

            if i = 0 then
              RADIX := '';
            elsif i = 1 then
              RADIX := tis[s];
            elsif i = 2 then
              RADIX := mln[s];
            elsif i = 3 then
              RADIX := mlrd[s];
            end if;

            p_result := DIGIT||RADIX|| p_result;
          else

            if i <= 1 then
              if p_is_default = 'T' then
                DIGIT := dig_a[mod(s, 10)];
              else
                DIGIT := dig[mod(s, 10)];
              end if;
            else
              DIGIT := dig[mod(s, 10)];
            end if;

            if i = 0 then
              RADIX := '';
            elsif i = 1 then
              RADIX := tis[mod(s, 10)];
            elsif i = 2 then
              begin
              if mod(s, 10) = 0 then
                 RADIX := mln[5];
              else
                 RADIX := mln[mod(s, 10)];
              end if;
              end;
            elsif i = 3 then
              begin
              if mod(s, 10) = 0 then
                 RADIX := mlrd[5];
              else
                 RADIX := mlrd[mod(s, 10)];
              end if;
              end;
            end if;

            p_result := Ten[trunc(S/10)]||DIGIT||RADIX||p_result;

          end if;
          CurrValue := trunc(CurrValue/100);
          S := CurrValue % 10;
          p_result := Hun[S] ||p_result;
          CurrValue := trunc(CurrValue/10);
          i := i + 1;
        else
          CurrValue := trunc(CurrValue/1000);
          i := i + 1;
        end if;
      end loop;
    end if;

    p_result := upper(substr(p_result, 1, 1))||substr(p_result, 2, 254);
    return(trim(both substr(p_result, 1, 255)));

  exception when others
  then 
    return null;
  end;

$function$
;
