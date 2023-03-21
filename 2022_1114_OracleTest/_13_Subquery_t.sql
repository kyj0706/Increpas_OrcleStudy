/*
   서브쿼리(Subquery)
   : 하위쿼리의 결과를 조건으로 주쿼리 수행
   
   --사원테이블에서 최불암과 같은 부서 직원 조회
   1.최불암의 부서?
     select deptno from sawon where saname='최불암'
   2.최불암의 부서 10 -> 10번부서 직원 조회
     select * from sawon where deptno=10
   
   select * from sawon
   where deptno in (select deptno from sawon where saname='최불암')

   --사원테이블에서 장동건과 급여가 같은 직원 조회
     select * from sawon
     where sapay in (select sapay from sawon where saname='장동건') 


   --사원테이블에서 장동건과 동일한 년도에 입사한 직원 조회
     select * from sawon
     where to_char(sahire,'YYYY')in(select to_char(sahire,'YYYY') from sawon where saname='장동건')

   --고객테이블에서 류민과 동일한 지역에 사는 고객 조회(광역시:서울 경기 인천)
     select * from gogek
     where  substr(goaddr,1,2) in (select substr(goaddr,1,2) from gogek where goname='류민')

   --고객테이블에서 류민과 같은 달에 태어난 고객 조회
   select * from gogek
   where substr(gojumin,3,2) in (select substr(gojumin,3,2) from gogek where goname='류민')

   --고객테이블에서 최초입사자 정보를 조회
   select * from sawon
   where to_char(sahire,'YYYYMMDD') = (select distinct to_char(min(sahire),'YYYYMMDD')  from sawon)

   --distinct:도메인내 중복데이터 1번만 나오도록 
   select distinct * from
   (
	   select '하나' from dual
	   union all
	   select '하나' from dual
   )


   --사원테이블에서 급여평균보다 많이 받는 직원 조회
   select * from sawon
   where sapay > (select avg(sapay) from sawon)


   insert into sawon values(21,'장동건','남자',10,'사원','2022-11-11',16,2500);
   commit
   select * from sawon
   
   
   Q1. 사원테이블에서 최불암(장동건)보다 급여를 많이 받는 직원 조회
       select * from sawon
       where sapay > ANY (select sapay from sawon where saname='장동건')
       
   Q2. 사원테이블에서 가장 최근입사자한 직원 조회
       select * from sawon
       where  to_char(sahire,'YYYY-MM-DD') in (select to_char(max(sahire),'YYYY-MM-DD') from sawon)
       
       
   Q3. 사원테이블에서 가장 최근입사자와 동일한 부서 직원 조회
       select * from sawon
       where deptno in 
       (
	       select deptno from sawon
	       where  to_char(sahire,'YYYY-MM-DD') in (select to_char(max(sahire),'YYYY-MM-DD') from sawon)
       )
         
         
   --사원테이블에서 10번부서의 최대급여자 조회
   select * from sawon
   where sapay = (select max(sapay) from sawon where deptno=10)
         and
         deptno= 10
        
  --사원테이블에서 20번부서의 최대급여자 조회
  select * from sawon
  where sapay = (select max(sapay) from sawon where deptno=20)
         and
         deptno= 20
                     
  --사원테이블에서 각부서별 최대급여자 조회
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
                           
   
   ##### 위의 SQL문의 문제점을 해결할 수 있는 방안
   
   ## 상관쿼리
   : 주쿼리의 정보를 이용해서 서브쿼리 수행하고 결과를 참조해서 주쿼리를 선택
   
   select 
      * 
   from  sawon s1 
   where  s1.sapay = (select max(sapay) from sawon where deptno=s1.deptno)
   order by deptno asc                             
                                                        
   
##################[문제]##############################################
   
   Q4.사원테이블에서 최불암과 같은 월에 입사한 직원 조회
      select * from sawon
      where  to_char(sahire,'MM') in (select to_char(sahire,'MM') from sawon where saname='최불암') 
   
   Q5.고객테이블에서 류민과 같은 월에 태어난 고객 조회
      select * from gogek
      where substr(gojumin,3,2) in (select substr(gojumin,3,2) from gogek where goname='류민') 
      
   Q6.사원테이블에서 각부서별 입사일자가 가장 빠른 직원 조회(상관쿼리)
      select * from sawon s1
      where sahire = (select min(sahire) from sawon where deptno=s1.deptno)
      order by deptno
      
   Q7.사원테이블에서 이미자와 동일한 년대에 입사한 직원 조회(년대: 1980  1990 2000)
   select * from sawon
   where substr(to_char(sahire,'YYYY'),1,3) in 
          (select substr(to_char(sahire,'YYYY'),1,3) from sawon where saname='이미자' )

   select * from sawon
   where floor(to_number(to_char(sahire,'YYYY'))/10) in 
          (select floor(to_number(to_char(sahire,'YYYY'))/10) from sawon where saname='이미자' )
      
   Q8.사원테이블에서 최불암과 같은 계절에 입사한 직원 조회
   
   select * from sawon
   where 
      (
	     case  floor(to_number(to_char(sahire,'MM'))/3)
	         when 1 then '봄'
	         when 2 then '여름'
	         when 3 then '가을'
	         else '겨울'
	      end
      )
      in 
      (   select 
		      case  floor(to_number(to_char(sahire,'MM'))/3)
		         when 1 then '봄'
		         when 2 then '여름'
		         when 3 then '가을'
		         else '겨울'
		      end 
	       from sawon where saname='최불암'  
	   )
    
   Q9.고객테이블에서 영희와 같은 성별을 갖는 고객 조회(여자)
   select * from gogek
   where
      (  
	        case  
	           when to_number(substr(gojumin,8,1)) in(1,3,5,7,9)  then '남자'
	           else '여자'
	        end
      ) 
	  in 
	  (
	      select 
	        case  
	           when to_number(substr(gojumin,8,1)) in(1,3,5,7,9)  then '남자'
	           else '여자'
	        end
	      from gogek 
	      where goname='영희'  
      )                                                                                                                                                              
                                                                                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                            
                                                                                                                                      
                                                                                                                                                                
                                                                                                                                                                                                                    
                                    
   

*/