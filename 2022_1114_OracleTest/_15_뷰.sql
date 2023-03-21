/*

	��(view)
	1. ������ ���̺�(������� ���̺�� �����ϴ�)
	2. view ���ο� ó���� SQL������ ���� => ����� SQL����� ����
	3. ����
		1)���Ἲ(����) : ������ SQL���� �����ϰ� ����� �� �ִ�.
		2)���ȼ� 		 : �並 ���ؼ� �߿������� ���� �� �ִ�.
	4. ����
		create or replace view view�̸�
		as
			SQL��

--������̺��� ���� �Ǵ� ���� ������ ��ȸ(view�� �̷��� ����ϴ� �Ŵ� �ϴ� ���� ����)
	create or replace view sawon_man_view
	as
		select * from sawon where sasex ='����' with check option

	create or replace view sawon_woman_view
	as
		select * from sawon where sasex ='����' with check option

	select * from sawon_man_view
	select * from sawon_woman_view
	
--������̺�
	create or replace view sawon_view
	as --�߰� view ���̺� 
		select 
			s.*,
			to_number(to_char(sahire,'YYYY')) as hire_year,
			to_number(to_char(sahire,'MM')) as hire_month,
			to_number(to_char(sahire,'DD')) as hire_day,
			to_char(sapay *10000,'L999,999,999') as sapay2
		from (select * from sawon) s --�굵 ��� -> inline view (SQL�� ������ �ӽû����Ǵ� ��)

	select * from sawon_view
	
	--view �̿� -> �� �ٸ� view ����
	create or replace view sawon_view2
	as
		select
			s.*,
			case floor(hire_month/3)
				when 1 then '��'
				when 2 then '����'
				when 3 then '����'
				else '�ܿ�'
			end as hire_season
		from (select * from sawon_view) s
	
	select * from sawon_view2

--������̺��� �嵿�ǰ� ������ ������ �Ի��� ���� ��ȸ
	select * from sawon_view2
	where hire_season in
	(select hire_season from sawon_view2 where saname ='�嵿��')
	
	
--�����̺�
	select * from gogek
	
	create or replace view gogek_view
	as
		select
			gobun,goname,goaddr,godam,
			substr(gojumin,1,8) || '*******' as gojumin,
				(to_number(substr(gojumin,1,2))+
						(
							case
								when to_number(substr(gojumin,8,1)) in(1,2,5,6) then 1900
								when to_number(substr(gojumin,8,1)) in(3,4,7,8) then 2000
								else 1800
							end
						) 
					) as goyear,
				to_number(substr(gojumin,3,2)) as gomonth,
				to_number(substr(gojumin,5,2)) as goday,
			case
				when to_number(substr(gojumin,8,1)) in(1,3,5,7,9) then '����'
				else '����'
			end as gogender
		from gogek
	
	select * from gogek_view
	
	--����� ���� ������ ���� ����ȸ
	select * from gogek_view
	where gogender in
	(select gogender from gogek_view where goname='����')

##################################################################################################

--�� ���ȿ� ���� �׽�Ʈ ����
--conn system/oracle
--connection Name : Oracle_system��ȯ
	1.��������
		create user test5 identified by test5
	2.���ӱ��� �ο�
		grant connent to test5

--gogek_view�� ���� select���� �ο�(�����ָ� ���Ѻο� �� �� �ִ�)
--conn test/test
--Connection Name : Oracle_test��ȯ
	1.��ü(Entity : Table or View)����
		grant select on gogek_view to test5
	
	cf) grant all on ���̺�(��) to ����
		���� : select.insert.update.delete
			   all(������)

--conn test5/test5
--connection Name : Oracle_test5��ȯ

	select * from test.gogek_view
	select * from test.gogek --(x)������ �ο����� �ʾҴ�.
	
	
-conn test/test

	select * from gogek_view
	
--Q1)gogek_view�� �̿��ؼ� gogek_view2����
	 gogek_view2�� �߰� �÷� : goage,gotti,goganji
	 
	 4  5  6  7  8  9  0  1  2  3     <- ����(mod)����⵵, 10)
	 �� �� �� �� �� �� �� �� �� ��
	 
	 4  5  6  7  8  9  10  11  0  1  2  3  <-mod(����⵵,12)
	 �� �� �� �� �� �� ��  �� �� �� �� ��
	 
	 
	 select * from gogek_view
	 
	 
	 create or replace view gogek_view2
	 as
		 select g.*,
				--����
				(to_number(to_char(sysdate,'YYYY')))-(goyear)+1 as goage, 
				
				--��
				case mod(goyear,12)
					when 4  then '[��] ��'
					when 5  then '[��] ��'
					when 6  then '[��] ȣ����'
					when 7  then '[��] �䳢'
					when 8  then '[��] ��'
					when 9  then '[��] ��'
					when 10 then '[��] ��'
					when 11 then '[��] ��'
					when 0  then '[��] ������'
					when 1  then '[��] ��'
					when 2  then '[��] ��'
					when 3  then '[��] ����'
				end as gotti,
				
				--����
					(
						substr('����Ӱ谩����������', 		mod(goyear,10)+1,1) ||
						substr('�������������ι��������', 	mod(goyear,12)+1,1) || '��'
						
					)as goganji,
		
				
				--����
				case floor(gomonth/3)
					when 1 then '��'
					when 2 then '����'
					when 3 then '����'
					else '�ܿ�'
				end as goseason
		 from 
		 (select * from gogek_view) g
	
	
	select * from gogek_view2
	 	
	 			
	 							
			/*case mod(goyear,10)
				when 4  then '[��]'
				when 5  then '[��]'
				when 6  then '[��]'
				when 7  then '[��]'
				when 8  then '[��]'
				when 9 	then '[��]'
				when 0  then '[��]'
				when 1  then '[��]'
				when 2  then '[��]'
				when 3  then '[��]'
			end as goganji,*/
	
	--inline view : SQL���峻�� �ӽ÷� �ۼ��� ��
		select
			s.*,
			(select round(avg(sapay),0) from sawon) as total_avg,
			(select round(avg(sapay),0) from sawon where deptno=10) as avg_10,
			(select round(avg(sapay),0) from sawon where deptno=10) as avg_20,
			(select round(avg(sapay),0) from sawon where deptno=10) as avg_30,
			(select round(avg(sapay),0) from sawon where deptno=10) as avg_40
		from 
			 (select * from sawon) s
	 
	 
	
*/