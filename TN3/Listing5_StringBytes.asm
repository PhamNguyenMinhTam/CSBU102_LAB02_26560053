# ==================================================
# Course: CSBU102 - Computer System
# Lab: LAB 02 - Accessing Main Memory
# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# Experiment 3 - Listing 5: String Bytes
# Source: Listing5_StringBytes.asm
#
# Purpose:
# Load all four bytes of Hi! and print the second character.
#
# Register Plan:
# $s0 = Address of the first byte of word1
# $t0 = Byte at offset 0: H (0x48)
# $t1 = Byte at offset 1: i (0x69), the character to print
# $t2 = Byte at offset 2: ! (0x21)
# $t3 = Byte at offset 3: null terminator (0x00)
# $a0 = Character code copied from t1 for syscall 11
# $zero = Constant zero for copying the character code from t1 to a0
# $v0 = Syscall service number: 11=print character, 10=exit
# ==================================================
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
    li   $v0, 11          # Select service: 11=print character
    add  $a0, $t1, $zero  # Print i
    syscall               # Print character in $a0
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program
