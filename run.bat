@echo off

call build.bat

if exist bin/pong.com (
    dosbox -noautoexec -c "mount c ./bin" -c "c:" -c "pong"
)
