# Sample project for ZXSpectrum Next using Z88dk in VS Code
Simple example demonstrating [banked function calls](https://github.com/z88dk/z88dk/wiki/More-Than-64k), which allow code execution across different memory banks without manual bank switching. Note: Banked calls require the [z88dk nightly snapshot](http://nightly.z88dk.org/) from September 7th, 2025 or later.

## Debugging with `-debug` (C line information in the map file)

This branch builds with `-debug`. With `-debug`, z88dk writes the debug information directly into the linker map file (`build/main.map`):

- `__C_LINE_*` symbols: address of each C source line, including the level and block (scope) for sdcc, e.g.
  `__C_LINE_7_factorial_2ec... = $140000 ; addr, local, , factorial_c, PAGE_20_CODE, factorial.c::x::10000::1	:7`
- `__ASM_LINE_*` symbols: address of each assembler line that has a label.
- `__CDBINFO__*` symbols: the sdcc CDB records (functions, variables, types).

DeZog's "z88dkv2" configuration in [.vscode/launch.json](.vscode/launch.json) reads the .lis files and the map file. If the map file contains `__C_LINE_` symbols, DeZog uses them for the C line <-> address associations (exact, linked addresses). Labels, assembler lines and WPMEM/ASSERTION/LOGPOINT comments are still taken from the .lis files. Without `-debug` DeZog falls back to the C line references in the .lis files (`--c-code-in-asm`).

The addresses in the map file also carry the page of banked code (`0x14xxxx` for `PAGE_20_CODE`, `0x16xxxx` for `PAGE_22_CODE`, see [src/mmap.inc](src/mmap.inc)). This lets DeZog set breakpoints in, and step through, `factorial.c` and `fibonacci.c` even though both are mapped at `0x0000`.

Requirements:
- A z88dk nightly from 2026-04-21 or later (includes the `sdcc_debug` changes, the zpragma line fix and the ucpp line sync fix, see [this z88dk forum thread](https://www.z88dk.org/forum/viewtopic.php?t=12139)).
- A DeZog build that understands the `-debug` map file: branch [claude/z88dk-parser-v3-on-3.7.4](https://github.com/vmorilla/DeZog/tree/claude/z88dk-parser-v3-on-3.7.4) of vmorilla/DeZog (based on DeZog 3.7.4, works with the CSpect DeZogPlugin speaking DZRP 2.0). Build it with `npm ci && npx @vscode/vsce package` and install the resulting `.vsix` with "Extensions: Install from VSIX...".

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