.data
	arr: .space 20

.text
main:
	la $t1, arr
	li $t0, 48
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 7196
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 9294
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 9091
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 7031
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 3577
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 7702
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 3503
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 7217
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 2168
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 5409
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 8233
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 2023
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 7152
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 1578
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 2399
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 3863
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 6025
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 8489
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 9718
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	la $a0, arr
	li $a1, 20
	jal bubble
	syscall
