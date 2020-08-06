@echo off

:check_parameters
    if [%1] == [] (
        echo [Source file not informed. Usage: build <program_name>] 
        exit /b 1
    )

:clean_bin_directory
    if exist bin (
        rmdir bin /q /s
    )
    mkdir bin

:assemble
    fasm %1.asm bin/%1.com
    if %errorlevel% equ 0 (
        echo %1 built with success!
    )
    exit /b %errorlevel%
