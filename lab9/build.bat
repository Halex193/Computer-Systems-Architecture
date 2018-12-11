@echo off
nasm -f obj lab9.asm
nasm -f obj lab9_functions.asm
alink lab9.obj lab9_functions.obj -oPE -subsys console -entry start
pause
