/*
--정렬(sort)
	:order by 필드 [asc][desc]
		asc[ending] : 오름차순
		desc[ending]: 내림차순 
		
					  1차정렬		   2차정렬
		order by 필드1 [정렬방식], 필드2 [정렬방식]
	--예시
	select * from sawon
	order by deptno,sasex
	
	
	--group by구조                         실행순서
	select 
		그룹필드(제목),통계함수			   --5)	
	from 	 테이블명(뷰)                  --1)
	where 	 조건절						   --2)
	group by 그룹필드(수식)				   --3)
	having 	 통계결과조건				   --4)
	order by 필드						   --6)
	
--설명--	
	select 
		*  		--<-들어올수 있는 항목(통계함수,그룹필드)
	from sawon
	group by deptno --<- 기준
	order by deptno asc --<- 반듯이 써야 되냐? 아니다. 왜? 결과값으 중요한거지 정렬이 중요한게 아니니까
	
--##################################################################################################	
	

--예제1_1)
	select 
		count(*) as 인원수	
	from sawon
	group by deptno 
	order by deptno asc

--예제1_2)
	select 
		deptno,count(*) as 인원수	
	from sawon
	group by deptno 
	order by deptno asc
--=============================================	

		
--예제3_1) 부서별 성별인원수
	select
		deptno,sasex,count(*)
	from sawon
	group by deptno, sasex
	order by deptno, sasex
	
--예제3_2) 직급별 인원수,급여합계,급여평균
	select * from sawon
	select 
		sajob, count(*),
		sum(sapay) as sum, 
		round(avg(sapay),0) as avg
	from sawon
	group by sajob
	
--예제4_1) 입사년도별 인원수(함수식)
	select 
	  to_char(sahire,'YYYY') as 입사년도,
	  count(*) as 인원수 
	from sawon
	group by to_char(sahire,'YYYY')
	order by to_char(sahire,'YYYY')
	
--예제4_2) view를 사용하면 얼마나 사용하데 편리해지는지 ?
	select * from sawon_view
	
	select
		hire_year, count(*)
	from sawon_view
	group by hire_year
	order by hire_year
	
--예제4_3) 입사월별 인원수
	select * from sawon_view
	
	--함수사용
	select
		to_char(sahire,'MM') as 입사월 ,
		count(*) as 인원수
	from sawon
	group by to_char(sahire,'MM')
	order by to_char(sahire,'MM')
	
	--view사용
	select 
		hire_month as 입사원,
		count(*) as 인원수
	from sawon_view
	group by hire_month
	order by hire_month

--########################################
	
--예제5_1) 고객의 거주지별 인원수(광역시 단위 :서울 경기)
	select * from gogek
						
	select 
		substr(goaddr,1,2) as 거주지, 
		count(*) as 인원수
	from gogek
	group by substr(goaddr,1,2)
	order by substr(goaddr,1,2)
	
	select
	substr(goaddr,1,2) as 거주지, 
	gogender as 성별, --?? 여자면 ? 어떻게 나오는데 ?
	 count(*) as 인원수
	from gogek_view
	group by substr(goaddr,1,2), gogender
	
	
	select substr(goaddr,1,2), gogender from gogek_view
	order by substr(goaddr,1,2)
	
					
				
-- having 절 : group에 대한 조건절 
-- where 절  : select에 대한 조건절
--having절 : group 통계에 대한 조건절 

	select
		deptno, round(avg(sapay),0) dept_avg
	from sawon
	group by deptno
	having round(avg(sapay),0) >=3000
	order by deptno
	
--위의 실행결과를 where절 : inline view를 이용
	select * from
	(
		select
		deptno, round(avg(sapay),0) dept_avg
		from sawon
		group by deptno
		order by deptno
	)
	where dept_avg >=3000

--#####################################################
--GROUP BY 문제

Q1) 사원테이블에서 입사계절별 인원수
	select * from sawon_view2
	
	--결과
	select
		hire_season as 입사계절, 
		count(*) as 인원수
	from sawon_view2
	group by hire_season
	

Q2) 사원테이블에서 입사년대별 인원수
	 입사년대		인원수
	 1980			 ?
	 1990            ?
	 2000            ?
	 
	 select * from sawon_view2
	 select floor(hire_year/10) from sawon_view2
	 
	 --결과
	 select
	 	floor(hire_year/10)*10 || '년대',
	 	count(*)
	 from sawon_view2
	 group by floor(hire_year/10)*10
	 
	 
	 
	 
Q3) 고객테이블에서 성별 인원수 구해라
	select * from gogek_view2
	
	--결과
	select
		gogender as 성별, 
		count(*) as 인원수
	from gogek_view2
	group by gogender


Q4) 고객테이블에서 연령대별 인원수
	 연령대			인원수
	 20대			  ?
	 30대			  ?
	 40대			  ?
	 
	 select * from gogek_view2
	 
	 --결과
	 select
	 	floor(goage/10)*10 || '대', 
	 	count(*)
	 from gogek_view2
	 group by floor(goage/10)*10
	 order by floor(goage/10)*10

Q5) 고객테이블에서 띠별 인원수
	select * from gogek_view2
	
	--결과
	select
		gotti as 띠,
		count(*) as 인원수
	from gogek_view2
	group by gotti

Q6) 고객테이블에서 태어난계절별 인원수
	select * from gogek_view2
	
	--결과
	select
		goseason as 태어난계절,
		count(*) as 인원수
	from gogek_view2
	group by goseason
			
	
	
	
	
	
	



*/