# ==================================================
# Course: CSBU102 - Computer System
# Lab: LAB 02 - Accessing Main Memory
# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# Source: Lab02_26560053_TN2.asm
# Purpose: All Experiment 2 exercises (Steps 2.1-2.3), including all index variants and baseline.
# Select one exercise at main; reset and assemble before each run.
# ==================================================
.data
# Step 2.1 - Swap two scores / Listing 3
.align 2
tn2_step_2_1_scores: .word 40, 55, 70, 85, 100

# Step 2.2 - The index in a register / Listing 4 Original: i = 3
.align 2
tn2_step_2_2_i3_scores: .word 40, 55, 70, 85, 100
tn2_step_2_2_i3_msg: .asciiz "scores[i] = "
tn2_step_2_2_i3_nl: .asciiz "\n"

# Step 2.2 - The index in a register / Listing 4 / Table 8 Variant (a): i = 0
.align 2
tn2_step_2_2_i0_scores: .word 40, 55, 70, 85, 100
tn2_step_2_2_i0_msg: .asciiz "scores[i] = "
tn2_step_2_2_i0_nl: .asciiz "\n"

# Step 2.2 - The index in a register / Listing 4 / Table 8 Variant (b): i = 2
.align 2
tn2_step_2_2_i2_scores: .word 40, 55, 70, 85, 100
tn2_step_2_2_i2_msg: .asciiz "scores[i] = "
tn2_step_2_2_i2_nl: .asciiz "\n"

# Step 2.2 - The index in a register / Listing 4 / Table 8 Variant (c): i = 4
.align 2
tn2_step_2_2_i4_scores: .word 40, 55, 70, 85, 100
tn2_step_2_2_i4_msg: .asciiz "scores[i] = "
tn2_step_2_2_i4_nl: .asciiz "\n"

# Step 2.2 - The index in a register / Listing 4 / Table 8 Case (d): i = 3, intentional shift by 1
.align 2
tn2_step_2_2_wrong_scores: .word 40, 55, 70, 85, 100
tn2_step_2_2_wrong_msg: .asciiz "scores[i] = "
tn2_step_2_2_wrong_nl: .asciiz "\n"

# Step 2.3 - Your own data / Based on Listing 4 Baseline: original scores, no update
.align 2
tn2_step_2_3_baseline_scores: .word 40, 55, 70, 85, 100
tn2_step_2_3_baseline_msg: .asciiz "Total: "
tn2_step_2_3_baseline_nl: .asciiz "\n"

# Step 2.3 - Your own data / Based on Listing 4 Personal data: D = 3, k = 3, V = 46
.align 2
tn2_step_2_3_update_scores: .word 40, 55, 70, 85, 100
tn2_step_2_3_update_msg: .asciiz "Total: "
tn2_step_2_3_update_nl: .asciiz "\n"

.text
.globl main
main:
    # Select ONE exercise by keeping only its jump active.
    j tn2_step_2_3_update
    # j tn2_step_2_1
    # j tn2_step_2_2_i3
    # j tn2_step_2_2_i0
    # j tn2_step_2_2_i2
    # j tn2_step_2_2_i4
    # j tn2_step_2_2_wrong
    # j tn2_step_2_3_baseline
    nop

# ==================================================
# Step 2.1 - Swap two scores
# Listing 3
# ==================================================
# Purpose: Exchange scores[0] and scores[4] using word loads and stores.
# Register Plan:
# $s0 = Base address of scores
# $t0 = Original scores[0] (40), then stored into scores[4]
# $t1 = Original scores[4] (100), then stored into scores[0]
# $v0 = Syscall service number: 10=exit
tn2_step_2_1:
    la   $s0, tn2_step_2_1_scores      # $s0 = array base
    lw   $t0, 0($s0)      # Preserve original scores[0]
    lw   $t1, 16($s0)     # Preserve original scores[4]
    sw   $t1, 0($s0)      # scores[0] = 100
    sw   $t0, 16($s0)     # scores[4] = 40
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program

