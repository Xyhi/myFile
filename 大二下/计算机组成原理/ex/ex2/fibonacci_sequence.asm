.text
addi a0,zero,20		# ��a0�Ĵ����д������20 
addi x24,zero,0		# �����صĽ��������x24�Ĵ�����
addi sp,sp,-12		# ��sp�п���12��byte�ռ�
sw x22,8(sp)		# ��x22�Ĵ�������8(sp)
sw x23,4(sp)		# ��x23�Ĵ�������4(sp)
sw ra,0(sp)		# ��ra�Ĵ�������0(sp)
addi x22,zero,1		# ��x22�д��볣��1
addi x23,zero,2		# ��x23�д��볣��2
jal ra, fact		# ����fact�ݹ鷽��
jal zero, Done		# �ݹ�������򷵻�
fact:
	addi sp, sp, -8	# ��sp�п���8��byte�ռ�
	sw ra, 4(sp)	# ��ra�Ĵ�������4(sp)
	sw x19,0(sp)	# ��x19�Ĵ�����ȡ0(sp),����ʱ���յݹ����a0�Ĳ�����Ϣ
	beq a0,x22,out	# ���n==1���򵽴�ݹ����
	beq a0,x23,out	# ���n==2���򵽴�ݹ����
	mv x19, a0	# ��a0�Ĵ����е�ֵ��������ʱ����x19��
	sw x19, 0(sp)	# ��x19�е����ݣ�����ջ0(sp)λ��
	addi a0,a0,-1	# ��a0=n-1�����еݹ�
	jal ra, fact	# ����fact�ݹ鷽��
	lw x19,0(sp)	# ��0(sp)λ�õ���ʱ����x19ȡ��
	addi a0,x19,-2	# ��a0=n-2�����еݹ�
	jal ra, fact	# ����fact�ݹ鷽��
	lw ra,4(sp)	# �ָ�ra
	lw x19,0(sp)	# �ָ�x19
	addi sp,sp,8	# �ָ�ջָ��
	jalr ra		# ����ra��ַ
out:
	addi x24,x24,1	# ����ݹ���������շ��ؽ���ı���x24=x24+1
	addi sp,sp,8	# �ָ�ջָ�룬��ջ
	jalr ra		# �ָ�����λ��
Done:
	lw x22,8(sp)	# �ָ�x22�Ĵ���
	lw x23,4(sp)	# �ָ�x23�Ĵ���
	lw ra,0(sp)	# �ָ�ra�Ĵ���
	addi sp,sp,12	# �ָ�ջָ��
