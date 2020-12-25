////////////////////////////////////////////////////////////////////////////////
// Opcode table
////////////////////////////////////////////////////////////////////////////////

var WDC65C02op = new Array();

/*  AND iz  */ WDC65C02op[0x32] = function(m) { m.iz(); m.and(); };

/*  ADC iz  */ WDC65C02op[0x72] = function(m) { m.iz(); m.adc(); };

/*  BIT zp  */ WDC65C02op[0x34] = function(m) { m.zpx(); m.bit(); };
/*  BIT abs */ WDC65C02op[0x3C] = function(m) { m.abx(); m.bit(); };
/*  BIT zp  */ WDC65C02op[0x89] = function(m) { m.imm(); m.bit(); };

/*  BRA rel */ WDC65C02op[0x80] = function(m) { m.rel(); m.bra(); };

/*  CMP iz  */ WDC65C02op[0xD2] = function(m) { m.iz(); m.cmp(); };

/*! DEC A   */ WDC65C02op[0x3A] = function(m) { m.imp(); m.dea(); };

/*  EOR iz  */ WDC65C02op[0x52] = function(m) { m.iz(); m.eor(); };

/*! INC A   */ WDC65C02op[0x1A] = function(m) { m.imp(); m.ina(); };

/*  JMP indx */ WDC65C02op[0x7C] = function(m) { m.indx(); m.jmp(); };

/*  LDA iz  */ WDC65C02op[0xB2] = function(m) { m.iz(); m.lda(); };

/*  ORA iz  */ WDC65C02op[0x12] = function(m) { m.iz(); m.ora(); };

/*  PHX     */ WDC65C02op[0xDA] = function(m) { m.imp(); m.phx(); };
/*  PHY     */ WDC65C02op[0x5A] = function(m) { m.imp(); m.phy(); };

/*  PLX     */ WDC65C02op[0xFA] = function(m) { m.imp(); m.plx(); };
/*  PLY     */ WDC65C02op[0x7A] = function(m) { m.imp(); m.ply(); };

/*  SBC iz  */ WDC65C02op[0xF2] = function(m) { m.iz(); m.sbc(); };

/*  STA iz  */ WDC65C02op[0x92] = function(m) { m.iz(); m.sta(); };

/*  STZ abs */ WDC65C02op[0x9C] = function(m) { m.abs(); m.stz(); };
/*  STZ zp  */ WDC65C02op[0x64] = function(m) { m.zp(); m.stz(); };
/*  STZ abx */ WDC65C02op[0x9E] = function(m) { m.abxp(); m.stz(); };
/*  STZ zpx */ WDC65C02op[0x74] = function(m) { m.zpx(); m.stz(); };

/*  TRB abs */ WDC65C02op[0x1C] = function(m) { m.abs(); m.trb(); };
/*  TRB zp  */ WDC65C02op[0x14] = function(m) { m.zp(); m.trb(); };

/*  TSB abs */ WDC65C02op[0x0C] = function(m) { m.abs(); m.tsb(); };
/*  TSB zp  */ WDC65C02op[0x04] = function(m) { m.zp(); m.tsb(); };

////////////////////////////////////////////////////////////////////
// illegal opcodes perform a NOP.
//
// The following table (http://6502.org/tutorials/65c02opcodes.html)
// summarizes the unused opcodes of the 65C02.
// The first number is the size in bytes,
// and the second number is the number of cycles taken.
// After the second number, a lower case letter may be present;
// when it is present it indicates a footnote.

