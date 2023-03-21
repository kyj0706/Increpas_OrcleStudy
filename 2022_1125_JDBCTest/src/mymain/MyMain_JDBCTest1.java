package mymain;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

//import oracle.jdbc.driver.OracleDriver;

public class MyMain_JDBCTest1 {
	
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
		
		
		//DDL��ɾ�
		//���̺� ����
		//String sql ="create table tttt(no int)";
		//���̺� ����
		//String sql ="drop table tttt";
		
		
		//����
		//���̺��  : person
		//�÷��� 	: idx, name, age(�Ϸù�ȣ/�̸�/����)
		
		//String sql ="create table person(idx int, name varchar2(100), age number)";
		
		
		
		
		
		
		
		//DML��ɾ�
		//String sql = "insert into tttt values(3)";
		//String sql = "update tttt set no=10";
		//String sql = "delete from tttt";
		//String sql = "delete from tttt where no=3";
	
		
		//person���̺� sample data insert
		//String sql = "insert into person values(1,'�ϱ浿',20) ";
		String sql = "insert into person (idx,name,age)"
				+ "values(3,'��浿',22)";
				
				
			
		
		
		
		
		
		
		int res = stmt.executeUpdate(sql); //Java -> DB��û�Ǵ� ��ɽ�
		
		System.out.printf("--SQL success(ó�������:%d)--\n",res);
		
		//�ݱ�(���� �������� �ݴ´�)
		stmt.close();
		conn.close();
	}

}