# ==================================================
# Step 2.2 - The index in a register
# Listing 4
# ==================================================
# Original: i = 3
# Purpose: Compute base + 4*i and print scores[3].
# Register Plan:
# $s0 = Base address of scores
# $s1 = Array index i = 3
# $t1 = Byte offset 4*i, then address base + 4*i for scores[3]
# $t2 = Value loaded from scores[3] for printing
# $a0 = Message/newline address or selected score for printing
# $zero = Constant zero for initializing i and copying the selected score to a0
# $v0 = Syscall service number: 4=print string, 1=print integer, 10=exit
tn2_step_2_2_i3:
    la   $s0, tn2_step_2_2_i3_scores      # $s0 = array base
    addi $s1, $zero, 3    # $s1 = index i
    sll  $t1, $s1, 2      # $t1 = 4 * i (byte offset)
    add  $t1, $t1, $s0    # $t1 = address of scores[i]
    lw   $t2, 0($t1)      # $t2 = selected score
    li   $v0, 4           # Select service: 4=print string
    la   $a0, tn2_step_2_2_i3_msg         # Address of output message
    syscall               # Print zero-terminated string at $a0
    li   $v0, 1           # Select service: 1=print integer
    add  $a0, $t2, $zero  # Copy value to the print argument
    syscall               # Print integer in $a0
    li   $v0, 4           # Select service: 4=print string
    la   $a0, tn2_step_2_2_i3_nl          # Address of newline string
    syscall               # Print zero-terminated string at $a0
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program

# Variant (a): i = 0
# Purpose: Print scores[0] using a register index.
# Register Plan:
# $s0 = Base address of scores
# $s1 = Array index i = 0
# $t1 = Byte offset 4*i, then address base + 4*i for scores[0]
# $t2 = Value loaded from scores[0] for printing
# $a0 = Message/newline address or selected score for printing
# $zero = Constant zero for initializing i and copying the selected score to a0
# $v0 = Syscall service number: 4=print string, 1=print integer, 10=exit
tn2_step_2_2_i0:
    la   $s0, tn2_step_2_2_i0_scores      # $s0 = array base
    addi $s1, $zero, 0    # $s1 = index i
    sll  $t1, $s1, 2      # $t1 = 4 * i (byte offset)
    add  $t1, $t1, $s0    # $t1 = address of scores[i]
    lw   $t2, 0($t1)      # $t2 = selected score
    li   $v0, 4           # Select service: 4=print string
    la   $a0, tn2_step_2_2_i0_msg         # Address of output message
    syscall               # Print zero-terminated string at $a0
    li   $v0, 1           # Select service: 1=print integer
    add  $a0, $t2, $zero  # Copy value to the print argument
    syscall               # Print integer in $a0
    li   $v0, 4           # Select service: 4=print string
    la   $a0, tn2_step_2_2_i0_nl          # Address of newline string
    syscall               # Print zero-terminated string at $a0
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program

# Variant (b): i = 2
# Purpose: Print scores[2] using a register index.
# Register Plan:
# $s0 = Base address of scores
# $s1 = Array index i = 2
# $t1 = Byte offset 4*i, then address base + 4*i for scores[2]
# $t2 = Value loaded from scores[2] for printing
# $a0 = Message/newline address or selected score for printing
# $zero = Constant zero for initializing i and copying the selected score to a0
# $v0 = Syscall service number: 4=print string, 1=print integer, 10=exit
tn2_step_2_2_i2:
    la   $s0, tn2_step_2_2_i2_scores      # $s0 = array base
    addi $s1, $zero, 2    # $s1 = index i
    sll  $t1, $s1, 2      # $t1 = 4 * i (byte offset)
    add  $t1, $t1, $s0    # $t1 = address of scores[i]
    lw   $t2, 0($t1)      # $t2 = selected score
    li   $v0, 4           # Select service: 4=print string
    la   $a0, tn2_step_2_2_i2_msg         # Address of output message
    syscall               # Print zero-terminated string at $a0
    li   $v0, 1           # Select service: 1=print integer
    add  $a0, $t2, $zero  # Copy value to the print argument
    syscall               # Print integer in $a0
    li   $v0, 4           # Select service: 4=print string
    la   $a0, tn2_step_2_2_i2_nl          # Address of newline string
    syscall               # Print zero-terminated string at $a0
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program

