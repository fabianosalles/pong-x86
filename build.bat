@echo off
if exist bin (
    rmdir bin /q /s
)
mkdir bin
fasm pong.asm bin/pong.com
