-- Table: p_interface.import_data_type

-- DROP TABLE IF EXISTS p_interface.import_data_type;

CREATE TABLE IF NOT EXISTS p_interface.import_data_type
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    type_oper character varying(255) COLLATE pg_catalog."default" NOT NULL,
    data_type character varying(4) COLLATE pg_catalog."default" NOT NULL,
    data_text text COLLATE pg_catalog."default",
    data_xml xml,
    data_json json,
    CONSTRAINT pk_import_data_type PRIMARY KEY (id),
    CONSTRAINT import_data_type_chk CHECK (data_type::text = ANY (ARRAY['xml'::character varying, 'json'::character varying, 'csv'::character varying]::text[]))
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS p_interface.import_data_type
    OWNER to test_user;

COMMENT ON TABLE p_interface.import_data_type
    IS 'Таблица с принятыми данными';

COMMENT ON COLUMN p_interface.import_data_type.id
    IS 'ID';

COMMENT ON COLUMN p_interface.import_data_type.type_oper
    IS 'Тип операции';

COMMENT ON COLUMN p_interface.import_data_type.data_type
    IS 'Тип данных';

COMMENT ON COLUMN p_interface.import_data_type.data_text
    IS 'Данные Text';

COMMENT ON COLUMN p_interface.import_data_type.data_xml
    IS 'Данные XML';

COMMENT ON COLUMN p_interface.import_data_type.data_json
    IS 'Данные JSON';