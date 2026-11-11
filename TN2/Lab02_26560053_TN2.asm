# ==================================================
# Course: CSBU102 - Computer System
# Lab: LAB 02 - Accessing Main Memory
# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# Experiment 2 - Step 2.3: Update and Total (Based on Listing 4)
# Source: Lab02_26560053_TN2.asm
#
# Purpose:
# Update scores[3] to 46 and print the sum 311.
#
# Register Plan:
# $s0 = Base address of scores
# $s1 = Index k = 3, selected by last student ID digit D = 3
# $s2 = Replacement score V = 46
# $s3 = Running total of all five scores; final value 311
# $t0 = Value of scores[0] (40)
# $t1 = Offset 4*k, then address of scores[k], then scores[1] (55)
# $t2 = Value of scores[2] (70)
# $t3 = Updated value of scores[3] (46)
# $t4 = Value of scores[4] (100)
# $a0 = Total message/newline address or total from s3 for printing
# $zero = Constant zero for initializing k and V and copying the total to a0
# $v0 = Syscall service number: 4=print string, 1=print integer, 10=exit
# ==================================================
.data
scores: .word 40, 55, 70, 85, 100
msg: .asciiz "Total: "
nl: .asciiz "\n"

.text
.globl main
main:
    # Step 1: Initialize the array base, k = 3 and V = 46
    la   $s0, scores      # $s0 = array base
    addi $s1, $zero, 3    # Last ID digit D=3 gives k=3
    addi $s2, $zero, 46   # $s2 = new value V

    # Step 2: Calculate the address of scores[k]
    sll  $t1, $s1, 2      # $t1 = 4*k
    add  $t1, $t1, $s0    # $t1 = address of scores[k]

    # Step 3: Store the replacement score
    sw   $s2, 0($t1)      # scores[3] = 46

    # Step 4: Load all five scores using constant offsets
    lw   $t0, 0($s0)      # $t0 = 40
    lw   $t1, 4($s0)      # $t1 = 55
    lw   $t2, 8($s0)      # $t2 = 70
    lw   $t3, 12($s0)     # $t3 = 46
    lw   $t4, 16($s0)     # $t4 = 100

    # Step 5: Calculate the total in $s3
    add  $s3, $t0, $t1    # $s3 accumulates the total
    add  $s3, $s3, $t2
    add  $s3, $s3, $t3
    add  $s3, $s3, $t4    # $s3 = 311; original total was 350

    # Step 6: Print the total and a newline
    li   $v0, 4           # Select service: 4=print string
    la   $a0, msg         # Address of output message
    syscall               # Print zero-terminated string at $a0
    li   $v0, 1           # Select service: 1=print integer
    add  $a0, $s3, $zero  # Copy value to the print argument
    syscall               # Print integer in $a0
    li   $v0, 4           # Select service: 4=print string
    la   $a0, nl          # Address of newline string
    syscall               # Print zero-terminated string at $a0

    # Step 7: Exit the program
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program
