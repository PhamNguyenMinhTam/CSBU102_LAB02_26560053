# ==================================================
# Course: CSBU102 - Computer System
# Lab: LAB 02 - Accessing Main Memory
# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# Experiment 1 - Listing 2: Base Plus Offset
# Source: Listing2_Offsets.asm
#
# Purpose:
# Read words using positive and negative byte offsets.
#
# Register Plan:
# $s0 = Base address of scores (0x10010000)
# $s1 = Address of scores[2] (base + 8)
# $t0 = Value of scores[0] (40)
# $t1 = Value of scores[1] (55)
# $t2 = Value of scores[4] (100)
# $t3 = Value of scores[2] (70), loaded through s1
# $t4 = Value of scores[1] (55), loaded at s1 - 4
# $v0 = Syscall service number: 10=exit
# ==================================================
.data
scores: .word 40, 55, 70, 85, 100

.text
.globl main
main:
    # Step 1: Load the array base address
    la   $s0, scores      # $s0 = base address 0x10010000

    # Step 2: Read scores using offsets from the base
    lw   $t0, 0($s0)      # $t0 = scores[0] = 40
    lw   $t1, 4($s0)      # $t1 = scores[1] = 55
    lw   $t2, 16($s0)     # $t2 = scores[4] = 100

    # Step 3: Calculate the address of scores[2]
    addi $s1, $s0, 8      # $s1 = address of scores[2]

    # Step 4: Read scores using the adjusted base
    lw   $t3, 0($s1)      # $t3 = 70
    lw   $t4, -4($s1)     # $t4 = 55

    # Step 5: Exit the program
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program
