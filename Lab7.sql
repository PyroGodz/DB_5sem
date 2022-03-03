--1 Get full list of background proccesses
select * from v$bgprocess;

--2 define background proccesses, that execute and work in current moment
select *from v$process where background is not null;
select *from v$process;

--3 define how many proccesses DBWn works in current moment
show parameter db_writer_processes;
select *from v$process where pname like 'DBW%';

--4 get list current sessions with exemplar
select * from v$instance;

--5 define regime of this connections
select username, server from v$session;

--6 define services (points of connections exemplar)
select * from v$services;  

--7 get known for y parameters of despetcher'a and their values
show parameter dispatcher;

--8 get in list windows-serviceses service realizing proccess LISTENER
--OracleOraDB19Home1TNSListener

--9 Get list current connections with instance
select username, server from v$session;

--10 B lect marked only key && host + port
--C:\app\ora_install_user\product\12.1.0\dbhome_1\NETWORK\ADMIN

--11 execute lsnrctl 
--lsnrctl
--help --> start, stop,status - ready, blocked, unknown
--services, version
--reload - reload the parameter files and SIDs
--save_config - saves configuration changes to parameter file
--trace
--exit
--quit
--help

--12 in lsnrctl too. List services of instance, served by LISTENER
--services