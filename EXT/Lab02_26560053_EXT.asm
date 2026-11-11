# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# LAB 02 - Extension - 3 x 3 board
# Purpose: Store X at (1,2) and O at (2,0) using row-major addressing.
.data
board: .word 0, 0, 0, 0, 0, 0, 0, 0, 0

.text
.globl main
main:
    la   $s0, board       # $s0 = base address of board
    addi $s1, $zero, 1    # $s1 = row
    addi $s2, $zero, 2    # $s2 = column
    sll  $t0, $s1, 1      # $t0 = 2*row
    add  $t0, $t0, $s1    # $t0 = 3*row
    add  $t0, $t0, $s2    # $t0 = index = 5
    sll  $t0, $t0, 2      # $t0 = byte offset
    add  $t1, $s0, $t0    # $t1 = 0x10010014
    addi $t2, $zero, 1    # X = 1
    sw   $t2, 0($t1)
    addi $s1, $zero, 2    # row = 2
    addi $s2, $zero, 0    # column = 0
    sll  $t0, $s1, 1      # $t0 = 2*row
    add  $t0, $t0, $s1    # $t0 = 3*row
    add  $t0, $t0, $s2    # $t0 = index = 6
    sll  $t0, $t0, 2      # $t0 = byte offset
    add  $t3, $s0, $t0    # $t3 = 0x10010018
    addi $t2, $zero, 2    # O = 2
    sw   $t2, 0($t3)
    li   $v0, 10         # Exit program
    syscall
