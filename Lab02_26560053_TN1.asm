# ==================================================
# Course: CSBU102 - Computer System
# Lab: LAB 02 - Accessing Main Memory
# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# Source: Lab02_26560053_TN1.asm
# Purpose: All Experiment 1 exercises (Steps 1.1-1.3) plus Part 0 warm-up.
# Select one exercise at main; reset and assemble before each run.
# ==================================================
.data
# PART 0 - Step 0 - Quick check / Listing 0 Warm-up
.align 2
tn1_step_0_x: .word 7
tn1_step_0_msg: .asciiz "Value read from memory: "
tn1_step_0_nl: .asciiz "\n"

# Step 1.1 - Variables in memory / Listing 1
.align 2
tn1_step_1_1_varB: .word 25
tn1_step_1_1_varC: .word 17
tn1_step_1_1_varA: .word 0

# Step 1.2 - Base plus offset / Listing 2
.align 2
tn1_step_1_2_scores: .word 40, 55, 70, 85, 100

# Step 1.3 - Break it on purpose / Listing 2 modified Case (a): intentional unaligned load at base + 2
.align 2
tn1_step_1_3_a_scores: .word 40, 55, 70, 85, 100

# Step 1.3 - Break it on purpose / Listing 2 modified Case (b): intentional out-of-bounds load at base + 20
.align 2
tn1_step_1_3_b_scores: .word 40, 55, 70, 85, 100

.text
.globl main
main:
    # Select ONE exercise by keeping only its jump active.
    j tn1_step_1_1
    # j tn1_step_0
    # j tn1_step_1_2
    # j tn1_step_1_3_a
    # j tn1_step_1_3_b
    nop

# ==================================================
# PART 0 - Step 0 - Quick check
# Listing 0
# ==================================================
# Warm-up
# Purpose: Read and print one word from memory.
# Register Plan:
# $t0 = Address of x
# $a0 = Address of msg, value of x (7), then address of nl, for printing
# $v0 = Syscall service number: 4=print string, 1=print integer, 10=exit
tn1_step_0:
    li   $v0, 4           # Select service: 4=print string
    la   $a0, tn1_step_0_msg         # Address of output message
    syscall               # Print zero-terminated string at $a0
    la   $t0, tn1_step_0_x           # $t0 = address of x
    lw   $a0, 0($t0)      # $a0 = value read from x
    li   $v0, 1           # Select service: 1=print integer
    syscall               # Print integer in $a0
    li   $v0, 4           # Select service: 4=print string
    la   $a0, tn1_step_0_nl          # Address of newline string
    syscall               # Print zero-terminated string at $a0
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program

# ==================================================
# Step 1.1 - Variables in memory
# Listing 1
# ==================================================
# Purpose: Compute varA = varB + varC in memory.
# Register Plan:
# $t0 = Address of varB; base for varC (+4) and varA (+8)
# $t1 = Value loaded from varB (25)
# $t2 = Value loaded from varC (17)
# $t3 = Sum varB + varC (42), stored into varA
# $v0 = Syscall service number: 10=exit
tn1_step_1_1:
    la   $t0, tn1_step_1_1_varB        # $t0 = base address of the three variables
    lw   $t1, 0($t0)      # $t1 = varB = 25
    lw   $t2, 4($t0)      # $t2 = varC = 17
    add  $t3, $t1, $t2    # $t3 = 42
    sw   $t3, 8($t0)      # varA = 42
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program

# ==================================================
# Step 1.2 - Base plus offset
# Listing 2
# ==================================================
# Purpose: Read words using positive and negative byte offsets.
# Register Plan:
# $s0 = Base address of this variant's scores array
# $s1 = Address of scores[2] (base + 8)
# $t0 = Value of scores[0] (40)
# $t1 = Value of scores[1] (55)
# $t2 = Value of scores[4] (100)
# $t3 = Value of scores[2] (70), loaded through s1
# $t4 = Value of scores[1] (55), loaded at s1 - 4
# $v0 = Syscall service number: 10=exit
tn1_step_1_2:
    la   $s0, tn1_step_1_2_scores      # $s0 = base address of this variant
    lw   $t0, 0($s0)      # $t0 = scores[0] = 40
    lw   $t1, 4($s0)      # $t1 = scores[1] = 55
    lw   $t2, 16($s0)     # $t2 = scores[4] = 100
    addi $s1, $s0, 8      # $s1 = address of scores[2]
    lw   $t3, 0($s1)      # $t3 = 70
    lw   $t4, -4($s1)     # $t4 = 55
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program

# ==================================================
# Step 1.3 - Break it on purpose
# Listing 2 modified
# ==================================================
# Case (a): intentional unaligned load at base + 2
# Purpose: Deliberately load a word at base + 2; an exception is expected.
# Register Plan:
# $s0 = Base address of this variant's scores array
# $s1 = Address of scores[2] (base + 8); not reached after exception
# $t0 = Value of scores[0] (40)
# $t1 = Destination of failing lw at base + 2; no value is loaded
# $t2 = Value of scores[4] (100); not reached after exception
# $t3 = Value of scores[2] (70), loaded through s1; not reached after exception
# $t4 = Value of scores[1] (55), loaded at s1 - 4; not reached after exception
# $v0 = Syscall service number: 10=exit; syscall code not reached after exception
# The expected alignment exception stops this block; later instructions are not reached.
tn1_step_1_3_a:
    la   $s0, tn1_step_1_3_a_scores      # $s0 = base address of this variant
    lw   $t0, 0($s0)      # $t0 = scores[0] = 40
    lw   $t1, 2($s0)      # INTENTIONAL: unaligned address base + 2
    lw   $t2, 16($s0)     # $t2 = scores[4] = 100
    addi $s1, $s0, 8      # $s1 = address of scores[2]
    lw   $t3, 0($s1)      # $t3 = 70
    lw   $t4, -4($s1)     # $t4 = 55
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program

# Case (b): intentional out-of-bounds load at base + 20
# Purpose: Read past scores; hardware does not enforce array bounds.
# Register Plan:
# $s0 = Base address of this variant's scores array
# $s1 = Address of scores[2] (base + 8)
# $t0 = Value of scores[0] (40)
# $t1 = Word read at base + 20, beyond scores; not an array element
# $t2 = Value of scores[4] (100)
# $t3 = Value of scores[2] (70), loaded through s1
# $t4 = Value of scores[1] (55), loaded at s1 - 4
# $v0 = Syscall service number: 10=exit
# The word beyond the array has no reliable value; no array bounds are enforced.
tn1_step_1_3_b:
    la   $s0, tn1_step_1_3_b_scores      # $s0 = base address of this variant
    lw   $t0, 0($s0)      # $t0 = scores[0] = 40
    lw   $t1, 20($s0)     # INTENTIONAL: aligned word after the array
    lw   $t2, 16($s0)     # $t2 = scores[4] = 100
    addi $s1, $s0, 8      # $s1 = address of scores[2]
    lw   $t3, 0($s1)      # $t3 = 70
    lw   $t4, -4($s1)     # $t4 = 55
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program
