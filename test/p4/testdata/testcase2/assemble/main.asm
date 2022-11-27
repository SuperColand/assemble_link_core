.data
	arr: .space 20

.text
main:
	la $t1, arr
	li $t0, 45
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 9216
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 4198
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 7795
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 9484
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 9650
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 4590
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 6431
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 705
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 8316
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 5557
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 8189
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 2652
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 606
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 2153
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 7829
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 9813
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 367
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 6658
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 8961
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	la $a0, arr
	li $a1, 20
	jal bubble
	syscall
