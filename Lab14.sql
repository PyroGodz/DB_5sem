GRANT CREATE DATABASE LINK TO c##mtd;
GRANT CREATE PUBLIC DATABASE LINK TO c##mtd;
select * from all_db_links;

drop database link con1;

CREATE DATABASE LINK con1
  CONNECT TO system
  IDENTIFIED BY passwordis   
  USING '(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 10.0.2.15)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl.bye.by)
    )
  )';
  
    select * from t1@con1;
    insert into B@con1 values(4,'UMPA');
    update B@con1 set NAME='BIS' where id=2;
    delete B@con1 where ID=4;
    begin
    dbms_output.put_line(TEACHERSS.GET_NUM_TEACHERS@con1('ÈÄèÏ'));
    end;
    

select * from dba_db_links;
drop public database link con2;


CREATE PUBLIC DATABASE LINK con2
  CONNECT TO MTD_USER
  IDENTIFIED BY passwordis   
  USING 'DESKTOP-4K3JN12:1521/orcl';
 
    select * from B@con2;
    insert into B@con2 values(4,'UMPA');
    update B@con2 set NAME='LUKA' where id=4;
    delete B@con2 where ID=4;
    begin
    dbms_output.put_line(TEACHERSS.GET_NUM_TEACHERS@con2('ÈÄèÏ'));
    end;
    