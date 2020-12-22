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

	indx() {
		var a = this.read(this.PC++);
        a |= (this.read(this.PC++) << 8);
        this.addr += this.X;
		this.addr = this.read(a);
		this.addr |= (this.read((a & 0xFF00) | ((a + 1) & 0xFF)) << 8);
		this.cycles += 6;
	}

    iz() {
		var a = this.read(this.PC++) & 0xFF;
        this.addr |= (this.read((a & 0xFF00) | ((a + 1) & 0xFF)) << 8);
        if (this.D) {
            this.cycles += 5;
        } else {

        }
    }

    bra() { this.branch(true); }

    dea() {
		this.A = (this.A - 1) & 0xFF;
		this.fnz(this.A);
    }

    ina() {
	    this.A = (this.A + 1) & 0xFF;
	    this.fnz(this.A);
    }

	phx() {
		this.write(this.S + 0x100, this.X);
		this.S = (this.S - 1) & 0xFF;
		this.cycles++;
    }

	phy() {
		this.write(this.S + 0x100, this.Y);
		this.S = (this.S - 1) & 0xFF;
		this.cycles++;
    }

	plx() {
		this.S = (this.S + 1) & 0xFF;
		this.X = this.read(this.S + 0x100);
		this.fnz(this.X);
		this.cycles += 2;
    }

	ply() {
		this.S = (this.S + 1) & 0xFF;
		this.Y = this.read(this.S + 0x100);
		this.fnz(this.Y);
		this.cycles += 2;
    }

	trb() {
        this.tmp = this.read(this.addr);
        this.Z = ((this.tmp & this.A) == 0) ? 1 : 0;
        this.tmp = this.tmp & ~this.A;
        this.write(this.addr, this.tmp);
	}

	tsb() {
        this.tmp = this.read(this.addr);
        this.Z = ((this.tmp & this.A) == 0) ? 1 : 0;
        this.tmp = this.tmp | this.A;
        this.write(this.addr, this.tmp);
	}
}

////////////////////////////////////////////////////////////////////////////////
// CPU instantiation
////////////////////////////////////////////////////////////////////////////////

module.exports = CPU65C02;
