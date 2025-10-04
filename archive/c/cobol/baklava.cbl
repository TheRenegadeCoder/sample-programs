        IDENTIFICATION DIVISION.
        PROGRAM-ID. BAKLAVA.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
            01  NUM             PIC 9(2).
            01  NUM-SPACES      PIC 9(2).
            01  NUM-STARS       PIC 9(2).
            01  BAKLAVA-SPACES  PIC X(10) VALUE SPACES.
            01  BAKLAVA-STARS   PIC X(21) VALUE ALL "*".

        PROCEDURE DIVISION.
            PERFORM VARYING NUM FROM 0 BY 1 UNTIL NUM > 20
                COMPUTE NUM-SPACES = FUNCTION ABS(NUM - 10)
                COMPUTE NUM-STARS = 21 - 2 * NUM-SPACES

      * Display NUM-SPACES " " without newline
                DISPLAY BAKLAVA-SPACES(1:NUM-SPACES) NO ADVANCING

      * Display NUM-STARS "*" with newline
                DISPLAY BAKLAVA-STARS(1:NUM-STARS)
            END-PERFORM
            STOP RUN.
