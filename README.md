# VC65X
6502, 6510 (including illegal opcodes), 65c02 and 65816 Development Environment for Visual Studio Code

![re](images/screenshot1.png)
## Features

* Syntax highlighting for ACME assembler files
* Integration of the ACME assembler
* Full debugging support for MOS 6502 CPU

## Requirements

There are no additional requirements or dependencies to operate this extension.

## Introduction and Basic Usage

The VC65X extension provides a convienient editing, build and run environment. This is done by providing syntax highlighting, automatic background compilation using the ACME assembler, an embedded 6502 CPU emulator.

### Syntax Highlighting

Support for ACME assember syntax is provided.

### Background Compilation

Whenever a `.asm` source file is modified and saved, it is automatically compiled to a plain `.bin` program file.

If compilation is successful, that program file can either be run/debugged with the embedded debugger based on a defined launch configuration (see *Debugger Launch Configuration*).

If compilation fails, the ACME outputs are shown in the diagnostics view.

### MOS 6502 CPU Emulator

The VC65X extension comes with a built-in 6502 CPU emulator that allows very fast edit-build-run cycles. It purely executes 6502 machine code as fast as possible - and integrates nicely to the Visual Studio Code debugger interface.

An active 6502 debugging session allows you to:

- define breakpoints
- inspect registers, addresses, values
- get hover information for many elements of the source code

## Preferences/Settings

To setup the VC65X development environment, go to Preferences>Settings and check the following settings:

> VC65X: Assembler Path

Path to assembler executable.

Example: `C:\Tools\vc65x\acme\acme.exe`

> VC65X: Assembler Arguments

Additional assembler command line options.

> VC65X: Auto Build

Enable auto build before running or debugging.

> VC65X: Background Build

Enable background build after source changes.

## Debugger Launch Configuration

In order to run a compiled 65X program (`.bin`) using the embedded 6502 CPU emulator, you have to create a launch configuration. Here is a small example:

    {
        "version": "0.2.0",
        "configurations": [
            {
                "type": "asm",
                "request": "launch",
                "name": "Launch Program",
                "pc": "0x0100",
                "base": "0x0000",
                "arch":"6502",
                "binary": "C:\\Work\\vc65x\\demo1\\.cache\\src\\test.bin"
            }
        ]
    }

> `type`: Launch type

Always needs to be "asm".

> `request`: Request type

Always use "launch" here.

> `name`: Launch configuration name

Any name you want to use is fine.

> `binary`: Path to a compiled 65X program

The default build output path is ".cache" within the workspace root folder.

> `pc`: Optional parameter to overwrite the start address of the 65X program

A 16-bit address in decimal or $hexadecimal form.

> `base`: Optional parameter to overwrite the base load address of the 65X program

A 16-bit address in decimal or $hexadecimal form.

> `arch`: Optional parameter to overwrite the CPU architecture of the emulator.

Select from "6502", "65C02" or "65816".

## Open Source

This package includes open source from other developers and I would like to thank all of those:

* Gregory Estrade - 6502.js: It was great to have your 6502 emulator to form the core of the debugger. Thank you for compressing the 6502 cpu in such a nice piece of software!
* Tony Landi - Acme Cross Assembler (C64): I started with the basic syntax definition for ACME from your package. Thanks for starting that!

## ToDo
- [X] Implement 65C02 variant
- [ ] Implement 65816 variant
- [ ] add [v6502r](https://github.com/floooh/v6502r) as emulation option
## Ideas Taken From
* Captain JiNX - VSCode KickAss (C64)
* Janne Hellsten - c64jasm

## Links

* VS64 - The C64 Development Environment : https://github.com/rosc77/vs64
* The ACME Cross-Assembler: https://sourceforge.net/projects/acme-crossass/
* VICE, the Versatile Commodore Emulator: http://vice-emu.sourceforge.net/
* C64 65XE Debugger: https://sourceforge.net/projects/c64-debugger/
* Cycle-accurate 6502 emulator in Javascript: https://github.com/Torlus/6502.js
* set of functional tests for the 6502/65C02 type processors: https://github.com/Klaus2m5/6502_65C02_functional_tests
* ideas for system-level support : https://github.com/LowLevelJavaScript/16-Bit-Virtual-Machine
* nice extension documentation ideas: https://github.com/prb28/vscode-amiga-assembly
