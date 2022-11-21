CREATE SEQUENCE public.users_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;

DROP TABLE public.users;

CREATE TABLE public.users (
	id_user int4 NOT NULL DEFAULT nextval('users_id_seq'::regclass),
	device_id varchar NULL,
	ds_firstname varchar NULL,
	ds_lastname varchar NULL,	
	ds_login varchar NULL,
	ds_pwd varchar NULL,
	fl_status int4 default 1,
	reg_ins timestamp default current_timestamp, 
	reg_upd timestamp null, 
	reg_del timestamp null,
	CONSTRAINT id_user_un UNIQUE (id_user),
	CONSTRAINT users_pk PRIMARY KEY (id_user)
);	

INSERT INTO public.users (device_id,ds_firstname,ds_lastname,ds_login,ds_pwd) VALUES ('0357789642345067','Willian','Santos','WOS83','12345678');

select * from public.users u ;

-- //**//

CREATE SEQUENCE public.devices_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;

DROP TABLE public.devices;

CREATE TABLE public.devices (
	id_device int4 NOT NULL DEFAULT nextval('devices_id_seq'::regclass),	
	device_id varchar NULL,	
	ds_name varchar NULL,
	ds_imei varchar NULL,	
	ds_serial_number varchar NULL,
	ds_model varchar NULL,	
	fl_status int4 default 1,
	reg_ins timestamp default current_timestamp, 
	reg_upd timestamp null, 
	reg_del timestamp null,
	CONSTRAINT id_device_un UNIQUE (id_device),
	CONSTRAINT devices_pk PRIMARY KEY (id_device)
);	

INSERT INTO public.devices (device_id,ds_name,ds_imei,ds_serial_number,ds_model) VALUES ('0357789642345067','XPTO','0123456789','SN987654321X','5G-GPS');

select * from public.devices d ;

-- //**//

drop table last_positions;

select * from POSITIONS_LAST;
select * from users;
select * from logs;

-- //**//

INSERT INTO USERS (
ID_USER
,DS_NAME
,DS_ROLE
,ID_GROUP
,DS_GROUP
,DS_LOGIN
,DS_PASSWORD
,DS_PHONE
,DS_EMAIL
,DT_CREATEAT
,DT_UPDATEAT
,DT_LASTLOGIN
,ID_ENTITY
,DS_ENTITY
,ID_ENTITY_TYPE
,DS_ENTITY_TYPE
,DS_TOKEN_TYPE
,DS_TOKEN
,DT_TOKEN
,NR_TOKEN_LIFETIME
,DT_TOKEN_EXPIRE
)VALUES(
146 --ID_USER
,'William Santos' --,DS_NAME
,'Analista de Sistemas' --,DS_ROLE
,2 --,ID_GROUP
,'Administrador Contratante' --,DS_GROUP
,'william' --,DS_LOGIN
,'#h#p0te5YZ' --,DS_PASSWORD
,'(11) 99679-2013' --,DS_PHONE
,'m16@m16.com.br' --,DS_EMAIL
,'2022-11-02 09:10:06' --,DT_CREATEAT
,'2022-11-02 09:52:16' --,DT_UPDATEAT
,'2022-11-15 07:15:59' --,DT_LASTLOGIN
,1 --,ID_ENTITY
,'M.S. de Miranda Rastreadores - EPP' --,DS_ENTITY
,1 --,ID_ENTITY_TYPE
,'Pessoa jurídica' --,DS_ENTITY_TYPE
,'Bearer' --,DS_TOKEN_TYPE
,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2Njg1MDc0MDgsImlzcyI6InZwczM1MDY3LnB1YmxpY2Nsb3VkLmNvbS5iciIsIm5iZiI6MTY2ODUwNzQwOCwiZXhwIjoxNjY4NTE0NjA4LCJjb250cmFjdG9yIjp7ImlkIjoxLCJuYW1lIjoiTS5TLiBkZSBNaXJhbmRhIFJhc3RyZWFkb3JlcyAtIEVQUCIsImVudGl0eXR5cGVpZCI6MSwiZW50aXR5dHlwZW5hbWUiOiJQZXNzb2EganVyXHUwMGVkZGljYSIsImNvb3BlcmF0aXZlIjpmYWxzZSwianVyaWRpY2FscGVyc29uIjp0cnVlLCJibG9ja2VkIjpmYWxzZSwidXVpZCI6IjgyN2Q4MzM4LTZkMGMtYmY4NS0zZWEyLWZmMWY2NmZkNzBkMyJ9LCJ1c2VyIjp7ImlkIjoxNDYsIm5hbWUiOiJXaWxsaWFtIFNhbnRvcyIsInVzZXJuYW1lIjoid2lsbGlhbSIsImdyb3VwSUQiOjJ9fQ.WfSSh6SfGJ24f648_Sg4TsxAMpIK7GOQOk9EAIqamZo' --,DS_TOKEN
,'2022-11-15 07:16:48' --,DT_TOKEN
,120 --,NR_TOKEN_LIFETIME
,datetime('DT_TOKEN','+120 minute') --,DT_TOKEN_EXPIRE
);



