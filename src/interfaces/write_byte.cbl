       identification division.
       program-id. WRITE_BYTE.
       environment division.
       data division.
       working-storage section.
           01 MEMORY-R  external.
               05 MAX_ADDR pic 9(5).
               05 MEMORY-ARR binary-char unsigned occurs 65536 times.
       linkage section.
           01 BYTE-VAL binary-char unsigned.
           01 DATA-ADDRESS binary-short unsigned.
       procedure division using by value BYTE-VAL, by value 
           DATA-ADDRESS.
           if BYTE-VAL > 255
               display "WRITE_BYTE FAIL: data larger than byte"
               stop run
           end-if.
           set DATA-ADDRESS up by 1.
           move BYTE-VAL to MEMORY-ARR (DATA-ADDRESS).
       end program WRITE_BYTE.
       