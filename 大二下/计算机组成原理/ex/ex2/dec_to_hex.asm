.data
	number: .word 200110505	# 将学号信息存入到number中
.text
start:
	lui t0,0x00002		
	lw a2,0x0(t0)		# 将学号信息存到寄存器a2中
	addi sp,sp,-12		# 开辟主线程栈空间
	sw ra, 8(sp)		# 将ra存入栈中8(sp)位置
	sw a2, 4(sp)		# 将a2存入栈中4(sp)位置
	sw x19, 0(sp)		# 将x19存入栈中0(sp)位置，在寄存器x19处存入结果
	jal ra,f		# 调转到f函数，进行进制转换
	jal zero, Done		# 调用结束
f:	
	addi sp, sp, -12	# sp=sp-12，开辟12byte栈空间	
	sw x20, 8(sp)		# 将x20存入栈中8(sp)位置
	sw x21, 4(sp)		# 将x21存入栈中4(sp)位置
	sw x22, 0(sp)		# 将x22存入栈中0(sp)位置
	addi x22,zero,16	# 将16存入寄存器x22中
	addi x19,zero,0		# 将0存入寄存器x19中
	addi x20,zero,0 	# i = 0
	div x21,a2,x22 		# ans = num / 16
	jal zero,WHILE		# 跳转到While循环
WHILE:
	beq x21,zero,Exit 	# while(num/16 != 0)
	rem x21,a2,x22		# ans = num % 16
	srli a2,a2, 4		# num >> 4
	sll x21,x21,x20		# ans << i
	add x19,x19,x21 	# ret += ans
	addi x20,x20,4		# i += 4
	div x21,a2,x22  	# temp = num\16
	jal zero,WHILE		# 判断循环条件
Exit:
	rem x21,a2,x22		# ans = num % 16
	beq x21, zero, Exit2	# if(num % 16 == 0)
	sll x21,x21,x20		# ans << i
	add x19,x19,x21 	# ret += ans
Exit2:
	lw x20, 8(sp)		# 恢复x20寄存器
	lw x21, 4(sp)		# 恢复x21寄存器
	lw x22, 0(sp)		# 恢复x22寄存器
	addi sp, sp, 12		# 恢复子程序栈指针
	jalr ra			# 返回主线程
Done:
	lw ra, 8(sp)		# 恢复ra寄存器
	lw a2, 4(sp)		# 恢复a2寄存器
	addi sp, sp, 12		# 恢复主线程栈指针

		
