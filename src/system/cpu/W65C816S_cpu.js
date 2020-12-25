var W65C02S = require('./W65C02S_cpu');
var W65C816Sop = require('./W65C816S_opcodes');

class W65C816S extends W65C02S{

    constructor(memory) {
        super(memory);

        for (const [i, v] of W65C816Sop.entries()) {
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

module.exports = W65C816S;
