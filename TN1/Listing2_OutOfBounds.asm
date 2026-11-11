# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# LAB 02 - Step 1.3 B - Intentional out-of-bounds read
# Purpose: Read past scores; hardware does not enforce array bounds.
.data
scores: .word 40, 55, 70, 85, 100

.text
.globl main
main:
    la   $s0, scores      # $s0 = base address 0x10010000
    lw   $t0, 0($s0)      # $t0 = scores[0] = 40
    lw   $t1, 20($s0)     # INTENTIONAL: aligned word after the array
    lw   $t2, 16($s0)     # $t2 = scores[4] = 100
    addi $s1, $s0, 8      # $s1 = address of scores[2]
    lw   $t3, 0($s1)      # $t3 = 70
    lw   $t4, -4($s1)     # $t4 = 55
    li   $v0, 10         # Exit program
    syscall
