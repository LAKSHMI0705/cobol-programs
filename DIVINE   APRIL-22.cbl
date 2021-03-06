      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. stdmarks.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT STDFILE
           ASSIGN TO 'C:\Users\Manipal\Desktop\divine\STD.txt'
           ORGANISATION IS LINE SEQUENTIAL
           FILE STATUS IS WS-STAT.
       DATA DIVISION.
       FILE SECTION.
       FD STDFILE.
       01 STD-REC.
           05 stud-id     pic 99.
           05 stud-gender pic x.
              88 validg value 'M' 'F'.
           05 stud-marks  pic 999.
       WORKING-STORAGE SECTION.
       77 WS-STAT           PIC 99.
       77 WS-MALES          PIC 99  VALUE ZERO.
       77 WS-FEMALES        PIC 99  VALUE ZERO.
       77 WS-MTMARKS        PIC 999 VALUE ZERO.
       77 WS-FTMARKS        PIC 999 VALUE ZERO.
       77 WS-MMARKS         PIC 999 VALUE ZERO.
       77 WS-SMARKS         PIC 999 VALUE ZERO.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           OPEN INPUT STDFILE
           IF (WS-STAT = 00) THEN
                PERFORM READ-PARA thru READ-EXIT
                PERFORM COMPUTE-PARA
                PERFORM CLOSE-PARA
           END-IF
           DISPLAY "MALES-" WS-MALES "TOTAL MARKS SCORED-" WS-MTMARKS
           DISPLAY "FEMALES-" WS-FEMALES "TOTAL MARKS SCORED-"WS-FTMARKS
             STOP RUN.
       READ-PARA.
           PERFORM UNTIL WS-STAT NOT = 00
           READ STDFILE
           END-READ
           IF (WS-STAT NOT = 10) THEN
               PERFORM COMPUTE-PARA
           END-IF
           END-PERFORM.
       READ-EXIT.
           EXIT.
       COMPUTE-PARA.
           IF (stud-gender = 'M') THEN
               ADD 1 TO WS-MALES
               MOVE WS-MTMARKS              TO WS-MMARKS
               MOVE stud-marks              TO WS-SMARKS
               ADD WS-SMARKS                TO WS-MMARKS GIVING WS-MTMARKS
           ELSE
             IF (stud-gender = 'F') THEN
               ADD 1 TO WS-FEMALES
               MOVE WS-FTMARKS              TO WS-MMARKS
               MOVE stud-marks              TO WS-SMARKS
               ADD WS-SMARKS                TO WS-MMARKS GIVING WS-FTMARKS
             ELSE
                  DISPLAY "INVALID GENDER"
             END-IF
           END-IF.
       CLOSE-PARA.
           CLOSE STDFILE.
       END PROGRAM stdmarks.
