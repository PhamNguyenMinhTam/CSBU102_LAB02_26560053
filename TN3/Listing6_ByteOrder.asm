# ==================================================
# Course: CSBU102 - Computer System
# Lab: LAB 02 - Accessing Main Memory
# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# Experiment 3 - Listing 6: Byte Order
# Source: Listing6_ByteOrder.asm
#
# Purpose:
# Inspect the little-endian bytes and whole word.
#
# Register Plan:
# $s0 = Address of word w
# $t0 = Byte at offset 0 (0x44 in little-endian order)
# $t1 = Byte at offset 1 (0x43)
# $t2 = Byte at offset 2 (0x42)
# $t3 = Byte at offset 3 (0x41)
# $t4 = Complete word loaded by lw (0x41424344)
# $v0 = Syscall service number: 10=exit
# ==================================================
.data
w: .word 0x41424344

.text
.globl main
main:
    la   $s0, w           # $s0 = address of word w
    lb   $t0, 0($s0)      # 0x44 at lowest address
    lb   $t1, 1($s0)      # 0x43
    lb   $t2, 2($s0)      # 0x42
    lb   $t3, 3($s0)      # 0x41
    lw   $t4, 0($s0)      # Whole word = 0x41424344
    li   $v0, 10          # Select service: 10=exit
    syscall               # Exit program
