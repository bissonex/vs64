var CPU65C02 = require('./65C02_cpu');
var CPU65816op = require('./65816_opcodes');

class CPU65816 extends CPU65C02{

    constructor(memory) {
        super(memory);

        for (const [i, v] of CPU65816op.entries()) {
            if (typeof v !== 'undefined') {
                this.opcodes.splice(i, 1, v);
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////////
    // Subroutines - addressing modes & flags
    ////////////////////////////////////////////////////////////////////////////////

	txy() {
		this.Y = this.X;
		this.fnz(this.Y);
	}

	tyx() {
		this.X = this.Y;
		this.fnz(this.X);
	}
}

////////////////////////////////////////////////////////////////////////////////
// CPU instantiation
////////////////////////////////////////////////////////////////////////////////

module.exports = CPU65816;
