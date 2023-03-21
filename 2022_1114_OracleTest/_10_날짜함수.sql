/*
 
	select sysdate from dual; 
	
	--날짜 data
	sysdata 출력시 년월일만 보이지만 -> 현재 시간이 같이 숨겨져 있다.
	그래서 date 형태로 '2022-11-17' 을하면 시간은 00:00:00이 되버린다.
 
 
--sysdte 예제
	select to_char(sysdate,'RRRR-MM-DD HH24:MI:SS') "지금시간" from dual ;
	결과 : 2022-11-17 10:15:49

--t : 날짜를 사용할때는 조심해라  
	select to_char(to_date('2022-11-17'),'RRRR-MM-DD HH24:MI:SS') "지금시간" from dual ;
	결과 : 2022-11-17 00:00:00

--sysdte 예제 일시분초  1은 하루 기준이다.
	select to_char(sysdate-1,'RRRR-MM-DD HH24:MI:SS') "하루전지금시간" from dual ;
  	
	select to_char(sysdate-1/24,'RRRR-MM-DD HH24:MI:SS') "1시간전시간" from dual ;
  	
	select to_char(sysdate-1/24/60,'RRRR-MM-DD HH24:MI:SS') "1분전시간" from dual ;
  	
	select to_char(sysdate-1/24/60/10,'RRRR-MM-DD HH24:MI:SS') "6초전시간" from dual ;
  	
	select to_char(sysdate-(5/24 + 30/24/60 + 10/24/60/60),'RRRR-MM-DD HH24:MI:SS') "5시간 30분 10초전" from dual ;
  	
################################################## 

--SYSTIMESTAMP 예제
	select to_char(systimestamp,'RRRR-MM-DD HH24:MI:SS.FF3')  from dual ;
 
	select to_char(systimestamp,'RRRR-MM-DD HH24:MI:SS.FF9')  from dual ;
 
##################################################
--ADD_MONTHS(DATE, NONTH)
	-3개월 후-
	select to_char(add_months(sysdate,3), 'RRRR-MM-DD') "date" from dual;
	-3개월 전-
	select to_char(add_months(sysdate,-3), 'RRRR-MM-DD') "date" from dual;
	
	-ex-
	select sysdate 입대일자, add_months(sysdate,18) 제대일자 from dual;
##################################################

--MONTHS_BETWEEN(a1, a2) : 날짜의 차이(월단위)

-- 두 일자 사이에 달의 수를 조회하는 예제
	select months_between(to_date('2010-06-05','RRRR-MM-DD'), 
                          to_date('2010-05-01','RRRR-MM-DD'))  "month"  from dual;
 
-- 두 일자 사이에 일짜 수를 조회하는 예제
	select to_date('2010-06-05','RRRR-MM-DD') - 
           to_date('2010-05-01','RRRR-MM-DD')  "day"  from dual;
 
##################################################
  
--ROUND(d[,F])   

-- ROUND예제
	select to_char(round(to_date('2011-09-11 21:00:01',
                             'RRRR-MM-DD HH24:MI:SS'), 'year'),
               				 'RRRR-MM-DD HH24:MI:SS')  from dual;
 
	select to_char(round(to_date('2011-09-11 21:00:01',
                             'RRRR-MM-DD HH24:MI:SS'), 'month'),
               				 'RRRR-MM-DD HH24:MI:SS')  from dual;
 
	select to_char(round(to_date('2011-09-11 21:00:01',
                             'RRRR-MM-DD HH24:MI:SS'), 'dd'),
               				 'RRRR-MM-DD HH24:MI:SS')  from dual;
 
	select to_char(round(to_date('2011-09-11 21:00:01',
                             'RRRR-MM-DD HH24:MI:SS')), 
               				 'RRRR-MM-DD HH24:MI:SS')  from dual;
     
##################################################
--E1) 사원테이블
select * from sawon

--퇴직급산정방식
월급 = 년봉/13
1) 퇴직금 = 월급 * 근무년수 +월급*잔여개월수/12
2) 퇴직금 = (월급*총근무월수)/12
	
	1)퇴직금
	select
		sabun,saname,sapay,
		floor(months_between(sysdate,sahire)/12) as 근속년수,
		floor(mod(months_between(sysdate,sahire),12)) as 잔여월수 , 
		floor(sapay/13) as 월급,
					--근무년수
		floor(
			(sapay/13)*(months_between(sysdate, sahire)/12) +
			(sapay/13)*(mod(months_between(sysdate,sahire),12))/12								
			) as 퇴직금
	from sawon



	2)퇴직금
	select
		sabun,saname,sapay,
		floor(months_between(sysdate,sahire)/12) as 근속년수,
		floor(mod(months_between(sysdate,sahire),12)) as 근속월수 , 
		floor(sapay/13) as 월급,
		floor(((sapay/13)* months_between(sysdate,sahire))/12) as 퇴직금
	from sawon


--근속년수
	select 
		sabun,saname,sahire,
		floor(months_between(sysdate, sahire)/12) 		as 근속년수,
		floor(mod(months_between(sysdate,sahire),12)) 	as 잔여월수
	from sawon
     
   
        
          
 
 */
