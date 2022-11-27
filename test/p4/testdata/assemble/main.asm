.data
	arr: .space 20
	
.text
	main:
	addiu $t0, $zero, 11
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	addiu $t0, $zero, -5
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	addiu $t0, $zero, 4
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	addiu $t0, $zero, 3
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	addiu $t0, $zero, -8
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	addiu $t0, $zero, 10
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	addiu $t0, $zero, 5
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	addiu $t0, $zero, 6
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	addiu  $t0, $zero,1
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	addiu $t0, $zero,22
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	la $a0, arr
	jal bubble
	syscall
