/*
 
	select sysdate from dual; 
	
	--��¥ data
	sysdata ��½� ����ϸ� �������� -> ���� �ð��� ���� ������ �ִ�.
	�׷��� date ���·� '2022-11-17' ���ϸ� �ð��� 00:00:00�� �ǹ�����.
 
 
--sysdte ����
	select to_char(sysdate,'RRRR-MM-DD HH24:MI:SS') "���ݽð�" from dual ;
	��� : 2022-11-17 10:15:49

--t : ��¥�� ����Ҷ��� �����ض�  
	select to_char(to_date('2022-11-17'),'RRRR-MM-DD HH24:MI:SS') "���ݽð�" from dual ;
	��� : 2022-11-17 00:00:00

--sysdte ���� �Ͻú���  1�� �Ϸ� �����̴�.
	select to_char(sysdate-1,'RRRR-MM-DD HH24:MI:SS') "�Ϸ������ݽð�" from dual ;
  	
	select to_char(sysdate-1/24,'RRRR-MM-DD HH24:MI:SS') "1�ð����ð�" from dual ;
  	
	select to_char(sysdate-1/24/60,'RRRR-MM-DD HH24:MI:SS') "1�����ð�" from dual ;
  	
	select to_char(sysdate-1/24/60/10,'RRRR-MM-DD HH24:MI:SS') "6�����ð�" from dual ;
  	
	select to_char(sysdate-(5/24 + 30/24/60 + 10/24/60/60),'RRRR-MM-DD HH24:MI:SS') "5�ð� 30�� 10����" from dual ;
  	
################################################## 

--SYSTIMESTAMP ����
	select to_char(systimestamp,'RRRR-MM-DD HH24:MI:SS.FF3')  from dual ;
 
	select to_char(systimestamp,'RRRR-MM-DD HH24:MI:SS.FF9')  from dual ;
 
##################################################
--ADD_MONTHS(DATE, NONTH)
	-3���� ��-
	select to_char(add_months(sysdate,3), 'RRRR-MM-DD') "date" from dual;
	-3���� ��-
	select to_char(add_months(sysdate,-3), 'RRRR-MM-DD') "date" from dual;
	
	-ex-
	select sysdate �Դ�����, add_months(sysdate,18) �������� from dual;
##################################################

--MONTHS_BETWEEN(a1, a2) : ��¥�� ����(������)

-- �� ���� ���̿� ���� ���� ��ȸ�ϴ� ����
	select months_between(to_date('2010-06-05','RRRR-MM-DD'), 
                          to_date('2010-05-01','RRRR-MM-DD'))  "month"  from dual;
 
-- �� ���� ���̿� ��¥ ���� ��ȸ�ϴ� ����
	select to_date('2010-06-05','RRRR-MM-DD') - 
           to_date('2010-05-01','RRRR-MM-DD')  "day"  from dual;
 
##################################################
  
--ROUND(d[,F])   

-- ROUND����
	select to_char(round(to_date('2011-09-11 21:00:01',
                             'RRRR-MM-DD HH24:MI:SS'), 'year'),
               				 'RRRR-MM-DD HH24:MI:SS')  from dual;
 
	select to_char(round(to_date('2011-09-11 21:00:01',
                             'RRRR-MM-DD HH24:MI:SS'), 'month'),
               				 'RRRR-MM-DD HH24:MI:SS')  from dual;
 
	select to_char(round(to_date('2011-09-11 21:00:01',
                             'RRRR-MM-DD HH24:MI:SS'), 'dd'),
               				 'RRRR-MM-DD HH24:MI:SS')  from dual;
 
	select to_char(round(to_date('2011-09-11 21:00:01',
                             'RRRR-MM-DD HH24:MI:SS')), 
               				 'RRRR-MM-DD HH24:MI:SS')  from dual;
     
##################################################
--E1) ������̺�
select * from sawon

--�����޻������
���� = ���/13
1) ������ = ���� * �ٹ���� +����*�ܿ�������/12
2) ������ = (����*�ѱٹ�����)/12
	
	1)������
	select
		sabun,saname,sapay,
		floor(months_between(sysdate,sahire)/12) as �ټӳ��,
		floor(mod(months_between(sysdate,sahire),12)) as �ܿ����� , 
		floor(sapay/13) as ����,
					--�ٹ����
		floor(
			(sapay/13)*(months_between(sysdate, sahire)/12) +
			(sapay/13)*(mod(months_between(sysdate,sahire),12))/12								
			) as ������
	from sawon



	2)������
	select
		sabun,saname,sapay,
		floor(months_between(sysdate,sahire)/12) as �ټӳ��,
		floor(mod(months_between(sysdate,sahire),12)) as �ټӿ��� , 
		floor(sapay/13) as ����,
		floor(((sapay/13)* months_between(sysdate,sahire))/12) as ������
	from sawon


--�ټӳ��
	select 
		sabun,saname,sahire,
		floor(months_between(sysdate, sahire)/12) 		as �ټӳ��,
		floor(mod(months_between(sysdate,sahire),12)) 	as �ܿ�����
	from sawon
     
   
        
          
 
 */
