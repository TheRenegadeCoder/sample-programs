        IDENTIFICATION DIVISION.
        PROGRAM-ID. BAKLAVA.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
          01 BAKLAVA-VARIABLES.
            03 NUM            PIC S9(2).
            03 NUM-SPACES     PIC S9(2).
            03 NUM-STARS      PIC S9(2).
          01 REPEAT-VARIABLES.
            03 NUM-REPEATS    PIC S9(2).
            03 REPEAT-CHAR    PIC X(1).

        PROCEDURE DIVISION.
            PERFORM VARYING NUM FROM 0 BY 1 UNTIL NUM > 20
                COMPUTE NUM-SPACES = FUNCTION ABS(NUM - 10)
                COMPUTE NUM-STARS = 20 - 2 * NUM-SPACES

      * Display NUM-SPACES " "
                MOVE " " TO REPEAT-CHAR
                MOVE NUM-SPACES TO NUM-REPEATS
                PERFORM DISPLAY-REPEAT-STRING

      * Display NUM-STARS "*"
                MOVE "*" TO REPEAT-CHAR
                MOVE NUM-STARS TO NUM-REPEATS
                PERFORM DISPLAY-REPEAT-STRING

      * Display newline
                DISPLAY "*"
            END-PERFORM
            STOP RUN.

        DISPLAY-REPEAT-STRING.
            PERFORM UNTIL NUM-REPEATS <= 0
                DISPLAY REPEAT-CHAR NO ADVANCING
                SUBTRACT 1 FROM NUM-REPEATS
            END-PERFORM
            EXIT.
