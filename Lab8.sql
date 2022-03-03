--1 Find sqlnet.ora & tnsnames.ora 
--C:\app\ora_install_user\product\12.1.0\dbhome_1\NETWORK\ADMIN
--2 connect via sqlplus with oracle as system. Get list of parameters
show parameter instance;

--3 connect via sqlplus with connecting DB as user SYSTEM, get list
--of tabplespaces, tabplespaces files, roles, users.
--sqlplus /nolog
--connect system/Ap*****3

select * from v$tablespace;
select * from sys.dba_data_files;
select * from dba_role_privs;
select * from all_users;

--4 check out with parameters in HKEY_LOCAL_MACHINE/SOFTWARE/ORACLE on y computer
--INST_LOC
--Specifies the location of Oracle Universal Installer files. 

--5 execute Oracle Net Manager and get ready connection string with yr name of
--name_your_user_SID - id connected DB
  
--6 sqlplus /nolog
--  connect c##mtd/12345;
-- sqlplus c##mtd/12345

--7 select * from mtd_t1;

--8 help timing
--  timi start
--  timi show
--  timi stop

--9 describe mtd_t1

--10   get list of all segments that mtd is owner
select *from dba_segments where owner = 'C##MTD'; -- for sysdba
select * from user_segments;  --for mtd

--11   create view that give count of all segments, coun of extents,blocks and memory in Kb, that they occupy
create or replace view Lab08 as
select count(*) as count,
    sum(extents) as count_extents,
    sum(blocks) as count_blocks,
    sum(bytes) as Kb from user_segments;
    
select *from Lab08;