INSERT INTO USERS (
ID_USER
,DS_NAME
,DS_ROLE
,ID_GROUP
,DS_GROUP
,DS_LOGIN
,DS_PASSWORD
,DS_PHONE
,DS_EMAIL
,DT_CREATEAT
,DT_UPDATEAT
,DT_LASTLOGIN
,ID_ENTITY
,DS_ENTITY
,ID_ENTITY_TYPE
,DS_ENTITY_TYPE
,DS_TOKEN_TYPE
,DS_TOKEN
,DT_TOKEN
,NR_TOKEN_LIFETIME
,DT_TOKEN_EXPIRE
)VALUES(
146 --ID_USER
,'William Santos' --,DS_NAME
,'Analista de Sistemas' --,DS_ROLE
,2 --,ID_GROUP
,'Administrador Contratante' --,DS_GROUP
,'william' --,DS_LOGIN
,'#h#p0te5YZ' --,DS_PASSWORD
,'(11) 99679-2013' --,DS_PHONE
,'m16@m16.com.br' --,DS_EMAIL
,'2022-11-02 09:10:06' --,DT_CREATEAT
,'2022-11-02 09:52:16' --,DT_UPDATEAT
,'2022-11-15 07:28:36' --,DT_LASTLOGIN
,1 --,ID_ENTITY
,'M.S. de Miranda Rastreadores - EPP' --,DS_ENTITY
,1 --,ID_ENTITY_TYPE
,'Pessoa jurídica' --,DS_ENTITY_TYPE
,'Bearer' --,DS_TOKEN_TYPE
,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2Njg1MDgzMDYsImlzcyI6InZwczM1MDY3LnB1YmxpY2Nsb3VkLmNvbS5iciIsIm5iZiI6MTY2ODUwODMwNiwiZXhwIjoxNjY4NTE1NTA2LCJjb250cmFjdG9yIjp7ImlkIjoxLCJuYW1lIjoiTS5TLiBkZSBNaXJhbmRhIFJhc3RyZWFkb3JlcyAtIEVQUCIsImVudGl0eXR5cGVpZCI6MSwiZW50aXR5dHlwZW5hbWUiOiJQZXNzb2EganVyXHUwMGVkZGljYSIsImNvb3BlcmF0aXZlIjpmYWxzZSwianVyaWRpY2FscGVyc29uIjp0cnVlLCJibG9ja2VkIjpmYWxzZSwidXVpZCI6IjgyN2Q4MzM4LTZkMGMtYmY4NS0zZWEyLWZmMWY2NmZkNzBkMyJ9LCJ1c2VyIjp7ImlkIjoxNDYsIm5hbWUiOiJXaWxsaWFtIFNhbnRvcyIsInVzZXJuYW1lIjoid2lsbGlhbSIsImdyb3VwSUQiOjJ9fQ.kw9KLKkOvJuyzDZPV5dXdoxb8_AsChN-Wle6Wqsrl7I' --,DS_TOKEN
,'2022-11-15 07:31:46' --,DT_TOKEN
,120 --,NR_TOKEN_LIFETIME
,datetime('DT_TOKEN','+120 minute') --,DT_TOKEN_EXPIRE

);


