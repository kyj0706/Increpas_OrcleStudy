/*
   ��������(Subquery)
   : ���������� ����� �������� ������ ����
   
   --������̺��� �ֺҾϰ� ���� �μ� ���� ��ȸ
   1.�ֺҾ��� �μ�?
     select deptno from sawon where saname='�ֺҾ�'
   2.�ֺҾ��� �μ� 10 -> 10���μ� ���� ��ȸ
     select * from sawon where deptno=10
   
   select * from sawon
   where deptno in (select deptno from sawon where saname='�ֺҾ�')

   --������̺��� �嵿�ǰ� �޿��� ���� ���� ��ȸ
     select * from sawon
     where sapay in (select sapay from sawon where saname='�嵿��') 


   --������̺��� �嵿�ǰ� ������ �⵵�� �Ի��� ���� ��ȸ
     select * from sawon
     where to_char(sahire,'YYYY')in(select to_char(sahire,'YYYY') from sawon where saname='�嵿��')

   --�����̺��� ���ΰ� ������ ������ ��� �� ��ȸ(������:���� ��� ��õ)
     select * from gogek
     where  substr(goaddr,1,2) in (select substr(goaddr,1,2) from gogek where goname='����')

   --�����̺��� ���ΰ� ���� �޿� �¾ �� ��ȸ
   select * from gogek
   where substr(gojumin,3,2) in (select substr(gojumin,3,2) from gogek where goname='����')

   --�����̺��� �����Ի��� ������ ��ȸ
   select * from sawon
   where to_char(sahire,'YYYYMMDD') = (select distinct to_char(min(sahire),'YYYYMMDD')  from sawon)

   --distinct:�����γ� �ߺ������� 1���� �������� 
   select distinct * from
   (
	   select '�ϳ�' from dual
	   union all
	   select '�ϳ�' from dual
   )


   --������̺��� �޿���պ��� ���� �޴� ���� ��ȸ
   select * from sawon
   where sapay > (select avg(sapay) from sawon)


   insert into sawon values(21,'�嵿��','����',10,'���','2022-11-11',16,2500);
   commit
   select * from sawon
   
   
   Q1. ������̺��� �ֺҾ�(�嵿��)���� �޿��� ���� �޴� ���� ��ȸ
       select * from sawon
       where sapay > ANY (select sapay from sawon where saname='�嵿��')
       
   Q2. ������̺��� ���� �ֱ��Ի����� ���� ��ȸ
       select * from sawon
       where  to_char(sahire,'YYYY-MM-DD') in (select to_char(max(sahire),'YYYY-MM-DD') from sawon)
       
       
   Q3. ������̺��� ���� �ֱ��Ի��ڿ� ������ �μ� ���� ��ȸ
       select * from sawon
       where deptno in 
       (
	       select deptno from sawon
	       where  to_char(sahire,'YYYY-MM-DD') in (select to_char(max(sahire),'YYYY-MM-DD') from sawon)
       )
         
         
   --������̺��� 10���μ��� �ִ�޿��� ��ȸ
   select * from sawon
   where sapay = (select max(sapay) from sawon where deptno=10)
         and
         deptno= 10
        
  --������̺��� 20���μ��� �ִ�޿��� ��ȸ
  select * from sawon
  where sapay = (select max(sapay) from sawon where deptno=20)
         and
         deptno= 20
                     
  --������̺��� ���μ��� �ִ�޿��� ��ȸ
  --select * from dept
  --select distinct deptno from sawon                            
  
   select * from sawon
   where 
         (    
	         sapay = (select max(sapay) from sawon where deptno=10)
	         and
	         deptno= 10
         )                
         or
         (    
	         sapay = (select max(sapay) from sawon where deptno=20)
	         and
	         deptno= 20
         )
         or
         (    
	         sapay = (select max(sapay) from sawon where deptno=30)
	         and
	         deptno= 30
         )
         or
         (    
	         sapay = (select max(sapay) from sawon where deptno=40)
	         and
	         deptno= 40
         )         
                         
    order by deptno asc                    
                           
   
   ##### ���� SQL���� �������� �ذ��� �� �ִ� ���
   
   ## �������
   : �������� ������ �̿��ؼ� �������� �����ϰ� ����� �����ؼ� �������� ����
   
   select 
      * 
   from  sawon s1 
   where  s1.sapay = (select max(sapay) from sawon where deptno=s1.deptno)
   order by deptno asc                             
                                                        
   
##################[����]##############################################
   
   Q4.������̺��� �ֺҾϰ� ���� ���� �Ի��� ���� ��ȸ
      select * from sawon
      where  to_char(sahire,'MM') in (select to_char(sahire,'MM') from sawon where saname='�ֺҾ�') 
   
   Q5.�����̺��� ���ΰ� ���� ���� �¾ �� ��ȸ
      select * from gogek
      where substr(gojumin,3,2) in (select substr(gojumin,3,2) from gogek where goname='����') 
      
   Q6.������̺��� ���μ��� �Ի����ڰ� ���� ���� ���� ��ȸ(�������)
      select * from sawon s1
      where sahire = (select min(sahire) from sawon where deptno=s1.deptno)
      order by deptno
      
   Q7.������̺��� �̹��ڿ� ������ ��뿡 �Ի��� ���� ��ȸ(���: 1980  1990 2000)
   select * from sawon
   where substr(to_char(sahire,'YYYY'),1,3) in 
          (select substr(to_char(sahire,'YYYY'),1,3) from sawon where saname='�̹���' )

   select * from sawon
   where floor(to_number(to_char(sahire,'YYYY'))/10) in 
          (select floor(to_number(to_char(sahire,'YYYY'))/10) from sawon where saname='�̹���' )
      
   Q8.������̺��� �ֺҾϰ� ���� ������ �Ի��� ���� ��ȸ
   
   select * from sawon
   where 
      (
	     case  floor(to_number(to_char(sahire,'MM'))/3)
	         when 1 then '��'
	         when 2 then '����'
	         when 3 then '����'
	         else '�ܿ�'
	      end
      )
      in 
      (   select 
		      case  floor(to_number(to_char(sahire,'MM'))/3)
		         when 1 then '��'
		         when 2 then '����'
		         when 3 then '����'
		         else '�ܿ�'
		      end 
	       from sawon where saname='�ֺҾ�'  
	   )
    
   Q9.�����̺��� ����� ���� ������ ���� �� ��ȸ(����)
   select * from gogek
   where
      (  
	        case  
	           when to_number(substr(gojumin,8,1)) in(1,3,5,7,9)  then '����'
	           else '����'
	        end
      ) 
	  in 
	  (
	      select 
	        case  
	           when to_number(substr(gojumin,8,1)) in(1,3,5,7,9)  then '����'
	           else '����'
	        end
	      from gogek 
	      where goname='����'  
      )                                                                                                                                                              
                                                                                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                            
                                                                                                                                      
                                                                                                                                                                
                                                                                                                                                                                                                    
                                    
   

*/