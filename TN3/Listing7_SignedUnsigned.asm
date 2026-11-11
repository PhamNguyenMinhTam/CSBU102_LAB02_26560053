# ==================================================
# Course: CSBU102 - Computer System
# Lab: LAB 02 - Accessing Main Memory
# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# Experiment 3 - Listing 7: Signed and Unsigned Bytes
# Source: Listing7_SignedUnsigned.asm
#
# Purpose:
# Compare sign extension by lb with zero extension by lbu.
#
# Register Plan:
# $s0 = Address of byte b1 (0xF0)
# $t0 = Sign-extended byte from lb (0xFFFFFFF0 = -16)
# $t1 = Zero-extended byte from lbu (0x000000F0 = 240)
# $v0 = Syscall service number: 10=exit
# ==================================================
.data
b1: .byte 0xF0

.text
.globl main
main:
    la   $s0, b1          # $s0 = address of byte b1
    lb   $t0, 0($s0)      # 0xFFFFFFF0 = -16
    lbu  $t1, 0($s0)      # 0x000000F0 = 240
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program
