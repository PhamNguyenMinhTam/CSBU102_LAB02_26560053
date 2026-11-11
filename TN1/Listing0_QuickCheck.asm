# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# LAB 02 - Listing 0 - Quick check
# Purpose: Read and print one word from memory.
.data
x: .word 7
msg: .asciiz "Value read from memory: "
nl: .asciiz "\n"

.text
.globl main
main:
    li   $v0, 4
    la   $a0, msg
    syscall
    la   $t0, x           # $t0 = address of x
    lw   $a0, 0($t0)      # $a0 = value read from x
    li   $v0, 1
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall
    li   $v0, 10         # Exit program
    syscall
