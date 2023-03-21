/*
 	DECODE(수식/필드 , 값1, (명령1),
 					   값2, (명령2),
 					   값2, (명령3),
 					   값2, (명령4), default
 
 	          12345678901234   <-index 1base
 	gojumin = 801212-1234560
 
 
 	select 
 		gobun, goname, gojumin,
 		DECODE(substr(gojumin,8,1), '1' ,'남자',
 									'3' ,'남자',
 									'5' ,'남자',
 									'7' ,'남자',
 									'9' ,'남자',
 		                            '2' ,'여자',
 		                            '4' ,'여자',
 		                            '6' ,'여자',
 		                            '8' ,'여자',
 		                            '0' ,'여자'
 		                            ) as gogender
 	from gogek
 
 --함축
 	select 
 		gobun, goname, gojumin,
 		DECODE(mod(to_number(substr(gojumin,8,1)),2), 1 ,'남자',
 		                            		          0 ,'여자' ) as gogender
 		                            
 	from gogek
 
#########################################################################
--CASE 문

	형식1)
		case 필드 / 수식
			when 값1 then 명령1
			when 값2 then 명령2
			when 값3 then 명령3
			else 기본명령
		end
		
	형식2)
		case
			when 조건1 then 명령1
			when 조건2 then 명령2
			when 조건2 then 명령2
			else 기본명령
		end
---------------
	형식1_예제)
	select 
		gobun, goname, gojumin,
		case mod(to_number(substr(gojumin, 8,1)),2)
			when 1 then '남자'
			else '여자'
		end as gogender
	from gogek
	
	
	형식2_예제)
	select
		gobun, goname, gojumin,
		case
			when to_number(substr(gojumin,8,1)) in(1,3,5,7,9) then '남자'
			else '여자'
		end as gogender
	from gogek
	
--사원테이블
	select * from sawon
	
	select 
		sabun, saname, sahire,
		to_number(to_char(sahire,'MM')) 
	from sawon	
	
	select 
		sabun, saname, sahire, 
		case 
			when to_number(to_char(sahire, 'MM')) in(3,4,5) 	then '봄'
			when to_number(to_char(sahire, 'MM')) in(6,7,8) 	then '여름'
			when to_number(to_char(sahire, 'MM')) in(9,10,11)	then '가을'
			else '겨울'
		end as season
	from sawon
	
	
	select 
		sabun, saname, sahire, 
		case floor(to_number(to_char(sahire, 'MM'))/3)
			when 1 then '봄'
			when 2 then '여름'
			when 3 then '가을'
			else '겨울'
		end as season
	from sawon
	
	
###############################################

--E1) 고객테이블에서 고객의 출생계절 추출
	gojumin <- varchar2
				
			   12345678901234 <-index 1base	
	gojumin = '801212-1234560'
	
	select * from gogek
	
	select
		gojumin,
		to_number(substr(gojumin, 3,2))
	from gogek
	
	
	select
		gobun, goname, gojumin,
		case floor(to_number(substr(gojumin, 3,2))/3)
			when 1 then '봄'     --3, 4, 5
			when 2 then '여름'   --6, 7, 8
			when 3 then '가을'   --9, 10, 11
			else '겨울' --나머지
		end as goseason
	from gogek 
	order by substr(gojumin,3,2) asc


--E2)주민번호 -> 출생년도 
			
			   12345678901234 <-index 1base	
	gojumin = '801212-1234560'
	
	select * from gogek
	
	--성별코드 1자리
			내국인		외국인
			남  여		남  여		
	1900	1	2		5	6		
	2000	3	4		7	8
	1800	9	0		
	
	--띠 12개 12간지
	#############################
	select
		gobun, goname, gojumin,
		
			--출생년도
			(to_number(substr(gojumin,1,2))+
				(
					case
						when to_number(substr(gojumin,8,1)) in(1,2,5,6) then 1900
						when to_number(substr(gojumin,8,1)) in(3,4,7,8) then 2000
						else 1800
					end
				) 
			) as 출생년도,
			
			--나이
			to_number(to_char(sysdate, 'YYYY')-
			(to_number(substr(gojumin,1,2))+
				(
					case
						when to_number(substr(gojumin,8,1)) in(1,2,5,6) then 1900
						when to_number(substr(gojumin,8,1)) in(3,4,7,8) then 2000
						else 1800
					end
				) 
			)+1) as 나이,
			
			--띠
			case mod((to_number(substr(gojumin,1,2))+
						(
							case
								when to_number(substr(gojumin,8,1)) in(1,2,5,6) then 1900
								when to_number(substr(gojumin,8,1)) in(3,4,7,8) then 2000
								else 1800
							end
						) 
	   			 	),12)    
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
			end as 띠
	from gogek
	
	
	
	select
		gobun, goname, gojumin,
		to_number(substr(gojumin,1,2))+1900 as 나이
	
	from gogek



 
*/