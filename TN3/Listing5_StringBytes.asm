# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# LAB 02 - Listing 5 - String bytes
# Purpose: Load all four bytes of Hi! and print the second character.
.data
word1: .asciiz "Hi!"

.text
.globl main
main:
    la   $s0, word1       # $s0 = first byte address
    lb   $t0, 0($s0)      # H = 0x48
    lb   $t1, 1($s0)      # i = 0x69
    lb   $t2, 2($s0)      # ! = 0x21
    lb   $t3, 3($s0)      # Null terminator = 0
    li   $v0, 11
    add  $a0, $t1, $zero  # Print i
    syscall
    li   $v0, 10         # Exit program
    syscall
