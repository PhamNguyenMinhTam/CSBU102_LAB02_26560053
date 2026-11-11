# CSBU102 - Computer System

## LAB 02 - Accessing Main Memory: Words, Arrays, Bytes and Strings

**Name:** Pham Nguyen Minh Tam - **Student ID:** 26560053

The four submission files contain every exercise from the original LAB02 Word document, including Listings 0-8, controlled experiments, index variants, the original total baseline and the optional extension. Each file has one main entry, one data section and one text section. Assignment Step headings organize the code; each Step/variant has its own accurate Register Plan.

## Structure

```text
.
|-- README.md
|-- .gitignore
|-- Lab02_26560053_TN1.asm
|-- Lab02_26560053_TN2.asm
|-- Lab02_26560053_TN3.asm
`-- Lab02_26560053_EXT.asm
```

Only these four assembly sources belong to the submission. Local validation tools are ignored by Git.

## Select and run an exercise

Use Java and MARS 4.5 with default memory configuration, extended (pseudo) instructions enabled, and **Initialize Program Counter to global main** enabled. Open one submission file; disable **Assemble all files in directory** because the four files are independent programs with their own `main`.

At `main`, keep exactly one `j` instruction active. Comment out the current jump and uncomment the desired jump. Keep the final `nop` in place. Reset the simulator, save, assemble again (F3), then run (F5). Repeat the reset and assembly for every selection to restore the original data. Each selected block exits with syscall 10, except that the two intentional alignment exceptions normally stop before reaching their exit code. No block falls through into the next exercise.

Defaults: TN1 selects Step 1.1, TN2 selects the Step 2.3 update, TN3 selects Step 3.4 `.asciiz`, and EXT marks the two board cells.

```text
java -jar Mars4_5.jar nc sm mc Default Lab02_26560053_TN2.asm
```

## Assignment mapping and results

In the table, TN1 means `Lab02_26560053_TN1.asm`, and similarly for TN2, TN3 and EXT. Each row is a separate jump selection. Expected results were checked against a new MARS run for every selection; observed bases are reported for the combined files under default memory configuration.

| File | Assignment / Listing | Jump label | Expected result, verified in MARS | Observed data base |
|---|---|---|---|---|
| TN1 | Part 0, Step 0 / Listing 0 | `tn1_step_0` | `Value read from memory: 7` and newline | `0x10010000` (x) |
| TN1 | Step 1.1 / Listing 1 | `tn1_step_1_1` | `$t3 = 42`, `varA = 42`; no output | `0x10010020` (varB) |
| TN1 | Step 1.2 / Listing 2 | `tn1_step_1_2` | `$t0..$t4 = 40,55,100,70,55`; `$s1 = base + 8` | `0x1001002C` |
| TN1 | Step 1.3, case (a) / modified Listing 2 | `tn1_step_1_3_a` | Expected alignment exception at base + 2, observed `0x10010042` | `0x10010040` |
| TN1 | Step 1.3, case (b) / modified Listing 2 | `tn1_step_1_3_b` | Read base + 20; no bounds exception, observed word 0 (not guaranteed) | `0x10010054` |
| TN2 | Step 2.1 / Listing 3 | `tn2_step_2_1` | Array `100,55,70,85,40` | `0x10010000` |
| TN2 | Step 2.2 / Listing 4, i=3 | `tn2_step_2_2_i3` | `scores[i] = 85`; address base + 12 | `0x10010014` |
| TN2 | Step 2.2 / Table 8 (a), i=0 | `tn2_step_2_2_i0` | `scores[i] = 40`; address base | `0x10010038` |
| TN2 | Step 2.2 / Table 8 (b), i=2 | `tn2_step_2_2_i2` | `scores[i] = 70`; address base + 8 | `0x1001005C` |
| TN2 | Step 2.2 / Table 8 (c), i=4 | `tn2_step_2_2_i4` | `scores[i] = 100`; address base + 16 | `0x10010080` |
| TN2 | Step 2.2 / Table 8 (d), wrong shift | `tn2_step_2_2_wrong` | Expected alignment exception at base + 6, observed `0x100100AA` | `0x100100A4` |
| TN2 | Step 2.3, baseline / based on Listing 4 | `tn2_step_2_3_baseline` | Original array unchanged; `$s3 = 350`; `Total: 350` | `0x100100C8` |
| TN2 | Step 2.3, personal update / based on Listing 4 | `tn2_step_2_3_update` | Array `40,55,70,46,100`; `$s3 = 311`; `Total: 311` | `0x100100E8` |
| TN3 | Step 3.1 / Listing 5 | `tn3_step_3_1` | `$t0..$t3 = 0x48,0x69,0x21,0x00`; prints lowercase `i` | `0x10010000` |
| TN3 | Step 3.2 / Listing 6 | `tn3_step_3_2` | Bytes `0x44,0x43,0x42,0x41`; `$t4 = 0x41424344` | `0x10010004` |
| TN3 | Step 3.3 / Listing 7 | `tn3_step_3_3` | `$t0 = 0xFFFFFFF0` (-16); `$t1 = 240` | `0x10010008` |
| TN3 | Step 3.4 / Listing 8, .asciiz | `tn3_step_3_4_asciiz` | `Nguyen Van An` and newline; edits only offsets 0,7,11 | `0x10010009` |
| TN3 | Step 3.4 / modified Listing 8, .ascii | `tn3_step_3_4_ascii` | Observed `Nguyen Van An [end]` and newline | `0x10010020` |
| EXT | Extension - A 3 x 3 board in memory | `ext_board` | Board `0,0,0,0,0,1,2,0,0`; stores at `0x10010014`, `0x10010018` | `0x10010000` |

Student ID 26560053 gives D=3, k=3 and V=46. The updated total is `350 - 85 + 46 = 311`. The extension computes `index = row + (row << 1) + column`, then `address = base + (index << 2)` using `sll` and `add`.

## Memory layout and intentional experiments

Multiple independent data sets now share each file's `.data` section. Later labels therefore have different absolute addresses from the original standalone listings and Word tables. Code uses `la` and base-plus-offset arithmetic, not hardcoded addresses. Word data is aligned with `.align 2`; byte and string data need no word alignment. The Word document has not been changed.

Word loads require an address divisible by four. Step 1.3 (a) intentionally loads at base + 2; Step 2.2 (d) intentionally shifts index 3 by one, producing base + 6. Both exceptions are expected. Their subsequent reads/output/exit instructions are not normally reached.

Step 1.3 (b) reads outside the five-word array at base + 20. MARS does not enforce array bounds. Its observed zero is not an array element or a reliable value; changes in nearby data can change the result.

In Step 3.4, `.asciiz` terminates the name with zero. The `.ascii` variant places its own tag immediately after its 13 name bytes, followed by its own newline string. Service 4 really reads into that tag until its terminating zero; the tag is not separately printed. The two variants have independent data.

## Validation performed after consolidation

All four complete files assembled independently with official MARS 4.5. All 19 jump selections were run in fresh simulator processes, equivalent to resetting between selections. Seventeen selections completed normally; the other two raised their expected alignment exceptions. Output, relevant registers, updated arrays/strings, the nine board words, and unchanged arrays/strings belonging to other selections were checked. Register plans, unique labels, a single `main` per file and explicit exits were also checked.

MARS reports a signed-byte range warning for the assignment's `.byte 0xF0`; the source assembles and the verified `lb`/`lbu` values are -16 and 240. No unexpected runtime exceptions occurred. No screenshots were captured, and no test scripts or logs are included in the submission.

## Migration from the former 21 sources

All former files were mapped before removal, after the combined programs passed validation. TN1/TN2/TN3 main files previously duplicated their corresponding Listing outcomes; each pair is represented by the same combined block below. No exercise was dropped. The Step 2.3 baseline is an additional required selection.

| Former source | New file | Destination block |
|---|---|---|
| `TN1/Lab02_26560053_TN1.asm` | TN1 | `tn1_step_1_1` |
| `TN1/Listing0_QuickCheck.asm` | TN1 | `tn1_step_0` |
| `TN1/Listing1_Variables.asm` | TN1 | `tn1_step_1_1` |
| `TN1/Listing2_Offsets.asm` | TN1 | `tn1_step_1_2` |
| `TN1/Listing2_Misaligned.asm` | TN1 | `tn1_step_1_3_a` |
| `TN1/Listing2_OutOfBounds.asm` | TN1 | `tn1_step_1_3_b` |
| `TN2/Lab02_26560053_TN2.asm` | TN2 | `tn2_step_2_3_update` |
| `TN2/Listing3_Swap.asm` | TN2 | `tn2_step_2_1` |
| `TN2/Listing4_ArrayIndex.asm` | TN2 | `tn2_step_2_2_i3` |
| `TN2/Listing4_Index0.asm` | TN2 | `tn2_step_2_2_i0` |
| `TN2/Listing4_Index2.asm` | TN2 | `tn2_step_2_2_i2` |
| `TN2/Listing4_Index4.asm` | TN2 | `tn2_step_2_2_i4` |
| `TN2/Listing4_WrongShift.asm` | TN2 | `tn2_step_2_2_wrong` |
| `TN2/Step2_3_UpdateAndTotal.asm` | TN2 | `tn2_step_2_3_update` and `tn2_step_2_3_baseline` |
| `TN3/Lab02_26560053_TN3.asm` | TN3 | `tn3_step_3_4_asciiz` |
| `TN3/Listing5_StringBytes.asm` | TN3 | `tn3_step_3_1` |
| `TN3/Listing6_ByteOrder.asm` | TN3 | `tn3_step_3_2` |
| `TN3/Listing7_SignedUnsigned.asm` | TN3 | `tn3_step_3_3` |
| `TN3/Listing8_Capitalize.asm` | TN3 | `tn3_step_3_4_asciiz` |
| `TN3/Listing8_WithoutNull.asm` | TN3 | `tn3_step_3_4_ascii` |
| `EXT/Lab02_26560053_EXT.asm` | EXT | `ext_board` |

Capture any screenshots required by the assignment and submit the Word document and repository link through the course's submission channel.
