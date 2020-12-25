////////////////////////////////////////////////////////////////////////////////
// Opcode table
////////////////////////////////////////////////////////////////////////////////

var R65C02op = new Array();

/*  AND iz  */ R65C02op[0x32] = function(m) { m.iz(); m.and(); };

/*  ADC iz  */ R65C02op[0x72] = function(m) { m.iz(); m.adc(); };

/*  BBR0 rel */ R65C02op[0x0F] = function(m) { m.zp(), m.temp= m.read(m.addr); m.rel(); m.bbr(0, m.temp); };
/*  BBR1 rel */ R65C02op[0x1F] = function(m) { m.zp(), m.temp= m.read(m.addr); m.rel(); m.bbr(1, m.temp); };
/*  BBR2 rel */ R65C02op[0x2F] = function(m) { m.zp(), m.temp= m.read(m.addr); m.rel(); m.bbr(2, m.temp); };
/*  BBR3 rel */ R65C02op[0x3F] = function(m) { m.zp(), m.temp= m.read(m.addr); m.rel(); m.bbr(3, m.temp); };
/*  BBR4 rel */ R65C02op[0x4F] = function(m) { m.zp(), m.temp= m.read(m.addr); m.rel(); m.bbr(4, m.temp); };
/*  BBR5 rel */ R65C02op[0x5F] = function(m) { m.zp(), m.temp= m.read(m.addr); m.rel(); m.bbr(5, m.temp); };
/*  BBR6 rel */ R65C02op[0x6F] = function(m) { m.zp(), m.temp= m.read(m.addr); m.rel(); m.bbr(6, m.temp); };
/*  BBR7 rel */ R65C02op[0x7F] = function(m) { m.zp(), m.temp= m.read(m.addr); m.rel(); m.bbr(7, m.temp); };

/*  BBS0 rel */ R65C02op[0x8F] = function(m) { m.zp(), m.temp= m.read(m.addr); m.rel(); m.bbs(0, m.temp); };
/*  BBS1 rel */ R65C02op[0x9F] = function(m) { m.zp(), m.temp= m.read(m.addr); m.rel(); m.bbs(1, m.temp); };
/*  BBS2 rel */ R65C02op[0xAF] = function(m) { m.zp(), m.temp= m.read(m.addr); m.rel(); m.bbs(2, m.temp); };
/*  BBS3 rel */ R65C02op[0xBF] = function(m) { m.zp(), m.temp= m.read(m.addr); m.rel(); m.bbs(3, m.temp); };
/*  BBS4 rel */ R65C02op[0xCF] = function(m) { m.zp(), m.temp= m.read(m.addr); m.rel(); m.bbs(4, m.temp); };
/*  BBS5 rel */ R65C02op[0xDF] = function(m) { m.zp(), m.temp= m.read(m.addr); m.rel(); m.bbs(5, m.temp); };
/*  BBS6 rel */ R65C02op[0xEF] = function(m) { m.zp(), m.temp= m.read(m.addr); m.rel(); m.bbs(6, m.temp); };
/*  BBS7 rel */ R65C02op[0xFF] = function(m) { m.zp(), m.temp= m.read(m.addr); m.rel(); m.bbs(7, m.temp); };

/*  BIT zp  */ R65C02op[0x34] = function(m) { m.zpx(); m.bit(); };
/*  BIT abs */ R65C02op[0x3C] = function(m) { m.abx(); m.bit(); };
/*  BIT imm */ R65C02op[0x89] = function(m) { m.imm(); m.biti(); };

/*  BRA rel */ R65C02op[0x80] = function(m) { m.rel(); m.bra(); };

/*  CMP iz  */ R65C02op[0xD2] = function(m) { m.iz(); m.cmp(); };

/*! DEC A   */ R65C02op[0x3A] = function(m) { m.imp(); m.dea(); };

/*  EOR iz  */ R65C02op[0x52] = function(m) { m.iz(); m.eor(); };

/*! INC A   */ R65C02op[0x1A] = function(m) { m.imp(); m.ina(); };

/*  JMP abxi*/ R65C02op[0x7C] = function(m) { m.abxpi(); m.jmp(); };

/*  LDA iz  */ R65C02op[0xB2] = function(m) { m.iz(); m.lda(); };

