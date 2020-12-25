var R65C02 = require('./R65C02_cpu');
var W65C02Sop = require('./W65C02S_opcodes');

class W65C02S extends R65C02{

    constructor(memory) {
        super(memory);

        for (const [i, v] of W65C02Sop.entries()) {
            if (typeof v !== 'undefined') {
                this.opcodes.splice(i, 1, v);
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////////
    // Subroutines - addressing modes & flags
    ////////////////////////////////////////////////////////////////////////////////
    // stp() { this.nop; }

    // wai() { this.nop; }

}

////////////////////////////////////////////////////////////////////////////////
// CPU instantiation
////////////////////////////////////////////////////////////////////////////////

module.exports = W65C02S;
