# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# LAB 02 - Listing 7 - Signed and unsigned bytes
# Purpose: Compare sign extension by lb with zero extension by lbu.
.data
b1: .byte 0xF0

.text
.globl main
main:
    la   $s0, b1          # $s0 = address of byte b1
    lb   $t0, 0($s0)      # 0xFFFFFFF0 = -16
    lbu  $t1, 0($s0)      # 0x000000F0 = 240
    li   $v0, 10         # Exit program
    syscall
