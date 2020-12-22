////////////////////////////////////////////////////////////////////////////////
// Opcode table
////////////////////////////////////////////////////////////////////////////////

var CPU65C02op = new Array();

/*  AND iz  */ CPU65C02op[0x32] = function(m) { m.iz(); m.and(); };

/*  ADC iz  */ CPU65C02op[0x72] = function(m) { m.iz(); m.adc(); };

/*  BIT zp  */ CPU65C02op[0x34] = function(m) { m.zpx(); m.bit(); };
/*  BIT abs */ CPU65C02op[0x3C] = function(m) { m.abx(); m.bit(); };
/*  BIT zp  */ CPU65C02op[0x89] = function(m) { m.imm(); m.bit(); };

/*  BRA rel */ CPU65C02op[0x80] = function(m) { m.rel(); m.bra(); };

/*  CMP iz  */ CPU65C02op[0xC1] = function(m) { m.iz(); m.cmp(); };

/*! DEC A   */ CPU65C02op[0x3A] = function(m) { m.imp(); m.dea(); };

/*  EOR iz  */ CPU65C02op[0x41] = function(m) { m.iz(); m.eor(); };

/*! INC A   */ CPU65C02op[0x1A] = function(m) { m.imp(); m.ina(); };

/*  JMP indx */ CPU65C02op[0x7C] = function(m) { m.indx(); m.jmp(); };

/*  LDA iz  */ CPU65C02op[0xB2] = function(m) { m.iz(); m.lda(); };

/*  PHX     */ CPU65C02op[0xDA] = function(m) { m.imp(); m.phx(); };
/*  PHY     */ CPU65C02op[0x5A] = function(m) { m.imp(); m.phy(); };

/*  PLX     */ CPU65C02op[0xFA] = function(m) { m.imp(); m.plx(); };
/*  PLY     */ CPU65C02op[0x7A] = function(m) { m.imp(); m.ply(); };

/*  SBC iz  */ CPU65C02op[0xF2] = function(m) { m.iz(); m.sbc(); };

/*  STA iz  */ CPU65C02op[0x81] = function(m) { m.iz(); m.sta(); };

/*  TRB abs */ CPU65C02op[0x1C] = function(m) { m.abs(); m.trb(); };
/*  TRB zp  */ CPU65C02op[0x14] = function(m) { m.zp(); m.trb(); };

/*  TSB abs */ CPU65C02op[0x0C] = function(m) { m.abs(); m.tsb(); };
/*  TSB zp  */ CPU65C02op[0x04] = function(m) { m.zp(); m.tsb(); };

module.exports = CPU65C02op;