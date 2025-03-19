      *    ColBoy: The worlds best COBOL GameBoy Emulator
      *    Written by Grace

       identification division.
       program-id. I_LD_BYTE.
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
           
              
      *    > All Addressable 16 bits of ram
           01 MEMORY-R  external.
               05 MAX_ADDR pic 9(5).
               05 MEMORY-ARR binary-char unsigned occurs 65536 times.


      * ====== LOCAL =======
           01 LOAD-ADDR binary-short unsigned value 0.
               88 LOAD-USE-REG value 0.

           01 SAVE-ADDR binary-short unsigned value 0.
               88 SAVE-USE-REG value 0.

           01 MOVE-VAL binary-char unsigned value 0.
           
           01 TEMP binary-char unsigned value 0.
           
       linkage section.
           01 TARGET-R pic x any length.
           01 SOURCE-R pic x any length.
       procedure division using by reference TARGET-R, by reference 
           SOURCE-R.
       
           set R-PC up by 1.

           if SOURCE-R = "bc" or SOURCE-R = "de" or SOURCE-R = "hl"
               call "GET_REGISTER" using by reference LOAD-ADDR,
      -             by reference SOURCE-R
           end-if.



           if SOURCE-R = "nn"
               set R-PC up by 1
               call "READ_BYTE" using by reference TEMP,
                    by value R-PC
               set R-PC up by 1
               call "READ_BYTE" using by reference LOAD-ADDR,
                    by value R-PC
               multiply 256 by LOAD-ADDR
               add TEMP to LOAD-ADDR
           end-if

           if not LOAD-USE-REG
               if SOURCE-R = "n"
                   set R-PC up by 1
                   call "READ_BYTE" using by reference MOVE-VAL,
                        by value R-PC
               else
                   call "GET_REGISTER" using by reference MOVE-VAL,      
      -                 by reference SOURCE-R
               end-if
           else
               call "READ_BYTE" using by reference MOVE-VAL,
      -             by reference LOAD-ADDR
           end-if.

           if TARGET-R = "bc" or TARGET-R = "de" or TARGET-R = "hl"
               call "GET_REGISTER" using by reference SAVE-ADDR,
      -             by reference TARGET-R
           end-if.           

           if TARGET-R = "nn"
               set R-PC up by 1
               call "READ_BYTE" using by reference TEMP,
                    by value R-PC
               set R-PC up by 1
               call "READ_BYTE" using by reference SAVE-ADDR,
                    by value R-PC
               multiply 256 by SAVE-ADDR
               add TEMP to SAVE-ADDR
           end-if
           
           if not SAVE-USE-REG
               call "SET_REGISTER" using by value MOVE-VAL,
      -             by reference TARGET-R
           else
               call "WRITE_BYTE" using by value MOVE-VAL, 
      -             by reference SAVE-ADDR
           end-if.

       end program I_LD_BYTE.
