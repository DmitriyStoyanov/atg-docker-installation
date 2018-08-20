alter session set "_ORACLE_SCRIPT"=true;

ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/XE/system.dbf' AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;

create user CORE identified by CORE;
create user PUB identified by PUB;
create user CATA identified by CATA;
create user CATB identified by CATB;


-- CORE
grant EXP_FULL_DATABASE to CORE;
grant IMP_FULL_DATABASE to CORE;
grant ADVISOR to CORE;
grant CREATE MATERIALIZED VIEW to CORE;
grant CREATE PROCEDURE to CORE;
grant CREATE PUBLIC SYNONYM to CORE;
grant CREATE SEQUENCE to CORE;
grant CREATE SESSION to CORE;
grant CREATE SYNONYM to CORE;
grant CREATE TABLE to CORE;
grant CREATE TRIGGER to CORE;
grant CREATE VIEW to CORE;
grant SELECT ANY DICTIONARY to CORE;
grant UNLIMITED TABLESPACE to CORE;


-- PUB
grant EXP_FULL_DATABASE to PUB;
grant IMP_FULL_DATABASE to PUB;
grant ADVISOR to PUB;
grant CREATE MATERIALIZED VIEW to PUB;
grant CREATE PROCEDURE to PUB;
grant CREATE PUBLIC SYNONYM to PUB;
grant CREATE SEQUENCE to PUB;
grant CREATE SESSION to PUB;
grant CREATE SYNONYM to PUB;
grant CREATE TABLE to PUB;
grant CREATE TRIGGER to PUB;
grant CREATE VIEW to PUB;
grant SELECT ANY DICTIONARY to PUB;
grant UNLIMITED TABLESPACE to PUB;

-- CATA
grant EXP_FULL_DATABASE to CATA;
grant IMP_FULL_DATABASE to CATA;
grant ADVISOR to CATA;
grant CREATE MATERIALIZED VIEW to CATA;
grant CREATE PROCEDURE to CATA;
grant CREATE PUBLIC SYNONYM to CATA;
grant CREATE SEQUENCE to CATA;
grant CREATE SESSION to CATA;
grant CREATE SYNONYM to CATA;
grant CREATE TABLE to CATA;
grant CREATE TRIGGER to CATA;
grant CREATE VIEW to CATA;
grant SELECT ANY DICTIONARY to CATA;
grant UNLIMITED TABLESPACE to CATA;

-- CATB
grant EXP_FULL_DATABASE to CATB;
grant IMP_FULL_DATABASE to CATB;
grant ADVISOR to CATB;
grant CREATE MATERIALIZED VIEW to CATB;
grant CREATE PROCEDURE to CATB;
grant CREATE PUBLIC SYNONYM to CATB;
grant CREATE SEQUENCE to CATB;
grant CREATE SESSION to CATB;
grant CREATE SYNONYM to CATB;
grant CREATE TABLE to CATB;
grant CREATE TRIGGER to CATB;
grant CREATE VIEW to CATB;
grant SELECT ANY DICTIONARY to CATB;
grant UNLIMITED TABLESPACE to CATB;


set serveroutput on
declare
cursor c1 is select owner,table_name from dba_tables where owner = 'CATA' and table_name != 'schema_version';
cmd varchar2(200);
begin
for c in c1 loop
DBMS_OUTPUT.PUT_LINE(c.owner||'.'||c.table_name);
cmd := 'GRANT SELECT, UPDATE, INSERT, DELETE ON '||c.owner||'.'||c.table_name|| ' to PUB';
execute immediate cmd;
end loop;
end;
/

declare
cursor c1 is select owner,table_name from dba_tables where owner = 'CATB' and table_name != 'schema_version';
cmd varchar2(200);
begin
for c in c1 loop
DBMS_OUTPUT.PUT_LINE(c.owner||'.'||c.table_name);
cmd := 'GRANT SELECT, UPDATE, INSERT, DELETE ON '||c.owner||'.'||c.table_name|| ' to PUB';
execute immediate cmd;
end loop;
end;
/

declare
cursor c1 is select owner,table_name from dba_tables where owner = 'CORE' and table_name != 'schema_version';
cmd varchar2(200);
begin
for c in c1 loop
DBMS_OUTPUT.PUT_LINE(c.owner||'.'||c.table_name);
cmd := 'GRANT SELECT, UPDATE, INSERT, DELETE ON '||c.owner||'.'||c.table_name|| ' to PUB';
execute immediate cmd;
end loop;
end;
/


--alter session set "_ORACLE_SCRIPT"=true;
--drop user CORE cascade;
--drop user PUB cascade;
--drop user CATA cascade;
--drop user CATB cascade;