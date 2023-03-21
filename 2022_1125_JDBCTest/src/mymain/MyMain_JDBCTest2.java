package mymain;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

//import oracle.jdbc.driver.OracleDriver;

public class MyMain_JDBCTest2 {
	
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
		
	
		//3.ResultSet : 결과행 처리객체
		String sql = "select * from dept"+"\n"
				+ "where"				 +"\n"
				+ "deptno >=30"			 +"\n"
				;	
		
		ResultSet rs = stmt.executeQuery(sql);
		
		//처음~ 끝까지 읽어온다.
		while(rs.next()) {
			//rs의 위치는 => Date(Record)를 가르킨다.
			
			//현재레코드 내의 지정된 컬럼값 읽어오기
			
			int deptno = rs.getInt("deptno");
			String dname = rs.getString("dname");
			String loc = rs.getString("loc");
			
			//DB자료형에 상관없이 모두 String으로 읽어올수 있다.
			String str_deptno =rs.getString("deptno");
			
			
			
			
			/*
			//이런 API가 있는데 [사용하지 말아라]
			 컬럼순서에 의해서 읽어온다(컬럼조회순서가 변경되면 잘못가져온다 : 위험선있따.
			int deptno = rs.getInt(1);
			String dname = rs.getString(2);
			String loc = rs.getString(3);
			*/
			System.out.printf("[%d(%s)-%s-%s]\n",deptno,str_deptno,dname,loc);
			
		}
		
		
		
		
		
		
		
		//닫기(열린 역순으로 닫는다)
		rs.close();	  //3
		stmt.close(); //2
		conn.close(); //1
	}

}
