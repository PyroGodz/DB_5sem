--1 get current size space SGA
select * from v$sga;
select SUM(VALUE) from v$sga;

--2 get current size of main pulles SGA
select * from v$sga_dynamic_components where current_size > 0;

--3 get sizes of "GRANYJl" for each pull
select component, granule_size from v$sga_dynamic_components;

--4 get accesseble V(volum(OB'IOM)) free memory
select current_size from v$sga_dynamic_free_memory;

--5 get sizes of pulles KEEP, DEFAULT, RECYCLE of buffer cache ( In Lect there are 2 ways)
select component, min_size, current_size from v$sga_dynamic_components where component like '%cache%';
--alter system set db_cache_size=600m scope=spfile;
--alter system set db_keep_cache_size=100m scope=spfile;
--alter system set db_recycle_cache_size=100m scope=spfile;

select name, resize_state, block_size, buffers, prev_buffers from v$buffer_pool;

--6 create table that will place pull keep. show segment of table
drop table keep_table;
create table keep_table(x int) storage(buffer_pool keep);
select segment_name, segment_type, tablespace_name, buffer_pool from user_segments where segment_name ='KEEP_TABLE';

--7 create table that will caching pull default. show segment of table
drop table def_table;
create table def_table(x int) cache storage(buffer_pool default);
select segment_name, segment_type, tablespace_name, buffer_pool from user_segments where segment_name ='DEF_TABLE';

--8 find size buffer of jurnal repeates
show parameter log_buffer;

--9 Find 10 most large objects in shared(Razdelyaemom) pull
select *from (select pool, name, bytes from v$sgastat where pool = 'shared pool' order by bytes desc) where rownum <=10;

--10  Find size of free memory in large pool
select pool, name, bytes from v$sgastat where pool = 'large pool' and name = 'free memory';

--11  Get list of current connections with instance
select * from v$session;

--12 Find list of current connections with instance(dedicated, shared)
select username, server from v$session where username is not null;

--13 Find most executing objects in databases
select name,type,executions from v$db_object_cache order by executions desc ;
