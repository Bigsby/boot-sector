nasm %1.asm -f bin -o %1.bin                    :: compile assembly to machine code
if %errorlevel% neq 0 exit /b %errorlevel%      :: exit if there are errors
qemu-system-i386 -drive format=raw,file=%1.bin  :: run machine with created raw disk