-- FUNCTION: p_interface.add_import_data_type(character varying, character varying, text)

-- DROP FUNCTION IF EXISTS p_interface.add_import_data_type(character varying, character varying, text);

CREATE OR REPLACE FUNCTION p_interface.add_import_data_type(
	p_type_oper character varying,
	p_data_type character varying,
	p_data_value text)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

	BEGIN
      -- добавить историю данных
      if p_data_type = 'csv'
      then
         insert into p_interface.import_data_type(type_oper, data_type, data_text)
           values (p_type_oper, p_data_type, p_data_value);
      elsif p_data_type = 'xml'    
      then
         insert into p_interface.import_data_type(type_oper, data_type, data_xml)
           values (p_type_oper, p_data_type, p_data_value::xml);
           
      elsif p_data_type = 'json'
      then
         insert into p_interface.import_data_type(type_oper, data_type, data_json)
           values (p_type_oper, p_data_type, to_json(p_data_value));
           
      end if;
      
      return 1;
	END;
$BODY$;

ALTER FUNCTION p_interface.add_import_data_type(character varying, character varying, text)
    OWNER TO test_user;
