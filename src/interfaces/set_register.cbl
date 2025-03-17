      *    ColBoy: The worlds best COBOL GameBoy Emulator
      *    Written by Grace

       identification division.
       program-id. SET_REGISTER.
       environment division.
       data division.
       working-storage section.
           01 REGISTERS external.
      *        > Program Counter   - 16bit                       
               05 R-PC binary-short unsigned.

      *        > Stack Pointer     - 16bit
               05 R-SP binary-short unsigned.

      *        > Accumulator       - 8bit
               05 R-A binary-char unsigned.

      *        > Flags Register    - 8bit
      *        > register F uses its upper 4 bits to store 4 flags
      *        > so we will be storing that. Lower 4 bits should
      *        > *Theoretically* be zero so this should be fine
               05 R-F binary-char unsigned.
                   88 R-F-ZERO             value x'80' thru x'F0'.
                   88 R-F-SUBTRACTION      value x'40' thru x'70'
                                                 x'C0' thru x'F0'.
                   88 R-F-HALF-CARRY       value x'20' thru x'30'
                                                 x'60' thru x'70'
                                                 x'A0' thru x'B0'
                                                 x'E0' thru x'F0'.
                   88 R-F-CARRY            value x'05' x'30' x'50'
                                                 x'70' x'90' x'B0'
                                                 x'D0' x'F0'.

      *        > B C D E H L       - 8bit
               05 R-B binary-char unsigned.
               05 R-C binary-char unsigned.
               05 R-D binary-char unsigned.
               05 R-E binary-char unsigned.
               05 R-H binary-char unsigned.
               05 R-L binary-char unsigned.
           
       linkage section.
           01 RET-VAL binary-short unsigned.
           01 REG pic X any length.
       procedure division using by value RET-VAL, by reference REG.
           if REG = 'bc'
               divide RET-VAL by 256 giving R-B remainder R-C
           end-if.
           if REG = 'de'
               divide RET-VAL by 256 giving R-D remainder R-E
           end-if.
           if REG = 'hl'
               divide RET-VAL by 256 giving R-H remainder R-L
           end-if.
           if RET-VAL greater than 255
                   if not (REG = 'bc' or REG = 'de' or reg = 'hl' 
      -            or reg = 'pc' or reg = 'sp')
                               display "BAD REGISTER CALL :( EXITING"
                               stop run
                    end-if
           end-if.
           if REG = 'a'
               move RET-VAL to R-A
           end-if.
           if REG = 'b'
               move RET-VAL to R-B
           end-if.
           if REG = 'c'
               move RET-VAL to R-C
           end-if.
           if REG = 'd'
               move RET-VAL to R-D
           end-if.
           if REG = 'e'
               move RET-VAL to R-E
           end-if.
           if REG = 'h'
               move RET-VAL to R-H
           end-if.
           if REG = 'l'
               move RET-VAL to R-L
           end-if.
           if REG = 'pc'
               move RET-VAL to R-PC
           end-if.
           if REG = 'sp'
               move RET-VAL to R-SP
           end-if.
           if REG = 'F'
               move RET-VAL to R-F
           end-if.

       end program SET_REGISTER.
