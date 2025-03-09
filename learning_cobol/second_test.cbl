       identification division.
       program-id. sec.
       environment division.
       data division.
       working-storage section.
           01 DEF-X pic X value 'a'.
           01 DEF-NUM pic 9(3) comp value 255.
       procedure division.
           display "Second program".
           compute DEF-NUM = DEF-NUM + 1.
           display "NUM: ", DEF-NUM.

           display "X: ", function numval(DEF-X).
           call "hello_world".
      *    stop run.
       end program sec.
