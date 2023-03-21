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
	// ojdbc14.jar (�ݵ�� �Ʒ��ڵ�� OracleDriver Load)
	// ojdbc60.jar/ojdbc80.jar (�ڵ� Loading)
	static {
		//�Ʊ�� �� ������ ���������. �׷��� ���� ��� ���Եȴ� ->�����
		
		//Oracle oracle = new OracleDriver();
		
		//������ �޸𸮿� �ø��°Ŵ�. ->���α׷��� ������ ������ �������� �ʴ´�
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	
	//���������� Exception
	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		//1. Connection ȹ�� : ���������ü
		String url	="jdbc:oracle:thin:@localhost:1521:xe";
		String user ="test";
		String pwd	="test";
		
		Connection conn = DriverManager.getConnection(url, user, pwd);
		
		System.out.println("--success connetion--");

		//2. Statement���´� : SQL��� ó����ü(DDL/DCL/DML)
		Statement stmt = conn.createStatement();
		/*
		 	Statement
		 		executeUpdate(sql)	: select���� ��� SQL����
		 		executeQuery(sql) 	: select���忡�� ���
		 */
		
	
		//3.ResultSet : ����� ó����ü
		String sql = "select * from sawon_view2"
				//+ "where"				 +"\n"
				//+ "deptno >=30"			 +"\n"
				;	
		
		ResultSet rs = stmt.executeQuery(sql);
		
		//ó��~ ������ �о�´�.
		while(rs.next()) {
			//rs�� ��ġ�� => Date(Record)�� ����Ų��.
			
			//���緹�ڵ� ���� ������ �÷��� �о����
			
			
			
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
		
		
		
		
		
		
		
		//�ݱ�(���� �������� �ݴ´�)
		rs.close();	  //3
		stmt.close(); //2
		conn.close(); //1
	}

}
