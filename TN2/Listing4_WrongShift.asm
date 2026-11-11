# ==================================================
# Course: CSBU102 - Computer System
# Lab: LAB 02 - Accessing Main Memory
# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# Experiment 2 - Listing 4: Array Index (i = 3) - Intentional Wrong Shift
# Source: Listing4_WrongShift.asm
#
# Purpose:
# Use 2*i for i=3; expect an alignment exception at base + 6.
#
# Register Plan:
# $s0 = Base address of scores
# $s1 = Array index i = 3
# $t1 = Incorrect offset 2*i = 6, then unaligned address base + 6
# $t2 = Destination of failing lw; no selected score is loaded
# $a0 = Message/newline address or selected score for printing; print code not reached after exception
# $zero = Constant zero for initializing i and copying the selected score to a0
# $v0 = Syscall service number: 4=print string, 1=print integer, 10=exit; syscall code not reached after exception
# ==================================================
.data
scores: .word 40, 55, 70, 85, 100
msg: .asciiz "scores[i] = "
nl: .asciiz "\n"

.text
.globl main
main:
    # Step 1: Initialize the array base and index i = 3
    la   $s0, scores      # $s0 = array base
    addi $s1, $zero, 3    # $s1 = index i

    # Step 2: Intentionally calculate the incorrect offset 2*i and address base + 6
    sll  $t1, $s1, 1      # INTENTIONAL: wrong byte offset 2*i = 6
    add  $t1, $t1, $s0    # INTENTIONAL: base + 6, not the address of scores[3]

    # Step 3: Attempt the unaligned word load at base + 6
    lw   $t2, 0($t1)      # INTENTIONAL: lw raises an alignment exception

    # Step 4: Remaining output and exit (not reached after the expected exception)
    li   $v0, 4           # Select service: 4=print string
    la   $a0, msg         # Address of output message
    syscall               # Print zero-terminated string at $a0
    li   $v0, 1           # Select service: 1=print integer
    add  $a0, $t2, $zero  # Copy value to the print argument
    syscall               # Print integer in $a0
    li   $v0, 4           # Select service: 4=print string
    la   $a0, nl          # Address of newline string
    syscall               # Print zero-terminated string at $a0
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program
