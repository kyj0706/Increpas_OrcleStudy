/*

###[숫자->문자]#####

-- 콤마 예제
select to_char(12345678,'999,999,999') comma from dual;
 
-- 소숫점 예제  
select to_char(123.45678,'999,999,999.99') period from dual; 
 
-- $ 표시 예제
select to_char(12345678,'$999,999,999') dollar  from dual;
 
-- local 화폐 표시 예제 (한국의 경우 ￦로 자동 변환 됨)
select to_char(12345678,'L999,999,999') local  from dual;
 
-- 왼쪽에 0을 삽입
select to_char(123,'09999') zero from dual;  
 
-- 16진수로 변환
select to_char(100,'xxxx') hexadecimal from dual;


####[날짜->문자]####
-- 년,월,일,시,분,초 예제
select to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') "sysdate"
from dual;
 
-- 365일 중 몇 일째인지 조회
select to_char(sysdate, 'DDD') "day of year" from dual;
 
-- 53주 중 몇 주차 인지 조회
select to_char(sysdate, 'IW') "week of year" from dual;
 
-- 해당 월의 이름 조회
select to_char(sysdate, 'MONTH') "name of month" from dual;

select
    to_char(sysdate,'YYYY') as year, 
    to_char(sysdate,'RRRR') as year2, 
    to_char(sysdate,'MM')   as month 
from dual

####[문자->날짜]###

select
    to_date('2022-11-16'),                                  -- 00:00:00
    to_date('2022-11-16 12:20:30','YYYY-MM-DD HH:MI:SS'),   -- 12:20:30
    sysdate                            -- 현재시간   
from dual


*/