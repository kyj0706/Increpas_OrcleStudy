/*
	����Ŭ�ڷ���
		=>ũ��(byte����)
		
	 1. ������ : �ִ� 2000byte����� �� �ִ�.
		char(ũ��)		<-��������
		varchar2(ũ��)	<-��������
		
		ex)
		memo char(100) 		<-	'�ȳ�'(0) "�ȳ�"(x)	-> 100byte�� ����
		memo varchar2(100)	<-	'�ȳ�'(0) 			-> 6byte�� ����
		
		--����Ŭ�� �ѱ� 1���� 3byte�� ǥ���Ѵ�.
		select length('�ȳ�'), lengthb('�ȳ�') from dual   --dual(�ӽ����̺�)
		
		
	2. ������
		int -> number(38,0)
		number(p,s) precision(��ü�ڸ���) scale(�Ҽ������� �ڸ���)
		number(p)
		
		
		create table ttt(no int, kor number(3), avg number(5,1))
		--������ ���̺� ������ sqlplus���ؼ� Ȯ�� : desc[ribe] ttt     ->[describe] -> ��� desc
		
	3.��¥��
		date 	(�ڷ���) 	<- ����Ͻú���
		sysdate	(�Լ�)		<- ����ý��۳�¥���ϱ�
		
		select sysdate from dual
		
		select 
			to_char(sysdate,'YYYY') as ��,
			to_char(sysdate,'MM') 	as ��,
			to_char(sysdate,'DD') 	as ��,
			to_char(sysdate,'PM HH24') 	as ��,
			to_char(sysdate,'MI') 	as ��,
			to_char(sysdate,'SS') 	as ��,
			to_char(sysdate,'DAY') 	as ����,
			to_char(sysdate,'YYYY_MM_DD(DAY)_PM_HH(HH24):MI:SS')
		from dual
		
		
	4.��뷮(LOB: Large Object) : 2~4GB
		BLOB : Binary Large Object		(binary ��뷮 ������)
		CLOB : Character Large Object	(������ ��뷮 ������)







*/