/*  RMB0 zp */ R65C02op[0x07] = function(m) { m.zp(); m.rmb(0); };
/*  RMB1 zp */ R65C02op[0x17] = function(m) { m.zp(); m.rmb(1); };
/*  RMB2 zp */ R65C02op[0x27] = function(m) { m.zp(); m.rmb(2); };
/*  RMB3 zp */ R65C02op[0x37] = function(m) { m.zp(); m.rmb(3); };
/*  RMB4 zp */ R65C02op[0x47] = function(m) { m.zp(); m.rmb(4); };
/*  RMB5 zp */ R65C02op[0x57] = function(m) { m.zp(); m.rmb(5); };
/*  RMB6 zp */ R65C02op[0x67] = function(m) { m.zp(); m.rmb(6); };
/*  RMB7 zp */ R65C02op[0x77] = function(m) { m.zp(); m.rmb(7); };

/*  ORA iz  */ R65C02op[0x12] = function(m) { m.iz(); m.ora(); };

/*  PHX     */ R65C02op[0xDA] = function(m) { m.imp(); m.phx(); };
/*  PHY     */ R65C02op[0x5A] = function(m) { m.imp(); m.phy(); };

/*  PLX     */ R65C02op[0xFA] = function(m) { m.imp(); m.plx(); };
/*  PLY     */ R65C02op[0x7A] = function(m) { m.imp(); m.ply(); };

/*  SBC iz  */ R65C02op[0xF2] = function(m) { m.iz(); m.sbc(); };

/*  SMB0 zp */ R65C02op[0x87] = function(m) { m.zp(); m.smb(0); };
/*  SMB1 zp */ R65C02op[0x97] = function(m) { m.zp(); m.smb(1); };
/*  SMB2 zp */ R65C02op[0xA7] = function(m) { m.zp(); m.smb(2); };
/*  SMB3 zp */ R65C02op[0xB7] = function(m) { m.zp(); m.smb(3); };
/*  SMB4 zp */ R65C02op[0xC7] = function(m) { m.zp(); m.smb(4); };
/*  SMB5 zp */ R65C02op[0xD7] = function(m) { m.zp(); m.smb(5); };
/*  SMB6 zp */ R65C02op[0xE7] = function(m) { m.zp(); m.smb(6); };
/*  SMB7 zp */ R65C02op[0xF7] = function(m) { m.zp(); m.smb(7); };

/*  STA iz  */ R65C02op[0x92] = function(m) { m.iz(); m.sta(); };

/*  STZ abs */ R65C02op[0x9C] = function(m) { m.abs(); m.stz(); };
/*  STZ zp  */ R65C02op[0x64] = function(m) { m.zp(); m.stz(); };
/*  STZ abx */ R65C02op[0x9E] = function(m) { m.abxp(); m.stz(); };
/*  STZ zpx */ R65C02op[0x74] = function(m) { m.zpx(); m.stz(); };

/*  TRB abs */ R65C02op[0x1C] = function(m) { m.abs(); m.trb(); };
/*  TRB zp  */ R65C02op[0x14] = function(m) { m.zp(); m.trb(); };

/*  TSB abs */ R65C02op[0x0C] = function(m) { m.abs(); m.tsb(); };
/*  TSB zp  */ R65C02op[0x04] = function(m) { m.zp(); m.tsb(); };

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

