# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# LAB 02 - TN2 / Step 2.3 - Personal data
# Purpose: Update scores[3] to 46 and print the sum 311.
.data
scores: .word 40, 55, 70, 85, 100
msg: .asciiz "Total: "
nl: .asciiz "\n"

.text
.globl main
main:
    la   $s0, scores      # $s0 = array base
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
    li   $v0, 4
    la   $a0, msg
    syscall
    li   $v0, 1
    add  $a0, $s3, $zero
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall
    li   $v0, 10         # Exit program
    syscall
