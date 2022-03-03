SET SERVEROUTPUT ON;
--1 simplest anon block
begin
    null;
end;

--2 print HW!
declare 
    x char(15) :=  'Hello world';
begin
    dbms_output.put_line(x);
end;

--3   use errm,sqlcode
--sqlerrm ????????????????? ??? ?????????? ?????????-- ??????
--sqlcode ????? ??????
declare 
    z number (10, 2);
begin 
    z := 5 / 0;
    dbms_output.put_line('I did not sleep to do it');
EXCEPTION
    when OTHERS
    then dbms_output.put_line('# = ' || sqlcode|| chr(10) || 'error = ' || sqlerrm);
end;

--4 nested block, show exepcion there
declare
    z number(10 , 2) := 3;
begin
    begin
        z := 5 / 0;
    exception
        when OTHERS
        then dbms_output.put_line('# = ' || sqlcode|| chr(10) || 'error = ' || sqlerrm);
    end;
    dbms_output.put_line('z = '||z);
end;

--5 type of warnings comiler supp at this moment
show parameter plsql_warnings;
select name, value from v$parameter where name = 'plsql_warnings';

--6 all spectial symbols
select keyword from v$reserved_words where length = 1 and keyword != 'A';

--7 all key words pl\sql
select keyword from v$reserved_words where length > 1 and keyword!='A' order by keyword;

--8 wotch all parameters Oracle Server connected PL/SQL. And check it in SQL+
select name,value from v$parameter where name like 'plsql%';
show parameter plsql;

--9
declare
        c1 number(3)        := 25;  --10
        c2 number(3)        := 10;
        mult number(3);
        div number(10,2);
        fix number(10,2)    := 3.12;
        otr number(4, -5)   := 32.12345;              --12, 13
        bf binary_float     := 123456789.12345678911; --14
        bd binary_double    := 123456789.12345678911; --15
        en number(32,10)    := 12345E-10;             --16
        b1 boolean          := true;                  --17
    
    begin
        div := mod(c1,c2);    --11
        mult := (c1 * c2);
        dbms_output.put_line('c1 = '||c1);
        dbms_output.put_line('c2 = '||c2);
        dbms_output.put_line('c1%c2 = '||div);
        dbms_output.put_line('c1*c2 = '||mult);
        dbms_output.put_line('fix = '||fix);
        dbms_output.put_line('otr = '||otr);
        dbms_output.put_line('en = '||en);
        dbms_output.put_line('bf = '||bf);
        dbms_output.put_line('bd = '||bd);
        if b1 then dbms_output.put_line('b1 = '||'true'); end if;
    end;
--18
declare
    n constant number(5) := 9;
    v constant varchar2(5) := '2 hii';
    c constant char(5) := 'c hii';
begin
    dbms_output.put_line('const n = '||n);
    dbms_output.put_line('const n + n = '||(n+n));    
    dbms_output.put_line('const n * 5 = '||(n*5)); 
    dbms_output.put_line('const v = '||v);
    dbms_output.put_line('const c = '||c);
  --n := 10;
    exception 
        when others
        then dbms_output.put_line('error = '||n);
end;

--19-20
select *from faculty;

declare
   v varchar(25) := 'word';
   t v%TYPE := 'type v';
   r  faculty%ROWTYPE;
begin
    dbms_output.put_line('v = '||v);
    dbms_output.put_line('t = '||t);
    r.faculty := 'hi';
    dbms_output.put_line(r.faculty);
        exception 
        when others
        then dbms_output.put_line('error = '||sqlerrm);
end;

--21
declare
    x pls_integer := 17;
begin
    if 8>x then
      dbms_output.put_line('8 > '||x);
    elsif 8=x then 
      dbms_output.put_line('8 = '||x);
    else 
      dbms_output.put_line('8<'||x);
    end if;
end;

--23
declare
    x pls_integer := 9;
begin
    case x
        when 9 then dbms_output.put_line('9');
        else dbms_output.put_line('else');
    end case;
    case
        when 3 = x then dbms_output.put_line('3 ='||x);
        when x between 4 and 8 then dbms_output.put_line('between');
        else dbms_output.put_line('else');
    end case;
end;

--24  use loop
declare 
  i number(3) := 0;
begin
  loop
    dbms_output.put_line(i);
    i := i + 1;
  exit when i > 10;
  end loop;
end;
-- 24 use while
declare 
  i number(3) := 0;
begin
  while(i <= 8)
  loop
    dbms_output.put_line(i);
    i := i + 1;
  end loop;
end;

-- 25 use for
begin
  for i in 0..7
  loop
    dbms_output.put_line(I);
  end loop;
end;