# Variant (c): i = 4
# Purpose: Print scores[4] using a register index.
# Register Plan:
# $s0 = Base address of scores
# $s1 = Array index i = 4
# $t1 = Byte offset 4*i, then address base + 4*i for scores[4]
# $t2 = Value loaded from scores[4] for printing
# $a0 = Message/newline address or selected score for printing
# $zero = Constant zero for initializing i and copying the selected score to a0
# $v0 = Syscall service number: 4=print string, 1=print integer, 10=exit
tn2_step_2_2_i4:
    la   $s0, tn2_step_2_2_i4_scores      # $s0 = array base
    addi $s1, $zero, 4    # $s1 = index i
    sll  $t1, $s1, 2      # $t1 = 4 * i (byte offset)
    add  $t1, $t1, $s0    # $t1 = address of scores[i]
    lw   $t2, 0($t1)      # $t2 = selected score
    li   $v0, 4           # Select service: 4=print string
    la   $a0, tn2_step_2_2_i4_msg         # Address of output message
    syscall               # Print zero-terminated string at $a0
    li   $v0, 1           # Select service: 1=print integer
    add  $a0, $t2, $zero  # Copy value to the print argument
    syscall               # Print integer in $a0
    li   $v0, 4           # Select service: 4=print string
    la   $a0, tn2_step_2_2_i4_nl          # Address of newline string
    syscall               # Print zero-terminated string at $a0
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program

# Case (d): i = 3, intentional shift by 1
# Purpose: Use 2*i for i=3; expect an alignment exception at base + 6.
# Register Plan:
# $s0 = Base address of scores
# $s1 = Array index i = 3
# $t1 = Incorrect offset 2*i = 6, then unaligned address base + 6
# $t2 = Destination of failing lw; no selected score is loaded
# $a0 = Message/newline address or selected score for printing; print code not reached after exception
# $zero = Constant zero for initializing i and copying the selected score to a0
# $v0 = Syscall service number: 4=print string, 1=print integer, 10=exit; syscall code not reached after exception
# The expected alignment exception stops this block; later instructions are not reached.
tn2_step_2_2_wrong:
    la   $s0, tn2_step_2_2_wrong_scores      # $s0 = array base
    addi $s1, $zero, 3    # $s1 = index i
    sll  $t1, $s1, 1      # INTENTIONAL: wrong byte offset 2*i = 6
    add  $t1, $t1, $s0    # INTENTIONAL: base + 6, not the address of scores[3]
    lw   $t2, 0($t1)      # INTENTIONAL: lw raises an alignment exception
    li   $v0, 4           # Select service: 4=print string
    la   $a0, tn2_step_2_2_wrong_msg         # Address of output message
    syscall               # Print zero-terminated string at $a0
    li   $v0, 1           # Select service: 1=print integer
    add  $a0, $t2, $zero  # Copy value to the print argument
    syscall               # Print integer in $a0
    li   $v0, 4           # Select service: 4=print string
    la   $a0, tn2_step_2_2_wrong_nl          # Address of newline string
    syscall               # Print zero-terminated string at $a0
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program

