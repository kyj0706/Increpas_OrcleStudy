/*
 
  ## nvl(�ʵ�/����, ��ü��)
  	select sabun,saname, nvl(samgr,0) as samgr from sawon
   
  ## nvl2(�ʵ�/����, ���̾ƴѰ�찪, ���ΰ�찪)
	select sabun,saname ,nvl2(samgr, 1, 0) as samgr from sawon
  
  ## nullüũ : �ʵ� is null �Ǵ� �ʵ� is not null
	--������̺��� �μ��常 ��ȸ (samgr = null)
  	select * from sawon where samgr is null
    
 	--�μ����� �ƴ� 
 	select * from sawon where samgr is not null
  
    
      
        
            
  
  
*/
