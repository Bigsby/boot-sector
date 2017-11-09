# boot-sector
## Fooling around with boot sectors

Download QEmu from [here](https://www.qemu.org/) > Emulator to run boot sectors.

Download HxD from [here](https://mh-nexus.de/en/downloads.php?product=HxD) > Raw Hexadecimal file editor.

Download NASM from [here](http://www.nasm.us/) > Assembler.

Download GnuWin32 CoreUtils from [here](http://gnuwin32.sourceforge.net/packages/coreutils.htm) > For tools like *od* (Octal dump).

## Run emulator with boot image by running:

```
qemu-system-x86_64 -drive format=raw,file=«imageFile»
```
*Ctrl+C* on calling console to terminate.

## Compile Assembly files
```
nasm «filename».asm -f bin -o «filename».bin
```
- *-f bin* tells the assembler to produce raw machine code so no linking metadata for code packages is generated.

## Dump binary file 
```
od -t x1 -A n «filename».bin
```
- *-t x1* = output in hexa of size 16 (C=char, S=short, L=long, I=int, D=double, 1=16b, 2=32b)
- *-A n* = file off-set (n=none)

Output should look like so:
```
 eb fe 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
*
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 55 aa
 ```

- *\** > zeros omitted for brevity)

## Convert raw disk image to VirtualBox .vdi
```
qemu-img convert -f raw -O vdi «filename».bin «filename».vdi
```

In **VirtualBox**:
1. Create new Virtual Machine
2. Type: *Other*
3. Version: *Other/Unknow*
   
   ...
4. *Use an existing virtual hard disk file* and select the generated file.


# Notes

**BIOS** - Basic Input/Output Software

**Boot Sector**
 - **Size**: 512b
- **Magic Number**: Last 2 bytes (512th & 512th) must be, respectively: x55, xaa

**ISR** - Interrupt Service Routing 
- **xcd x10**, **int 0x10** - screen - with **mov ah**, 0x0e - for *scrolling teletype*

**Memory after boot is loaded**
- x0 - (BIOS) Interrupt Ver - 1024B
- x400 - BIOS Data Area - 256B
- x500 - Free - 30464B
- x7c00 - Boot Sector - 512B
- x7e00 - Free - 635312B (638KB)
- x9fc00 - Extended BIOS Data Area - 639KB
- xa0000 - Video Memory - 128KB
- xC0000 - BIOS - 256KB
- x100000 and on- Free


# CPU intructions

- **xe9** - *jmp* - long jump (+/-32KB) - *xfffd* = offset -3, i.e., jump to jump (xe0), i.e., to itself
- **xeb** - *jmp* - short jump +/-128
- **db** - declare byte(s) of data

**Register mov's**
- **ax**
- **bh** (**bx** high byte) - xb4
- **al** (**ax** low byte) - xb0

**Accessing value**
- **[address]** - get value at address (pointer)

**Stack**
- **push** - add to *stack*
- **pop** - remove from *stack*
- **bp** - address of base of *stack*
- **sp** - address of top of *stack* (lower than **bp**)

**Cotnrol Structures**
- **cmp**
- **je** target - jump if equal (i.e. x == y) 
- **jne** target - jump if not equal (i.e. x != y) 
- **jl** target - jump if less than (i.e. x < y) 
- **jle** target - jump if less than or equal (i.e. x <= y) 
- **jg** target - jump if greater than (i.e. x > y) 
- **jge** target - jump if greater than or equal (i.e. x >= y)

**Functions**
- **ip** - instruction pointer - where *CPU* store the current instrunction address - **Not accessible**
- **call** - jump to a label setting **ip**
- **ret** - jump to back from **call** to next address after **call**
- **pusha** - push registers to *stack*
- **popa** - pop back registers from *stack*

# References

**Doc**

http://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf


**x86 op codes**

http://ref.x86asm.net/coder32.html

**Convert image files**
https://docs.openstack.org/image-guide/convert-images.html


