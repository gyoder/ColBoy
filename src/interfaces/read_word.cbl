       identification division.
       program-id. READ_WORD.
       environment division.
       data division.
       working-storage section.
           01 MEMORY-R  external.
               05 MAX_ADDR pic 9(5).
               05 MEMORY-ARR binary-char unsigned occurs 65536 times.
       linkage section.
           01 RET-VAL binary-short unsigned.
           01 DATA-ADDRESS binary-short unsigned.
       procedure division using by reference RET-VAL, by value 
           DATA-ADDRESS.
           set DATA-ADDRESS up by 2.
           move MEMORY-ARR (DATA-ADDRESS) to RET-VAL.
           multiply 256 by RET-VAL.
           set DATA-ADDRESS down by 1.
           add MEMORY-ARR (DATA-ADDRESS) to RET-VAL.
       end program READ_WORD.
       