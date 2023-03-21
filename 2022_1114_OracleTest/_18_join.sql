/*
select * from sawon
order by sabun desc


--조인(join) : 행과 행이 결합
	1. 2개이상의 테이블을 연결(결합)해서 조회하는 방법
	2. 종류
		1)cross join : 모든행이 조건없이 결합 
		2)inner join : 1:1로 결합되는 형식
		3)outer join
			A left  outer join B : A테이블행은 모두추출 B는 만족하는행만 추출
									-> 만족하지 않으면 null로 채워진다.
			A right outer join B : B테이블행은 모두추출 A는 만족하는행만 추출 
			A full  outer join B : A,B테이블의 행이 모두 추출
		
		4)self join : 자신의 테이블과 연결하는 방식 
		
--###########################################################################		

--[cross join 연습]
	select * from sawon, dept	

	[ANSI-92 SQL] : 모든 DBMS에 적용되는 "표준" 문법
	select * from sawon cross join dept
--###########################################################################		
	
--[inner join] : 행-행 1:1결합되는 형식의 조인
1)	[inner join]
	select * from sawon s, dept d
	where s.deptno = d.deptno --조인조건
	
2)		[ANSI-92 SQL] 장점) : 조인조건과 일반 검색 조건이 분리가 되어있어 구분이 명확하다.
		select  
			sabun,saname,dept.deptno,dname
		from sawon inner join dept on sawon.deptno = dept.deptno -- on절 뒷쪽이 조인조건
		where dept.deptno <> 10
		
	
3)	--(alias)를 사용 하는 이유
	select  
		sabun,saname,d.deptno,dname
	from sawon s, dept d
	where s.deptno = d.deptno --조인조건
		and s.deptno <> 10 	  --일반적인검색조건
--###########################################################################		

--[self join] : 자신의 테이블과 결합
예제1) 사번 직원 사원명 / 상사번호 상사직위 상사명
			sawon s1		 sawon s2
	
1)	create or replace view sawon_view5
	as
		select 
			s1.sabun,s1.sajob,s1.saname,
			s2.sabun as sabun2 ,
			s2.sajob as sajob2,
			s2.saname as saname2 
		from sawon s1 , sawon s2
		where s1.samgr = s2.sabun
		order by s1.sabun
		

[outer join] :
			A left  outer join B : A(all)  B(만족하는행)       
            A right outer join B : B(all)  A(만족하는행)       
            A full  outer join B : A,B(만족하는행) + A,B(만족하지않는 행)     
	
2)		[Oracle만 지원]
		select 
			s1.sabun,s1.sajob,s1.saname,
			s2.sabun as sabun2 ,
			s2.sajob as sajob2,
			s2.saname as saname2 
		from sawon s1 , sawon s2
		where s1.samgr = s2.sabun(+) --left outer 조인조건
		order by s1.sabun
		
		cf)MS-SQL Server : where s1.samgr *= s2.sabun


3)		[ANSI-92 SQL]
		select 
			s1.sabun,s1.sajob,s1.saname,
			s2.sabun as sabun2 ,
			s2.sajob as sajob2,
			s2.saname as saname2 
		from sawon s1 left outer join sawon s2 on s1.samgr = s2.sabun
		order by s1.sabun
		
		select
			s1.sabun as 사원번호, 
			s1.sajob as 사원직급, 
			s1.saname as 사원이름,
			
			s2.sabun as 상사번호, 
			s2.sajob as 상사직급, 
			s2.saname as 상사이름
		from sawon s1 left outer join sawon s2 on s1.samgr = s2.sabun
		
		select
		 	s1.sabun as 상사번호, 
			s1.sajob as 상사직급, 
			s1.saname as 상사이름,
			
			s2.sabun as 사원번호, 
			s2.sajob as 사원직급, 
			s2.saname as 사원이름
		from sawon s1 right outer join sawon s2 on s1.sabun = s2.samgr
		
		
		select
			s1.sabun as 사원번호, 
			s1.sajob as 사원직급, 
			s1.saname as 사원이름,
			
			s2.sabun as 상사번호, 
			s2.sajob as 상사직급, 
			s2.saname as 상사이름
		from sawon s1 full outer join sawon s2 on s1.samgr = s2.sabun
		
		
		select * from sawon
		
3) full outer join
	select * from sawon s full outer join dept d on s.deptno = d.deptno		
	
--###########################################################################


[join을 쉽게 하려면 : 왼쪽부터 순서대로...]
--예제2) 사원 사원명 / 부서번호  부서명 / 담당고객번호 담당고객명
			sawon s			dept d				gogek g
					 (1)s.deptno=d.deptno
					 					 (2) s.sabun=g.godam
			
	select 
		s.sabun, s.saname,
		d.deptno, d.dname,
		g.gobun, g.goname
	 
	from sawon s inner join dept d on s.deptno = d.deptno --(1)
		 left outer join gogek g   on s.sabun = g.godam --(2)
	order by s.sabun
	
--###########################################################################
--Q1. 사번 사원명 / 부서명 / 고객번호 고객명 / 상사번호 상사명 /상사고객담당번호 상사담당고객명	
		sawon s1	dept d      gogek g1			  sawon s2          gogek g2				  
	
	
	select
		s1.sabun as 사번, s1.saname as 사원명,
	  	d.dname as 부서명,
	  	g1.gobun as 고객번호, g1.goname as 고객명,
	  	s2.sabun as 상사번호, s2.saname as 상사명,
	  	g2.gobun as 상사담당고객번호, g2.goname as 상사담당고객명
	
	from sawon s1 inner join dept d on s1.deptno = d.deptno
		left outer join gogek g1 	on s1.sabun = g1.godam
		left outer join sawon s2 	on s1.samgr = s2.sabun 
		left outer join gogek g2 	on s2.sabun = g2.godam
		
	order by s1.sabun
	
	select * from sawon
	
	
	select 
			s1.sabun,s1.sajob,s1.saname,
			s2.sabun as sabun2 ,
			s2.sajob as sajob2,
			s2.saname as saname2 
		from sawon s1 inner join sawon s2 on s1.samgr = s2.sabun
		order by s1.sabun
	
	
	
	
	
	
	
*/