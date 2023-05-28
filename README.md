# Visual Studio build script

Custom PowerShell build script to compile Windows C/C++ projects without relying on Visual Studio or MSBuild project files, intended for simple projects.

This repo is bundled with an application for testing the build system that display a simple message box.

## Requirements

- [Build Tools for Visual Studio](https://aka.ms/vs/17/release/vs_BuildTools.exe)
- PowerShell

## Usage

To build a project, navigate to the project directory and run the build script:

```
.\build.ps1
```

To remove all generated files and directories, run the build script with the `clean` argument:

```
.\build.ps1 clean
```

## Configuration

The build script can be configured by editing the variables defined at the top of the file.

The following options are currently supported:

- **source directory**: directory containing the C/C++ source files
- **build directory**: directory where the intermediate object files will be generated during the compilation process
- **output directory**: directory where the final binary will be placed after compilation
- **executable name**: name of the final executable
- **compiler flags**: flags that will be passed to `cl.exe`
- **linker flags**: flags that will be passed to `link.exe`
- **static libraries**: static libraries to be linked with the binary
- **platform**: the target architecture, either `x86` or `amd64`