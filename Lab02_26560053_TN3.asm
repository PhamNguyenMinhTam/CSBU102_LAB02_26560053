# ==================================================
# Course: CSBU102 - Computer System
# Lab: LAB 02 - Accessing Main Memory
# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# Source: Lab02_26560053_TN3.asm
# Purpose: All Experiment 3 exercises (Steps 3.1-3.4), including both string variants.
# Select one exercise at main; reset and assemble before each run.
# ==================================================
.data
# Step 3.1 - The bytes of a string / Listing 5
tn3_step_3_1_word1: .asciiz "Hi!"

# Step 3.2 - Which byte comes first? / Listing 6
.align 2
tn3_step_3_2_w: .word 0x41424344

# Step 3.3 - Signed and unsigned bytes / Listing 7
tn3_step_3_3_b1: .byte 0xF0

# Step 3.4 - Capital letters by hand / Listing 8 Variant: .asciiz with null terminator
tn3_step_3_4_asciiz_str1: .asciiz "nguyen van an"
tn3_step_3_4_asciiz_tag:  .asciiz " [end]"
tn3_step_3_4_asciiz_nl:   .asciiz "\n"

# Step 3.4 - Capital letters by hand / Listing 8 modified Variant: .ascii without null terminator
tn3_step_3_4_ascii_str1: .ascii "nguyen van an"
tn3_step_3_4_ascii_tag:  .asciiz " [end]"
tn3_step_3_4_ascii_nl:   .asciiz "\n"

.text
.globl main
main:
    # Select ONE exercise by keeping only its jump active.
    j tn3_step_3_4_asciiz
    # j tn3_step_3_1
    # j tn3_step_3_2
    # j tn3_step_3_3
    # j tn3_step_3_4_ascii
    nop

# ==================================================
# Step 3.1 - The bytes of a string
# Listing 5
# ==================================================
# Purpose: Load all four bytes of Hi! and print the second character.
# Register Plan:
# $s0 = Address of the first byte of word1
# $t0 = Byte at offset 0: H (0x48)
# $t1 = Byte at offset 1: i (0x69), the character to print
# $t2 = Byte at offset 2: ! (0x21)
# $t3 = Byte at offset 3: null terminator (0x00)
# $a0 = Character code copied from t1 for syscall 11
# $zero = Constant zero for copying the character code from t1 to a0
# $v0 = Syscall service number: 11=print character, 10=exit
tn3_step_3_1:
    la   $s0, tn3_step_3_1_word1       # $s0 = first byte address
    lb   $t0, 0($s0)      # H = 0x48
    lb   $t1, 1($s0)      # i = 0x69
    lb   $t2, 2($s0)      # ! = 0x21
    lb   $t3, 3($s0)      # Null terminator = 0
    li   $v0, 11          # Select service: 11=print character
    add  $a0, $t1, $zero  # Print i
    syscall               # Print character in $a0
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program

# ==================================================
# Step 3.2 - Which byte comes first?
# Listing 6
# ==================================================
# Purpose: Inspect the little-endian bytes and whole word.
# Register Plan:
# $s0 = Address of word w
# $t0 = Byte at offset 0 (0x44 in little-endian order)
# $t1 = Byte at offset 1 (0x43)
# $t2 = Byte at offset 2 (0x42)
# $t3 = Byte at offset 3 (0x41)
# $t4 = Complete word loaded by lw (0x41424344)
# $v0 = Syscall service number: 10=exit
tn3_step_3_2:
    la   $s0, tn3_step_3_2_w           # $s0 = address of word w
    lb   $t0, 0($s0)      # 0x44 at lowest address
    lb   $t1, 1($s0)      # 0x43
    lb   $t2, 2($s0)      # 0x42
    lb   $t3, 3($s0)      # 0x41
    lw   $t4, 0($s0)      # Whole word = 0x41424344
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program

# ==================================================
# Step 3.3 - Signed and unsigned bytes
# Listing 7
# ==================================================
# Purpose: Compare sign extension by lb with zero extension by lbu.
# Register Plan:
# $s0 = Address of byte b1 (0xF0)
# $t0 = Sign-extended byte from lb (0xFFFFFFF0 = -16)
# $t1 = Zero-extended byte from lbu (0x000000F0 = 240)
# $v0 = Syscall service number: 10=exit
tn3_step_3_3:
    la   $s0, tn3_step_3_3_b1          # $s0 = address of byte b1
    lb   $t0, 0($s0)      # 0xFFFFFFF0 = -16
    lbu  $t1, 0($s0)      # 0x000000F0 = 240
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program

# ==================================================
# Step 3.4 - Capital letters by hand
# Listing 8
# ==================================================
# Variant: .asciiz with null terminator
# Purpose: Capitalize offsets 0, 7 and 11 and print Nguyen Van An.
# Register Plan:
# $s0 = Address of the first byte of str1
# $t0 = Letter at offsets 0, 7, then 11; converted to N, V, then A
# $a0 = Address of str1, then newline string, for syscall 4
# $zero = Constant zero for copying the str1 address from s0 to a0
# $v0 = Syscall service number: 4=print string, 10=exit
tn3_step_3_4_asciiz:
    la   $s0, tn3_step_3_4_asciiz_str1        # $s0 = first byte address
    lb   $t0, 0($s0)      # First letter n
    addi $t0, $t0, -32    # n -> N
    sb   $t0, 0($s0)      # Store N at offset 0
    lb   $t0, 7($s0)      # First letter v of van
    addi $t0, $t0, -32    # v -> V
    sb   $t0, 7($s0)      # Store V at offset 7
    lb   $t0, 11($s0)     # First letter a of an
    addi $t0, $t0, -32    # a -> A
    sb   $t0, 11($s0)     # Store A at offset 11
    li   $v0, 4           # Select service: 4=print string
    add  $a0, $s0, $zero  # Print until a zero byte is encountered
    syscall               # Print zero-terminated string at $a0
    li   $v0, 4           # Select service: 4=print string
    la   $a0, tn3_step_3_4_asciiz_nl          # Address of newline string
    syscall               # Print zero-terminated string at $a0
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program

# Variant: .ascii without null terminator
# Purpose: Demonstrate printing past str1 into subsequent data until zero.
# Register Plan:
# $s0 = Address of the first byte of str1
# $t0 = Letter at offsets 0, 7, then 11; converted to N, V, then A
# $a0 = Address of unterminated str1 (printing continues into tag), then newline
# $zero = Constant zero for copying the str1 address from s0 to a0
# $v0 = Syscall service number: 4=print string, 10=exit
tn3_step_3_4_ascii:
    la   $s0, tn3_step_3_4_ascii_str1        # $s0 = first byte address
    lb   $t0, 0($s0)      # First letter n
    addi $t0, $t0, -32    # n -> N
    sb   $t0, 0($s0)      # Store N at offset 0
    lb   $t0, 7($s0)      # First letter v of van
    addi $t0, $t0, -32    # v -> V
    sb   $t0, 7($s0)      # Store V at offset 7
    lb   $t0, 11($s0)     # First letter a of an
    addi $t0, $t0, -32    # a -> A
    sb   $t0, 11($s0)     # Store A at offset 11
    li   $v0, 4           # Select service: 4=print string
    add  $a0, $s0, $zero  # Print until a zero byte is encountered
    syscall               # Print zero-terminated string at $a0
    li   $v0, 4           # Select service: 4=print string
    la   $a0, tn3_step_3_4_ascii_nl          # Address of newline string
    syscall               # Print zero-terminated string at $a0
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program
