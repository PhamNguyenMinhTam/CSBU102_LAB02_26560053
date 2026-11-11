# ==================================================
# Course: CSBU102 - Computer System
# Lab: LAB 02 - Accessing Main Memory
# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# Experiment 2 - Listing 3: Swap Two Scores
# Source: Listing3_Swap.asm
#
# Purpose:
# Exchange scores[0] and scores[4] using word loads and stores.
#
# Register Plan:
# $s0 = Base address of scores
# $t0 = Original scores[0] (40), then stored into scores[4]
# $t1 = Original scores[4] (100), then stored into scores[0]
# $v0 = Syscall service number: 10=exit
# ==================================================
.data
scores: .word 40, 55, 70, 85, 100

.text
.globl main
main:
    # Step 1: Load the array base address
    la   $s0, scores      # $s0 = array base

    # Step 2: Preserve both original scores
    lw   $t0, 0($s0)      # Preserve original scores[0]
    lw   $t1, 16($s0)     # Preserve original scores[4]

    # Step 3: Store the scores in swapped positions
    sw   $t1, 0($s0)      # scores[0] = 100
    sw   $t0, 16($s0)     # scores[4] = 40

    # Step 4: Exit the program
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program
