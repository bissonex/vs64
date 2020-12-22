//
// Emulator MOS 6502 System
//

//const path = require('path');
//const fs = require('fs');
//const process = require('process');

//-----------------------------------------------------------------------------------------------//
// Init module
//-----------------------------------------------------------------------------------------------//
// eslint-disable-next-line
BIND(module);

const fs = require('fs');

//-----------------------------------------------------------------------------------------------//
// Required Modules
//-----------------------------------------------------------------------------------------------//
var Constants = require('src/constants');
const createMemory = require('./system/create-memory');
const CPU6502 = require('./system/cpu/cpu');
const CPU65C02 = require('./system/cpu/65C02_cpu');
const MemoryMapper = require('./system/memory-mapper.js');
const createScreenDevice = require('./system/peripherals/screen-device');

function getTime() {
    var t = process.hrtime();
    return t[0] * 1000000 + ((t[1] / 1000) | 0);
}

//-----------------------------------------------------------------------------------------------//
// Emulator
//-----------------------------------------------------------------------------------------------//

class Emulator {

    constructor(session) {
        this._session = session;

        this._MM = new MemoryMapper();
        this._memory = createMemory(2**16);
        this._MM.map(this._memory, 0, 0xffff);

        // Map 0xFF bytes of the address space to an "output device" - just stdout
        this._MM.map(createScreenDevice(), 0x3000, 0x30ff, true);

        this._writableBytes = new Uint8Array(this._memory.buffer);


        //this._cpu = new CPU65C02(this._MM);

        //this.init();
    }

    init(forcedCpuArchitecture) {

        if (null != forcedCpuArchitecture) {
            switch (forcedCpuArchitecture) {
                case "6502":
                    this._cpu = new CPU6502(this._MM);
                    break;

                case "65C02":
                    this._cpu = new CPU65C02(this._MM);
                default:
                    break;
            }

        } else {
            this._cpu = new CPU6502(this._MM);
        }
        this._running = false;
        this._prg = null;
    }

    on(eventName, eventFunction) {
        if (null == this._eventMap) {
            this._eventMap = [];
        }

        this._eventMap[eventName] = eventFunction;
    }

    fireEvent(eventName, arg1, arg2, arg3) {
        if (null == this._eventMap) return null;

        var eventFunction = this._eventMap[eventName];
        if (null == eventFunction) return null;

        return eventFunction(arg1, arg2, arg3);
    }

    getStats() {

        var stats = {
            PC: this._cpu.PC,
            registers: {
                A: this._cpu.A,
                X: this._cpu.X,
                Y: this._cpu.Y,
                S: this._cpu.S
            },
            flags: {
                N: this._cpu.N,
                Z: this._cpu.Z,
                B: this._cpu.B,
                C: this._cpu.C,
                V: this._cpu.V,
                I: this._cpu.I,
                D: this._cpu.D
            },
            irq: this._cpu.irq,
            nmi: this._cpu.nmi,
            opcode: this._cpu.opcode,
            cycles: this._cpu.cycles,
        };

        return stats;
    }

    async start(continueExecution) { // jshint ignore:line

        this._running = true;
        var thisInstance = this;

        var promise = new Promise(function (resolve, reject) {
            setTimeout(function () {
                thisInstance.run(true, resolve, continueExecution);
            }, 0);
        });

        return promise;
    }

    stop() { // jshint ignore:line

        this._running = false;

    }

    run(runAsync, resolve, continueExecution) {

        var result = {
            reason: Constants.InterruptReason.UNKNOWN
        };

        var session = this._session;

        var breakpoints = session._breakpoints;
        var breakpointIndex = 0;
        var nextBreakpoint = -1;

        var statementCounter = 0;

        var firstStepWithoutBreakpoint = (continueExecution ? true : false);

        var lastPC = 0;

        // execution is interrupted after a defined amount of time
        // to let JS proceed with other tasks from the queue
        var startTime = getTime();
        var endTime = 0;
        if (Constants.EmulatorIterationExecutionTime > 0) {
            endTime = startTime + Constants.EmulatorIterationExecutionTime * 1000;
        }
        var checkCounter = 0;

        while (true == this._running) {

            var pc = this._cpu.PC;

            if (null != breakpoints && !firstStepWithoutBreakpoint) {
                if (pc < lastPC) {
                    breakpointIndex = 0;
                }

                while (breakpointIndex < breakpoints.length &&
                    breakpoints[breakpointIndex].address.address < pc) {
                    breakpointIndex++;
                }

                var breakpoint = breakpoints[breakpointIndex];
                if (null != breakpoint && pc == breakpoint.address.address) {
                    if (null != breakpoint.logMessage) {
                        this.fireEvent('logpoint', breakpoint);
                    } else {
                        this.fireEvent('breakpoint', breakpoint);
                        result.reason = Constants.InterruptReason.BREAKPOINT;
                        break;
                    }
                }
            }

            lastPC = pc;

            //this.log();
            this._cpu.step();

            if (this.B) {
                this.fireEvent('break', pc);
                result.reason = Constants.InterruptReason.BREAK;
                break;
            }

            if (true == this.returnReached) {
                result.reason = Constants.InterruptReason.EXIT;
                break;
            }

            statementCounter++;
            if (Constants.EmulatorIterationMaxSteps > 0 &&
                statementCounter > Constants.EmulatorIterationMaxSteps) {
                result.reason = Constants.InterruptReason.YIELD;
                break;
            }

            checkCounter++;
            if (checkCounter >= 1000) {
                checkCounter = 0;
                if (endTime > 0) {
                    var currentTime = getTime();
                    if (currentTime >= endTime) {
                        //console.log("STATEMENTS BEFORE YIELD: " + statementCounter);
                        result.reason = Constants.InterruptReason.YIELD;
                        break;
                    }
                }
            }

            firstStepWithoutBreakpoint = false;
        }

        if (!this._running) {
            result.reason = Constants.InterruptReason.INTERRUPTED;
        }

        if (this._running && result.reason == Constants.InterruptReason.YIELD) {
            var thisInstance = this;
            if (Constants.EmulatorIterationSleepTime > 0) {
                setTimeout(function () { thisInstance.run(true, resolve); }, Constants.EmulatorIterationSleepTime);
            } else {
                process.nextTick(function () { thisInstance.run(true, resolve); });
            }
        } else if (resolve) {
            resolve(result);
        } else {
            return result;
        }
    }

