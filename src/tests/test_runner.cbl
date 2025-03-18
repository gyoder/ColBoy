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
               05 TEST-SHORT binary-short unsigned value 0.

       procedure division.
       display "==== C TESTS ====".
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

       display "==== STATE TESTS ===="
       display "Running Register Verification Tests".
      * Not working for some reason. makes segfault
      *call "verify_reg".
       move 6 to R-A.
       call "GET_REGISTER" using by reference TEST-NUM, by content 'a'.
       if not TEST-NUM = 6
           display "SET REG FAIL"
       else
           display "SET_REGISTER Success"
       end-if.
       call "SET_REGISTER" using by value 5, by content 'a'.
       if not R-A = 5
           display "GET REG FAIL"
       else
           display "GET_REGISTER Success"
       end-if.


       display "".
       display "Memory Address Get and Set".
       move 5 to MEMORY-ARR (6).
       call "READ_BYTE" using by reference TEST-NUM, by value 5.
       if not TEST-NUM = 5
           display "READ_BYTE FAIL"
       else
           display "READ_BYTE Success"
       end-if.
       call "WRITE_BYTE" using by value 7, by value 6.
       if not MEMORY-ARR (7) = 7
           display "WRITE_BYTE FAIL"
       else
           display "WRITE_BYTE Success"
       end-if. 
       move 2 to MEMORY-ARR (9).
       move 1 to MEMORY-ARR (10).
       call "READ_WORD" using by reference TEST-SHORT, by value 8.
       if not TEST-SHORT = 258
           display "READ_WORD FAIL"
       else
           display "READ_WORD Success"
       end-if.  
       call "WRITE_WORD" using by value 258, by value 19.
       if not (MEMORY-ARR (20) = 2 and MEMORY-ARR (21) = 1)
           display "WRITE_WORD FAIL"
       else
           display "WRITE_WORD Success"
       end-if. 
       end program TEST_RUNNER.
