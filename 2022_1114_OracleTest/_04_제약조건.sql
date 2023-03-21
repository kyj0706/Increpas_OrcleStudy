/*

	제약조건(Constraint)
	1. 데이터무결성(Data intergrity)지키기 위한 속성
	2. 테이블 생성시 컬럼 뒤에 붙인다.
	3. 테이블 생성후 나중에 추가할 수도 있다.
	
	4.종류
		1) not null : 필수입력 ( null : 기본값)
		2) unique	: 도메인내 값 중복불가
		3) check	: 조건에 만족하는 값만 허용
		4) default 	: 값을 넣지않으면 기본값
		5) primary key(개체무결성) : 기본키(not null + unique) + index 가 합쳐진 기능
		6) foreign key(참조무결성) : 외래키(외부테이블에서 참조)

--###############################################################
	1) not null : 필수입력
				 테이블 선언시에만 사용가능하다.
				 
	create table tb1
	(
		name 	varchar2(100) not null,
		gender	varchar2(100) 	 -- null이 생략 되어 있다
	)
	
	insert into tb1 values('일길동','남자');
	insert into tb1(name,gender) values('이미자','여자');
	insert into tb1(name) values('이길동');
	
	insert into tb1(gender) values('남자'); --(x) not null
		
	select * from tb1

--###############################################################	
			
	2) unique : 중복불가
	
	create table tb2
	(
		id 		varchar2(100) unique,
		pwd 	varchar2(100) not null
	)
	
	insert into tb2 values('hong','1234');
	insert into tb2 values('hong','1111');
	동일한 id 추가시 에러
	1) 무결성 제약 조건(TEST.SYS_C004073)에 위배됩니다
	
	select * from tb2
	
	--제약조건 추가용 테이블
	create table tb22
	(
		id 		varchar2(100),
		pwd 	varchar2(100) not null
	)
	
	--제약조건 추가
	alter table tb22 
		add constraint unique_tb22_id unique(id);
						(제약조건이름)
	
	insert into tb22 values('hong','1234');
	insert into tb22 values('hong','1111');
	동일한 id 추가시 에러
	2) 무결성 제약 조건(TEST.UNIQUE_TB22_ID)에 위배됩니다
		
	--차이점
	1) 무결성 제약 조건(TEST.SYS_C004073)에 위배됩니다
	2) 무결성 제약 조건(TEST.UNIQUE_TB22_ID)에 위배됩니다
	
	
	--제약조건 확인하기
	-- System이 관리하는 Dictionary Table에서 확인
	
	select constraint_type, constraint_name, table_name
	from user_constraints 
	where table_name= 'TB22'
	
	select * from tb2
	
	
--###############################################################	
	3) Check제약(도메인무결성): 주어진 조건에 만족하는 값만 허용
	
	create table tb3
	(
		name 	varchar2(100) not null,
		gender 	varchar2(100) 
	
	
	)
	
	--(x) : gender : '남자' '남' 'man' 'male' 'M'
	
	alter table tb3
		add constraint ck_tb3_gender check(gender='남자' or gender='여자'); 
						(제약조건명)
									##in 연산자로 표현
									 check(gender in('남자','여자'))
						
	insert into tb3 values('홍길동', '남자');
	insert into tb3 values('이미자', '여자');
	
	에러 : 체크 제약조건(TEST.CK_TB3_GENDER)이 위배되었습니다
	insert into tb3 values('오미자', 'female');
	
	select * from tb3
	
	--성적
	create table tb33
	(
		name 	varchar2(100) not null, --inline 방식
		kor		number(3),
		eng		number(3),
		mat		number(3),
		
		--제약조건지정
		constraint ck_tb33_kor check(kor >=0 and kor<=100)
	
	)
	
	insert into tb33 values('일길동',88,77,99);
	insert into tb33 values('이길동',88,177,99);
	
	select * from tb33
	
	update tb33 set eng =77 where name='이길동';
	
	--eng check제약 
	alter table tb33
	 add constraint ck_tb33_eng check(eng>=0 and eng<=100);
	에러 : (TEST.CK_TB33_ENG)을 검증할 수 없습니다 - 잘못된 제약을 확인합니다 
			(이미 잘못된 데이터가 들어와있다는말)
	조치 : 오류데이터 수정후에 다시 설정
	
	
	--mat check
	alter table tb33
		add constraint ck_tb33_mat check(mat between 0 and 100);
		
	
	insert into tb33 values('이오류',66,77,-10);
--###############################################################	
	4) default : 기본값 (입력되지 않으면 기본값)
	create table tb4
	(
		name 	varchar2(100) not null,
		gender	varchar2(100) default '인간',
		age 	int			  default 1
	
	)
	
	
	insert into tb4 values('일길동','남자',20);
	--(방법1)기본값 입력방법
	insert into tb4(name) values('이길동');
	insert into tb4 values('삼길동',default, default);
	
	
	select * from tb4
--###############################################################	
	5)Primary key제약 (기본키) : 개체(Entity) 무결성
		- 레코드(행)을 대표하는 대표컬럼
		- not null +  unique 제약조건의 조합
		- 추가로 index지정 (검색성능이 향상)
		
		create table tb5
		(
			번호 int,
			이름 varchar2(100) not null,
			주소 varchar2(255)
		
		)
		
		--기본키
		alter table tb5
			add constraint ck_tb5_번호 primary key(번호);
	
		insert into tb5 values(1,'일길동', '서울 관악 신림1동');
		insert into tb5 values(2,'이길동', '서울 관악 신림2동');
		insert into tb5 values(3,'삼길동', '서울 관악 신림3동');
		
		에러 : 무결성 제약 조건(TEST.CK_TB5_번호)에 위배됩니다
		insert into tb5 values(3,'삼식이', '서울 관악 신림2동');
		insert into tb5(이름) values('이오류');
	
	
	select * from tb5
	
	select * from tb5 where 번호=2;
	
	
	--2개이상의 키를 조합해서 Primary key로 설정할 수 있다.(의미없음 문법적으로 가능하다를 보여주기 위함)
	create table tb55
	(
		idx int,
		sale_date date,
		product_name varchar2(100)
		
	)
	
	alter table tb55
	 add constraint pk_tb55_idx_sale_date primary key(idx,sale_date);
	 
	insert into tb55 values(1, sysdate, 'TV'); 
	insert into tb55 values(1, sysdate, 'Radio'); 
	
	select * from tb55
--###############################################################	
	6) foreign key(외래키) : 참조하는 값이 외부테이블에서 참조하겠다.
	
	create table 학생
	(
		학번 		int,
		이름 		varchar2(100) not null,
		전화 		varchar2(100) not null,
		보호자명	varchar2(100) not null,
		보호자직업	varchar2(100) not null,
		주소		varchar2(100) not null
	)
	
	--기본키설정
	alter table 학생
	 add constraint pk_학생_학번 primary key(학번);
	 
	--sample data
	insert into 학생 values(1,'일길동','111-1111','일아비','자영업','서울');
	insert into 학생 values(2,'이길동','222-2222','이아비','회사원','인천');
	
	--성적테이블
	create table 성적
	(
		일련번호 	int,
		학번		int,
		국어		int,
		영어		int,
		수학		int,
		학년		int,
		학기		int,
		시험종류	varchar2(100)
	)
	
	--기본키설정
	alter table 성적
		add constraint pk_성적_일련번호 primary key(일련번호);
		
	--외래키(성적,학번)
	alter table 성적
	 	add constraint fk_성적_학번 foreign key(학번)
	 								references 학생(학번);
	 								
	 								
	 								
	insert into 성적 values(1, 1, 100,90,80,1,1,'중간고사');
	insert into 성적 values(2, 1, 90,80,70 ,1,1,'기말고사');
	insert into 성적 values(3, 1, 70,60,50 ,1,2,'중간고사');
	insert into 성적 values(4, 1, 80,90,100,1,2,'기말고사');
	
	## 참조무결성
	
	에러 : 무결성 제약조건(TEST.FK_성적_학번)이 위배되었습니다- 부모 키가 없습니다
	insert into 성적 values(5, 3, 80,90,100,1,2,'기말고사');
	
	select * from 성적
	
		
				

*/
