var CPU6502 = require('./cpu');
var CPU65C02op = require('./65C02_opcodes');

class CPU65C02 extends CPU6502{

    constructor(memory) {
        super(memory);

        for (const [i, v] of CPU65C02op.entries()) {
            if (typeof v !== 'undefined') {
                this.opcodes.splice(i, 1, v);
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////////
    // Subroutines - addressing modes & flags
    ////////////////////////////////////////////////////////////////////////////////

    ina() {
	    this.A = (this.A + 1) & 0xFF;
	    this.fnz(this.A);
    }

}

////////////////////////////////////////////////////////////////////////////////
// CPU instantiation
////////////////////////////////////////////////////////////////////////////////

module.exports = CPU65C02;
