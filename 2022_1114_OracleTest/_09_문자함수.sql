/*

--1, 문자결함 : ||
	select '우리' || '나라' || '대한민국' from dual

	select saname || sajob || '님 고생 많으셨습니다.' from sawon
	
-- INITCAP, LOWER, UPPER 예제
select initcap('oracleclub') name from dual
union all
select upper('oracleclub') name from dual
union all
select lower('oracleclub') name from dual;


###[중요] 문자 잘라내기#####
-- 세번째 이후 문자열 반환
				   1234567890	<- oracle의 문자열을 index 1 base
	select substr('oracleclub',3) name from dual;

-- 세번째 이후 네개의 문자열 반환
							  위치 개수	
	select substr('oracleclub',3 ,4) name from dual;

-- 뒤에서 세번째이후 두개의 문자열 반환
				   0987654321 음수면 뒤에서부터 읽는다.	
	select substr('oracleclub',-3 ,2) name from dual;
	
	
--E)고객테이블에서 서울 사는 고객만 조회
	
	select substr(goaddr, 1,2) from gogek

	

	select * from gogek
	where substr(goaddr, 1,2) ='서울'
	and substr(gojumin,8,1)='1'
	
--고객테이블에서 여자고객만 조회(함수사용)
	select * from gogek
	where 
	substr(gojumin, 8,1)
	in(0,2,4,6,8) 

--E2)고객테이블에서 가을 출생자만 조회(9,10,11월 출생자) <=함수사용(substr)
	select * from gogek
	where
	substr(gojumin, 3, 2) 
	in('09','10','11') 
	
	select * from gogek
	where to_number(substr(gojumin,3,2)) in (9,10,11)
	

--E3)사원테이블에서 7월 입사자 조회(입사일자에서 월만 추출) <= 함수사용(to_char)
	select * from sawon
	where to_char(sahire, 'MM') ='07'


*/