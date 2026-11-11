# ==================================================
# Course: CSBU102 - Computer System
# Lab: LAB 02 - Accessing Main Memory
# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# Experiment 1 - Listing 2: Base Plus Offset - Step 1.3 A (Intentional Alignment Error)
# Source: Listing2_Misaligned.asm
#
# Purpose:
# Deliberately load a word at base + 2; an exception is expected.
#
# Register Plan:
# $s0 = Base address of scores (0x10010000)
# $s1 = Address of scores[2] (base + 8); not reached after exception
# $t0 = Value of scores[0] (40)
# $t1 = Destination of failing lw at base + 2; no value is loaded
# $t2 = Value of scores[4] (100); not reached after exception
# $t3 = Value of scores[2] (70), loaded through s1; not reached after exception
# $t4 = Value of scores[1] (55), loaded at s1 - 4; not reached after exception
# $v0 = Syscall service number: 10=exit; syscall code not reached after exception
# ==================================================
.data
scores: .word 40, 55, 70, 85, 100

.text
.globl main
main:
    la   $s0, scores      # $s0 = base address 0x10010000
    lw   $t0, 0($s0)      # $t0 = scores[0] = 40
    lw   $t1, 2($s0)      # INTENTIONAL: unaligned address 0x10010002
    lw   $t2, 16($s0)     # $t2 = scores[4] = 100
    addi $s1, $s0, 8      # $s1 = address of scores[2]
    lw   $t3, 0($s1)      # $t3 = 70
    lw   $t4, -4($s1)     # $t4 = 55
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program
