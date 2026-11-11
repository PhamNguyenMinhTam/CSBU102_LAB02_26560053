# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# LAB 02 - TN1 / Listing 1 - Variables
# Purpose: Compute varA = varB + varC in memory.
.data
varB: .word 25
varC: .word 17
varA: .word 0

.text
.globl main
main:
    la   $t0, varB        # $t0 = base address of the three variables
    lw   $t1, 0($t0)      # $t1 = varB = 25
    lw   $t2, 4($t0)      # $t2 = varC = 17
    add  $t3, $t1, $t2    # $t3 = 42
    sw   $t3, 8($t0)      # varA = 42
    li   $v0, 10         # Exit program
    syscall
