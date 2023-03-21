/*
	�������� Table�� ���� �غ��ô� ~ 
	
	create table test_sung
	(
	-- �÷���	�ڷ���
		num 	int,
		name 	varchar2(100),
		kor 	number(3),
		eng		number(3),
		mat		number(3)
	)
	
	
	--1.�����ʹ� ���̺� ���� ������� �ִ´�. -> (���2) ���� ������� �־ƾ� �ϴ°�? �ƴϴ�.
	--2.�������� ���ڿ��� ������ ''(�̱������̼��̴�)
	--3.�����ݷ��� ���û����̴�.  ������ ������ ���� �뵵�� ���ȴ�. (������ SQL������ ;�� ����.)
	
	--DML (Data Manupulation Language) : ������ ���۾��
	-- : insert delete update
	
	--(���1)���̺� ������ �ֱ� (insert)
	insert into test_sung values(1,'�ϱ浿',90,80,70);
	insert into test_sung values(2,'�̱浿',100,100,100);
	insert into test_sung values(3,'��浿',90,90,90);
	
	--(���2)���̺� ������ �ֱ�_�����ٸ��� 
	--�ؼ� ���� �� �ִµ� �׷��� ������� [�뵵]-> �ʿ���� �����͸� �����ϰ� ������ 
	insert into test_sung(num,kor,eng,mat,name) values(4,55,66,77,'��浿');
	
	
	--����!!! 
	--update/delete�� where �������� ������ ���� �ش�ȴ�.
	
	
	--������ ����(update)
								  where ������
	update test_sung set kor = 80 where num =1
	
	--�����ͻ���(delete)
	delete from test_sung where num = 4
	
	
	--��������ȸ
	* : ����÷� ��ȸ
	select * from test_sung
	
	
	
	select 
		num,name,kor,eng,mat,  	--�⺻�ʵ�
		(kor+eng+mat) as tot,	--�����ʵ�(�÷�)
		(kor+eng+mat)/3 as avg,
		rank() over(order by (kor+eng+mat) desc) as rank
	from test_sung
	order by num
	
	
	
	CRUD(�߰�/�б�/����/����)
	Create 	: insert
	Read 	: select
	Update 	: update
	Delete	: delete
	




*/