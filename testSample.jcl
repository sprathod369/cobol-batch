//CALCJOB   JOB (ACCT),'SALARY CALCULATION',CLASS=A,MSGCLASS=A
//STEP1     EXEC PGM=ProgA,PARM='EmployeeData.csv'
//STEPLIB   DD  DSN=your.cobol.loadlib,DISP=SHR
//SYSOUT    DD  SYSOUT=A
//SYSPRINT  DD  SYSOUT=A
//INPUT     DD  DSN=your.input.dataset(EmployeeData.csv),DISP=SHR
//OUTPUT    DD  DSN=your.output.dataset,DISP=NEW,SPACE=(CYL,(5,5)),UNIT=SYSDA
//SYSIN     DD  DUMMY