# ==================================================
# Step 2.3 - Your own data
# Based on Listing 4
# ==================================================
# Baseline: original scores, no update
# Purpose: Print the original total 350 without updating any array element.
# Register Plan:
# $s0 = Base address of scores
# $s3 = Running total of all five scores; final value 350
# $t0 = Value of scores[0] (40)
# $t1 = Value of scores[1] (55)
# $t2 = Value of scores[2] (70)
# $t3 = Original value of scores[3] (85)
# $t4 = Value of scores[4] (100)
# $a0 = Total message/newline address or total from s3 for printing
# $zero = Constant zero for copying the total to a0
# $v0 = Syscall service number: 4=print string, 1=print integer, 10=exit
tn2_step_2_3_baseline:
    la   $s0, tn2_step_2_3_baseline_scores      # $s0 = array base
    lw   $t0, 0($s0)      # $t0 = 40
    lw   $t1, 4($s0)      # $t1 = 55
    lw   $t2, 8($s0)      # $t2 = 70
    lw   $t3, 12($s0)     # $t3 = original scores[3] = 85
    lw   $t4, 16($s0)     # $t4 = 100
    add  $s3, $t0, $t1    # $s3 accumulates the total
    add  $s3, $s3, $t2
    add  $s3, $s3, $t3
    add  $s3, $s3, $t4    # $s3 = 350 (no update)
    li   $v0, 4           # Select service: 4=print string
    la   $a0, tn2_step_2_3_baseline_msg         # Address of output message
    syscall               # Print zero-terminated string at $a0
    li   $v0, 1           # Select service: 1=print integer
    add  $a0, $s3, $zero  # Copy value to the print argument
    syscall               # Print integer in $a0
    li   $v0, 4           # Select service: 4=print string
    la   $a0, tn2_step_2_3_baseline_nl          # Address of newline string
    syscall               # Print zero-terminated string at $a0
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program

# Personal data: D = 3, k = 3, V = 46
# Purpose: Update scores[3] to 46 and print the sum 311.
# Register Plan:
# $s0 = Base address of scores
# $s1 = Index k = 3, selected by last student ID digit D = 3
# $s2 = Replacement score V = 46
# $s3 = Running total of all five scores; final value 311
# $t0 = Value of scores[0] (40)
# $t1 = Offset 4*k, then address of scores[k], then scores[1] (55)
# $t2 = Value of scores[2] (70)
# $t3 = Updated value of scores[3] (46)
# $t4 = Value of scores[4] (100)
# $a0 = Total message/newline address or total from s3 for printing
# $zero = Constant zero for initializing k and V and copying the total to a0
# $v0 = Syscall service number: 4=print string, 1=print integer, 10=exit
tn2_step_2_3_update:
    la   $s0, tn2_step_2_3_update_scores      # $s0 = array base
    addi $s1, $zero, 3    # Last ID digit D=3 gives k=3
    addi $s2, $zero, 46   # $s2 = new value V
    sll  $t1, $s1, 2      # $t1 = 4*k
    add  $t1, $t1, $s0    # $t1 = address of scores[k]
    sw   $s2, 0($t1)      # scores[3] = 46
    lw   $t0, 0($s0)      # $t0 = 40
    lw   $t1, 4($s0)      # $t1 = 55
    lw   $t2, 8($s0)      # $t2 = 70
    lw   $t3, 12($s0)     # $t3 = 46
    lw   $t4, 16($s0)     # $t4 = 100
    add  $s3, $t0, $t1    # $s3 accumulates the total
    add  $s3, $s3, $t2
    add  $s3, $s3, $t3
    add  $s3, $s3, $t4    # $s3 = 311; original total was 350
    li   $v0, 4           # Select service: 4=print string
    la   $a0, tn2_step_2_3_update_msg         # Address of output message
    syscall               # Print zero-terminated string at $a0
    li   $v0, 1           # Select service: 1=print integer
    add  $a0, $s3, $zero  # Copy value to the print argument
    syscall               # Print integer in $a0
    li   $v0, 4           # Select service: 4=print string
    la   $a0, tn2_step_2_3_update_nl          # Address of newline string
    syscall               # Print zero-terminated string at $a0
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program
