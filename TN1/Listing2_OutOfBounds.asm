# ==================================================
# Course: CSBU102 - Computer System
# Lab: LAB 02 - Accessing Main Memory
# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# Experiment 1 - Listing 2: Base Plus Offset - Step 1.3 B (Intentional Out-of-Bounds Read)
# Source: Listing2_OutOfBounds.asm
#
# Purpose:
# Read past scores; hardware does not enforce array bounds.
#
# Register Plan:
# $s0 = Base address of scores (0x10010000)
# $s1 = Address of scores[2] (base + 8)
# $t0 = Value of scores[0] (40)
# $t1 = Word read at base + 20, beyond scores; not an array element
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

    # Step 2: Read the first score and intentionally read base + 20 beyond the array (no bounds exception required)
    lw   $t0, 0($s0)      # $t0 = scores[0] = 40
    lw   $t1, 20($s0)     # INTENTIONAL: aligned word after the array

    # Step 3: Perform the remaining offset reads
    lw   $t2, 16($s0)     # $t2 = scores[4] = 100
    addi $s1, $s0, 8      # $s1 = address of scores[2]
    lw   $t3, 0($s1)      # $t3 = 70
    lw   $t4, -4($s1)     # $t4 = 55

    # Step 4: Exit the program
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program
