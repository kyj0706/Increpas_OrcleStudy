/*
	오라클자료형
		=>크기(byte단위)
		
	 1. 문자형 : 최대 2000byte사용할 수 있다.
		char(크기)		<-고정길이
		varchar2(크기)	<-가변길이
		
		ex)
		memo char(100) 		<-	'안녕'(0) "안녕"(x)	-> 100byte로 저장
		memo varchar2(100)	<-	'안녕'(0) 			-> 6byte로 저장
		
		--오라클은 한글 1글자 3byte로 표현한다.
		select length('안녕'), lengthb('안녕') from dual   --dual(임시테이블)
		
		
	2. 숫자형
		int -> number(38,0)
		number(p,s) precision(전체자릿수) scale(소수점이하 자릿수)
		number(p)
		
		
		create table ttt(no int, kor number(3), avg number(5,1))
		--생성된 테이블 구조를 sqlplus통해서 확인 : desc[ribe] ttt     ->[describe] -> 약어 desc
		
	3.날짜형
		date 	(자료형) 	<- 년월일시분초
		sysdate	(함수)		<- 현재시스템날짜구하기
		
		select sysdate from dual
		
		select 
			to_char(sysdate,'YYYY') as 년,
			to_char(sysdate,'MM') 	as 월,
			to_char(sysdate,'DD') 	as 일,
			to_char(sysdate,'PM HH24') 	as 시,
			to_char(sysdate,'MI') 	as 분,
			to_char(sysdate,'SS') 	as 초,
			to_char(sysdate,'DAY') 	as 요일,
			to_char(sysdate,'YYYY_MM_DD(DAY)_PM_HH(HH24):MI:SS')
		from dual
		
		
	4.대용량(LOB: Large Object) : 2~4GB
		BLOB : Binary Large Object		(binary 대용량 데이터)
		CLOB : Character Large Object	(문자형 대용량 데이터)







*/