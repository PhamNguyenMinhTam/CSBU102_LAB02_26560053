# ==================================================
# Course: CSBU102 - Computer System
# Lab: LAB 02 - Accessing Main Memory
# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# Part 0 - Listing 0: Quick Check
# Source: Listing0_QuickCheck.asm
#
# Purpose:
# Read and print one word from memory.
#
# Register Plan:
# $t0 = Address of x
# $a0 = Address of msg, value of x (7), then address of nl, for printing
# $v0 = Syscall service number: 4=print string, 1=print integer, 10=exit
# ==================================================
.data
x: .word 7
msg: .asciiz "Value read from memory: "
nl: .asciiz "\n"

.text
.globl main
main:
    li   $v0, 4           # Select service: 4=print string
    la   $a0, msg         # Address of output message
    syscall               # Print zero-terminated string at $a0
    la   $t0, x           # $t0 = address of x
    lw   $a0, 0($t0)      # $a0 = value read from x
    li   $v0, 1           # Select service: 1=print integer
    syscall               # Print integer in $a0
    li   $v0, 4           # Select service: 4=print string
    la   $a0, nl          # Address of newline string
    syscall               # Print zero-terminated string at $a0
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program
