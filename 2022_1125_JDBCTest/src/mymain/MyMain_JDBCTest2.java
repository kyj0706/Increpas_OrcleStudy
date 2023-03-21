package mymain;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

//import oracle.jdbc.driver.OracleDriver;

public class MyMain_JDBCTest2 {
	
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
		String sql = "select * from dept"+"\n"
				+ "where"				 +"\n"
				+ "deptno >=30"			 +"\n"
				;	
		
		ResultSet rs = stmt.executeQuery(sql);
		
		//ó��~ ������ �о�´�.
		while(rs.next()) {
			//rs�� ��ġ�� => Date(Record)�� ����Ų��.
			
			//���緹�ڵ� ���� ������ �÷��� �о����
			
			int deptno = rs.getInt("deptno");
			String dname = rs.getString("dname");
			String loc = rs.getString("loc");
			
			//DB�ڷ����� ������� ��� String���� �о�ü� �ִ�.
			String str_deptno =rs.getString("deptno");
			
			
			
			
			/*
			//�̷� API�� �ִµ� [������� ���ƶ�]
			 �÷������� ���ؼ� �о�´�(�÷���ȸ������ ����Ǹ� �߸������´� : ���輱�ֵ�.
			int deptno = rs.getInt(1);
			String dname = rs.getString(2);
			String loc = rs.getString(3);
			*/
			System.out.printf("[%d(%s)-%s-%s]\n",deptno,str_deptno,dname,loc);
			
		}
		
		
		
		
		
		
		
		//�ݱ�(���� �������� �ݴ´�)
		rs.close();	  //3
		stmt.close(); //2
		conn.close(); //1
	}

}
