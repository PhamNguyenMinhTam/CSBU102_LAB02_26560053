# ==================================================
# Course: CSBU102 - Computer System
# Lab: LAB 02 - Accessing Main Memory
# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# Experiment 2 - Listing 4: Array Index (i = 2)
# Source: Listing4_Index2.asm
#
# Purpose:
# Print scores[2] using a register index.
#
# Register Plan:
# $s0 = Base address of scores
# $s1 = Array index i = 2
# $t1 = Byte offset 4*i, then address base + 4*i for scores[2]
# $t2 = Value loaded from scores[2] for printing
# $a0 = Message/newline address or selected score for printing
# $zero = Constant zero for initializing i and copying the selected score to a0
# $v0 = Syscall service number: 4=print string, 1=print integer, 10=exit
# ==================================================
.data
scores: .word 40, 55, 70, 85, 100
msg: .asciiz "scores[i] = "
nl: .asciiz "\n"

.text
.globl main
main:
    # Step 1: Initialize the array base and index
    la   $s0, scores      # $s0 = array base
    addi $s1, $zero, 2    # $s1 = index i

    # Step 2: Calculate the element address as base + 4*i
    sll  $t1, $s1, 2      # $t1 = 4 * i (byte offset)
    add  $t1, $t1, $s0    # $t1 = address of scores[i]

    # Step 3: Load the selected score
    lw   $t2, 0($t1)      # $t2 = selected score

    # Step 4: Print the message and selected score
    li   $v0, 4           # Select service: 4=print string
    la   $a0, msg         # Address of output message
    syscall               # Print zero-terminated string at $a0
    li   $v0, 1           # Select service: 1=print integer
    add  $a0, $t2, $zero  # Copy value to the print argument
    syscall               # Print integer in $a0

    # Step 5: Print a newline and exit the program
    li   $v0, 4           # Select service: 4=print string
    la   $a0, nl          # Address of newline string
    syscall               # Print zero-terminated string at $a0
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program
