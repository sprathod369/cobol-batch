       IDENTIFICATION DIVISION.
       PROGRAM-ID. ProgB.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT DeptSalaryInputFile ASSIGN TO 'deptSalaryOutput.csv'
               ORGANIZATION IS LINE SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS IS InputFileStatus.
           SELECT DeptSalaryOutputFile ASSIGN TO 
           'salaryReport.csv'
               ORGANIZATION IS LINE SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS IS OutputFileStatus.

       DATA DIVISION.
       FILE SECTION.
       FD  DeptSalaryInputFile.
       01  DeptSalaryInputRecord.
           05 DeptName           PIC X(20).
           05 Separator          PIC X VALUE ','.
           05 DeptTotalSalary    PIC 9(9)V99.

       FD  DeptSalaryOutputFile.
       01  DeptSalaryOutputRecord.
           05 DeptName           PIC X(20).
           05 Separator          PIC X VALUE ','.
           05 DeptTotalSalary    PIC 9(9)V99.

       WORKING-STORAGE SECTION.
       01  EndOfFile             PIC X VALUE 'N'.
           88 EOF                 VALUE 'Y'.
           88 NotEOF              VALUE 'N'.
       01  InputFileStatus       PIC XX.
       01  OutputFileStatus      PIC XX.

       PROCEDURE DIVISION.
       OPEN INPUT DeptSalaryInputFile
       OPEN OUTPUT DeptSalaryOutputFile

       PERFORM UNTIL EOF
           READ DeptSalaryInputFile INTO DeptSalaryInputRecord
               AT END
                   SET EOF TO TRUE
               NOT AT END
                   MOVE DeptSalaryInputRecord TO DeptSalaryOutputRecord
                   WRITE DeptSalaryOutputRecord
           END-READ
       END-PERFORM

       CLOSE DeptSalaryInputFile
       CLOSE DeptSalaryOutputFile

       CALL 'ProgC' USING 'salaryReport.csv'
       STOP RUN.
