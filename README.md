# CSBU102 - Computer System

## LAB 02 - Accessing Main Memory: Words, Arrays, Bytes and Strings

**Student:** Pham Nguyen Minh Tam - **Student ID:** 26560053

Programs follow the original `CSBU102_LAB02.docx` assignment. Each source is a separate executable; the three required TN files reproduce the main outcome of their experiment.

## Requirements and running

Use MARS 4.5 with Java, the default memory configuration, and extended (pseudo) instructions enabled. Enable **Initialize Program Counter to global main**. Open one `.asm` file, choose **Run > Assemble** (F3), then **Run > Go** (F5). Inspect registers and the Data Segment after execution; use decimal or hexadecimal display as appropriate. Reset before repeating a run. Disable **Assemble all files in directory** because these independent programs reuse labels such as `main` and `scores`.

For command-line use with the official JAR:

```text
java -jar Mars4_5.jar nc sm mc Default TN2/Lab02_26560053_TN2.asm
```

## Repository structure

```text
.
|-- .gitignore
|-- README.md
|-- TN1/
|   |-- Lab02_26560053_TN1.asm
|   |-- Listing0_QuickCheck.asm
|   |-- Listing1_Variables.asm
|   |-- Listing2_Offsets.asm
|   |-- Listing2_Misaligned.asm
|   `-- Listing2_OutOfBounds.asm
|-- TN2/
|   |-- Lab02_26560053_TN2.asm
|   |-- Listing3_Swap.asm
|   |-- Listing4_ArrayIndex.asm
|   |-- Listing4_Index0.asm
|   |-- Listing4_Index2.asm
|   |-- Listing4_Index4.asm
|   |-- Listing4_WrongShift.asm
|   `-- Step2_3_UpdateAndTotal.asm
|-- TN3/
|   |-- Lab02_26560053_TN3.asm
|   |-- Listing5_StringBytes.asm
|   |-- Listing6_ByteOrder.asm
|   |-- Listing7_SignedUnsigned.asm
|   |-- Listing8_Capitalize.asm
|   `-- Listing8_WithoutNull.asm
`-- EXT/
    `-- Lab02_26560053_EXT.asm
```

## Experiments and validation

TN1 loads and stores words using base addresses and byte offsets. TN2 swaps scores, calculates `base + 4*i`, and updates a score before summing the array. TN3 examines character bytes, little-endian word storage, sign extension and string editing. The extension uses row-major addressing for a 3 x 3 board.

All 21 files were individually assembled and run with the official MARS 4.5 classes, default memory configuration and global `main` entry. The table records verified output, registers or memory, including the two expected runtime exceptions. No screenshots were captured.

| Listing / experiment | Source file | Verified result |
|---|---|---|
| TN1 main / Listing 1 | `TN1/Lab02_26560053_TN1.asm` | `$t3 = 42`, memory `varA = 42`; no printed output |
| Listing 0 | `TN1/Listing0_QuickCheck.asm` | `Value read from memory: 7` |
| Listing 1 | `TN1/Listing1_Variables.asm` | `$t3 = 42`, memory `varA = 42` |
| Listing 2 | `TN1/Listing2_Offsets.asm` | `$t0..$t4 = 40,55,100,70,55`; `$s1 = 0x10010008` |
| Step 1.3 A | `TN1/Listing2_Misaligned.asm` | Expected word-alignment exception at `0x10010002` |
| Step 1.3 B | `TN1/Listing2_OutOfBounds.asm` | No exception; read beyond array at `0x10010014`, observed `$t1 = 0` |
| TN2 main / Step 2.3 | `TN2/Lab02_26560053_TN2.asm` | `Total: 311`; `$s3 = 311`; array `40,55,70,46,100` |
| Listing 3 | `TN2/Listing3_Swap.asm` | Array `100,55,70,85,40` |
| Listing 4 | `TN2/Listing4_ArrayIndex.asm` | `scores[i] = 85`; `$t1 = 0x1001000C` |
| Listing 4, i=0 | `TN2/Listing4_Index0.asm` | `scores[i] = 40`; `$t1 = 0x10010000` |
| Listing 4, i=2 | `TN2/Listing4_Index2.asm` | `scores[i] = 70`; `$t1 = 0x10010008` |
| Listing 4, i=4 | `TN2/Listing4_Index4.asm` | `scores[i] = 100`; `$t1 = 0x10010010` |
| Listing 4, wrong shift | `TN2/Listing4_WrongShift.asm` | Expected word-alignment exception at `0x10010006` |
| Step 2.3 | `TN2/Step2_3_UpdateAndTotal.asm` | Same verified total and memory as TN2 main |
| TN3 main / Listing 8 | `TN3/Lab02_26560053_TN3.asm` | `Nguyen Van An`; only bytes at offsets 0,7,11 changed |
| Listing 5 | `TN3/Listing5_StringBytes.asm` | Prints `i`; `$t0..$t3 = 0x48,0x69,0x21,0x00` |
| Listing 6 | `TN3/Listing6_ByteOrder.asm` | `$t0..$t3 = 0x44,0x43,0x42,0x41`; `$t4 = 0x41424344` |
| Listing 7 | `TN3/Listing7_SignedUnsigned.asm` | `$t0 = 0xFFFFFFF0` (-16); `$t1 = 0x000000F0` (240) |
| Listing 8 | `TN3/Listing8_Capitalize.asm` | `Nguyen Van An`; modified string verified in memory |
| Listing 8, .ascii | `TN3/Listing8_WithoutNull.asm` | Observed `Nguyen Van An [end]` with the supplied adjacent declarations |
| Extension | `EXT/Lab02_26560053_EXT.asm` | Board `0,0,0,0,0,1,2,0,0`; addresses `0x10010014`, `0x10010018` |

For student ID 26560053, the last digit is D=3, giving k=3 and V=46. The original scores total 350; replacing 85 with 46 gives `350 - 85 + 46 = 311`.

## Controlled experiments

`Listing2_Misaligned.asm` and `Listing4_WrongShift.asm` deliberately stop with alignment exceptions at their `lw` instructions. A word address must be a multiple of four. Shifting index 3 by one gives byte offset 6 instead of 12. These exceptions are expected results.

`Listing2_OutOfBounds.asm` deliberately reads the aligned word immediately after the five scores. MARS does not enforce array bounds: the observed zero is not an array element or a value to rely on. Keeping an index inside an array is the programmer's responsibility.

`.asciiz` adds a terminating zero; `.ascii` does not. In `Listing8_WithoutNull.asm`, print service 4 continues from `str1` into the following `tag` until its zero byte. More generally, output may continue into subsequent memory until a zero is encountered. The observed extra text above was verified in MARS, not printed separately or hardcoded as a replacement for the experiment.

## Extension and submission

The extension keeps the board base in `$s0`, row in `$s1`, and column in `$s2`. It computes `index = 3*row + column` using `row + (row << 1)`, then `address = base + (index << 2)`. Stores set `board[1][2] = 1` and `board[2][0] = 2`.

The four required submission filenames are present in TN1, TN2, TN3 and EXT. Capture any screenshots still required by the assignment document and submit the document and repository link as instructed by the course.
