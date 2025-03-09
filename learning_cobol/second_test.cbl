       identification division.
       program-id. sec.
       environment division.
       data division.
       working-storage section.
           01 DEF-X pic X value 'a'.
           01 DEF-NUM pic 9(3) comp value 255.
           01 DEF-CHR binary-char unsigned value 255.

           01 TEST-XAR pic X(5).
           01 TEST-BCAR binary-char occurs 5 times.
       procedure division.
           display "Second program".
           compute DEF-NUM = DEF-NUM + 1.
           add 1 to DEF-CHR.
           display "NUM: ", DEF-NUM.
           display "CHR: ", DEF-CHR.
           move DEF-CHR to DEF-X.
           move "asdfa" to TEST-XAR.
           move TEST-XAR to TEST-BCAR.
           display "X: ", function numval(DEF-X).
           call "hello_world".
      *    stop run.
       end program sec.
