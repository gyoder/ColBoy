      *    GBXtreme: The worlds best COBOL GameBoy Emulator
      *    Written by Grace

       identification division.
       program-id. CPU-RESET.
       environment division.
       data division.
       working-storage section.
           01 dumb external binary-char.
           01 GBX-INTERNAL external.
               05 REGISTERS.
      *            > Program Counter   - 16bit                       
                   10 R-PC binary-short unsigned.

      *            > Stack Pointer     - 16bit
                   10 R-SP binary-short unsigned.

      *            > Accumulator       - 8bit
                   10 R-A binary-char unsigned.

      *            > Flags Register    - 8bit
      *            > register F uses its upper 4 bits to store 4 flags
      *            > so we will be storing that. Lower 4 bits should
      *            > *Theoretically* be zero so this should be fine
                   10 R-F binary-char unsigned.
                       88 R-F-ZERO             value x'80' thru x'F0'.
                       88 R-F-SUBTRACTION      value x'40' thru x'70'
                                                     x'C0' thru x'F0'.
                       88 R-F-HALF-CARRY       value x'20' thru x'30'
                                                     x'60' thru x'70'
                                                     x'A0' thru x'B0'
                                                     x'E0' thru x'F0'.
                       88 R-F-CARRY            value x'10' x'30' x'50'
                                                     x'70' x'90' x'B0'
                                                     x'D0' x'F0'.

      *            > B C D E H L       - 8bit
                   10 R-B binary-char unsigned.
                   10 R-C binary-char unsigned.
                   10 R-D binary-char unsigned.
                   10 R-E binary-char unsigned.
                   10 R-H binary-char unsigned.
                   10 R-L binary-char unsigned.
                   
      *        > All Addressable 16 bits of ram
               05 MAX_ADDR pic 9(5).
               05 MEMORY-ARR binary-char unsigned occurs 65536 times.

           01 I pic 9(5) value 1.
       procedure division.
       MAIN.
           move 5 to dumb.
           move 0 to R-PC.
           move 0 to R-SP.
           move 0 to R-A.
           move 0 to R-F.
           move 0 to R-B.
           move 0 to R-C.
           move 0 to R-D.
           move 0 to R-E.
           move 0 to R-H.
           move 0 to R-L.
           perform SET-ZERO varying I from 1 by 1 until I > MAX_ADDR.
           go to ENDP.
       SET-ZERO.
           move ZEROS to MEMORY-ARR(I).
       ENDP.
       end program CPU-RESET.
       