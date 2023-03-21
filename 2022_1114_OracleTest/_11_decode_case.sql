/*
 	DECODE(����/�ʵ� , ��1, (���1),
 					   ��2, (���2),
 					   ��2, (���3),
 					   ��2, (���4), default
 
 	          12345678901234   <-index 1base
 	gojumin = 801212-1234560
 
 
 	select 
 		gobun, goname, gojumin,
 		DECODE(substr(gojumin,8,1), '1' ,'����',
 									'3' ,'����',
 									'5' ,'����',
 									'7' ,'����',
 									'9' ,'����',
 		                            '2' ,'����',
 		                            '4' ,'����',
 		                            '6' ,'����',
 		                            '8' ,'����',
 		                            '0' ,'����'
 		                            ) as gogender
 	from gogek
 
 --����
 	select 
 		gobun, goname, gojumin,
 		DECODE(mod(to_number(substr(gojumin,8,1)),2), 1 ,'����',
 		                            		          0 ,'����' ) as gogender
 		                            
 	from gogek
 
#########################################################################
--CASE ��

	����1)
		case �ʵ� / ����
			when ��1 then ���1
			when ��2 then ���2
			when ��3 then ���3
			else �⺻���
		end
		
	����2)
		case
			when ����1 then ���1
			when ����2 then ���2
			when ����2 then ���2
			else �⺻���
		end
---------------
	����1_����)
	select 
		gobun, goname, gojumin,
		case mod(to_number(substr(gojumin, 8,1)),2)
			when 1 then '����'
			else '����'
		end as gogender
	from gogek
	
	
	����2_����)
	select
		gobun, goname, gojumin,
		case
			when to_number(substr(gojumin,8,1)) in(1,3,5,7,9) then '����'
			else '����'
		end as gogender
	from gogek
	
--������̺�
	select * from sawon
	
	select 
		sabun, saname, sahire,
		to_number(to_char(sahire,'MM')) 
	from sawon	
	
	select 
		sabun, saname, sahire, 
		case 
			when to_number(to_char(sahire, 'MM')) in(3,4,5) 	then '��'
			when to_number(to_char(sahire, 'MM')) in(6,7,8) 	then '����'
			when to_number(to_char(sahire, 'MM')) in(9,10,11)	then '����'
			else '�ܿ�'
		end as season
	from sawon
	
	
	select 
		sabun, saname, sahire, 
		case floor(to_number(to_char(sahire, 'MM'))/3)
			when 1 then '��'
			when 2 then '����'
			when 3 then '����'
			else '�ܿ�'
		end as season
	from sawon
	
	
###############################################

--E1) �����̺��� ���� ������� ����
	gojumin <- varchar2
				
			   12345678901234 <-index 1base	
	gojumin = '801212-1234560'
	
	select * from gogek
	
	select
		gojumin,
		to_number(substr(gojumin, 3,2))
	from gogek
	
	
	select
		gobun, goname, gojumin,
		case floor(to_number(substr(gojumin, 3,2))/3)
			when 1 then '��'     --3, 4, 5
			when 2 then '����'   --6, 7, 8
			when 3 then '����'   --9, 10, 11
			else '�ܿ�' --������
		end as goseason
	from gogek 
	order by substr(gojumin,3,2) asc


--E2)�ֹι�ȣ -> ����⵵ 
			
			   12345678901234 <-index 1base	
	gojumin = '801212-1234560'
	
	select * from gogek
	
	--�����ڵ� 1�ڸ�
			������		�ܱ���
			��  ��		��  ��		
	1900	1	2		5	6		
	2000	3	4		7	8
	1800	9	0		
	
	--�� 12�� 12����
	#############################
	select
		gobun, goname, gojumin,
		
			--����⵵
			(to_number(substr(gojumin,1,2))+
				(
					case
						when to_number(substr(gojumin,8,1)) in(1,2,5,6) then 1900
						when to_number(substr(gojumin,8,1)) in(3,4,7,8) then 2000
						else 1800
					end
				) 
			) as ����⵵,
			
			--����
			to_number(to_char(sysdate, 'YYYY')-
			(to_number(substr(gojumin,1,2))+
				(
					case
						when to_number(substr(gojumin,8,1)) in(1,2,5,6) then 1900
						when to_number(substr(gojumin,8,1)) in(3,4,7,8) then 2000
						else 1800
					end
				) 
			)+1) as ����,
			
			--��
			case mod((to_number(substr(gojumin,1,2))+
						(
							case
								when to_number(substr(gojumin,8,1)) in(1,2,5,6) then 1900
								when to_number(substr(gojumin,8,1)) in(3,4,7,8) then 2000
								else 1800
							end
						) 
	   			 	),12)    
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
			end as ��
	from gogek
	
	
	
	select
		gobun, goname, gojumin,
		to_number(substr(gojumin,1,2))+1900 as ����
	
	from gogek



 
*/