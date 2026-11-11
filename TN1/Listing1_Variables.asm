# ==================================================
# Course: CSBU102 - Computer System
# Lab: LAB 02 - Accessing Main Memory
# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# Experiment 1 - Listing 1: Variables in Memory
# Source: Listing1_Variables.asm
#
# Purpose:
# Compute varA = varB + varC in memory.
#
# Register Plan:
# $t0 = Address of varB; base for varC (+4) and varA (+8)
# $t1 = Value loaded from varB (25)
# $t2 = Value loaded from varC (17)
# $t3 = Sum varB + varC (42), stored into varA
# $v0 = Syscall service number: 10=exit
# ==================================================
.data
varB: .word 25
varC: .word 17
varA: .word 0

.text
.globl main
main:
    # Step 1: Load the variables from memory
    la   $t0, varB        # $t0 = base address of the three variables
    lw   $t1, 0($t0)      # $t1 = varB = 25
    lw   $t2, 4($t0)      # $t2 = varC = 17

    # Step 2: Calculate the sum of varB and varC
    add  $t3, $t1, $t2    # $t3 = 42

    # Step 3: Store the result in varA
    sw   $t3, 8($t0)      # varA = 42

    # Step 4: Exit the program
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program