INSERT INTO POSITIONS_LAST (
ID_USER
,ID_POSITION_LAST
,DS_TYPE
,EQUIPMENT_ID
,EQUIPMENT_MODEL_ID
,EQUIPMENT_MODEL_NAME
,EQUIPMENT_BRAND_ID
,EQUIPMENT_BRAND_NAME
,TERMINAL_ID
,FIRMWARE_VERSION
,VEHICLE_ID
,PLATE
,VEHICLE_TYPE_ID
,VEHICLE_TYPE_NAME
,VEHICLE_SUB_TYPE_ID
,VEHICLE_SUB_TYPE_NAME
,VEHICLE_BRAND_ID
,VEHICLE_BRAND_NAME
,VEHICLE_MODEL_ID
,VEHICLE_MODEL_NAME
,VEHICLE_COLOR_ID
,VEHICLE_COLOR
,CUSTOMER_ID
,CUSTOMER_NAME
,SUBSIDIARY_ID
,EVENT_DATE
,SYSTEM_DATE
,LATITUDE
,LONGITUDE
,SATELLITES
,COURSE
,ADDRESS
,IGNITION_STATUS
,SPEED
,ODOMETER
,HORIMETER
,POWER_VOLTAGE
,CHARGE
,BATTERY_VOLTAGE
,GSM_SIGNAL_STRENGTH
,INPUTS
,OUTPUTS
,ALARMS
)VALUES(
146 -- ID_USER
,2407 -- ,ID_POSITION_LAST
,'Tracking' -- ,DS_TYPE
,3250 -- ,EQUIPMENT_ID
,60 -- ,EQUIPMENT_MODEL_ID
,'NT20' -- ,EQUIPMENT_MODEL_NAME
,26 -- ,EQUIPMENT_BRAND_ID
,'X3Tech' -- ,EQUIPMENT_BRAND_NAME
,'0359510081341955' -- ,TERMINAL_ID
,'null' -- ,FIRMWARE_VERSION
,0 -- ,VEHICLE_ID
,'null' -- ,PLATE
,0 -- ,VEHICLE_TYPE_ID
,'null' -- ,VEHICLE_TYPE_NAME
,0 -- ,VEHICLE_SUB_TYPE_ID
,'Não informado' -- ,VEHICLE_SUB_TYPE_NAME
,0 -- ,VEHICLE_BRAND_ID
,'null' -- ,VEHICLE_BRAND_NAME
,0 -- ,VEHICLE_MODEL_ID
,'null' -- ,VEHICLE_MODEL_NAME
,0 -- ,VEHICLE_COLOR_ID
,'null' -- ,VEHICLE_COLOR
,0 -- ,CUSTOMER_ID
,'null' -- ,CUSTOMER_NAME
,0 -- ,SUBSIDIARY_ID
,'2022-11-14 13:50:02' -- ,EVENT_DATE
,'2022-11-14 13:50:02' -- ,SYSTEM_DATE
,-23.730952 -- ,LATITUDE
,-47.320528 -- ,LONGITUDE
,11 -- ,SATELLITES
,207 -- ,COURSE
,'null' -- ,ADDRESS
,false -- ,IGNITION_STATUS
,16 -- ,SPEED
,601 -- ,ODOMETER
,1694 -- ,HORIMETER
,13.32 -- ,POWER_VOLTAGE
,-1 -- ,CHARGE
,4 -- ,BATTERY_VOLTAGE
,34 -- ,GSM_SIGNAL_STRENGTH
,'' -- ,INPUTS
,'' -- ,OUTPUTS
,'None' -- ,ALARMS
);

SELECT COUNT(1) AS QTD FROM POSITIONS_LAST WHERE 1 = 1 AND ID_POSITION_LAST = 2466;

select distinct pl.TERMINAL_ID,  pl.* from POSITIONS_LAST pl order by 1 DESC;



select * from POSITIONS_LAST order by 1 DESC;
select * from POSITIONS_LAST;
select * from USERS;
select * from LOGS;

SELECT COUNT(1) AS QTD 
FROM POSITIONS_LAST
WHERE 1 = 1
AND ID_USER = 146
ORDER BY ID_POSITION_LAST DESC;


