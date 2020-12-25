var WDC65C02 = require('./WDC65C02_cpu');
var WDC65816op = require('./WDC65816_opcodes');

class WDC65816 extends WDC65C02{

    constructor(memory) {
        super(memory);

        for (const [i, v] of WDC65816op.entries()) {
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

module.exports = WDC65816;
