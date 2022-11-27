.data
	arr: .space 30

.text
main:
	la $t1, arr
	li $t0, 54
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 8693
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 2255
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 4449
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 7660
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 1430
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 3927
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 7649
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 7472
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 2640
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 5114
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 8321
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 3533
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 7476
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 426
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 4307
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 1963
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 107
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 2150
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 1231
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 2517
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 992
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 1193
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 8211
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 5936
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 3849
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 4352
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 9083
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 6922
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 3131
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	la $a0, arr
	li $a1, 30
	jal bubble
	syscall
