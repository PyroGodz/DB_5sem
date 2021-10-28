drop table MTD_t1;
drop table MTD_t;
create table MTD_t( x number(3) Primary key , s varchar2(50));

insert all
  into MTD_t (x,s) values (1,'Hello')
  into MTD_t (x,s) values (2,'my old')
  into MTD_t (x,s) values (3,'friend')
select * from dual
commit;

select * from MTD_t;

update MTD_t
  set s ='Where have y been'
  where x>1 and x<4;
select * from MTD_t;
commit;

select COUNT(x) from MTD_t;
select MAX(x) from MTD_t;

delete from MTD_t
where s='Hello';
Commit;

select * from MTD_t;

create table MTD_t1 (
column1 number(5), 
columnx number(3),
constraint FK_t1_To_t
foreign key (columnx)
references MTD_t(x)
);

insert all
  into MTD_t1 (column1,columnx) values (1,2)
  into MTD_t1 (column1,columnx) values (2,2)
  into MTD_t1 (column1,columnx) values (3,3)
select * from dual
commit;
select * from MTD_t1;

select x,s,column1 from MTD_t
left outer join MTD_t1
on MTD_t.x = MTD_t1.column1;

select x,s,column1 from MTD_t
right outer join MTD_t1
on MTD_t.x = MTD_t1.column1;


select x,s,column1 from MTD_t
inner join MTD_t1
on MTD_t.x = MTD_t1.column1;
