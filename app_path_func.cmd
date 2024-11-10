@ECHO OFF
CLS

rem FOR /F "skip=2 tokens=1,2* USEBACKQ" %%N IN (`reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\%~1" /t REG_SZ  /v "Path"`) DO (
rem  IF /I "%%N" == "Path" (
rem   SET wherepath=%%P%~1
rem   GoTo Found
rem  )
rem )

rem FOR /F "tokens=* USEBACKQ" %%F IN (`where.exe %~1`) DO (
rem  SET wherepath=%%F
rem  GoTo Found
rem )

FOR /F "tokens=* USEBACKQ" %%F IN (`where.exe /R "%PROGRAMFILES%" %~1`) DO (
 SET wherepath=%%F
 GoTo Found
)

FOR /F "tokens=* USEBACKQ" %%F IN (`where.exe /R "%PROGRAMFILES(x86)%" %~1`) DO (
 SET wherepath=%%F
 GoTo Found
)

FOR /F "tokens=* USEBACKQ" %%F IN (`where.exe /R "%WINDIR%" %~1`) DO (
 SET wherepath=%%F
 GoTo Found
)

:Found
SET %2=%wherepath%
:End
