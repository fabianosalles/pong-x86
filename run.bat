@echo off

:check_parameters
    if [%1] == [] (
        echo [Source file not informed. Usage: run <program_name>]
        goto :eof
    )

:build
    call build.bat %1
    if %errorlevel% neq 0 (
        echo Cannot not run %1.
        goto :eof
    )

rem starts dosbox with the c: driver pointing to the ./bin directory
rem and runs the program from there
:run
    if exist bin/%1%.com (
        dosbox -noautoexec -c "mount c ./bin" -c "c:" -c "%1"
    )


