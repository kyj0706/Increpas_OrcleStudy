/*

--sawon���̺��� deptno �ܷ�Ű����

	alter table sawon
	 add constraint fk_sawon_deptno foreign key(deptno)
	 								references dept(deptno);
	 								
	alter table sawon 								
	 add constraint fk_sawon_samgr foreign key(samgr)
	 							   references sawon(sabun);
	 				
	alter table gogek				
	 add constraint fk_gogek_godam foreign key(godam)
	 							   references sawon(sabun);
	 				


*/