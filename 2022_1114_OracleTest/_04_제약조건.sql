/*

	��������(Constraint)
	1. �����͹��Ἲ(Data intergrity)��Ű�� ���� �Ӽ�
	2. ���̺� ������ �÷� �ڿ� ���δ�.
	3. ���̺� ������ ���߿� �߰��� ���� �ִ�.
	
	4.����
		1) not null : �ʼ��Է� ( null : �⺻��)
		2) unique	: �����γ� �� �ߺ��Ұ�
		3) check	: ���ǿ� �����ϴ� ���� ���
		4) default 	: ���� ���������� �⺻��
		5) primary key(��ü���Ἲ) : �⺻Ű(not null + unique) + index �� ������ ���
		6) foreign key(�������Ἲ) : �ܷ�Ű(�ܺ����̺��� ����)

--###############################################################
	1) not null : �ʼ��Է�
				 ���̺� ����ÿ��� ��밡���ϴ�.
				 
	create table tb1
	(
		name 	varchar2(100) not null,
		gender	varchar2(100) 	 -- null�� ���� �Ǿ� �ִ�
	)
	
	insert into tb1 values('�ϱ浿','����');
	insert into tb1(name,gender) values('�̹���','����');
	insert into tb1(name) values('�̱浿');
	
	insert into tb1(gender) values('����'); --(x) not null
		
	select * from tb1

--###############################################################	
			
	2) unique : �ߺ��Ұ�
	
	create table tb2
	(
		id 		varchar2(100) unique,
		pwd 	varchar2(100) not null
	)
	
	insert into tb2 values('hong','1234');
	insert into tb2 values('hong','1111');
	������ id �߰��� ����
	1) ���Ἲ ���� ����(TEST.SYS_C004073)�� ����˴ϴ�
	
	select * from tb2
	
	--�������� �߰��� ���̺�
	create table tb22
	(
		id 		varchar2(100),
		pwd 	varchar2(100) not null
	)
	
	--�������� �߰�
	alter table tb22 
		add constraint unique_tb22_id unique(id);
						(���������̸�)
	
	insert into tb22 values('hong','1234');
	insert into tb22 values('hong','1111');
	������ id �߰��� ����
	2) ���Ἲ ���� ����(TEST.UNIQUE_TB22_ID)�� ����˴ϴ�
		
	--������
	1) ���Ἲ ���� ����(TEST.SYS_C004073)�� ����˴ϴ�
	2) ���Ἲ ���� ����(TEST.UNIQUE_TB22_ID)�� ����˴ϴ�
	
	
	--�������� Ȯ���ϱ�
	-- System�� �����ϴ� Dictionary Table���� Ȯ��
	
	select constraint_type, constraint_name, table_name
	from user_constraints 
	where table_name= 'TB22'
	
	select * from tb2
	
	
--###############################################################	
	3) Check����(�����ι��Ἲ): �־��� ���ǿ� �����ϴ� ���� ���
	
	create table tb3
	(
		name 	varchar2(100) not null,
		gender 	varchar2(100) 
	
	
	)
	
	--(x) : gender : '����' '��' 'man' 'male' 'M'
	
	alter table tb3
		add constraint ck_tb3_gender check(gender='����' or gender='����'); 
						(�������Ǹ�)
									##in �����ڷ� ǥ��
									 check(gender in('����','����'))
						
	insert into tb3 values('ȫ�浿', '����');
	insert into tb3 values('�̹���', '����');
	
	���� : üũ ��������(TEST.CK_TB3_GENDER)�� ����Ǿ����ϴ�
	insert into tb3 values('������', 'female');
	
	select * from tb3
	
	--����
	create table tb33
	(
		name 	varchar2(100) not null, --inline ���
		kor		number(3),
		eng		number(3),
		mat		number(3),
		
		--������������
		constraint ck_tb33_kor check(kor >=0 and kor<=100)
	
	)
	
	insert into tb33 values('�ϱ浿',88,77,99);
	insert into tb33 values('�̱浿',88,177,99);
	
	select * from tb33
	
	update tb33 set eng =77 where name='�̱浿';
	
	--eng check���� 
	alter table tb33
	 add constraint ck_tb33_eng check(eng>=0 and eng<=100);
	���� : (TEST.CK_TB33_ENG)�� ������ �� �����ϴ� - �߸��� ������ Ȯ���մϴ� 
			(�̹� �߸��� �����Ͱ� �����ִٴ¸�)
	��ġ : ���������� �����Ŀ� �ٽ� ����
	
	
	--mat check
	alter table tb33
		add constraint ck_tb33_mat check(mat between 0 and 100);
		
	
	insert into tb33 values('�̿���',66,77,-10);
--###############################################################	
	4) default : �⺻�� (�Էµ��� ������ �⺻��)
	create table tb4
	(
		name 	varchar2(100) not null,
		gender	varchar2(100) default '�ΰ�',
		age 	int			  default 1
	
	)
	
	
	insert into tb4 values('�ϱ浿','����',20);
	--(���1)�⺻�� �Է¹��
	insert into tb4(name) values('�̱浿');
	insert into tb4 values('��浿',default, default);
	
	
	select * from tb4
--###############################################################	
	5)Primary key���� (�⺻Ű) : ��ü(Entity) ���Ἲ
		- ���ڵ�(��)�� ��ǥ�ϴ� ��ǥ�÷�
		- not null +  unique ���������� ����
		- �߰��� index���� (�˻������� ���)
		
		create table tb5
		(
			��ȣ int,
			�̸� varchar2(100) not null,
			�ּ� varchar2(255)
		
		)
		
		--�⺻Ű
		alter table tb5
			add constraint ck_tb5_��ȣ primary key(��ȣ);
	
		insert into tb5 values(1,'�ϱ浿', '���� ���� �Ÿ�1��');
		insert into tb5 values(2,'�̱浿', '���� ���� �Ÿ�2��');
		insert into tb5 values(3,'��浿', '���� ���� �Ÿ�3��');
		
		���� : ���Ἲ ���� ����(TEST.CK_TB5_��ȣ)�� ����˴ϴ�
		insert into tb5 values(3,'�����', '���� ���� �Ÿ�2��');
		insert into tb5(�̸�) values('�̿���');
	
	
	select * from tb5
	
	select * from tb5 where ��ȣ=2;
	
	
	--2���̻��� Ű�� �����ؼ� Primary key�� ������ �� �ִ�.(�ǹ̾��� ���������� �����ϴٸ� �����ֱ� ����)
	create table tb55
	(
		idx int,
		sale_date date,
		product_name varchar2(100)
		
	)
	
	alter table tb55
	 add constraint pk_tb55_idx_sale_date primary key(idx,sale_date);
	 
	insert into tb55 values(1, sysdate, 'TV'); 
	insert into tb55 values(1, sysdate, 'Radio'); 
	
	select * from tb55
--###############################################################	
	6) foreign key(�ܷ�Ű) : �����ϴ� ���� �ܺ����̺��� �����ϰڴ�.
	
	create table �л�
	(
		�й� 		int,
		�̸� 		varchar2(100) not null,
		��ȭ 		varchar2(100) not null,
		��ȣ�ڸ�	varchar2(100) not null,
		��ȣ������	varchar2(100) not null,
		�ּ�		varchar2(100) not null
	)
	
	--�⺻Ű����
	alter table �л�
	 add constraint pk_�л�_�й� primary key(�й�);
	 
	--sample data
	insert into �л� values(1,'�ϱ浿','111-1111','�Ͼƺ�','�ڿ���','����');
	insert into �л� values(2,'�̱浿','222-2222','�̾ƺ�','ȸ���','��õ');
	
	--�������̺�
	create table ����
	(
		�Ϸù�ȣ 	int,
		�й�		int,
		����		int,
		����		int,
		����		int,
		�г�		int,
		�б�		int,
		��������	varchar2(100)
	)
	
	--�⺻Ű����
	alter table ����
		add constraint pk_����_�Ϸù�ȣ primary key(�Ϸù�ȣ);
		
	--�ܷ�Ű(����,�й�)
	alter table ����
	 	add constraint fk_����_�й� foreign key(�й�)
	 								references �л�(�й�);
	 								
	 								
	 								
	insert into ���� values(1, 1, 100,90,80,1,1,'�߰����');
	insert into ���� values(2, 1, 90,80,70 ,1,1,'�⸻���');
	insert into ���� values(3, 1, 70,60,50 ,1,2,'�߰����');
	insert into ���� values(4, 1, 80,90,100,1,2,'�⸻���');
	
	## �������Ἲ
	
	���� : ���Ἲ ��������(TEST.FK_����_�й�)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�
	insert into ���� values(5, 3, 80,90,100,1,2,'�⸻���');
	
	select * from ����
	
		
				

*/
