/*

--������� ����
	select 						--(����) ���Ҳ��� ? ���� �ҷ���
		sabun, saname, sapay	--3. ������ table ���� column(�ʵ�)���� �̰ž�
	from sawon					--1. �� ���̺��� ���� ����
	where sabun < 11			--2. ���̺��� ���?  �긦  �̸�ŭ??... (������ ����)
	order by sapay desc			--4. ������� ...�� �������� ��������  asc[��������] desc[��������]
	
--heading : ��ȸ����� ��µǴ� �÷���
			�÷���(����) [as] heading
	select
		sabun as ���,
		saname �����,
		sapay  "�� ��",  --������ Ʋ�ȴ�. ������ ���� �׷����� �ϰ�ʹ�.."" �� ����ȴ�.(heading������ ����)
		sapay*0.1 as bonus											
	from sawon
	
--������̺��� 10���μ� ���� ��ȸ
	select * from sawon
	where deptno = 10	

--������̺��� �������� ��ȸ
	select * from sawon
	where sasex = '����'

--#################################################	
--������̺��� ������ ������ ���� ��ȸ
	select * from sawon
	where sajob = '����'

--������̺��� 10���μ��� ������ ��ȸ
	select * from sawon
	where deptno=10 and sajob ='����'

--������̺��� ������ ����, �븮�� ���� ��ȸ
	select * from sawon
	where sajob='����' or sajob='�븮'

--in������ ��� : �ʵ� in(A,B) -> �ʵ�=A or �ʵ�=B
	select * from sawon
	where sajob in('����' , '�븮')
--#################################################	
--������̺��� ����� 3500�̻� ���� ��ȸ
	select * from sawon
	where sapay>=3500
	
--������̺��� ����� 3000~3500������ ���� ��ȸ
	select * from sawon
	where sapay>=3000 and sapay<=3500
	
--between������ ��� : A and B
	select * from sawon
	where sapay between 3000 and 3500
--#################################################	
	
--���ڿ� ����˻�	
	�ʵ� like '% or _'
	% : ��簪
	_ : ��簪(����1��) [�ε� � ���� ���͵� �ȴ�]
	
	select * from sawon where saname ='�̹���'
	
	
--������̺��� ������ '��'���� ���� ��ȸ
	select * from sawon
	where saname like '��%'

--������̺��� �̸��� 2��° ���ڰ� '��'�� ���� ��ȸ
	select * from sawon
	where saname like '_��%'

--�����̺��� �ּҰ� ���������� �� ��ȸ
	select * from gogek
	where goaddr like '����%'

--E1)�����̺��� ���ڰ��� ��ȸ
	select * from gogek
	where gojumin like '______-2%' or
		  gojumin like '______-4%' or
		  gojumin like '______-6%' or
		  gojumin like '______-8%' or
		  gojumin like '______-0%' 
		  
	insert into gogek values(16,'��õ��','�λ� ������','001212-4123456',2);
	commit

--E2)�����̺��� ��������� �ܿ��� ���� ��ȸ
	select * from gogek
	where gojumin like '__12%' or
		  gojumin like '__01%' or
		  gojumin like '__02%' 

--E3)�����̺��� ���￡ �����ϴ� 80���� �� ��ȸ
	select * from gogek
	where gojumin like '8%' and goaddr like '����%'

--������̺��� 1993�⵵�� �Ի��� ���� ��ȸ
	select * from sawon 
	where to_char(sahire,'YYYY') = '1993'

###[��¥ ��ȸ]####
--������̺��� 2000�⵵ ������ �Ի��� ���� ��ȸ
	select * from sawon
	where sahire < '2000-1-1'
	
--������̺��� 1995~2000�⵵ �Ի��� ������ ��ȸ
###Ʋ�� ��ȸ���� : 2000-12-31 00:00:00 ���Ŀ� �����ʹ� ��ȸ���� �ʴ´�.
	select * from sawon
	where sahire >= '1995-1-1' and sahire <= '2000-12-31'

-��¥ ->�⵵ ->���ں�ȯ
	select to_number(to_char(sahire, 'YYYY')) from sawon
	
	select * from sawon
	where to_number(to_char(sahire, 'YYYY')) between 1995 and 2000

--E4)������̺��� 1999-9-9�ϱ��� �Ի��� ���� ��ȸ (�ð��� �����ϰ� ��)
	select * from sawon
	where to_char(sahire, 'YYYY-MM-DD') <= '1999-09-09'
*/

	
	

