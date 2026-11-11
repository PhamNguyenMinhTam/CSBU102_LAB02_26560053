# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# LAB 02 - Listing 4 - Index 0
# Purpose: Print scores[0] using a register index.
.data
scores: .word 40, 55, 70, 85, 100
msg: .asciiz "scores[i] = "
nl: .asciiz "\n"

.text
.globl main
main:
    la   $s0, scores      # $s0 = array base
    addi $s1, $zero, 0    # $s1 = index i
    sll  $t1, $s1, 2      # $t1 = 4 * i (byte offset)
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
