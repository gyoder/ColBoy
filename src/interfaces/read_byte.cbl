       identification division.
       program-id. READ_BYTE.
       environment division.
       data division.
       working-storage section.
           01 MEMORY-R  external.
               05 MAX_ADDR pic 9(5).
               05 MEMORY-ARR binary-char unsigned occurs 65536 times.
       linkage section.
           01 RET-VAL binary-char unsigned.
           01 DATA-ADDRESS binary-short unsigned.
       procedure division using by reference RET-VAL, by value 
           DATA-ADDRESS.
           set DATA-ADDRESS up by 1.
           move MEMORY-ARR (DATA-ADDRESS) to RET-VAL.
       end program READ_BYTE.
       