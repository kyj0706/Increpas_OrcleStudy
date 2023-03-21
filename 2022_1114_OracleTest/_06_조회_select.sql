/*

--실행순서 이해
	select 						--(시작) 뭐할꺼야 ? 선택 할려고
		sabun, saname, sapay	--3. 선택한 table 내에 column(필드)명은 이거야
	from sawon					--1. 이 테이블을 쓰게 해줘
	where sabun < 11			--2. 테이블에서 어디?  얘를  이만큼??... (행추출 조건)
	order by sapay desc			--4. 보기불편 ...얘 기준으로 정렬해줘  asc[오름차순] desc[내림차순]
	
--heading : 조회결과시 출력되는 컬럼명
			컬럼명(수식) [as] heading
	select
		sabun as 사번,
		saname 사원명,
		sapay  "년 봉",  --명명법이 틀렸다. 에러가 난다 그럼에도 하고싶다.."" 를 쓰면된다.(heading에서만 가능)
		sapay*0.1 as bonus											
	from sawon
	
--사원테이블에서 10번부서 직원 조회
	select * from sawon
	where deptno = 10	

--사원테이블에서 여자직원 조회
	select * from sawon
	where sasex = '여자'

--#################################################	
--사원테이블에서 직급이 과장인 직원 조회
	select * from sawon
	where sajob = '과장'

--사원테이블에서 10번부서의 과장을 조회
	select * from sawon
	where deptno=10 and sajob ='과장'

--사원테이블에서 직급이 과장, 대리인 직원 조회
	select * from sawon
	where sajob='과장' or sajob='대리'

--in연산자 사용 : 필드 in(A,B) -> 필드=A or 필드=B
	select * from sawon
	where sajob in('과장' , '대리')
--#################################################	
--사원테이블에서 년봉이 3500이상 직원 조회
	select * from sawon
	where sapay>=3500
	
--사원테이블에서 년봉이 3000~3500사이인 직원 조회
	select * from sawon
	where sapay>=3000 and sapay<=3500
	
--between연산자 사용 : A and B
	select * from sawon
	where sapay between 3000 and 3500
--#################################################	
	
--문자열 유사검색	
	필드 like '% or _'
	% : 모든값
	_ : 모든값(문자1개) [인데 어떤 값이 들어와도 된다]
	
	select * from sawon where saname ='이미자'
	
	
--사원테이블에서 성씨가 '이'씨인 직원 조회
	select * from sawon
	where saname like '이%'

--사원테이블에서 이름중 2번째 글자가 '미'인 직원 조회
	select * from sawon
	where saname like '_미%'

--고객테이블에서 주소가 서울지역인 고객 조회
	select * from gogek
	where goaddr like '서울%'

--E1)고객데이블에서 여자고객만 조회
	select * from gogek
	where gojumin like '______-2%' or
		  gojumin like '______-4%' or
		  gojumin like '______-6%' or
		  gojumin like '______-8%' or
		  gojumin like '______-0%' 
		  
	insert into gogek values(16,'이천년','부산 강서구','001212-4123456',2);
	commit

--E2)고객데이블에서 출생계절이 겨울인 고객을 조회
	select * from gogek
	where gojumin like '__12%' or
		  gojumin like '__01%' or
		  gojumin like '__02%' 

--E3)고객테이블에서 서울에 거주하는 80년대생 고객 조회
	select * from gogek
	where gojumin like '8%' and goaddr like '서울%'

--사원테이블에서 1993년도에 입사한 직원 조회
	select * from sawon 
	where to_char(sahire,'YYYY') = '1993'

###[날짜 조회]####
--사원테이블에서 2000년도 이전에 입사한 직원 조회
	select * from sawon
	where sahire < '2000-1-1'
	
--사원테이블에서 1995~2000년도 입사한 직원을 조회
###틀린 조회문장 : 2000-12-31 00:00:00 이후에 데이터는 조회되지 않는다.
	select * from sawon
	where sahire >= '1995-1-1' and sahire <= '2000-12-31'

-날짜 ->년도 ->숫자변환
	select to_number(to_char(sahire, 'YYYY')) from sawon
	
	select * from sawon
	where to_number(to_char(sahire, 'YYYY')) between 1995 and 2000

--E4)사원테이블에서 1999-9-9일까지 입사한 직원 조회 (시간을 제외하고 비교)
	select * from sawon
	where to_char(sahire, 'YYYY-MM-DD') <= '1999-09-09'
*/

	
	

