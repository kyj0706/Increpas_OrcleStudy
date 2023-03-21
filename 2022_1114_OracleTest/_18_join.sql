/*
select * from sawon
order by sabun desc


--����(join) : ��� ���� ����
	1. 2���̻��� ���̺��� ����(����)�ؼ� ��ȸ�ϴ� ���
	2. ����
		1)cross join : ������� ���Ǿ��� ���� 
		2)inner join : 1:1�� ���յǴ� ����
		3)outer join
			A left  outer join B : A���̺����� ������� B�� �����ϴ��ุ ����
									-> �������� ������ null�� ä������.
			A right outer join B : B���̺����� ������� A�� �����ϴ��ุ ���� 
			A full  outer join B : A,B���̺��� ���� ��� ����
		
		4)self join : �ڽ��� ���̺�� �����ϴ� ��� 
		
--###########################################################################		

--[cross join ����]
	select * from sawon, dept	

	[ANSI-92 SQL] : ��� DBMS�� ����Ǵ� "ǥ��" ����
	select * from sawon cross join dept
--###########################################################################		
	
--[inner join] : ��-�� 1:1���յǴ� ������ ����
1)	[inner join]
	select * from sawon s, dept d
	where s.deptno = d.deptno --��������
	
2)		[ANSI-92 SQL] ����) : �������ǰ� �Ϲ� �˻� ������ �и��� �Ǿ��־� ������ ��Ȯ�ϴ�.
		select  
			sabun,saname,dept.deptno,dname
		from sawon inner join dept on sawon.deptno = dept.deptno -- on�� ������ ��������
		where dept.deptno <> 10
		
	
3)	--(alias)�� ��� �ϴ� ����
	select  
		sabun,saname,d.deptno,dname
	from sawon s, dept d
	where s.deptno = d.deptno --��������
		and s.deptno <> 10 	  --�Ϲ����ΰ˻�����
--###########################################################################		

--[self join] : �ڽ��� ���̺�� ����
����1) ��� ���� ����� / ����ȣ ������� ����
			sawon s1		 sawon s2
	
1)	create or replace view sawon_view5
	as
		select 
			s1.sabun,s1.sajob,s1.saname,
			s2.sabun as sabun2 ,
			s2.sajob as sajob2,
			s2.saname as saname2 
		from sawon s1 , sawon s2
		where s1.samgr = s2.sabun
		order by s1.sabun
		

[outer join] :
			A left  outer join B : A(all)  B(�����ϴ���)       
            A right outer join B : B(all)  A(�����ϴ���)       
            A full  outer join B : A,B(�����ϴ���) + A,B(���������ʴ� ��)     
	
2)		[Oracle�� ����]
		select 
			s1.sabun,s1.sajob,s1.saname,
			s2.sabun as sabun2 ,
			s2.sajob as sajob2,
			s2.saname as saname2 
		from sawon s1 , sawon s2
		where s1.samgr = s2.sabun(+) --left outer ��������
		order by s1.sabun
		
		cf)MS-SQL Server : where s1.samgr *= s2.sabun


3)		[ANSI-92 SQL]
		select 
			s1.sabun,s1.sajob,s1.saname,
			s2.sabun as sabun2 ,
			s2.sajob as sajob2,
			s2.saname as saname2 
		from sawon s1 left outer join sawon s2 on s1.samgr = s2.sabun
		order by s1.sabun
		
		select
			s1.sabun as �����ȣ, 
			s1.sajob as �������, 
			s1.saname as ����̸�,
			
			s2.sabun as ����ȣ, 
			s2.sajob as �������, 
			s2.saname as ����̸�
		from sawon s1 left outer join sawon s2 on s1.samgr = s2.sabun
		
		select
		 	s1.sabun as ����ȣ, 
			s1.sajob as �������, 
			s1.saname as ����̸�,
			
			s2.sabun as �����ȣ, 
			s2.sajob as �������, 
			s2.saname as ����̸�
		from sawon s1 right outer join sawon s2 on s1.sabun = s2.samgr
		
		
		select
			s1.sabun as �����ȣ, 
			s1.sajob as �������, 
			s1.saname as ����̸�,
			
			s2.sabun as ����ȣ, 
			s2.sajob as �������, 
			s2.saname as ����̸�
		from sawon s1 full outer join sawon s2 on s1.samgr = s2.sabun
		
		
		select * from sawon
		
3) full outer join
	select * from sawon s full outer join dept d on s.deptno = d.deptno		
	
--###########################################################################


[join�� ���� �Ϸ��� : ���ʺ��� �������...]
--����2) ��� ����� / �μ���ȣ  �μ��� / ������ȣ ������
			sawon s			dept d				gogek g
					 (1)s.deptno=d.deptno
					 					 (2) s.sabun=g.godam
			
	select 
		s.sabun, s.saname,
		d.deptno, d.dname,
		g.gobun, g.goname
	 
	from sawon s inner join dept d on s.deptno = d.deptno --(1)
		 left outer join gogek g   on s.sabun = g.godam --(2)
	order by s.sabun
	
--###########################################################################
--Q1. ��� ����� / �μ��� / ����ȣ ���� / ����ȣ ���� /��������ȣ ��������	
		sawon s1	dept d      gogek g1			  sawon s2          gogek g2				  
	
	
	select
		s1.sabun as ���, s1.saname as �����,
	  	d.dname as �μ���,
	  	g1.gobun as ����ȣ, g1.goname as ����,
	  	s2.sabun as ����ȣ, s2.saname as ����,
	  	g2.gobun as ��������ȣ, g2.goname as ��������
	
	from sawon s1 inner join dept d on s1.deptno = d.deptno
		left outer join gogek g1 	on s1.sabun = g1.godam
		left outer join sawon s2 	on s1.samgr = s2.sabun 
		left outer join gogek g2 	on s2.sabun = g2.godam
		
	order by s1.sabun
	
	select * from sawon
	
	
	select 
			s1.sabun,s1.sajob,s1.saname,
			s2.sabun as sabun2 ,
			s2.sajob as sajob2,
			s2.saname as saname2 
		from sawon s1 inner join sawon s2 on s1.samgr = s2.sabun
		order by s1.sabun
	
	
	
	
	
	
	
*/