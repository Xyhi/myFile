.data
	number: .word 200110505	# ��ѧ����Ϣ���뵽number��
.text
start:
	lui t0,0x00002		
	lw a2,0x0(t0)		# ��ѧ����Ϣ�浽�Ĵ���a2��
	addi sp,sp,-12		# �������߳�ջ�ռ�
	sw ra, 8(sp)		# ��ra����ջ��8(sp)λ��
	sw a2, 4(sp)		# ��a2����ջ��4(sp)λ��
	sw x19, 0(sp)		# ��x19����ջ��0(sp)λ�ã��ڼĴ���x19��������
	jal ra,f		# ��ת��f���������н���ת��
	jal zero, Done		# ���ý���
f:	
	addi sp, sp, -12	# sp=sp-12������12byteջ�ռ�	
	sw x20, 8(sp)		# ��x20����ջ��8(sp)λ��
	sw x21, 4(sp)		# ��x21����ջ��4(sp)λ��
	sw x22, 0(sp)		# ��x22����ջ��0(sp)λ��
	addi x22,zero,16	# ��16����Ĵ���x22��
	addi x19,zero,0		# ��0����Ĵ���x19��
	addi x20,zero,0 	# i = 0
	div x21,a2,x22 		# ans = num / 16
	jal zero,WHILE		# ��ת��Whileѭ��
WHILE:
	beq x21,zero,Exit 	# while(num/16 != 0)
	rem x21,a2,x22		# ans = num % 16
	srli a2,a2, 4		# num >> 4
	sll x21,x21,x20		# ans << i
	add x19,x19,x21 	# ret += ans
	addi x20,x20,4		# i += 4
	div x21,a2,x22  	# temp = num\16
	jal zero,WHILE		# �ж�ѭ������
Exit:
	rem x21,a2,x22		# ans = num % 16
	beq x21, zero, Exit2	# if(num % 16 == 0)
	sll x21,x21,x20		# ans << i
	add x19,x19,x21 	# ret += ans
Exit2:
	lw x20, 8(sp)		# �ָ�x20�Ĵ���
	lw x21, 4(sp)		# �ָ�x21�Ĵ���
	lw x22, 0(sp)		# �ָ�x22�Ĵ���
	addi sp, sp, 12		# �ָ��ӳ���ջָ��
	jalr ra			# �������߳�
Done:
	lw ra, 8(sp)		# �ָ�ra�Ĵ���
	lw a2, 4(sp)		# �ָ�a2�Ĵ���
	addi sp, sp, 12		# �ָ����߳�ջָ��

		
