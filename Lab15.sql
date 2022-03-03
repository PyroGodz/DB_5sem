grant create trigger to c##mtd;
SET SERVEROUTPUT ON SIZE UNLIMITED;
commit;
--1
create table lab15 (
 a int primary key,
 b int,
 x varchar(50)
);

drop table lab15;
FLASHBACK table lab15 TO BEFORE DROP;
--2
begin
    for k in 0..9
    loop
    insert into lab15 VALUES (k, k*k, 'M---'||k);
    end loop;
end;

select *from lab15;

--3
--drop trigger before_operation_trigger
create or replace trigger before_operation_trigger
before insert or update or delete on lab15
begin 
    if inserting then
    DBMS_OUTPUT.PUT_LINE('BYDESH RABOTATb___INSERT');
    elsif updating then
    DBMS_OUTPUT.PUT_LINE('BYDESH RABOTATb___UPDATE');
    elsif deleting then
    DBMS_OUTPUT.PUT_LINE('BYDESH RABOTATb___DELETE');
    end if;
end;

insert into lab15 values (11, 22, 'cccc');
update lab15 set b = 100 where a = 11;
delete lab15 where a = 11;

--5

--drop trigger before_row_trigger
create or replace trigger before_row_trigger
before insert or update or delete on lab15  for each row
begin 
    if inserting then
    DBMS_OUTPUT.PUT_LINE('BYDESH RABOTATb_ROW__INSERT');
    elsif updating then
    DBMS_OUTPUT.PUT_LINE('BYDESH RABOTATb_ROW__UPDATE');
    elsif deleting then
    DBMS_OUTPUT.PUT_LINE('BYDESH RABOTATb_ROW__DELETE');
    end if;
end;

--5
--drop trigger after_operator_trigger
create or replace trigger after_operator_trigger
after insert or update or delete on lab15
begin 
    if inserting then
    DBMS_OUTPUT.PUT_LINE('CPABOTALA RABOTA___INSERT');
    elsif updating then
    DBMS_OUTPUT.PUT_LINE('CPABOTALA RABOTA___UPDATE');
    elsif deleting then
    DBMS_OUTPUT.PUT_LINE('CPABOTALA RABOTA___DELETE');
    end if;
end;

--6
--drop trigger after_row_trigger
create or replace trigger after_row_trigger
after insert or update or delete on lab15  for each row
begin 
    if inserting then
    DBMS_OUTPUT.PUT_LINE('CPABOTALA RABOTA_ROW__INSERT');
    elsif updating then
    DBMS_OUTPUT.PUT_LINE('CPABOTALA RABOTA_ROW__UPDATE');
    elsif deleting then
    DBMS_OUTPUT.PUT_LINE('CPABOTALA RABOTA_ROW__DELETE');
    end if;
end;

--9
create table audits(
OperationDate date,
OperationType varchar2(10),
TriggerName varchar2(25),
Data varchar2(50)
);

select *from audits;
drop table audits;
FLASHBACK table audits TO BEFORE DROP;
--10
create or replace trigger before_operation_trigger
before insert or update or delete on lab15
begin 
    if inserting then
    DBMS_OUTPUT.PUT_LINE('BYDESH RABOTATb___INSERT');
    insert into audits values(sysdate, 'insert', 'before_operation_trigge', 'not allowed in table level');
    elsif updating then
    DBMS_OUTPUT.PUT_LINE('BYDESH RABOTATb___UPDATE');
    insert into audits values(sysdate, 'update', 'before_operation_trigge', 'not allowed in table level');
    elsif deleting then
    DBMS_OUTPUT.PUT_LINE('BYDESH RABOTATb___DELETE');
    insert into audits values(sysdate, 'delete', 'before_operation_trigge', 'not allowed in table level');
    end if;
end;

create or replace trigger before_row_trigger
before insert or update or delete on lab15 for each row
begin 
    if inserting then
    DBMS_OUTPUT.PUT_LINE('BYDESH RABOTATb_ROW__INSERT');
    insert into audits values(sysdate, 'insert', 'before_row_trigger', 'old:'||:old.a|| '-' ||:old.b|| '-'|| :old.x || 'new:' || :new.a || '-'|| :new.b || '-'|| :new.x);
    elsif updating then
    DBMS_OUTPUT.PUT_LINE('BYDESH RABOTATb_ROW__UPDATE');
    insert into audits values(sysdate, 'update', 'before_row_trigger', 'old:'||:old.a|| '-' ||:old.b|| '-'|| :old.x || 'new:' || :new.a || '-'|| :new.b || '-'|| :new.x);
    elsif deleting then
    DBMS_OUTPUT.PUT_LINE('BYDESH RABOTATb_ROW__DELETE');
    insert into audits values(sysdate, 'delete', 'before_row_trigger', 'old:'||:old.a|| '-' ||:old.b|| '-'|| :old.x || 'new:' || :new.a || '-'|| :new.b || '-'|| :new.x);
    end if;
end;

create or replace trigger after_operator_trigger
after insert or update or delete on lab15
begin 
    if inserting then
    DBMS_OUTPUT.PUT_LINE('CPABOTALA RABOTA___INSERT');
    insert into audits values(sysdate, 'insert', 'after_operator_trigger', 'not allowed in table level');
    elsif updating then
    DBMS_OUTPUT.PUT_LINE('CPABOTALA RABOTA___UPDATE');
     insert into audits values(sysdate, 'update', 'after_operator_trigger', 'not allowed in table level');
    elsif deleting then
    DBMS_OUTPUT.PUT_LINE('CPABOTALA RABOTA___DELETE');
    insert into audits values(sysdate, 'delete', 'after_operator_trigger', 'not allowed in table level');
    end if;
end;

create or replace trigger after_row_trigger
after insert or update or delete on lab15 for each row
begin 
    if inserting then
    DBMS_OUTPUT.PUT_LINE('CPABOTALA RABOTA_ROW__INSERT');
    insert into audits values(sysdate, 'insert', 'after_row_trigger', 'old:'||:old.a|| '-' ||:old.b|| '-'|| :old.x || 'new:' || :new.a || '-'|| :new.b || '-'|| :new.x);
    elsif updating then
    DBMS_OUTPUT.PUT_LINE('CPABOTALA RABOTA_ROW__UPDATE');
    insert into audits values(sysdate, 'update', 'after_row_trigger', 'old:'||:old.a|| '-' ||:old.b|| '-'|| :old.x || 'new:' || :new.a || '-'|| :new.b || '-'|| :new.x);
    elsif deleting then
    DBMS_OUTPUT.PUT_LINE('CPABOTALA RABOTA_ROW__DELETE');
    insert into audits values(sysdate, 'delete', 'after_row_trigger', 'old:'||:old.a|| '-' ||:old.b|| '-'|| :old.x || 'new:' || :new.a || '-'|| :new.b || '-'|| :new.x);
    end if;
end;


select *from audits;

insert into lab15 values (11, 22, 'cccc');
update lab15 set b = 100 where a = 11;
delete lab15 where a = 11;

--11
insert into lab15 values (9, 9, 'CHTO-CHTO??');

select * from lab15;
select *from audits;
drop table audits;
FLASHBACK table audits TO BEFORE DROP;

--12
drop table lab15;
FLASHBACK table lab15 TO BEFORE DROP;

--drop trigger enable_drop;
create or replace trigger enable_drop
before drop on SCHEMA
begin
    if SYS.dictionary_obj_name = 'LAB15'
    then raise_application_error(-20000, 'Haha, u cant drop '||ORA_DICT_OBJ_TYPE|| ' ' || ORA_DICT_OBJ_NAME);
    end if;
end;

--13
drop table audits;
--FLASHBACK table audits TO BEFORE DROP;
select trigger_name, table_name, status from user_triggers;

alter trigger enable_drop disable;
--alter trigger enable_drop enable;

--14
create or replace view lab_view as SELECT * FROM lab15;
    
CREATE OR REPLACE TRIGGER instead_trigg
instead of insert on lab_view
BEGIN
    if inserting then
        dbms_output.put_line('insert');
        insert into lab15 VALUES (100, 500, 'eee');
    end if;
END instead_trigg;

insert into lab_view values(12, 12, 'kkk');
delete lab15 where a = 100;
select *from lab_view;
select *from lab15;