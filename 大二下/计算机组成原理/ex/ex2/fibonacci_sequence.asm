.text
addi a0,zero,20		# 在a0寄存器中存入参数20 
addi x24,zero,0		# 将返回的结果保存在x24寄存器中
addi sp,sp,-12		# 在sp中开辟12个byte空间
sw x22,8(sp)		# 将x22寄存器存入8(sp)
sw x23,4(sp)		# 将x23寄存器存入4(sp)
sw ra,0(sp)		# 将ra寄存器存入0(sp)
addi x22,zero,1		# 将x22中存入常量1
addi x23,zero,2		# 将x23中存入常量2
jal ra, fact		# 调用fact递归方法
jal zero, Done		# 递归结束程序返回
fact:
	addi sp, sp, -8	# 在sp中开辟8个byte空间
	sw ra, 4(sp)	# 将ra寄存器存入4(sp)
	sw x19,0(sp)	# 将x19寄存器存取0(sp),来暂时接收递归基础a0的参数信息
	beq a0,x22,out	# 如果n==1，则到达递归基础
	beq a0,x23,out	# 如果n==2，则到达递归基础
	mv x19, a0	# 将a0寄存器中的值，存入临时变量x19中
	sw x19, 0(sp)	# 将x19中的数据，存入栈0(sp)位置
	addi a0,a0,-1	# 令a0=n-1，进行递归
	jal ra, fact	# 调用fact递归方法
	lw x19,0(sp)	# 将0(sp)位置的临时变量x19取出
	addi a0,x19,-2	# 令a0=n-2，进行递归
	jal ra, fact	# 调用fact递归方法
	lw ra,4(sp)	# 恢复ra
	lw x19,0(sp)	# 恢复x19
	addi sp,sp,8	# 恢复栈指针
	jalr ra		# 返回ra地址
out:
	addi x24,x24,1	# 到达递归基础，接收返回结果的变量x24=x24+1
	addi sp,sp,8	# 恢复栈指针，弹栈
	jalr ra		# 恢复调用位置
Done:
	lw x22,8(sp)	# 恢复x22寄存器
	lw x23,4(sp)	# 恢复x23寄存器
	lw ra,0(sp)	# 恢复ra寄存器
	addi sp,sp,12	# 恢复栈指针
