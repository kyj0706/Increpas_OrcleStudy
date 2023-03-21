package mymain;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

//import oracle.jdbc.driver.OracleDriver;

public class MyMain_JDBCTest1 {
	
	//.OracleDriver Load
	// ojdbc14.jar (반드시 아래코드로 OracleDriver Load)
	// ojdbc60.jar/ojdbc80.jar (자동 Loading)
	static {
		//아까는 힙 공간에 만들어진다. 그래서 제거 대상에 포함된다 ->기억중
		
		//Oracle oracle = new OracleDriver();
		
		//지금은 메모리에 올리는거다. ->프로그램이 끝나기 전에는 없어지지 않는다
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	
	//수업목적상 Exception
	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		//1. Connection 획득 : 연결관리객체
		String url	="jdbc:oracle:thin:@localhost:1521:xe";
		String user ="test";
		String pwd	="test";
		
		Connection conn = DriverManager.getConnection(url, user, pwd);
		
		System.out.println("--success connetion--");

		//2. Statement얻어온다 : SQL명령 처리객체(DDL/DCL/DML)
		Statement stmt = conn.createStatement();
		/*
		 	Statement
		 		executeUpdate(sql)	: select외의 모든 SQL문장
		 		executeQuery(sql) 	: select문장에만 사용
		 */
		
		
		//DDL명령어
		//테이블 생성
		//String sql ="create table tttt(no int)";
		//테이블 삭제
		//String sql ="drop table tttt";
		
		
		//연습
		//테이블명  : person
		//컬럼명 	: idx, name, age(일련번호/이름/나이)
		
		//String sql ="create table person(idx int, name varchar2(100), age number)";
		
		
		
		
		
		
		
		//DML명령어
		//String sql = "insert into tttt values(3)";
		//String sql = "update tttt set no=10";
		//String sql = "delete from tttt";
		//String sql = "delete from tttt where no=3";
	
		
		//person테이블 sample data insert
		//String sql = "insert into person values(1,'일길동',20) ";
		String sql = "insert into person (idx,name,age)"
				+ "values(3,'삼길동',22)";
				
				
			
		
		
		
		
		
		
		int res = stmt.executeUpdate(sql); //Java -> DB요청되는 명령시
		
		System.out.printf("--SQL success(처리된행수:%d)--\n",res);
		
		//닫기(열린 역순으로 닫는다)
		stmt.close();
		conn.close();
	}

}
