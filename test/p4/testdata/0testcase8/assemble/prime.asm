.data

.text
prime:
	move $s0, $a0
	li $t0, 1
 	beq $s0, $t0, is_not_prime
	li $t0,2
loop:
  	beq $t0, $s0, is_prime
  	divu $s0, $t0
 	mfhi $s1
  	beq $s1, $zero, is_not_prime
  	addiu $t0,$t0,1
  	j loop
is_prime:
	move $t1, $a0
	sw $t1, 0($zero)
	li $t1, 1
	sw $t1, 4($zero)
	jr $ra
is_not_prime: 
	move $t1, $a0
	sw $t1, 0($zero)
	li $t1, 0
	sw $t1, 4($zero)
	jr $ra