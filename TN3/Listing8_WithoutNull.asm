# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# LAB 02 - Listing 8 - Without null terminator
# Purpose: Demonstrate printing past str1 into subsequent data until zero.
.data
str1: .ascii "nguyen van an"
tag:  .asciiz " [end]"
nl:   .asciiz "\n"

.text
.globl main
main:
    la   $s0, str1        # $s0 = first byte address
    lb   $t0, 0($s0)      # First letter n
    addi $t0, $t0, -32    # n -> N
    sb   $t0, 0($s0)
    lb   $t0, 7($s0)      # First letter v of van
    addi $t0, $t0, -32    # v -> V
    sb   $t0, 7($s0)
    lb   $t0, 11($s0)     # First letter a of an
    addi $t0, $t0, -32    # a -> A
    sb   $t0, 11($s0)
    li   $v0, 4
    add  $a0, $s0, $zero  # Print until a zero byte is encountered
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall
    li   $v0, 10         # Exit program
    syscall
