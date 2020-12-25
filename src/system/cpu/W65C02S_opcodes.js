////////////////////////////////////////////////////////////////////////////////
// Opcode table
////////////////////////////////////////////////////////////////////////////////

var W65C02Sop = new Array();

// STP stops the clock input of the 65C02, effectively shutting down the 65C02
// until a hardware reset occurs (i.e. the RES pin goes low).
/*  STP imp  */ W65C02Sop[0xDB] = function(m) { m.imp(); m.nop(); };

// WAI puts the 65C02 into a low power sleep state until a
// hardware interrupt occurs, i.e. an IRQ, NMI, or RESET.
/*  WAI imp  */ W65C02Sop[0xCB] = function(m) { m.imp(); m.nop(); };

module.exports = W65C02Sop;