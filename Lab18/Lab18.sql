drop table lb18;
create table lb18
(
id number(10) primary key,
text varchar2(20),
date_value date
);
delete from lb18;
select *from lb18;
commit;
-- in directory
--sqlldr system/Ap****3 control = 'control.ctl'


spool 'export.txt'
select * from lb18;
spool off;
exit