/*
	성적관리 Table을 생성 해봅시다 ~ 
	
	create table test_sung
	(
	-- 컬럼명	자료형
		num 	int,
		name 	varchar2(100),
		kor 	number(3),
		eng		number(3),
		mat		number(3)
	)
	
	
	--1.데이터는 테이블 생성 순서대로 넣는다. -> (방법2) 굳이 순서대로 넣아야 하는가? 아니다.
	--2.데이터의 문자열은 무조건 ''(싱글쿼테이션이다)
	--3.세미콜론은 선택사항이다.  내용을 끝내기 위한 용도로 사용된다. (순수한 SQL문에는 ;은 없다.)
	
	--DML (Data Manupulation Language) : 데이터 조작언어
	-- : insert delete update
	
	--(방법1)테이블 데이터 넣기 (insert)
	insert into test_sung values(1,'일길동',90,80,70);
	insert into test_sung values(2,'이길동',100,100,100);
	insert into test_sung values(3,'삼길동',90,90,90);
	
	--(방법2)테이블 데이터 넣기_순서다르게 
	--해서 넣을 수 있는데 그래도 순서대로 [용도]-> 필요없는 데이터를 제외하고 넣을때 
	insert into test_sung(num,kor,eng,mat,name) values(4,55,66,77,'사길동');
	
	
	--주의!!! 
	--update/delete는 where 조건절이 없으면 전부 해당된다.
	
	
	--데이터 수정(update)
								  where 조건절
	update test_sung set kor = 80 where num =1
	
	--데이터삭제(delete)
	delete from test_sung where num = 4
	
	
	--데이터조회
	* : 모든컬럼 조회
	select * from test_sung
	
	
	
	select 
		num,name,kor,eng,mat,  	--기본필드
		(kor+eng+mat) as tot,	--연산필드(컬럼)
		(kor+eng+mat)/3 as avg,
		rank() over(order by (kor+eng+mat) desc) as rank
	from test_sung
	order by num
	
	
	
	CRUD(추가/읽기/수정/삭제)
	Create 	: insert
	Read 	: select
	Update 	: update
	Delete	: delete
	




*/