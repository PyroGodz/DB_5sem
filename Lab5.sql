--1. get list of all files tablespaces( permanent and temperary)
select tablespace_name, file_name from DBA_DATA_FILES; 
select tablespace_name, file_name from DBA_TEMP_FILES;

--2. create tablespace with statement offline XXX_QDATA
drop tablespace MTD_QDATA including contents and datafiles;

create tablespace MTD_QDATA
    datafile 'C:\DB\Tablespaces\MTD_QDATA.dbf'
    size 10m
    extent management local
    offline;
    
    
--alter to statement - online.
alter tablespace MTD_QDATA online;
-----------user-----------------------
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
select *from DBA_USERS; -- mtd

drop user mtd cascade;
create user mtd identified by 12345;
grant create session,
      create table, 
      create view, 
      create procedure,
      drop any table,
      drop any view,
      drop any procedure to mtd;
------------------------------------
--give to user quot 2m in tablespace XXX_QDATA.
alter user mtd quota 2m on MTD_QDATA;

--XXX_T1 create table and insert 3 values

create table mtd_t1 (
    a number(5) primary key,
    aa number(5)) tablespace MTD_QDATA;

grant insert on mtd_t1 to mtd;
    
insert into mtd_t1 values(1,1);
insert into mtd_t1 values(2,2);
insert into mtd_t1 values(3,3);
commit;

select * from mtd_t1;
--3. get list of segments of tablespace mtd_QDATA
--segments list
select * from dba_segments where tablespace_name like 'MTD%';
select * from dba_segments;
--SYS_C009903 is index

--4. drop table. show user_recyclebin. explain result.

  
drop table mtd_t1;    -- do it as mtd y will get hist. If use as sysdba -   drop   purge 
--segment name 'bin......'
select object_name, original_name from user_recyclebin; 
--dropped objects
select * from dba_recyclebin; -- 4 sysdba
select * from user_recyclebin;  -- 4 mtd

--5 recovery deleted(dropted) table
flashback table mtd_t1 to before drop;
select * from mtd_t1;
--6 insert 10k values
drop table mtd_t1;

create table mtd_t1 (
    a number(5) primary key,
    aa number(5)) tablespace MTD_QDATA;

begin
  for x in 0..10000
  loop
    insert into mtd_t1 values(x, x);
  end loop;
  commit;
end;

select *from mtd_t1;

--7 calculate how many extends, his size in blocks and bites.
select *from DBA_EXTENTS where SEGMENT_NAME like 'MTD%';
select extent_id, blocks, bytes from DBA_EXTENTS where SEGMENT_NAME like 'MTD%';
select *from DBA_EXTENTS;

--8. drop tablespace and his file
drop tablespace MTD_QDATA including contents and datafiles;

--9 get all groups jurnal repeate(current repeate jurnal)
select *from v$log;

--10  get all FILES groups jurnal repeate of instatce
select *from v$logfile;

--11  ? ??????? ???????????? ???????? ??????? ???????? ?????? ???? ????????????.
--???????? ????????? ????? ? ?????? ?????? ??????? ???????????? (??? ??????????? ??? ?????????? ????????? ???????).
ALTER SYSTEM SWITCH LOGFILE;
select *from v$log;
--current 1
--27-dec-21
--curent 2    29-dec-21
--active 1    
--

--12
alter database add logfile group 4 'C:\app\ora_install_user\oradata\orcl\REDO04.LOG'  size 50 m blocksize 512;
alter database add logfile member 'C:\app\ora_install_user\oradata\orcl\REDO041.LOG'  to group 4;
alter database add logfile member 'C:\app\ora_install_user\oradata\orcl\REDO042.LOG'  to group 4;

select group#, sequence#, bytes, members, status, first_change# from v$log;

--13-------------------
alter database drop logfile member 'C:\app\ora_install_user\oradata\orcl\REDO04.LOG';
alter database drop logfile member 'C:\app\ora_install_user\oradata\orcl\REDO041.LOG';
alter database drop logfile member 'C:\app\ora_install_user\oradata\orcl\REDO042.LOG';

alter database clear unarchived logfile group 4;
alter database drop logfile group 4;
select group#, sequence#, bytes, members, status, first_change# from v$log;

--14  14. ??????????, ??????????? ??? ??? ????????????? ???????? ???????
--(????????????? ?????? ???? ?????????, ????? ?????????, ???? ?????? ??????? ???????? ??????? ? ????????).
SELECT NAME, LOG_MODE FROM V$DATABASE;
SELECT INSTANCE_NAME, ARCHIVER, ACTIVE_STATE FROM V$INSTANCE;

--15
SELECT * FROM V$ARCHIVED_LOG;

--16
--??? ?????????????
--shutdown immediate;
--startup mount;
--alter database noarchivelog;
--alter database open;

select name, log_mode from v$database;
SELECT INSTANCE_NAME, ARCHIVER, ACTIVE_STATE FROM V$INSTANCE;

--17
ALTER SYSTEM SET LOG_ARCHIVE_DEST_1 ='LOCATION=C:\app\ora_install_user\oradata\orcl\archive.arc';

alter system switch logfile;
select * from v$archived_log;

--19
select *from v$controlfile_record_section;

--20
show parameter control;
-- is defined as the set of actions taken by the network to monitor and control traffic
--21
ALTER DATABASE BACKUP CONTROLFILE TO TRACE;
show parameter spfile ;

--22
--CREATE PFILE='mtd_pfile.ora' FROM SPFILE;

--23
--database/pwdorcl
SELECT * FROM V$PWFILE_USERS;

--24
SELECT * FROM V$DIAG_INFO;



