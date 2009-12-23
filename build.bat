@echo off
set CYGWIN=nodosfilewarning
cd fsmaker
javac "fsmaker.java"
java fsmaker
cd ..
nasm build\sector.asm -f bin -o build\sector.bin
nasm build\kernel.asm -f bin -o build\kernel.bin -l build\kernel.lst
del SollerOS.bin
dd if=build\sector.bin of=SollerOS.bin bs=512
dd if=build\kernel.bin of=SollerOS.bin bs=512 seek=1
set /P %doneit="Press Enter."