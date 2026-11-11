# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# LAB 02 - Listing 4 - Intentional wrong shift
# Purpose: Use 2*i for i=3; expect an alignment exception at base + 6.
.data
scores: .word 40, 55, 70, 85, 100
msg: .asciiz "scores[i] = "
nl: .asciiz "\n"

.text
.globl main
main:
    la   $s0, scores      # $s0 = array base
    addi $s1, $zero, 3    # $s1 = index i
    sll  $t1, $s1, 1      # INTENTIONAL: wrong byte offset 2*i = 6
    add  $t1, $t1, $s0    # $t1 = address of scores[i]
    lw   $t2, 0($t1)      # $t2 = selected score
    li   $v0, 4
    la   $a0, msg
    syscall
    li   $v0, 1
    add  $a0, $t2, $zero
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall
    li   $v0, 10         # Exit program
    syscall
