/*

SQL(Struvtured Query Language)
	DDL (Data Definition Language)	 [��������]		-> Create, Drop, Alter
	DML (Data Manipulation Language) [���۾��]		-> Insert, Delete, Update
	DCL (Data Control Language) 	 [��������]		-> Grant, Revoke

	����
	TCL (Transaction Control Language)[Ʈ�����]	-> Commit, Rollback


--1. ��������(��������) : DDL
			  (������)			   (��й�ȣ)
	create user test identified by test
	default tablespace users
	
  2. ���Ѻο�/���� : DCL
  	
  	2_1)���Ѻο�
  		grant connect to test  ->�������
  		grant resource to test -> �ڿ��� Ȱ���� �� �ִ� ����
  		
  		grant connect,resource,create view to test
  	2_2)��������
  		revoke connect from test
  
  
  3. ��������
  	drop user test


--���� : test��ȯ
				  (DBO.Table��)
	select * from test.dept 
	select * from	   sawon
	select * from 	   gogek
	

	




*/
