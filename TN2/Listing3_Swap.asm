# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# LAB 02 - Listing 3 - Swap
# Purpose: Exchange scores[0] and scores[4] using word loads and stores.
.data
scores: .word 40, 55, 70, 85, 100

.text
.globl main
main:
    la   $s0, scores      # $s0 = array base
    lw   $t0, 0($s0)      # Preserve original scores[0]
    lw   $t1, 16($s0)     # Preserve original scores[4]
    sw   $t1, 0($s0)      # scores[0] = 100
    sw   $t0, 16($s0)     # scores[4] = 40
    li   $v0, 10         # Exit program
    syscall
