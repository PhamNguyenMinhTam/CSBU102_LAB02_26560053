# ==================================================
# Course: CSBU102 - Computer System
# Lab: LAB 02 - Accessing Main Memory
# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# Experiment 3 - Listing 8: Capital Letters - Without Null Terminator (.ascii)
# Source: Listing8_WithoutNull.asm
#
# Purpose:
# Demonstrate printing past str1 into subsequent data until zero.
#
# Register Plan:
# $s0 = Address of the first byte of str1
# $t0 = Letter at offsets 0, 7, then 11; converted to N, V, then A
# $a0 = Address of unterminated str1 (printing continues into tag), then newline
# $zero = Constant zero for copying the str1 address from s0 to a0
# $v0 = Syscall service number: 4=print string, 10=exit
# ==================================================
.data
str1: .ascii "nguyen van an"
tag:  .asciiz " [end]"
nl:   .asciiz "\n"

.text
.globl main
main:
    # Step 1: Load the string base address
    la   $s0, str1        # $s0 = first byte address

    # Step 2: Capitalize the character at offset 0
    lb   $t0, 0($s0)      # First letter n
    addi $t0, $t0, -32    # n -> N
    sb   $t0, 0($s0)      # Store N at offset 0

    # Step 3: Capitalize the character at offset 7
    lb   $t0, 7($s0)      # First letter v of van
    addi $t0, $t0, -32    # v -> V
    sb   $t0, 7($s0)      # Store V at offset 7

    # Step 4: Capitalize the character at offset 11
    lb   $t0, 11($s0)     # First letter a of an
    addi $t0, $t0, -32    # a -> A
    sb   $t0, 11($s0)     # Store A at offset 11

    # Step 5: Print with service 4, continuing from unterminated str1 into tag
    li   $v0, 4           # Select service: 4=print string
    add  $a0, $s0, $zero  # Print until a zero byte is encountered
    syscall               # Print zero-terminated string at $a0

    # Step 6: Print a newline and exit the program
    li   $v0, 4           # Select service: 4=print string
    la   $a0, nl          # Address of newline string
    syscall               # Print zero-terminated string at $a0
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program
