/*

--��������(Subquery)
	:���������� ����� �������� ������ ����

--������̺��� �ֺҾϰ� ���� �μ� ���� ��ȸ
	select * from sawon
	
	1. �ֺҾ��� �μ�?
		select deptno from sawon where saname ='�ֺҾ�'
	2. �ֺҾ��� �μ��� 10 -> 10���μ� ���� ��ȸ
		select * from sawon where deptno =10
	
	3.��ġ��
		select * from sawon
		where deptno=(select deptno from sawon where saname='�ֺҾ�')
		
		--�����̶� �ߺ��ɰ� ������ in���� �ض�
		select * from sawon
		where deptno in (select deptno from sawon where saname='�ֺҾ�')
	
--������̺��� �嵿�ǰ� �޿��� ��������
	select sapay from sawon where saname ='�嵿��'
	
	select * from sawon
	where sapay =(select sapay from sawon where saname ='�嵿��')
	
	--�����̶� �ߺ��ɰ� ������ in���� �ض�
	select * from sawon
	where sapay in (select sapay from sawon where saname ='�嵿��')

--������̺��� �嵿�ǰ� ������ �⵵�� �Ի��� ���� ��ȸ
	select sahire from sawon where saname ='�嵿��'
	
	select * from sawon
	where to_char(sahire, 'YYYY') = (select to_char(sahire,'YYYY') from sawon where saname ='�嵿��')
	
-- �����̺��� ���ΰ� ������ ������ ��� ���� ��ȸ(������)
	select * from gogek
	select substr(goaddr, 1,2) from gogek where goname ='����'
	
	select * from gogek
	where substr(goaddr,1,2) = (select substr(goaddr, 1,2) from gogek where goname='����')

-- �����̺��� ���ΰ� ���� �޿� �¾ �� ��ȸ
	select substr(gojumin,3,2) from gogek where goname ='����'
	
	select * from gogek
	where substr(gojumin,3,2) = (select substr(gojumin,3,2) from gogek where goname='����')
	
-- ������̺��� �����Ի��� ������ ��ȸ
	select * from sawon
	where to_char(sahire,'YYYYMMDD') =(select to_char(min(sahire),'YYYYMMDD') from sawon)
	
		--distinct : �����γ� �ߺ������� 1���� ��������
		E3_1)
		select distinct * from 
		(
			select '�ϳ�' from dual
			union all
			select '�ϳ�' from dual
	    )
	
-- ����߰� 
	select * from sawon
	where sapay > (select avg(sapay) from sawon)


	insert into sawon values(21,'�嵿��','����',10,'���','2022-11-11',16,2500);
	commit
	
	select * from sawon
^@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@	
--Q1) ������̺��� �ֺҾϺ��� �޿��� ���� �޴� ���� ��ȸ
	select * from sawon
	select sapay from sawon where saname ='�ֺҾ�'
	-------------
	select * from sawon
 	where sapay > ANY
 	(select sapay from sawon where saname='�嵿��')
 	
--Q2) ������̺��� ���� �ֱ� �Ի��� ���� ��ȸ
	select * from sawon 
	where to_char(sahire,'YYYYMMDD') in 
	(select max(to_char(sahire,'YYYYMMDD')) from sawon)

--Q3) ������̺��� ���� �ֱ��Ի��ڿ� ������ �μ����� ��ȸ
	select * from sawon
	where deptno=
	(
	
		select deptno from sawon
		where to_char(sahire,'YYYYMMDD') in (select max(to_char(sahire,'YYYYMMDD')) from sawon)
	)
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@	
-- ������̺��� 10�� �μ��� �ִ�޿��� ��ȸ
	select * from sawon
	where sapay = (select max(sapay) from sawon where deptno = 10)
		and
		deptno=10
	
--������̺��� 20�� �μ��� �ִ� �޿��� ��ȸ.
	
	
	select * from sawon 
	where sapay = (select max(sapay) from sawon where deptno =20)
		and
		deptno=20
-- ������̺��� ���μ��� �ִ� �޿��� ��ȸ
	select * from sawon
	select distinct deptno from sawon
	
	select * from sawon
	where
		( 
		sapay = (select max(sapay) from sawon where deptno =10)
			and
			deptno=10
		)
		or
		( 
		sapay = (select max(sapay) from sawon where deptno =20)
			and
			deptno=20
		)
		or
		( 
		sapay = (select max(sapay) from sawon where deptno =30)
			and
			deptno=30
		)
		or
		( 
		sapay = (select max(sapay) from sawon where deptno =40)
			and
			deptno=40
		)
	order by deptno asc
	
	--����
	##������� 
	 : �������� ������ �̿��ؼ� �������� �����ϰ� ����� �����ؼ� �������� ����
	���������� ���� �̿��ؼ� ���������� ����  => ���������� ����� �����ְ� ���������� ���� 
	select * 
	from sawon s1
	where s1.sapay = 
	(select max(sapay) from sawon where deptno =s1.deptno)
	order by deptno asc
###########################!!!!! ���� !!!########################################
	4. ������̺��� �ֺҾϰ� ���� ���� �Ի��� ���� ��ȸ
		select * from sawon
		where to_number(to_char(sahire,'MM')) in
		(select to_number(to_char(sahire,'MM')) from sawon where saname ='�ֺҾ�')
	
	  ���̷��� ������ ���� ? ....
		select * from sawon
		where to_number(substr(to_char(sahire,'YYYYMMDD'),5,2)) in
		(select to_number(substr(to_char(sahire,'YYYYMMDD'),5,2)) from sawon where saname ='�ֺҾ�')
		order by to_char(sahire,'YYYY') asc
		
	5. �����̺��� ���ΰ� ���� ���� �¾ �� ��ȸ
		select * from gogek
		where substr(gojumin,3,2) in
		(select substr(gojumin,3,2) from gogek where goname = '����') 
		order by substr(gojumin,1,2) asc
		
					
	6. ������̺��� ���μ��� �Ի����ڰ� ���� ���� ���� ��ȸ(�������(
		select * 
		from sawon s1
		where to_char(s1.sahire,'YYYYMMDD') in 
		(select min(to_char(sahire,'YYYYMMDD')) from sawon where  deptno = s1.deptno) 
		order by to_char(sahire,'YYYYMMDD') asc
		
	
	7. ������̺��� �̹��ڿ� ������ ��뿡 �Ի��� ������ȸ (��� : 1980 1990 2000)
	 	select * from sawon
      	where floor(to_number(to_char(sahire,'YYYY'))/10) in 
      	(select floor(to_number(to_char(sahire,'YYYY'))/10) from sawon where saname='�̹���')
   		
	
	8. ������̺��� �ֺҾϰ� ���� ������ �Ի��� ���� ��ȸ
	 	 select * from sawon
      	where floor(to_number(to_char(sahire,'MM'))/3) in 
      	(select floor(to_number(to_char(sahire,'MM'))/3) from sawon where saname='�ֺҾ�')
	
	9. �����̺��� ����� ���� ������ ���� �� ��ȸ(����)
		select substr(gojumin,8,1) from gogek
	
		select * from gogek where goname = '����'	
		
		select * from gogek
		where mod(to_number(substr(gojumin,8,1)),2) in
		(select mod(to_number(substr(gojumin,8,1)),2) from gogek where goname = '����')

*/