    reset(startAddress) {

        this._cpu.reset();

        this._writableBytes.fill(0);

        if (null != startAddress) {
            // set reset vector to start address
            this.write(0xFFFD, (startAddress >> 8) & 0xFF);
            this.write(0xFFFC, (startAddress & 0xFF));
        }

        this._cpu.S = 0xFF; // initialize stack pointer
        this._cpu.PC = startAddress;
        this._cpu.opcode = this.read(this._cpu.PC);
        this._cpu.cycles = 0;
    }

    /**
     * Execute a single opcode
     */
    step() {
	    this._cpu.step();
    }


    read(addr) {

        if (addr < 0 || addr > 0xFFFF) {
            throw new Error('Illegal memory read at address: ' + addr.toString(16).toLowerCase());
        }

        //return this._memory[addr] & 0xFF;
        return this._writableBytes[addr];
    }

    write(addr, value) {
        if (addr < 0 || addr > 0xFFFF) {
            throw new Error('Illegal memory read at address: ' + addr.toString(16).toLowerCase());
        }
        //this._memory[addr] = (value & 0xFF);
        this._writableBytes[addr] = value;
    }

    loadProgram(filename, autoOffsetCorrection, forcedLoadAddress, forcedStartAddress) {

        var prg = null;

        try {
            prg = fs.readFileSync(filename);
        } catch (err) {
            if (err.code == 'ENOENT') {
                throw ("file " + filename + " does not exist");
            } else {
                throw ("unable to read file '" + filename + "'");
            }
        }

        this._prg = prg;

        this.injectProgram(prg, autoOffsetCorrection, forcedLoadAddress, forcedStartAddress);
    }

    injectProgram(prg, autoOffsetCorrection, forcedLoadAddress, forcedStartAddress) {

        var addr;
        var data;
        var startAddr;

        if (null != forcedLoadAddress) {
            addr = forcedLoadAddress;
            data=prg;
        } else {
            addr = ((prg[1] << 8) | prg[0]);
            data = prg.slice(2);
            startAddr = addr;
        }

        if (null != forcedStartAddress) {

            startAddr = forcedStartAddress;

        } else if (true == autoOffsetCorrection) {

            // skip if...
            // starts with valid next statement address
            //        and SYS basic comment
            //        and end of statement zero bytes
            //        !byte $0c,$08,$b5,$07,$9e,$20,$32,$30,$36,$32,$00,$00,$00
            //                              SYS       2   0   6   2

            var addrNextBasic = ((data[1] << 8) | data[0]);
            var maxHeaderBytes = 32;
            var delta = (addrNextBasic - addr);

            if (delta > 0 && delta < maxHeaderBytes) {

                // skip 2 address bytes of next basic token
                var ofs = 2;

                // scanning for "SYS" command 0x9e
                while (ofs < maxHeaderBytes) {
                    if (data[ofs] == 0x9e) break;
                    ofs++;
                }

                ofs++;

                // skip optional spaces
                while (data[ofs] == 0x20) {
                    ofs++;
                }

                // parse call address
                var addressCalc = 0;
                while (ofs < maxHeaderBytes) {
                    var c = data[ofs];
                    if (c < 0x30 || c > 0x39) break;
                    addressCalc = addressCalc * 10 + (data[ofs] - 0x30);
                    ofs++;
                }

                startAddr = addressCalc;
            }
        }

        this.reset(startAddr || 0);
        this._writableBytes.set(data, addr);
        this._cpu.opcode = this.read(this._cpu.PC);
    }
}

//-----------------------------------------------------------------------------------------------//
// Module Exports
//-----------------------------------------------------------------------------------------------//

module.exports = Emulator;
