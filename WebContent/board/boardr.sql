
create database jspdb;
create user 'jspbook'@'localhost' identified by '1234';

use jspdb;

create table BoardR (
	id int not null auto_increment,
	category varchar(10),
	userName varchar(20),
	title varchar(20),
	ddate VARCHAR(50),
     ppasswd VARCHAR(50),
	content varchar(100),
	groupId int,
	primary key (id)
) charset=utf8;

select * from BoardR;


delete from BoardR;

select distinct groupId from BoardR where groupId = (select MAX(groupId) from BoardR);