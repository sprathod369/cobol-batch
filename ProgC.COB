       IDENTIFICATION DIVISION.
       PROGRAM-ID. ProgC.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT EmpDataFile ASSIGN TO 'salaryReport.csv'
               ORGANIZATION IS LINE SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS IS FileStatus.

       DATA DIVISION.
       FILE SECTION.
       FD  EmpDataFile.
       01  EmpDataRecord.
           05  DeptName           PIC X(20).
           05  Separator          PIC X VALUE ','.
           05  Salary             PIC 9(7).

       WORKING-STORAGE SECTION.
       01  EndOfFile             PIC X VALUE 'N'.
           88 EOF                 VALUE 'Y'.
           88 NotEOF              VALUE 'N'.
       01  FileStatus            PIC XX.
       01  TotalSalary           PIC 9(5) VALUE 0.
       01  LineBuffer            PIC X(100).

       PROCEDURE DIVISION.
       OPEN INPUT EmpDataFile

       PERFORM UNTIL EOF
           READ EmpDataFile INTO LineBuffer
               AT END
                   SET EOF TO TRUE
               NOT AT END
                   PERFORM ParseAndAccumulateSalary
           END-READ
       END-PERFORM

       CLOSE EmpDataFile

       DISPLAY "Total Salary: " TotalSalary

       STOP RUN.

       ParseAndAccumulateSalary.
           UNSTRING LineBuffer DELIMITED BY ',' 
               INTO DeptName, Salary
           
           ADD Salary TO TotalSalary.
