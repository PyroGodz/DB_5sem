--1 DONE
SET SERVEROUTPUT ON SIZE UNLIMITED

alter table TEACHER drop column Birthday;
alter table TEACHER drop column SALARY;

alter table TEACHER add BIRTHDAY date;
alter table TEACHER add SALARY number(6,2);


-- into data
DECLARE
    cursor c_teacher is select TEACHER, BIRTHDAY, SALARY from TEACHER;
    l_data TEACHER.BIRTHDAY % type;
    l_salary TEACHER.SALARY % type;
    BEGIN
      SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);


    for row_teacher in c_teacher
    loop
      l_data := TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '1960-01-01','J'),TO_CHAR(DATE '2000-12-31','J'))),'J');
          SYS.DBMS_OUTPUT.PUT_LINE(l_data);

      l_salary := Round(DBMS_RANDOM.Value(20000, 200000)) / 100;
         SYS.DBMS_OUTPUT.PUT_LINE(l_salary);

    update TEACHER set TEACHER.BIRTHDAY = l_data, TEACHER.SALARY = l_salary where TEACHER.TEACHER = row_teacher.TEACHER;
      end loop;
END;

select * from teacher;

--rollback
--commit
--2
DECLARE
    LastName   TEACHER.TEACHER_NAME % type;
    FirstName  TEACHER.TEACHER_NAME % type;
    Patronymic TEACHER.TEACHER_NAME % type;

    pos_name INT:= 0;
    pos_patronymic INT:= 0;
    CURSOR c_teacher IS SELECT TEACHER_NAME FROM TEACHER;
BEGIN
        SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);
        for l_teachername in c_teacher
        loop
            pos_name := INSTR(l_teachername.TEACHER_NAME, ' ');
            pos_patronymic := INSTR(l_teachername.TEACHER_NAME, ' ', pos_name + 1);

            LastName := SUBSTR(l_teachername.TEACHER_NAME, 1, pos_name);

            FirstName := SUBSTR(l_teachername.TEACHER_NAME, pos_name, pos_patronymic-1);
            FirstName := SUBSTR(FirstName, 2, 1);

            Patronymic := SUBSTR(l_teachername.TEACHER_NAME, pos_patronymic);
            Patronymic := SUBSTR(Patronymic, 2, 1);

            SYS.DBMS_OUTPUT.PUT_LINE(LastName||' '||FirstName||'.'||Patronymic||'.');

        END LOOP;
END;

--3                                              d - day of week(1-7) 1-sunday
 select * from teacher where TO_CHAR((birthday), 'd') = 2;
 
--4
create view V_BIRTHDAY_ON_NEXT_MONTH as select * from TEACHER where to_char(BIRTHDAY,'Month') = to_char(sysdate + 30,'Month');

select * from V_BIRTHDAY_ON_NEXT_MONTH;
--select * from TEACHER
-- drop view V_BIRTHDAY_ON_NEXT_MONTH; 

--5
create view COUNT_BIRTHDAY_TEACHER as select
    sum(case when extract(month from BIRTHDAY) = 1  then 1 else 0 end) as "January",
    sum(case when extract(month from BIRTHDAY) = 2  then 1 else 0 END) as "February ",
    sum(case when extract(month from BIRTHDAY) = 3  then 1 else 0 END) as "March ",
    sum(case when extract(month from BIRTHDAY) = 4  then 1 else 0 END) as "April ",
    sum(case when extract(month from BIRTHDAY) = 5  then 1 else 0 END) as "May",
    sum(case when extract(month from BIRTHDAY) = 6  then 1 else 0 END) as "June",
    sum(case when extract(month from BIRTHDAY) = 7  then 1 else 0 END) as "Jule",
    sum(case when extract(month from BIRTHDAY) = 8  then 1 else 0 END) as "August",
    sum(case when extract(month from BIRTHDAY) = 9  then 1 else 0 END) as "September",
    sum(case when extract(month from BIRTHDAY) = 10 then 1 else 0 END) as "October",
    sum(case when extract(month from BIRTHDAY) = 11 then 1 else 0 END) as "November",
    sum(case when extract(month from BIRTHDAY) = 12 then 1 else 0 END) as "December"
from TEACHER;

select * from COUNT_BIRTHDAY_TEACHER;
-- drop view COUNT_BIRTHDAY_TEACHER;

--6
DECLARE
    YEAR_BIRTHDAY int;
    cursor c_teacher is select * from TEACHER;
    row_teacher TEACHER % rowtype;
BEGIN
    SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);
    for row_teacher in c_teacher
        loop
            YEAR_BIRTHDAY := (to_number(to_char(sysdate, 'YYYY')) + 1) - to_number(to_char(row_teacher.BIRTHDAY, 'YYYY'));

            if (mod(YEAR_BIRTHDAY,10) = 0)
                then
                    SYS.DBMS_OUTPUT.PUT_LINE(row_teacher.TEACHER_NAME|| ' '|| row_teacher.BIRTHDAY|| ' years: '|| YEAR_BIRTHDAY);
            end if;
        end loop;
END;

select * from TEACHER;
select * from PULPIT;
select * from FACULTY;
--7
cursor Salary(teacher%rowtype) return salary%type is
select pulpit,sum(salary) from teacher
group by pulpit;

--8
  
declare
    type contacts is record
    ( 
        adress VARCHAR2(50),
        phone number(13)
    );
    type person is record
    (
       name teacher.teacher_name%type,
       pulpit teacher.pulpit%type,
       contact contacts
    );
    rec person;
begin
    rec.name := 'Timotey Myadel';
    rec.pulpit := 'FIT';
    rec.contact.adress := 'Pushkina Kolotushkina';
    rec.contact.phone := 375296580546;
    dbms_output.put_line('Name: '||rec.name|| chr(10) ||'Pulpit: '|| rec.pulpit || chr(10)|| 'Phone number: '|| rec.contact.phone);
exception
  when others
      then dbms_output.put_line(sqlerrm);
end;