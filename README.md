# Sample project for ZXSpectrum Next using Z88dk in VS Code
Simple example demonstrating [banked function calls](https://github.com/z88dk/z88dk/wiki/More-Than-64k), which allow code execution across different memory banks without manual bank switching. Note: Banked calls require the [z88dk nightly snapshot](http://nightly.z88dk.org/) from September 7th, 2025 or later.

## Features
- Debuggin capabilities with [Dezog](https://github.com/maziac/DeZog)
- Problem matcher for error messages
- Relatively good intellisense
- Example Makefile
- Banked function calls

## Files explained

- [Root Makefile](Makefile): delegates build rules to the Makefile in the 'src' folder. This structure allows the project to scale, supporting additional folders with specialized Makefiles as needed.
****
- [build](build): output folder for the resulting .nex and accompanying .map and .lis file.

- [.vscode/launch.json](.vscode/launch.json): configuration of DeZog debugging options

- [.vscode/c_cpp_properties.json](.vscode/c_cpp_properties.json): configuration of the C extension in code for proper syntax checks

- [.vscode/tasks.json](.vscode/tasks.json): configuration of the build task (launching the Makefile) with a problem matcher adapted to the output of Z88dk

- [.vscode/settings](.vscode/settings): settings of the editor, included the automatic launch of the building process

- [src](src): folder with source files. Object (.obj) and List (.lis) files are generated in this folder (but are excluded from version control in .gitignore).

- [src/zpgrama.inc](src/zpgrama.inc): file for pragma output values that enable the customisation of the CRT (C runtime)

- [src/mmap.inc](src/mmap.inc): This file defines the logical memory map for the project, specifying how code and data sections are organized across different banks and pages in the ZX Spectrum Next’s memory and its base address for that section in the target memory map. The address is typically encoded as 0xPPAAAA, where PP is the page and AAAA is the address in the memory map.

- [src/main.c](src/main.c): Example program calling two functions in different memory banks (factorial and fibonacci). The example shows how no wrapping to switch banks is necessary.

- [src/factorial.h](src/factorial.h): Header file declaring the factorial function, which shows the usage of the __banked qualifier.

- [src/fibonacci.h](src/fibonacci.h): Header file declaring the fibonacci function, which shows the usage of the __banked qualifier.

- [src/factorial.c](src/factorial.c): Implementation of the factorial function. To make it banked, simply add the `__banked` qualifier and use `#pragma codeseg` to specify the memory page for placement; no other changes are required.
  
- [src/fibonacci.c](src/fibonacci.c): Implementation of the fibonacci function. To make it banked, simply add the `__banked` qualifier and use `#pragma codeseg` to specify the memory page for placement; no other changes are required.

- [src/interrupts.c](src/interrupts.c): Sets up IM 2 with the vector table at `0xFD00` and the handler outside `0x0000-0x3FFF`. This is needed because banked code is paged into `0x0000-0x3FFF` (`CLIB_BANKING_SEGMENT = 0`), replacing the ROM and its IM 1 handler at `0x0038`: an interrupt while a banked function runs would otherwise jump into the banked page and crash the program. Stopping at a breakpoint inside a banked function makes this almost certain to happen when execution is resumed.