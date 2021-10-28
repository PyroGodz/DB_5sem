--task1
create tablespace TS_MTD
    DATAFILE
    'C:\DB\TS_MTD.DBF'
    size 7M
    autoextend on next 5M
    maxsize 20M
    extent management local uniform size 64K;

--task2
create temporary tablespace TS_MTD_TEMP
  tempfile
    'C:\DB\TS_MTD_TEMP.DBF'
    size 5M
    autoextend on next 3M
    maxsize 30M
    extent management local uniform size 64K;
 
drop tablespace TS_MTD 
drop tablespace TS_MTD_TEMP

--task 3
select tablespace_name, contents from dba_tablespaces;

--task 4
create role RL_MTDCORE;

grant create session,
      create table,
      create view,
      create procedure to RL_MTDCORE;
      
--task 5
alter session set "_ORACLE_SCRIPT"=true;
select * from dba_sys_privs where grantee = 'RL_MTDCORE'

--task 6
create profile PF_MTDCORE LIMIT
  password_life_time 180  --password days of living 
  sessions_per_user 3 --count of sesion 4 user
  failed_login_attempts 7 --count of attempts enter
  password_lock_time 1 --count of days of block after errors
  password_reuse_time 10 --count of days after opportunity of change password
  password_grace_time default --count of days of aware about change password
  connect_time 180  --time of connection, min
  idle_time 30 --count min of idle
  
--task 7
select * from dba_profiles where profile = 'PF_MTDCORE'

--task 8
alter session set "_ORACLE_SCRIPT"=true;
create user MTDCORE identified by 123456
  default tablespace TS_MTD quota unlimited on TS_MTD
  temporary tablespace TS_MTD_TEMP
  profile PF_MTDCORE
  account unlock
  password expire
  
  grant create session to MTDCORE
  
  grant create table,
        create tablespace,
        alter tablespace,
        alter session,
        create user,
        create view to MTDCORE;
  
  select * from dba_users;
--task 9
  select * from v$instance;
    --connect mtdcore/Apahar33

--task 10
  create table smth1 (
    id int,
    descr varchar(10)
  );
  
  create view smth1to1 as 
    select *
    from smth1;
    
  drop table smth1;
  drop view smth1to1;
--task 11
  create tablespace MTD_QDATA
    DATAFILE
    'C:\DB\TS_MTD_QDATA.DBF'
    size 10M
    autoextend on next 5M
    maxsize 20M
    extent management local uniform size 64K
    OFFLINE;

drop tablespace MTD_QDATA;
  alter tablespace MTD_QDATA 
    ONLINE;
    
    
  alter session set "_ORACLE_SCRIPT"=true;
  create user MTD identified by Apahar33
  default tablespace MTD_QDATA quota 2M on MTD_QDATA
  account unlock;
  
  grant create table,
        create session to MTD;  
  
  create table smth2 (
  num int
  )
  
insert into smth2(num) values(1); 
insert into smth2(num) values(1); 
insert into smth2(num) values(1);
select * from smth2;