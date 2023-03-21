/*
 
  ## nvl(필드/수식, 대체값)
  	select sabun,saname, nvl(samgr,0) as samgr from sawon
   
  ## nvl2(필드/수식, 널이아닌경우값, 널인경우값)
	select sabun,saname ,nvl2(samgr, 1, 0) as samgr from sawon
  
  ## null체크 : 필드 is null 또는 필드 is not null
	--사원테이블에서 부서장만 조회 (samgr = null)
  	select * from sawon where samgr is null
    
 	--부서장이 아닌 
 	select * from sawon where samgr is not null
  
    
      
        
            
  
  
*/
