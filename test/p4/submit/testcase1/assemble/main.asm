.data
	arr: .space 20

.text
main:
	la $t1, arr
	li $t0, 41
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 8467
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 6334
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 6500
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 9169
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 5724
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 1478
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 9358
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 6962
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 4464
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 5705
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 8145
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 3281
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 6827
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 9961
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 491
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 2995
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 1942
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 4827
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 5436
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	la $a0, arr
	li $a1, 20
	jal bubble
	syscall
