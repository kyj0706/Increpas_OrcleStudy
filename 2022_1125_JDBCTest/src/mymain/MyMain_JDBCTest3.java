package mymain;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;

public class MyMain_JDBCTest3 {

	//0.OracleDriver Load
	//  ojdbc14.jar (반드시 아래코드로 OracleDriver Load)
	//  ojdbc60.jar/ojdbc80.jar 안해도 자동 Loading 
	static {
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		//1.Connection획득:연결관리객체
		String url     = "jdbc:oracle:thin:@localhost:1521:xe";
		String user    = "test";
		String pwd     = "test";
		
		Connection conn = DriverManager.getConnection(url, user, pwd);
		
		System.out.println("--success connection--");
		
		//2.Statement얻어온다: SQL명령 처리객체(DDL/DCL/DML)
		Statement stmt = conn.createStatement();
		/*
		    Statement
		      - executeUpdate(sql) : select외의 모든 SQL문장
		      - executeQuery(sql)  : select문장에만 사용  
		*/
		
		//3.ResultSet : 결과행 처리객체
		//                          
		String sql    = "select * from sawon";
		       
		ResultSet  rs =  stmt.executeQuery(sql);
		
		//처음~끝까지 읽어온다
		while(rs.next()) {
			
			//rs의 위치는 ? => Data(Record)를 가리킨다
			
			//현재레코드내의 지정된 컬럼값 읽어오기
			int    sabun	= rs.getInt("sabun");
			String saname	= rs.getString("saname");
			String sasex	= rs.getString("sasex");
			int    deptno	= rs.getInt("deptno");
			String sajob	= rs.getString("sajob");
			//                                         SQL     Java 
			String sahire	= rs.getString("sahire");//DATE -> String
			Date   sahire2	= rs.getDate("sahire");  //DATE -> Date
			
			int    samgr	= rs.getInt("samgr");
			int    sapay	= rs.getInt("sapay");
			
			
			System.out.printf("[%2d-(%5s)-%s-%d-%s-(%s)-(%s)-%d-%d]\n",
					          sabun,saname,sasex,deptno,sajob,
					          sahire.substring(0,16),
					          sahire2.toString(),
					          samgr,sapay  
					);
				
		}
		
		
		//닫기(열린역순)
		rs.close();    //3
		stmt.close();  //2
		conn.close();  //1
		
        
	}

}
