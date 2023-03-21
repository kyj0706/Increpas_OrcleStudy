/*

--서브쿼리(Subquery)
	:하위쿼리의 결과를 조건으로 주쿼리 수행

--사원테이블에서 최불암과 같은 부서 직원 조회
	select * from sawon
	
	1. 최불암의 부서?
		select deptno from sawon where saname ='최불암'
	2. 최불암의 부서는 10 -> 10번부서 직원 조회
		select * from sawon where deptno =10
	
	3.합치기
		select * from sawon
		where deptno=(select deptno from sawon where saname='최불암')
		
		--조금이라도 중복될거 같으면 in으로 해라
		select * from sawon
		where deptno in (select deptno from sawon where saname='최불암')
	
--사원테이블에서 장동건과 급여가 같은직원
	select sapay from sawon where saname ='장동건'
	
	select * from sawon
	where sapay =(select sapay from sawon where saname ='장동건')
	
	--조금이라도 중복될거 같으면 in으로 해라
	select * from sawon
	where sapay in (select sapay from sawon where saname ='장동건')

--사원테이블에서 장동건과 동일한 년도에 입사한 직원 조회
	select sahire from sawon where saname ='장동건'
	
	select * from sawon
	where to_char(sahire, 'YYYY') = (select to_char(sahire,'YYYY') from sawon where saname ='장동건')
	
-- 고객테이블에서 류민과 동일한 지역의 사는 고객을 조회(광역시)
	select * from gogek
	select substr(goaddr, 1,2) from gogek where goname ='류민'
	
	select * from gogek
	where substr(goaddr,1,2) = (select substr(goaddr, 1,2) from gogek where goname='류민')

-- 고객테이블에서 류민과 같은 달에 태어난 고객 조회
	select substr(gojumin,3,2) from gogek where goname ='류민'
	
	select * from gogek
	where substr(gojumin,3,2) = (select substr(gojumin,3,2) from gogek where goname='류민')
	
-- 사원테이블에서 최초입사자 정보를 조회
	select * from sawon
	where to_char(sahire,'YYYYMMDD') =(select to_char(min(sahire),'YYYYMMDD') from sawon)
	
		--distinct : 도메인내 중복데이터 1번만 나오도록
		E3_1)
		select distinct * from 
		(
			select '하나' from dual
			union all
			select '하나' from dual
	    )
	
-- 사원추가 
	select * from sawon
	where sapay > (select avg(sapay) from sawon)


	insert into sawon values(21,'장동건','남자',10,'사원','2022-11-11',16,2500);
	commit
	
	select * from sawon
^@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@	
--Q1) 사원테이블에서 최불암보다 급여를 많이 받는 직원 조회
	select * from sawon
	select sapay from sawon where saname ='최불암'
	-------------
	select * from sawon
 	where sapay > ANY
 	(select sapay from sawon where saname='장동건')
 	
--Q2) 사원테이블에서 가장 최근 입사한 직원 조회
	select * from sawon 
	where to_char(sahire,'YYYYMMDD') in 
	(select max(to_char(sahire,'YYYYMMDD')) from sawon)

--Q3) 사원테이블에서 가장 최근입사자와 동일한 부서직원 조회
	select * from sawon
	where deptno=
	(
	
		select deptno from sawon
		where to_char(sahire,'YYYYMMDD') in (select max(to_char(sahire,'YYYYMMDD')) from sawon)
	)
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@	
-- 사원테이블에서 10번 부서의 최대급여자 조회
	select * from sawon
	where sapay = (select max(sapay) from sawon where deptno = 10)
		and
		deptno=10
	
--사원테이블에서 20번 부서의 최대 급여자 조회.
	
	
	select * from sawon 
	where sapay = (select max(sapay) from sawon where deptno =20)
		and
		deptno=20
-- 사원테이블에서 각부서별 최대 급여자 조회
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
	
	--보안
	##상관쿼리 
	 : 주쿼리의 정보를 이용해서 서브쿼리 수행하고 결과를 참조해서 주쿼리를 선택
	메인쿼리의 값을 이용해서 서브쿼리를 실행  => 서브쿼리가 결과를 보내주고 메인쿼리는 진행 
	select * 
	from sawon s1
	where s1.sapay = 
	(select max(sapay) from sawon where deptno =s1.deptno)
	order by deptno asc
###########################!!!!! 문제 !!!########################################
	4. 사원테이블에서 최불암과 같은 월에 입사한 직원 조회
		select * from sawon
		where to_number(to_char(sahire,'MM')) in
		(select to_number(to_char(sahire,'MM')) from sawon where saname ='최불암')
	
	  왜이렇게 귀찮게 햇찌 ? ....
		select * from sawon
		where to_number(substr(to_char(sahire,'YYYYMMDD'),5,2)) in
		(select to_number(substr(to_char(sahire,'YYYYMMDD'),5,2)) from sawon where saname ='최불암')
		order by to_char(sahire,'YYYY') asc
		
	5. 고객테이블에서 류민과 같은 월에 태어난 고객 조회
		select * from gogek
		where substr(gojumin,3,2) in
		(select substr(gojumin,3,2) from gogek where goname = '류민') 
		order by substr(gojumin,1,2) asc
		
					
	6. 사원테이블에서 각부서별 입사일자가 가장 빠른 직원 조회(상관쿼리(
		select * 
		from sawon s1
		where to_char(s1.sahire,'YYYYMMDD') in 
		(select min(to_char(sahire,'YYYYMMDD')) from sawon where  deptno = s1.deptno) 
		order by to_char(sahire,'YYYYMMDD') asc
		
	
	7. 사원테이블에서 이미자와 동일한 년대에 입사한 직원조회 (년대 : 1980 1990 2000)
	 	select * from sawon
      	where floor(to_number(to_char(sahire,'YYYY'))/10) in 
      	(select floor(to_number(to_char(sahire,'YYYY'))/10) from sawon where saname='이미자')
   		
	
	8. 사원테이블에서 최불암과 같은 계절에 입사한 직원 조회
	 	 select * from sawon
      	where floor(to_number(to_char(sahire,'MM'))/3) in 
      	(select floor(to_number(to_char(sahire,'MM'))/3) from sawon where saname='최불암')
	
	9. 고객테이블에서 영희와 같은 성별을 같는 고객 조회(여자)
		select substr(gojumin,8,1) from gogek
	
		select * from gogek where goname = '영희'	
		
		select * from gogek
		where mod(to_number(substr(gojumin,8,1)),2) in
		(select mod(to_number(substr(gojumin,8,1)),2) from gogek where goname = '영희')

*/
