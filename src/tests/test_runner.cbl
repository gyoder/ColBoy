      *    ColBoy: The worlds best COBOL GameBoy Emulator
      *    Written by Grace

       identification division.
       program-id. TEST_RUNNER.
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


           01 TEST-VARS.
               05 TEST-NUM binary-char unsigned value 15.

       procedure division.
       display "==== C TESTS ===".
       display "Running Basic Linkage Test".
       call "basic_linkage_test".
       display "".

       display "Running Pass Value Test".
       call "pass_value_test" using by value TEST-NUM.
       display "".

       display "Running Pass By Reference Test".
       call "pass_reference_test" using by reference TEST-NUM.
       display "New Value: ", TEST-NUM.
       display "".

       end program TEST_RUNNER.
