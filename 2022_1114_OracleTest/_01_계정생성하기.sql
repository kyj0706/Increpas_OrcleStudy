/*

SQL(Struvtured Query Language)
	DDL (Data Definition Language)	 [구조정의]		-> Create, Drop, Alter
	DML (Data Manipulation Language) [조작언어]		-> Insert, Delete, Update
	DCL (Data Control Language) 	 [권한제어]		-> Grant, Revoke

	추후
	TCL (Transaction Control Language)[트랜잭션]	-> Commit, Rollback


--1. 계정생성(유저생성) : DDL
			  (계정명)			   (비밀번호)
	create user test identified by test
	default tablespace users
	
  2. 권한부여/제거 : DCL
  	
  	2_1)권한부여
  		grant connect to test  ->연결권한
  		grant resource to test -> 자원을 활용할 수 있는 권한
  		
  		grant connect,resource,create view to test
  	2_2)권한제거
  		revoke connect from test
  
  
  3. 계정삭제
  	drop user test


--계정 : test전환
				  (DBO.Table명)
	select * from test.dept 
	select * from	   sawon
	select * from 	   gogek
	

	




*/
