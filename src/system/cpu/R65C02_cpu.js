var CPU6502 = require('./cpu');
var R65C02op = require('./R65C02_opcodes');

class R65C02 extends CPU6502{

    constructor(memory) {
        super(memory);

        for (const [i, v] of R65C02op.entries()) {
            if (typeof v !== 'undefined') {
                this.opcodes.splice(i, 1, v);
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////////
    // Subroutines - addressing modes & flags
    ////////////////////////////////////////////////////////////////////////////////

	abxpi() {
		var paddr = this.read(this.PC++);
		paddr |= (this.read(this.PC++) << 8);
        this.addr = (paddr + this.X);
		var paddr = this.read(this.addr++);
        paddr |= (this.read(this.addr) << 8);
        this.addr = paddr;
		this.cycles += 5;
    }

    iz() {
		var a = this.read(this.PC++);
		var paddr = (this.read((a + 1) & 0xFF) << 8) | this.read(a);
		this.addr = paddr;
		if ((paddr & 0x100) != (this.addr & 0x100)) {
			this.cycles += 6;
		} else {
			this.cycles += 5;
		}
    }

    // JMP (abs) had a bug when the low byte of the operand was $FF, e.g. JMP ($12FF).
    // In this example, the low byte of the address to jump to was taken from $12FF,
    // but the high byte of the address to jump to was taken from $1200 rather than $1300.
    // This bug has been fixed on the 65C02, thus in the example the high byte is taken from $1300 rather than $1200.
    ind() {
		var a = this.read(this.PC++);
		a |= (this.read(this.PC++) << 8);
		this.addr = this.read(a);
		this.addr |= (this.read(a + 1) << 8);
		this.cycles += 6;
	}

    adc() {
		var v = this.read(this.addr);
		var c = this.C;
		var r = this.A + v + c;
		if (this.D) {
			var al = (this.A & 0x0F) + (v & 0x0F) + c;
			if (al >= 0x0A) al = ((al + 0x06) & 0x0F) + 0x10;
            var ah = (this.A & 0xF0) + (v & 0xF0) + al;
            if (ah >= 0xA0) ah += 0x60;
			this.Z = ((ah & 0xFF) == 0) ? 1 : 0;
			this.N = ((ah & 0x80) != 0) ? 1 : 0;
			this.V = ((~(this.A ^ v) & (this.A ^ ah) & 0x80) != 0) ? 1 : 0;
			// if (ah >= 0xA0) ah += 0x60;
			this.C = (ah >= 0x100) ? 1 : 0;
			this.A = ah & 0xFF;
		} else {
			this.Z = ((r & 0xFF) == 0) ? 1 : 0;
			this.N = ((r & 0x80) != 0) ? 1 : 0;
			this.V = ((~(this.A ^ v) & (this.A ^ r) & 0x80) != 0) ? 1 : 0;
			this.C = ((r & 0x100) != 0) ? 1 : 0;
			this.A = r & 0xFF;
		}
    }

	sbc() {
		var v = this.read(this.addr);
		var c = 1 - this.C;
        var r = this.A - v - c;

		if (this.D) {
			var al = (this.A & 0x0F) - (v & 0x0F) + this.C - 1;
            var ah = this.A - v + this.C - 1;
            if (ah < 0) ah = ah - 0x60;
            if (al < 0) ah = ah - 0x06;
			this.Z = ((ah & 0xFF) == 0) ? 1 : 0;
            this.N = ((ah & 0x80) != 0) ? 1 : 0;
            this.C = ((r & 0x100) != 0) ? 0 : 1;
            this.V = (((this.A ^ v) & (this.A ^ r) & 0x80) != 0) ? 1 : 0;
			this.A = ah & 0xFF;
		} else {
			this.Z = ((r & 0xFF) == 0) ? 1 : 0;
            this.N = ((r & 0x80) != 0) ? 1 : 0;
            this.C = ((r & 0x100) != 0) ? 0 : 1;
            this.V = (((this.A ^ v) & (this.A ^ r) & 0x80) != 0) ? 1 : 0;
			this.A = r & 0xFF;
        }

    }

    bbr(i, val) {
        this.branch((val & (1 << i)) == 0);
    }

    bbs(i, val) {
        this.branch((val & (1 << i)) != 0);
    }

	biti() {
		this.tmp = this.read(this.addr);
		// this.N = ((this.tmp & 0x80) != 0) ? 1 : 0;
		// this.V = ((this.tmp & 0x40) != 0) ? 1 : 0;
		this.Z = ((this.tmp & this.A) == 0) ? 1 : 0;
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

    rmb(i) {
        this.tmp = this.read(this.addr);
        this.tmp = (this.tmp & ~(1 << i)) & 0xFF;
        this.write(this.addr, this.tmp);
        this.cycles += 5;
    }

    // eor() {
	// 	this.A ^= this.read(this.addr);
	// 	this.fnz(this.A);
	// }

    smb(i) {
        this.tmp = this.read(this.addr);
        this.tmp = (this.tmp | (1 << i)) & 0xFF;
        this.write(this.addr, this.tmp);
        this.cycles += 5;
    }

    stz() {
        this.write(this.addr, 0);
        this.cycles += 4;
	}

	trb() {
        this.tmp = this.read(this.addr);
        this.Z = ((this.tmp & this.A) == 0) ? 1 : 0;
        this.tmp = this.tmp & ~this.A;
        this.write(this.addr, this.tmp);
        this.cycles += 5;
    }

	tsb() {
        this.tmp = this.read(this.addr);
        this.Z = ((this.tmp & this.A) == 0) ? 1 : 0;
        this.tmp = this.tmp | this.A;
        this.write(this.addr, this.tmp);
        this.cycles += 5;
    }
}

////////////////////////////////////////////////////////////////////////////////
// CPU instantiation
////////////////////////////////////////////////////////////////////////////////

module.exports = R65C02;
