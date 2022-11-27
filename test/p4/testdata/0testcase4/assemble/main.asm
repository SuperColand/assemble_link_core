.data
	arr: .space 30

.text
main:
	la $t1, arr
	li $t0, 51
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 7945
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 7159
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 386
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 7345
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 7504
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 815
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 576
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 960
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 6020
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 5261
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 8277
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 4162
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 930
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 1002
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 9737
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 7913
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 1682
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 319
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 474
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 1102
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 8279
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 6179
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 1197
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 1333
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 2790
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 5811
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 2607
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 6929
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	li $t0, 5514
	sw $t0, 0($t1)
	addiu $t1, $t1, 4
	la $a0, arr
	li $a1, 30
	jal bubble
	syscall
