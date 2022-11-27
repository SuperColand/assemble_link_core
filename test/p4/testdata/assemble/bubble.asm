.data

.text
	bubble:
		addiu $t0, $zero, 0
		addiu $s0, $zero, 9
		for_i:
			beq $t0, $s0, end_i
			addiu $t1, $zero, 0
			addiu $t2, $zero, 0
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