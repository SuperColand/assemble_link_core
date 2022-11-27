.data

.text
	bubble:
	li $t0, 0
	move $s0, $a1		# total number
	addiu $s0, $s0, -1
	for_i:
		beq $t0, $s0, end_i
		li $t1, 0
		li $t2, 0
		subu $s1, $s0, $t0
		for_j:
			beq $t1, $s1, end_j
			addiu $t3, $t2, 4
			addu $t5, $a0, $t2
			addu $t6, $a0, $t3
			lw $s2, 0($t5)
			lw $s3, 0($t6)
			subu $t4, $s3, $s2
			bgez $t4, else
			sw $s2, 0($t6)
			sw $s3, 0($t5)
			else:
			addiu $t1, $t1, 1
			addiu $t2, $t2, 4
			j for_j
		end_j:
		addiu $t0, $t0, 1
		j for_i
	end_i:
		jr $ra