//     02     03     04     07     0B     0C     0F
//     -----  -----  -----  -----  -----  -----  -----
// 00  2 2    1 1    . .    1 1 a  1 1    . .    1 1 b
// 10  . .    1 1    . .    1 1 a  1 1    . .    1 1 b
// 20  2 2    1 1    . .    1 1 a  1 1    . .    1 1 b
// 30  . .    1 1    . .    1 1 a  1 1    . .    1 1 b
// 40  2 2    1 1    2 3    1 1 a  1 1    . .    1 1 b
// 50  . .    1 1    2 4    1 1 a  1 1    3 8    1 1 b
// 60  2 2    1 1    . .    1 1 a  1 1    . .    1 1 b
// 70  . .    1 1    . .    1 1 a  1 1    . .    1 1 b
// 80  2 2    1 1    . .    1 1 c  1 1    . .    1 1 d
// 90  . .    1 1    . .    1 1 c  1 1    . .    1 1 d
// A0  . .    1 1    . .    1 1 c  1 1    . .    1 1 d
// B0  . .    1 1    . .    1 1 c  1 1    . .    1 1 d
// C0  2 2    1 1    . .    1 1 c  1 1 e  . .    1 1 d
// D0  . .    1 1    2 4    1 1 c  1 1 f  3 4    1 1 d
// E0  2 2    1 1    . .    1 1 c  1 1    . .    1 1 d
// F0  . .    1 1    2 4    1 1 c  1 1    3 4    1 1 d
//
// a) RMB instruction on Rockwell 65C02 and WDC 65C02
// b) BBR instruction on Rockwell 65C02 and WDC 65C02
// c) SMB instruction on Rockwell 65C02 and WDC 65C02
// d) BBS instruction on Rockwell 65C02 and WDC 65C02
// e) WAI instruction on WDC 65C02
// f) STP instruction on WDC 65C02

