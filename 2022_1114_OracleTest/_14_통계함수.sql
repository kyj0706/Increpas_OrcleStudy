/*

	통계(집계)함수
	
	count(필드) : 필드내의 도메인수 구하기(null계산안된다)
	count(*)	: 전체레코드수 구하기
	
	ex
	select count(*), count(samgr) from sawon

	
	
	max(필드) : 최대값 (숫자or날짜)
	min(필드) : 최대값 (숫자or날짜)
	sum(필드) : 최대값 (숫자or날짜)
	avg(필드) : 최대값 (숫자or날짜)
	
	select 
		max(sapay) as 최대급여,
		min(sapay) as 최소급여,
		sum(sapay) as 급여합계,
		avg(sapay) as 급여평균,
		min(sahire) as 최초입사일자,
		max(sahire) as 최근입사일자
	from sawon
	


*/