# Sample project for ZXSpectrum Next using Z88dk in VS Code

## Features
- Debuggin capabilities with Dezog
- Problem matcher for error messages
- Relatively good intellisense
- Example Makefile

Currently, using a forked version of DeZog: [https://github.com/vmorilla/DeZog/releases/tag/3.5.2-rc1-vm](https://github.com/vmorilla/DeZog/releases/tag/3.5.2-rc1-vm)

## Files explained

- [Root Makefile](Makefile): basically lunch rules in Makefile in the 'src' folder. The idea is that a project could become bigger with additional and require more specialized Makefiles per folder.

- [src](src): folder with source files. Object (.obj) and List (.lis) files are generated in this folder (but are excluded from version control in .gitignore).

- [build](build): output folder for the resulting .nex and accompanying .map and .lis file.

- [.vscode/launch.json](.vscode/launch.json): configuration of DeZog debugging options

- [.vscode/c_cpp_properties.json](.vscode/c_cpp_properties.json): configuration of the C extension in code for proper syntax checks

- [.vscode/tasks.json](.vscode/tasks.json): configuration of the build task (launching the Makefile) with a problem matcher adapted to the output of Z88dk

- [.vscode/settings](.vscode/settings): settings of the editor, included the automatic launch of the building process




4000 = 0100 
8000 = 1000
C000 = 1100

MMU0 50 0101 0000
MMU1 51 0101 0001
MMU2 52 0101 0010
MMU3 53 0101 0011
M
