package mymain;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;

public class MyMain_JDBCTest3 {

	//0.OracleDriver Load
	//  ojdbc14.jar (�ݵ�� �Ʒ��ڵ�� OracleDriver Load)
	//  ojdbc60.jar/ojdbc80.jar ���ص� �ڵ� Loading 
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
		//1.Connectionȹ��:���������ü
		String url     = "jdbc:oracle:thin:@localhost:1521:xe";
		String user    = "test";
		String pwd     = "test";
		
		Connection conn = DriverManager.getConnection(url, user, pwd);
		
		System.out.println("--success connection--");
		
		//2.Statement���´�: SQL��� ó����ü(DDL/DCL/DML)
		Statement stmt = conn.createStatement();
		/*
		    Statement
		      - executeUpdate(sql) : select���� ��� SQL����
		      - executeQuery(sql)  : select���忡�� ���  
		*/
		
		//3.ResultSet : ����� ó����ü
		//                          
		String sql    = "select * from sawon";
		       
		ResultSet  rs =  stmt.executeQuery(sql);
		
		//ó��~������ �о�´�
		while(rs.next()) {
			
			//rs�� ��ġ�� ? => Data(Record)�� ����Ų��
			
			//���緹�ڵ峻�� ������ �÷��� �о����
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
		
		
		//�ݱ�(��������)
		rs.close();    //3
		stmt.close();  //2
		conn.close();  //1
		
        
	}

}
