/*
--����(sort)
	:order by �ʵ� [asc][desc]
		asc[ending] : ��������
		desc[ending]: �������� 
		
					  1������		   2������
		order by �ʵ�1 [���Ĺ��], �ʵ�2 [���Ĺ��]
	--����
	select * from sawon
	order by deptno,sasex
	
	
	--group by����                         �������
	select 
		�׷��ʵ�(����),����Լ�			   --5)	
	from 	 ���̺��(��)                  --1)
	where 	 ������						   --2)
	group by �׷��ʵ�(����)				   --3)
	having 	 ���������				   --4)
	order by �ʵ�						   --6)
	
--����--	
	select 
		*  		--<-���ü� �ִ� �׸�(����Լ�,�׷��ʵ�)
	from sawon
	group by deptno --<- ����
	order by deptno asc --<- �ݵ��� ��� �ǳ�? �ƴϴ�. ��? ������� �߿��Ѱ��� ������ �߿��Ѱ� �ƴϴϱ�
	
--##################################################################################################	
	

--����1_1)
	select 
		count(*) as �ο���	
	from sawon
	group by deptno 
	order by deptno asc

--����1_2)
	select 
		deptno,count(*) as �ο���	
	from sawon
	group by deptno 
	order by deptno asc
--=============================================	

		
--����3_1) �μ��� �����ο���
	select
		deptno,sasex,count(*)
	from sawon
	group by deptno, sasex
	order by deptno, sasex
	
--����3_2) ���޺� �ο���,�޿��հ�,�޿����
	select * from sawon
	select 
		sajob, count(*),
		sum(sapay) as sum, 
		round(avg(sapay),0) as avg
	from sawon
	group by sajob
	
--����4_1) �Ի�⵵�� �ο���(�Լ���)
	select 
	  to_char(sahire,'YYYY') as �Ի�⵵,
	  count(*) as �ο��� 
	from sawon
	group by to_char(sahire,'YYYY')
	order by to_char(sahire,'YYYY')
	
--����4_2) view�� ����ϸ� �󸶳� ����ϵ� ���������� ?
	select * from sawon_view
	
	select
		hire_year, count(*)
	from sawon_view
	group by hire_year
	order by hire_year
	
--����4_3) �Ի���� �ο���
	select * from sawon_view
	
	--�Լ����
	select
		to_char(sahire,'MM') as �Ի�� ,
		count(*) as �ο���
	from sawon
	group by to_char(sahire,'MM')
	order by to_char(sahire,'MM')
	
	--view���
	select 
		hire_month as �Ի��,
		count(*) as �ο���
	from sawon_view
	group by hire_month
	order by hire_month

--########################################
	
--����5_1) ���� �������� �ο���(������ ���� :���� ���)
	select * from gogek
						
	select 
		substr(goaddr,1,2) as ������, 
		count(*) as �ο���
	from gogek
	group by substr(goaddr,1,2)
	order by substr(goaddr,1,2)
	
	select
	substr(goaddr,1,2) as ������, 
	gogender as ����, --?? ���ڸ� ? ��� �����µ� ?
	 count(*) as �ο���
	from gogek_view
	group by substr(goaddr,1,2), gogender
	
	
	select substr(goaddr,1,2), gogender from gogek_view
	order by substr(goaddr,1,2)
	
					
				
-- having �� : group�� ���� ������ 
-- where ��  : select�� ���� ������
--having�� : group ��迡 ���� ������ 

	select
		deptno, round(avg(sapay),0) dept_avg
	from sawon
	group by deptno
	having round(avg(sapay),0) >=3000
	order by deptno
	
--���� �������� where�� : inline view�� �̿�
	select * from
	(
		select
		deptno, round(avg(sapay),0) dept_avg
		from sawon
		group by deptno
		order by deptno
	)
	where dept_avg >=3000

--#####################################################
--GROUP BY ����

Q1) ������̺��� �Ի������ �ο���
	select * from sawon_view2
	
	--���
	select
		hire_season as �Ի����, 
		count(*) as �ο���
	from sawon_view2
	group by hire_season
	

Q2) ������̺��� �Ի��뺰 �ο���
	 �Ի���		�ο���
	 1980			 ?
	 1990            ?
	 2000            ?
	 
	 select * from sawon_view2
	 select floor(hire_year/10) from sawon_view2
	 
	 --���
	 select
	 	floor(hire_year/10)*10 || '���',
	 	count(*)
	 from sawon_view2
	 group by floor(hire_year/10)*10
	 
	 
	 
	 
Q3) �����̺��� ���� �ο��� ���ض�
	select * from gogek_view2
	
	--���
	select
		gogender as ����, 
		count(*) as �ο���
	from gogek_view2
	group by gogender


Q4) �����̺��� ���ɴ뺰 �ο���
	 ���ɴ�			�ο���
	 20��			  ?
	 30��			  ?
	 40��			  ?
	 
	 select * from gogek_view2
	 
	 --���
	 select
	 	floor(goage/10)*10 || '��', 
	 	count(*)
	 from gogek_view2
	 group by floor(goage/10)*10
	 order by floor(goage/10)*10

Q5) �����̺��� �캰 �ο���
	select * from gogek_view2
	
	--���
	select
		gotti as ��,
		count(*) as �ο���
	from gogek_view2
	group by gotti

Q6) �����̺��� �¾������ �ο���
	select * from gogek_view2
	
	--���
	select
		goseason as �¾����,
		count(*) as �ο���
	from gogek_view2
	group by goseason
			
	
	
	
	
	
	



*/