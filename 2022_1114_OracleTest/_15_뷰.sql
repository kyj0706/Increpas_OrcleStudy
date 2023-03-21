/*

	뷰(view)
	1. 가상의 테이블(상용방법은 테이블과 동일하다)
	2. view 내부에 처리할 SQL문장이 저장 => 실행시 SQL명령이 실행
	3. 목적
		1)간결성(편리함) : 복잡한 SQL문을 간결하게 사요할 수 있다.
		2)보안성 		 : 뷰를 통해서 중요정조를 감출 수 있다.
	4. 형식
		create or replace view view이름
		as
			SQL문

--사원테이블에서 남자 또는 여자 직원별 조회(view를 이렇게 사용하는 거다 하는 예제 정도)
	create or replace view sawon_man_view
	as
		select * from sawon where sasex ='남자' with check option

	create or replace view sawon_woman_view
	as
		select * from sawon where sasex ='여자' with check option

	select * from sawon_man_view
	select * from sawon_woman_view
	
--사원테이블
	create or replace view sawon_view
	as --추가 view 테이블 
		select 
			s.*,
			to_number(to_char(sahire,'YYYY')) as hire_year,
			to_number(to_char(sahire,'MM')) as hire_month,
			to_number(to_char(sahire,'DD')) as hire_day,
			to_char(sapay *10000,'L999,999,999') as sapay2
		from (select * from sawon) s --얘도 뷰다 -> inline view (SQL문 실행중 임시생성되는 뷰)

	select * from sawon_view
	
	--view 이용 -> 또 다른 view 생성
	create or replace view sawon_view2
	as
		select
			s.*,
			case floor(hire_month/3)
				when 1 then '봄'
				when 2 then '여름'
				when 3 then '가을'
				else '겨울'
			end as hire_season
		from (select * from sawon_view) s
	
	select * from sawon_view2

--사원테이블에서 장동건과 동일한 계정에 입사한 직원 조회
	select * from sawon_view2
	where hire_season in
	(select hire_season from sawon_view2 where saname ='장동건')
	
	
--고객테이블
	select * from gogek
	
	create or replace view gogek_view
	as
		select
			gobun,goname,goaddr,godam,
			substr(gojumin,1,8) || '*******' as gojumin,
				(to_number(substr(gojumin,1,2))+
						(
							case
								when to_number(substr(gojumin,8,1)) in(1,2,5,6) then 1900
								when to_number(substr(gojumin,8,1)) in(3,4,7,8) then 2000
								else 1800
							end
						) 
					) as goyear,
				to_number(substr(gojumin,3,2)) as gomonth,
				to_number(substr(gojumin,5,2)) as goday,
			case
				when to_number(substr(gojumin,8,1)) in(1,3,5,7,9) then '남자'
				else '여자'
			end as gogender
		from gogek
	
	select * from gogek_view
	
	--영희와 같은 성별을 갖는 고객조회
	select * from gogek_view
	where gogender in
	(select gogender from gogek_view where goname='영희')

##################################################################################################

--뷰 보안에 대한 테스트 절차
--conn system/oracle
--connection Name : Oracle_system전환
	1.계정생성
		create user test5 identified by test5
	2.접속권한 부여
		grant connent to test5

--gogek_view에 대한 select권한 부여(소유주만 권한부여 할 수 있다)
--conn test/test
--Connection Name : Oracle_test전환
	1.개체(Entity : Table or View)권한
		grant select on gogek_view to test5
	
	cf) grant all on 테이블(뷰) to 유저
		권한 : select.insert.update.delete
			   all(모든권한)

--conn test5/test5
--connection Name : Oracle_test5전환

	select * from test.gogek_view
	select * from test.gogek --(x)권한이 부여되지 않았다.
	
	
-conn test/test

	select * from gogek_view
	
--Q1)gogek_view를 이용해서 gogek_view2생성
	 gogek_view2의 추가 컬럼 : goage,gotti,goganji
	 
	 4  5  6  7  8  9  0  1  2  3     <- 간지(mod)출생년도, 10)
	 갑 을 병 정 무 기 경 신 임 계
	 
	 4  5  6  7  8  9  10  11  0  1  2  3  <-mod(출생년도,12)
	 자 축 인 묘 진 사 오  미 신 유 술 해
	 
	 
	 select * from gogek_view
	 
	 
	 create or replace view gogek_view2
	 as
		 select g.*,
				--나이
				(to_number(to_char(sysdate,'YYYY')))-(goyear)+1 as goage, 
				
				--띠
				case mod(goyear,12)
					when 4  then '[자] 쥐'
					when 5  then '[축] 소'
					when 6  then '[인] 호랑이'
					when 7  then '[묘] 토끼'
					when 8  then '[진] 용'
					when 9  then '[사] 뱀'
					when 10 then '[오] 말'
					when 11 then '[미] 양'
					when 0  then '[신] 원숭이'
					when 1  then '[유] 닭'
					when 2  then '[술] 개'
					when 3  then '[해] 돼지'
				end as gotti,
				
				--간지
					(
						substr('경신임계갑을병정무기', 		mod(goyear,10)+1,1) ||
						substr('신유술해자축인묘진사오미', 	mod(goyear,12)+1,1) || '년'
						
					)as goganji,
		
				
				--계절
				case floor(gomonth/3)
					when 1 then '봄'
					when 2 then '여름'
					when 3 then '가을'
					else '겨울'
				end as goseason
		 from 
		 (select * from gogek_view) g
	
	
	select * from gogek_view2
	 	
	 			
	 							
			/*case mod(goyear,10)
				when 4  then '[갑]'
				when 5  then '[을]'
				when 6  then '[병]'
				when 7  then '[정]'
				when 8  then '[무]'
				when 9 	then '[기]'
				when 0  then '[경]'
				when 1  then '[신]'
				when 2  then '[임]'
				when 3  then '[계]'
			end as goganji,*/
	
	--inline view : SQL문장내에 임시로 작성된 뷰
		select
			s.*,
			(select round(avg(sapay),0) from sawon) as total_avg,
			(select round(avg(sapay),0) from sawon where deptno=10) as avg_10,
			(select round(avg(sapay),0) from sawon where deptno=10) as avg_20,
			(select round(avg(sapay),0) from sawon where deptno=10) as avg_30,
			(select round(avg(sapay),0) from sawon where deptno=10) as avg_40
		from 
			 (select * from sawon) s
	 
	 
	
*/