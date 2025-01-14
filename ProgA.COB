       IDENTIFICATION DIVISION.
       PROGRAM-ID. ProgA.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT EmployeeFile ASSIGN TO 'EmployeeData.csv'
               ORGANIZATION IS LINE SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS IS FileStatus.
           SELECT DeptSalaryFile ASSIGN TO 'deptSalaryOutput.csv'
               ORGANIZATION IS LINE SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS IS OutputStatus.

       DATA DIVISION.
       FILE SECTION.
       FD  EmployeeFile.
       01  EmployeeRecord.
           05 EmployeeID          PIC 9(5).
           05 Separator1          PIC X VALUE ','.
           05 EmployeeName        PIC X(30).
           05 Separator2          PIC X VALUE ','.
           05 EmployeeDeptName    PIC X(20).
           05 Separator3          PIC X VALUE ','.
           05 EmployeeSalary      PIC 9(5).

       FD  DeptSalaryFile.
       01  DeptSalaryRecord.
           05 DeptName           PIC X(20).
           05 Separator          PIC X VALUE ','.
           05 DeptTotalSalary    PIC 9(5).

       WORKING-STORAGE SECTION.
       01  EndOfFile             PIC X VALUE 'N'.
           88 EOF                 VALUE 'Y'.
           88 NotEOF              VALUE 'N'.
       01  FileStatus            PIC XX.
       01  OutputStatus          PIC XX.
       01  LineBuffer            PIC X(100).
       01  DeptCount             PIC 9(2) VALUE 0..
       01  DeptFound             PIC 9(1) VALUE 0.
       01  DepartmentTable.
           05  DeptEntry OCCURS 10 TIMES INDEXED BY
               DepartmentTable-DeptIndex.
               10  DeptNameTable   PIC X(20).
               10  DeptSalaryTable PIC 9(5) VALUE ZEROS.

       01  TempEmployeeID        PIC 9(5).
       01  TempEmployeeName      PIC X(30).
       01  TempEmployeeDeptName  PIC X(20).
       01  TempEmployeeSalary    PIC 9(5).

       PROCEDURE DIVISION.
       OPEN INPUT EmployeeFile
       OPEN OUTPUT DeptSalaryFile

       PERFORM UNTIL EOF
           READ EmployeeFile INTO LineBuffer
               AT END
                   SET EOF TO TRUE
               NOT AT END
                   PERFORM ParseAndAccumulateSalary
           END-READ
       END-PERFORM

       PERFORM WriteDeptSalaries

       CLOSE EmployeeFile
       CLOSE DeptSalaryFile
		
	   CALL 'ProgB' USING 'deptSalaryOutput.csv'.
	   
       STOP RUN.

       ParseAndAccumulateSalary.
           UNSTRING LineBuffer DELIMITED BY ',' 
               INTO TempEmployeeID, TempEmployeeName, 
                    TempEmployeeDeptName, 
                    TempEmployeeSalary
           DISPLAY "DEPT " TempEmployeeDeptName.
           DISPLAY "SAL " TempEmployeeSalary.
           MOVE 0 TO DeptFound
           DISPLAY "Dept COUNT " DeptCount.
           PERFORM VARYING DepartmentTable-DeptIndex FROM 1 BY 1 UNTIL 
                    DepartmentTable-DeptIndex > DeptCount
               DISPLAY "Dept Name " TempEmployeeDeptName

               IF TempEmployeeDeptName = 
                  DeptNameTable (DepartmentTable-DeptIndex)
                   MOVE DepartmentTable-DeptIndex TO DeptCount
                   MOVE 1 TO DeptFound
               END-IF
           END-PERFORM
           DISPLAY "Dept Found " DeptFound.
           DISPLAY "Dept COUNT " DeptCount.
           DISPLAY ""
           
           IF DeptFound = 0
               ADD 1 TO DeptCount
               MOVE TempEmployeeDeptName TO DeptNameTable (DeptCount)
               MOVE TempEmployeeSalary TO DeptSalaryTable (DeptCount)
           ELSE
               ADD TempEmployeeSalary TO DeptSalaryTable (DeptCount)
           END-IF.

       WriteDeptSalaries.
           PERFORM VARYING DepartmentTable-DeptIndex FROM 1 BY 1 UNTIL 
                    DepartmentTable-DeptIndex > DeptCount
               MOVE DeptNameTable (DepartmentTable-DeptIndex) TO 
               DeptName
               MOVE DeptSalaryTable (DepartmentTable-DeptIndex) TO
               DeptTotalSalary
               
               MOVE FUNCTION TRIM(DeptName) TO DeptName 
               STRING DeptName "," DeptTotalSalary INTO DeptSalaryRecord
               
               WRITE DeptSalaryRecord
           END-PERFORM.
