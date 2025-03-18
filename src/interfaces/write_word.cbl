       identification division.
       program-id. WRITE_WORD.
       environment division.
       data division.
       working-storage section.
           01 MEMORY-R  external.
               05 MAX_ADDR pic 9(5).
               05 MEMORY-ARR binary-char unsigned occurs 65536 times.
           01 UPPER binary-char unsigned value 0.
           01 LOWER binary-char unsigned value 0.
       linkage section.
           01 WORD-VAL binary-short unsigned.
           01 DATA-ADDRESS binary-short unsigned.
       procedure division using by value WORD-VAL, by value 
           DATA-ADDRESS.
           divide WORD-VAL by 256 giving UPPER remainder LOWER.
           set DATA-ADDRESS up by 1.
      *    > Z80 CPU is little endian so yeah
           move LOWER to MEMORY-ARR (DATA-ADDRESS).
           set DATA-ADDRESS up by 1.
           move UPPER to MEMORY-ARR (DATA-ADDRESS).
       end program WRITE_WORD.
       