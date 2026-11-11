# ==================================================
# Course: CSBU102 - Computer System
# Lab: LAB 02 - Accessing Main Memory
# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# Extension: 3 x 3 Board (No Numbered Listing in Assignment)
# Source: Lab02_26560053_EXT.asm
#
# Purpose:
# Store X at (1,2) and O at (2,0) using row-major addressing.
#
# Register Plan:
# $s0 = Base address of the nine-word board
# $s1 = Row: first 1, then 2
# $s2 = Column: first 2, then 0
# $t0 = 2*row, then 3*row, then linear index, then byte offset 4*index
# $t1 = Address of board[1][2] = board[5] (0x10010014)
# $t2 = Mark to store: first X = 1, then O = 2
# $t3 = Address of board[2][0] = board[6] (0x10010018)
# $zero = Constant zero for initializing row, column and mark values
# $v0 = Syscall service number: 10=exit
# ==================================================
.data
board: .word 0, 0, 0, 0, 0, 0, 0, 0, 0

.text
.globl main
main:
    # Step 1: Load the board base address
    la   $s0, board       # $s0 = base address of board

    # Step 2: Set row = 1 and column = 2
    addi $s1, $zero, 1    # $s1 = row
    addi $s2, $zero, 2    # $s2 = column

    # Step 3: Calculate index = row + (row << 1) + column, then address = base + 4*index
    sll  $t0, $s1, 1      # $t0 = 2*row
    add  $t0, $t0, $s1    # $t0 = 3*row
    add  $t0, $t0, $s2    # $t0 = index = 5
    sll  $t0, $t0, 2      # $t0 = byte offset
    add  $t1, $s0, $t0    # $t1 = 0x10010014

    # Step 4: Store X = 1 in board[1][2]
    addi $t2, $zero, 1    # X = 1
    sw   $t2, 0($t1)      # Store X in board[1][2]

    # Step 5: Set row = 2 and column = 0
    addi $s1, $zero, 2    # row = 2
    addi $s2, $zero, 0    # column = 0

    # Step 6: Calculate the second index as row + (row << 1) + column and address as base + 4*index
    sll  $t0, $s1, 1      # $t0 = 2*row
    add  $t0, $t0, $s1    # $t0 = 3*row
    add  $t0, $t0, $s2    # $t0 = index = 6
    sll  $t0, $t0, 2      # $t0 = byte offset
    add  $t3, $s0, $t0    # $t3 = 0x10010018

    # Step 7: Store O = 2 in board[2][0]
    addi $t2, $zero, 2    # O = 2
    sw   $t2, 0($t3)      # Store O in board[2][0]

    # Step 8: Exit the program
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program
