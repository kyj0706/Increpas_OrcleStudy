/*

--1, ���ڰ��� : ||
	select '�츮' || '����' || '���ѹα�' from dual

	select saname || sajob || '�� ��� �����̽��ϴ�.' from sawon
	
-- INITCAP, LOWER, UPPER ����
select initcap('oracleclub') name from dual
union all
select upper('oracleclub') name from dual
union all
select lower('oracleclub') name from dual;


###[�߿�] ���� �߶󳻱�#####
-- ����° ���� ���ڿ� ��ȯ
				   1234567890	<- oracle�� ���ڿ��� index 1 base
	select substr('oracleclub',3) name from dual;

-- ����° ���� �װ��� ���ڿ� ��ȯ
							  ��ġ ����	
	select substr('oracleclub',3 ,4) name from dual;

-- �ڿ��� ����°���� �ΰ��� ���ڿ� ��ȯ
				   0987654321 ������ �ڿ������� �д´�.	
	select substr('oracleclub',-3 ,2) name from dual;
	
	
--E)�����̺��� ���� ��� ���� ��ȸ
	
	select substr(goaddr, 1,2) from gogek

	

	select * from gogek
	where substr(goaddr, 1,2) ='����'
	and substr(gojumin,8,1)='1'
	
--�����̺��� ���ڰ��� ��ȸ(�Լ����)
	select * from gogek
	where 
	substr(gojumin, 8,1)
	in(0,2,4,6,8) 

--E2)�����̺��� ���� ����ڸ� ��ȸ(9,10,11�� �����) <=�Լ����(substr)
	select * from gogek
	where
	substr(gojumin, 3, 2) 
	in('09','10','11') 
	
	select * from gogek
	where to_number(substr(gojumin,3,2)) in (9,10,11)
	

--E3)������̺��� 7�� �Ի��� ��ȸ(�Ի����ڿ��� ���� ����) <= �Լ����(to_char)
	select * from sawon
	where to_char(sahire, 'MM') ='07'


*/