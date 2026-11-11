# Name: Pham Nguyen Minh Tam
# Student ID: 26560053
# LAB 02 - Listing 6 - Byte order
# Purpose: Inspect the little-endian bytes and whole word.
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
    li   $v0, 10         # Exit program
    syscall