/* *KIL     */ WDC65C02op[0x02] = function(m) { m.imm(); m.nop(); };
/* *SLO izx */ WDC65C02op[0x03] = function(m) { m.imp(); m.nop(); };
/* *NOP zp  */ //WDC65C02op[0x04] = function(m) { m.imp(); m.nop(); };
/* *SLO zp  */ WDC65C02op[0x07] = function(m) { m.imp(); m.nop(); };
/* *ANC imm */ WDC65C02op[0x0B] = function(m) { m.imp(); m.nop(); };
/* *NOP abs */ //CPU6502op[0x0C] = function(m) { m.abs(); m.nop(); };
/* *SLO abs */ WDC65C02op[0x0F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //WDC65C02op[0x12] = function(m) { m.imp(); m.nop(); };
/* *SLO izy */ WDC65C02op[0x13] = function(m) { m.imp(); m.nop(); };
/* *NOP zpx */ //CPU6502op[0x14] = function(m) { m.zpx(); m.nop(); };
/* *SLO zpx */ WDC65C02op[0x17] = function(m) { m.imp(); m.nop(); };
/* *NOP     */ //CPU6502op[0x1A] = function(m) { m.imp(); m.nop(); };
/* *SLO aby */ WDC65C02op[0x1B] = function(m) { m.imp(); m.nop(); };
/* *NOP abx */ //CPU6502op[0x1C] = function(m) { m.abx(); m.nop(); };
/* *SLO abx */ WDC65C02op[0x1F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ WDC65C02op[0x22] = function(m) { m.imm(); m.nop(); };
/* *RLA izx */ WDC65C02op[0x23] = function(m) { m.imp(); m.nop(); };
/* *RLA zp  */ WDC65C02op[0x27] = function(m) { m.imp(); m.nop(); };
/* *ANC imm */ WDC65C02op[0x2B] = function(m) { m.imp(); m.nop(); };
/* *RLA abs */ WDC65C02op[0x2F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //CPU6502op[0x32] = function(m) { m.imp(); m.kil(); };
/* *RLA izy */ WDC65C02op[0x33] = function(m) { m.imp(); m.nop(); };
/* *NOP zpx */ //CPU6502op[0x34] = function(m) { m.zpx(); m.nop(); };
/* *RLA zpx */ WDC65C02op[0x37] = function(m) { m.imp(); m.nop(); };
/* *NOP     */ //CPU6502op[0x3A] = function(m) { m.imp(); m.nop(); };
/* *RLA aby */ WDC65C02op[0x3B] = function(m) { m.imp(); m.nop(); };
/* *NOP abx */ //CPU6502op[0x3C] = function(m) { m.abx(); m.nop(); };
/* *RLA abx */ WDC65C02op[0x3F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ WDC65C02op[0x42] = function(m) { m.imm(); m.nop(); };
/* *SRE izx */ WDC65C02op[0x43] = function(m) { m.imp(); m.nop(); };
/* *NOP zp  */ WDC65C02op[0x44] = function(m) { m.imm(); m.nop(); };
/* *SRE zp  */ WDC65C02op[0x47] = function(m) { m.imp(); m.nop(); };
/* *ALR imm */ WDC65C02op[0x4B] = function(m) { m.imp(); m.nop(); };
/* *SRE abs */ WDC65C02op[0x4F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //CPU6502op[0x52] = function(m) { m.imp(); m.kil(); };
/* *SRE izy */ WDC65C02op[0x53] = function(m) { m.imp(); m.nop(); };
/* *NOP zpx */ WDC65C02op[0x54] = function(m) { m.imm(); m.nop(); };
/* *SRE zpx */ WDC65C02op[0x57] = function(m) { m.imp(); m.nop(); };
/* *NOP     */ //WDC65C02op[0x5A] = function(m) { m.imp(); m.nop(); };
/* *SRE aby */ //CPU6502op[0x5B] = function(m) { m.aby(); m.sre(); m.rmw(); };
/* *NOP abx */ WDC65C02op[0x5C] = function(m) { m.abs(); m.nop(); };
/* *SRE abx */ WDC65C02op[0x5F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ WDC65C02op[0x62] = function(m) { m.imm(); m.nop(); };
/* *RRA izx */ WDC65C02op[0x63] = function(m) { m.imp(); m.nop(); };
/* *NOP zp  */ //CPU6502op[0x64] = function(m) { m.zp(); m.nop(); };
/* *RRA zp  */ WDC65C02op[0x67] = function(m) { m.imp(); m.nop(); };
/* *ARR imm */ WDC65C02op[0x6B] = function(m) { m.imp(); m.nop(); };
/* *RRA abs */ WDC65C02op[0x6F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //CPU6502op[0x72] = function(m) { m.imp(); m.kil(); };
/* *RRA izy */ WDC65C02op[0x73] = function(m) { m.imp(); m.nop(); };
/* *NOP zpx */ //CPU6502op[0x74] = function(m) { m.zpx(); m.nop(); };
/* *RRA zpx */ WDC65C02op[0x77] = function(m) { m.imp(); m.nop(); };
/* *NOP     */ //CPU6502op[0x7A] = function(m) { m.imp(); m.nop(); };
/* *RRA aby */ WDC65C02op[0x7B] = function(m) { m.imp(); m.nop(); };
/* *NOP abx */ //CPU6502op[0x7C] = function(m) { m.abx(); m.nop(); };
/* *RRA abx */ WDC65C02op[0x7F] = function(m) { m.imp(); m.nop(); };
/* *NOP imm */ //CPU6502op[0x80] = function(m) { m.imm(); m.nop(); };
/* *NOP imm */ WDC65C02op[0x82] = function(m) { m.imm(); m.nop(); };
/* *SAX izx */ WDC65C02op[0x83] = function(m) { m.imp(); m.nop(); };
/* *SAX zp  */ WDC65C02op[0x87] = function(m) { m.imp(); m.nop(); };
/* *NOP imm */ //CPU6502op[0x89] = function(m) { m.imm(); m.nop(); };
/* *XAA imm */ WDC65C02op[0x8B] = function(m) { m.imp(); m.nop(); };
/* *SAX abs */ WDC65C02op[0x8F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //CPU6502op[0x92] = function(m) { m.imp(); m.kil(); };
/* *AHX izy */ WDC65C02op[0x93] = function(m) { m.imp(); m.nop(); };
/* *SAX zpy */ WDC65C02op[0x97] = function(m) { m.imp(); m.nop(); };
/* *TAS aby */ WDC65C02op[0x9B] = function(m) { m.imp(); m.nop(); };
/* *SHY abx */ //CPU6502op[0x9C] = function(m) { m.abx(); m.shy(); };
/* *SHX aby */ //CPU6502op[0x9E] = function(m) { m.aby(); m.shx(); };
/* *AHX aby */ WDC65C02op[0x9F] = function(m) { m.imp(); m.nop(); };
/* *LAX izx */ WDC65C02op[0xA3] = function(m) { m.imp(); m.nop(); };
/* *LAX zp  */ WDC65C02op[0xA7] = function(m) { m.imp(); m.nop(); };
/* *LAX imm */ WDC65C02op[0xAB] = function(m) { m.imp(); m.nop(); };
/* *LAX abs */ WDC65C02op[0xAF] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //CPU6502op[0xB2] = function(m) { m.imp(); m.kil(); };
/* *LAX izy */ WDC65C02op[0xB3] = function(m) { m.imp(); m.nop(); };
/* *LAX zpy */ WDC65C02op[0xB7] = function(m) { m.imp(); m.nop(); };
/* *LAS aby */ WDC65C02op[0xBB] = function(m) { m.imp(); m.nop(); };
/* *LAX aby */ WDC65C02op[0xBF] = function(m) { m.imp(); m.nop(); };
/* *NOP imm */ WDC65C02op[0xC2] = function(m) { m.imm(); m.nop(); };
/* *DCP izx */ WDC65C02op[0xC3] = function(m) { m.imp(); m.nop(); };
/* *DCP zp  */ WDC65C02op[0xC7] = function(m) { m.imp(); m.nop(); };
/* *AXS imm */ WDC65C02op[0xCB] = function(m) { m.imp(); m.nop(); };
/* *DCP abs */ WDC65C02op[0xCF] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //CPU6502op[0xD2] = function(m) { m.imp(); m.kil(); };
/* *DCP izy */ WDC65C02op[0xD3] = function(m) { m.imp(); m.nop(); };
/* *NOP zpx */ WDC65C02op[0xD4] = function(m) { m.imm(); m.nop(); };
/* *DCP zpx */ WDC65C02op[0xD7] = function(m) { m.imp(); m.nop(); };
/* *NOP     */ //CPU6502op[0xDA] = function(m) { m.imp(); m.nop(); };
/* *STP     */ WDC65C02op[0xDB] = function(m) { m.imp(); m.nop(); };
/* *NOP abx */ WDC65C02op[0xDC] = function(m) { m.abs(); m.nop(); };
/* *DCP abx */ WDC65C02op[0xDF] = function(m) { m.imp(); m.nop(); };
/* *NOP imm */ WDC65C02op[0xE2] = function(m) { m.imm(); m.nop(); };
/* *ISC izx */ WDC65C02op[0xE3] = function(m) { m.imp(); m.nop(); };
/* *ISC zp  */ WDC65C02op[0xE7] = function(m) { m.imp(); m.nop(); };
/* *SBC imm */ WDC65C02op[0xEB] = function(m) { m.imp(); m.nop(); };
/* *ISC abs */ WDC65C02op[0xEF] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //CPU6502op[0xF2] = function(m) { m.imp(); m.kil(); };
/* *ISC izy */ WDC65C02op[0xF3] = function(m) { m.imp(); m.nop(); };
/* *NOP zpx */ WDC65C02op[0xF4] = function(m) { m.imm(); m.nop(); };
/* *ISC zpx */ WDC65C02op[0xF7] = function(m) { m.imp(); m.nop(); };
/* *NOP     */ //CPU6502op[0xFA] = function(m) { m.imp(); m.nop(); };
/* *ISC aby */ WDC65C02op[0xFB] = function(m) { m.imp(); m.nop(); };
/* *NOP abx */ WDC65C02op[0xFC] = function(m) { m.abs(); m.nop(); };
/* *ISC abx */ WDC65C02op[0xFF] = function(m) { m.imp(); m.nop(); };

module.exports = WDC65C02op;