/* *KIL     */ R65C02op[0x02] = function(m) { m.imm(); m.nop(); };
/* *SLO izx */ R65C02op[0x03] = function(m) { m.imp(); m.nop(); };
/* *NOP zp  */ //R65C02op[0x04] = function(m) { m.imp(); m.nop(); };
/* *SLO zp  */ //R65C02op[0x07] = function(m) { m.imp(); m.nop(); };
/* *ANC imm */ R65C02op[0x0B] = function(m) { m.imp(); m.nop(); };
/* *NOP abs */ //R65C02op[0x0C] = function(m) { m.abs(); m.nop(); };
/* *SLO abs */ //R65C02op[0x0F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //R65C02op[0x12] = function(m) { m.imp(); m.nop(); };
/* *SLO izy */ R65C02op[0x13] = function(m) { m.imp(); m.nop(); };
/* *NOP zpx */ //R65C02op[0x14] = function(m) { m.zpx(); m.nop(); };
/* *SLO zpx */ //R65C02op[0x17] = function(m) { m.imp(); m.nop(); };
/* *NOP     */ //R65C02op[0x1A] = function(m) { m.imp(); m.nop(); };
/* *SLO aby */ R65C02op[0x1B] = function(m) { m.imp(); m.nop(); };
/* *NOP abx */ //R65C02op[0x1C] = function(m) { m.abx(); m.nop(); };
/* *SLO abx */ //R65C02op[0x1F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ R65C02op[0x22] = function(m) { m.imm(); m.nop(); };
/* *RLA izx */ R65C02op[0x23] = function(m) { m.imp(); m.nop(); };
/* *RLA zp  */ //R65C02op[0x27] = function(m) { m.imp(); m.nop(); };
/* *ANC imm */ R65C02op[0x2B] = function(m) { m.imp(); m.nop(); };
/* *RLA abs */ //R65C02op[0x2F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //R65C02op[0x32] = function(m) { m.imp(); m.kil(); };
/* *RLA izy */ R65C02op[0x33] = function(m) { m.imp(); m.nop(); };
/* *NOP zpx */ //R65C02op[0x34] = function(m) { m.zpx(); m.nop(); };
/* *RLA zpx */ //R65C02op[0x37] = function(m) { m.imp(); m.nop(); };
/* *NOP     */ //R65C02op[0x3A] = function(m) { m.imp(); m.nop(); };
/* *RLA aby */ R65C02op[0x3B] = function(m) { m.imp(); m.nop(); };
/* *NOP abx */ //R65C02op[0x3C] = function(m) { m.abx(); m.nop(); };
/* *RLA abx */ //R65C02op[0x3F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ R65C02op[0x42] = function(m) { m.imm(); m.nop(); };
/* *SRE izx */ R65C02op[0x43] = function(m) { m.imp(); m.nop(); };
/* *NOP zp  */ R65C02op[0x44] = function(m) { m.imm(); m.nop(); };
/* *SRE zp  */ //R65C02op[0x47] = function(m) { m.imp(); m.nop(); };
/* *ALR imm */ R65C02op[0x4B] = function(m) { m.imp(); m.nop(); };
/* *SRE abs */ //R65C02op[0x4F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //R65C02op[0x52] = function(m) { m.imp(); m.kil(); };
/* *SRE izy */ R65C02op[0x53] = function(m) { m.imp(); m.nop(); };
/* *NOP zpx */ R65C02op[0x54] = function(m) { m.imm(); m.nop(); };
/* *SRE zpx */ //R65C02op[0x57] = function(m) { m.imp(); m.nop(); };
/* *NOP     */ //R65C02op[0x5A] = function(m) { m.imp(); m.nop(); };
/* *SRE aby */ R65C02op[0x5B] = function(m) { m.imp(); m.nop(); };
/* *NOP abx */ R65C02op[0x5C] = function(m) { m.abs(); m.nop(); };
/* *SRE abx */ //R65C02op[0x5F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ R65C02op[0x62] = function(m) { m.imm(); m.nop(); };
/* *RRA izx */ R65C02op[0x63] = function(m) { m.imp(); m.nop(); };
/* *NOP zp  */ //R65C02op[0x64] = function(m) { m.zp(); m.nop(); };
/* *RRA zp  */ //R65C02op[0x67] = function(m) { m.imp(); m.nop(); };
/* *ARR imm */ R65C02op[0x6B] = function(m) { m.imp(); m.nop(); };
/* *RRA abs */ //R65C02op[0x6F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //R65C02op[0x72] = function(m) { m.imp(); m.kil(); };
/* *RRA izy */ R65C02op[0x73] = function(m) { m.imp(); m.nop(); };
/* *NOP zpx */ //R65C02op[0x74] = function(m) { m.zpx(); m.nop(); };
/* *RRA zpx */ //R65C02op[0x77] = function(m) { m.imp(); m.nop(); };
/* *NOP     */ //R65C02op[0x7A] = function(m) { m.imp(); m.nop(); };
/* *RRA aby */ R65C02op[0x7B] = function(m) { m.imp(); m.nop(); };
/* *NOP abx */ //R65C02op[0x7C] = function(m) { m.abx(); m.nop(); };
/* *RRA abx */ //R65C02op[0x7F] = function(m) { m.imp(); m.nop(); };
/* *NOP imm */ //R65C02op[0x80] = function(m) { m.imm(); m.nop(); };
/* *NOP imm */ R65C02op[0x82] = function(m) { m.imm(); m.nop(); };
/* *SAX izx */ R65C02op[0x83] = function(m) { m.imp(); m.nop(); };
/* *SAX zp  */ //R65C02op[0x87] = function(m) { m.imp(); m.nop(); };
/* *NOP imm */ //R65C02op[0x89] = function(m) { m.imm(); m.nop(); };
/* *XAA imm */ R65C02op[0x8B] = function(m) { m.imp(); m.nop(); };
/* *SAX abs */ //R65C02op[0x8F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //R65C02op[0x92] = function(m) { m.imp(); m.kil(); };
/* *AHX izy */ R65C02op[0x93] = function(m) { m.imp(); m.nop(); };
/* *SAX zpy */ //R65C02op[0x97] = function(m) { m.imp(); m.nop(); };
/* *TAS aby */ R65C02op[0x9B] = function(m) { m.imp(); m.nop(); };
/* *SHY abx */ //R65C02op[0x9C] = function(m) { m.abx(); m.shy(); };
/* *SHX aby */ //R65C02op[0x9E] = function(m) { m.aby(); m.shx(); };
/* *AHX aby */ //R65C02op[0x9F] = function(m) { m.imp(); m.nop(); };
/* *LAX izx */ R65C02op[0xA3] = function(m) { m.imp(); m.nop(); };
/* *LAX zp  */ //R65C02op[0xA7] = function(m) { m.imp(); m.nop(); };
/* *LAX imm */ R65C02op[0xAB] = function(m) { m.imp(); m.nop(); };
/* *LAX abs */ //R65C02op[0xAF] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //R65C02op[0xB2] = function(m) { m.imp(); m.kil(); };
/* *LAX izy */ R65C02op[0xB3] = function(m) { m.imp(); m.nop(); };
/* *LAX zpy */ //R65C02op[0xB7] = function(m) { m.imp(); m.nop(); };
/* *LAS aby */ R65C02op[0xBB] = function(m) { m.imp(); m.nop(); };
/* *LAX aby */ //R65C02op[0xBF] = function(m) { m.imp(); m.nop(); };
/* *NOP imm */ R65C02op[0xC2] = function(m) { m.imm(); m.nop(); };
/* *DCP izx */ R65C02op[0xC3] = function(m) { m.imp(); m.nop(); };
/* *DCP zp  */ //R65C02op[0xC7] = function(m) { m.imp(); m.nop(); };
/* *AXS imm */ R65C02op[0xCB] = function(m) { m.imp(); m.nop(); };
/* *DCP abs */ //R65C02op[0xCF] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //R65C02op[0xD2] = function(m) { m.imp(); m.kil(); };
/* *DCP izy */ R65C02op[0xD3] = function(m) { m.imp(); m.nop(); };
/* *NOP zpx */ R65C02op[0xD4] = function(m) { m.imm(); m.nop(); };
/* *DCP zpx */ //R65C02op[0xD7] = function(m) { m.imp(); m.nop(); };
/* *NOP     */ //R65C02op[0xDA] = function(m) { m.imp(); m.nop(); };
/* *STP     */ R65C02op[0xDB] = function(m) { m.imp(); m.nop(); };
/* *NOP abx */ R65C02op[0xDC] = function(m) { m.abs(); m.nop(); };
/* *DCP abx */ //R65C02op[0xDF] = function(m) { m.imp(); m.nop(); };
/* *NOP imm */ R65C02op[0xE2] = function(m) { m.imm(); m.nop(); };
/* *ISC izx */ R65C02op[0xE3] = function(m) { m.imp(); m.nop(); };
/* *ISC zp  */ //R65C02op[0xE7] = function(m) { m.imp(); m.nop(); };
/* *SBC imm */ R65C02op[0xEB] = function(m) { m.imp(); m.nop(); };
/* *ISC abs */ //R65C02op[0xEF] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //R65C02op[0xF2] = function(m) { m.imp(); m.kil(); };
/* *ISC izy */ R65C02op[0xF3] = function(m) { m.imp(); m.nop(); };
/* *NOP zpx */ R65C02op[0xF4] = function(m) { m.imm(); m.nop(); };
/* *ISC zpx */ //R65C02op[0xF7] = function(m) { m.imp(); m.nop(); };
/* *NOP     */ //R65C02op[0xFA] = function(m) { m.imp(); m.nop(); };
/* *ISC aby */ R65C02op[0xFB] = function(m) { m.imp(); m.nop(); };
/* *NOP abx */ R65C02op[0xFC] = function(m) { m.abs(); m.nop(); };
/* *ISC abx */ //R65C02op[0xFF] = function(m) { m.imp(); m.nop(); };

module.exports = R65C02op;