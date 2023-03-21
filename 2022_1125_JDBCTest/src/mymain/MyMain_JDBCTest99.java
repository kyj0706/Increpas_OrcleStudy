package mymain;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

//import oracle.jdbc.driver.OracleDriver;

public class MyMain_JDBCTest99 {
	
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
		String sql = "select * from sawon_view2"
				//+ "where"				 +"\n"
				//+ "deptno >=30"			 +"\n"
				;	
		
		ResultSet rs = stmt.executeQuery(sql);
		
		//처음~ 끝까지 읽어온다.
		while(rs.next()) {
			//rs의 위치는 => Date(Record)를 가르킨다.
			
			//현재레코드 내의 지정된 컬럼값 읽어오기
			
			
			
			int sabun 		= rs.getInt("sabun");
			String saname	= rs.getString("saname");
			String sasex	= rs.getString("sasex");
			int deptno		= rs.getInt("deptno");
			String sajob	= rs.getString("sajob");
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd" );
			
			String sahire 	= sdf.format(rs.getTimestamp("sahire"));
			
			
			Date   sahire2	= rs.getDate("sahire");
		
			
			//String sahire = sdf.format(rs.getT("sahire"));
			
			//String sahire	= rs.getString("sahire");
			int samgr		= rs.getInt("samgr");
			int sapay		= rs.getInt("sapay");
			int hire_year	= rs.getInt("hire_year");
			int hire_month	= rs.getInt("hire_month");
			int hire_day	= rs.getInt("hire_day");
			String sapay2	= rs.getString("sapay2");
			String hire_season = rs.getString("hire_season");
		
			System.out.printf("[%2d] |%s| |%s| |%d| |%s| [%s] |%d| |%d| |%d| |%d| |%d| |%s| |%s|]\n",
					sabun,saname,sasex,deptno,sajob,sahire,samgr,sapay,hire_year,hire_month,hire_day,sapay2.trim(),hire_season);
			
			
			
		
			//System.out.printf("[%d(%s)-%s-%s]\n",deptno,str_deptno,dname,loc);
			
		}
		
		
		
		
		
		
		
		//닫기(열린 역순으로 닫는다)
		rs.close();	  //3
		stmt.close(); //2
		conn.close(); //1
	}

}
