       IDENTIFICATION DIVISION.
           PROGRAM-ID. FIZZ-BUZZ.
       	   AUTHOR. KAAMKIYA.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           01 COUNTER       PIC 999 VALUE 1.
           01 FIZZ          PIC 999 VALUE 1.
           01 BUZZ          PIC 999 VALUE 1.
           01 RESULT-STRING PIC xxx.
           01 SPACE-COUNT   PIC 99 VALUE ZERO.
       PROCEDURE DIVISION.
           PERFORM 100 TIMES
                IF FIZZ = 3
                    THEN IF BUZZ = 5
                        THEN DISPLAY "FizzBuzz"
                        COMPUTE BUZZ = 0
                        ELSE DISPLAY "Fizz"
                        END-IF
                        COMPUTE FIZZ = 0
                    ELSE IF BUZZ = 5
                        THEN DISPLAY "Buzz"
                        COMPUTE BUZZ = 0
                    ELSE
                        MOVE 0 TO SPACE-COUNT
                        INSPECT COUNTER TALLYING SPACE-COUNT
                            FOR LEADING ZEROS
                        MOVE COUNTER
                            (SPACE-COUNT + 1 : 
                                LENGTH OF COUNTER - SPACE-COUNT)
                                    TO RESULT-STRING
                        DISPLAY RESULT-STRING
                    END-IF
                END-IF
                ADD 1 TO COUNTER
                ADD 1 TO FIZZ
                ADD 1 TO BUZZ
           END-PERFORM
       STOP RUN.
