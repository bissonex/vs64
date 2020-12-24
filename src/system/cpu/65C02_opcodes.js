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

/*  CMP iz  */ CPU65C02op[0xD2] = function(m) { m.iz(); m.cmp(); };

/*! DEC A   */ CPU65C02op[0x3A] = function(m) { m.imp(); m.dea(); };

/*  EOR iz  */ CPU65C02op[0x52] = function(m) { m.iz(); m.eor(); };

/*! INC A   */ CPU65C02op[0x1A] = function(m) { m.imp(); m.ina(); };

/*  JMP indx */ CPU65C02op[0x7C] = function(m) { m.indx(); m.jmp(); };

/*  LDA iz  */ CPU65C02op[0xB2] = function(m) { m.iz(); m.lda(); };

/*  PHX     */ CPU65C02op[0xDA] = function(m) { m.imp(); m.phx(); };
/*  PHY     */ CPU65C02op[0x5A] = function(m) { m.imp(); m.phy(); };

/*  PLX     */ CPU65C02op[0xFA] = function(m) { m.imp(); m.plx(); };
/*  PLY     */ CPU65C02op[0x7A] = function(m) { m.imp(); m.ply(); };

/*  SBC iz  */ CPU65C02op[0xF2] = function(m) { m.iz(); m.sbc(); };

/*  STA iz  */ CPU65C02op[0x92] = function(m) { m.iz(); m.sta(); };

/*  STZ abs */ CPU65C02op[0x9C] = function(m) { m.abs(); m.stz(); };
/*  STZ zp  */ CPU65C02op[0x64] = function(m) { m.zp(); m.stz(); };
/*  STZ abx */ CPU65C02op[0x9E] = function(m) { m.abxp(); m.stz(); };
/*  STZ zpx */ CPU65C02op[0x74] = function(m) { m.zpx(); m.stz(); };

/*  TRB abs */ CPU65C02op[0x1C] = function(m) { m.abs(); m.trb(); };
/*  TRB zp  */ CPU65C02op[0x14] = function(m) { m.zp(); m.trb(); };

/*  TSB abs */ CPU65C02op[0x0C] = function(m) { m.abs(); m.tsb(); };
/*  TSB zp  */ CPU65C02op[0x04] = function(m) { m.zp(); m.tsb(); };

////////////////////////////////////////////////////////////////////
// illegal opcodes perform a NOP.
//
/* *KIL     */ CPU65C02op[0x02] = function(m) { m.imp(); m.nop(); };
/* *SLO izx */ CPU65C02op[0x03] = function(m) { m.imp(); m.nop(); };
/* *NOP zp  */ //CPU65C02op[0x04] = function(m) { m.imp(); m.nop(); };
/* *SLO zp  */ CPU65C02op[0x07] = function(m) { m.imp(); m.nop(); };
/* *ANC imm */ CPU65C02op[0x0B] = function(m) { m.imp(); m.nop(); };
/* *NOP abs */ //CPU6502op[0x0C] = function(m) { m.abs(); m.nop(); };
/* *SLO abs */ CPU65C02op[0x0F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ CPU65C02op[0x12] = function(m) { m.imp(); m.nop(); };
/* *SLO izy */ CPU65C02op[0x13] = function(m) { m.imp(); m.nop(); };
/* *NOP zpx */ //CPU6502op[0x14] = function(m) { m.zpx(); m.nop(); };
/* *SLO zpx */ CPU65C02op[0x17] = function(m) { m.imp(); m.nop(); };
/* *NOP     */ //CPU6502op[0x1A] = function(m) { m.imp(); m.nop(); };
/* *SLO aby */ CPU65C02op[0x1B] = function(m) { m.imp(); m.nop(); };
/* *NOP abx */ //CPU6502op[0x1C] = function(m) { m.abx(); m.nop(); };
/* *SLO abx */ CPU65C02op[0x1F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ CPU65C02op[0x22] = function(m) { m.imp(); m.nop(); };
/* *RLA izx */ CPU65C02op[0x23] = function(m) { m.imp(); m.nop(); };
/* *RLA zp  */ CPU65C02op[0x27] = function(m) { m.imp(); m.nop(); };
/* *ANC imm */ CPU65C02op[0x2B] = function(m) { m.imp(); m.nop(); };
/* *RLA abs */ CPU65C02op[0x2F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //CPU6502op[0x32] = function(m) { m.imp(); m.kil(); };
/* *RLA izy */ CPU65C02op[0x33] = function(m) { m.imp(); m.nop(); };
/* *NOP zpx */ //CPU6502op[0x34] = function(m) { m.zpx(); m.nop(); };
/* *RLA zpx */ CPU65C02op[0x37] = function(m) { m.imp(); m.nop(); };
/* *NOP     */ //CPU6502op[0x3A] = function(m) { m.imp(); m.nop(); };
/* *RLA aby */ CPU65C02op[0x3B] = function(m) { m.imp(); m.nop(); };
/* *NOP abx */ //CPU6502op[0x3C] = function(m) { m.abx(); m.nop(); };
/* *RLA abx */ CPU65C02op[0x3F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ CPU65C02op[0x42] = function(m) { m.imp(); m.nop(); };
/* *SRE izx */ CPU65C02op[0x43] = function(m) { m.imp(); m.nop(); };
/* *NOP zp  */ CPU65C02op[0x44] = function(m) { m.imp(); m.nop(); };
/* *SRE zp  */ CPU65C02op[0x47] = function(m) { m.imp(); m.nop(); };
/* *ALR imm */ CPU65C02op[0x4B] = function(m) { m.imp(); m.nop(); };
/* *SRE abs */ CPU65C02op[0x4F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //CPU6502op[0x52] = function(m) { m.imp(); m.kil(); };
/* *SRE izy */ CPU65C02op[0x53] = function(m) { m.imp(); m.nop(); };
/* *NOP zpx */ CPU65C02op[0x54] = function(m) { m.imp(); m.nop(); };
/* *SRE zpx */ CPU65C02op[0x57] = function(m) { m.imp(); m.nop(); };
/* *NOP     */ //CPU65C02op[0x5A] = function(m) { m.imp(); m.nop(); };
/* *SRE aby */ //CPU6502op[0x5B] = function(m) { m.aby(); m.sre(); m.rmw(); };
/* *NOP abx */ CPU65C02op[0x5C] = function(m) { m.imp(); m.nop(); };
/* *SRE abx */ CPU65C02op[0x5F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ CPU65C02op[0x62] = function(m) { m.imp(); m.nop(); };
/* *RRA izx */ CPU65C02op[0x63] = function(m) { m.imp(); m.nop(); };
/* *NOP zp  */ //CPU6502op[0x64] = function(m) { m.zp(); m.nop(); };
/* *RRA zp  */ CPU65C02op[0x67] = function(m) { m.imp(); m.nop(); };
/* *ARR imm */ CPU65C02op[0x6B] = function(m) { m.imp(); m.nop(); };
/* *RRA abs */ CPU65C02op[0x6F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //CPU6502op[0x72] = function(m) { m.imp(); m.kil(); };
/* *RRA izy */ CPU65C02op[0x73] = function(m) { m.imp(); m.nop(); };
/* *NOP zpx */ //CPU6502op[0x74] = function(m) { m.zpx(); m.nop(); };
/* *RRA zpx */ CPU65C02op[0x77] = function(m) { m.imp(); m.nop(); };
/* *NOP     */ //CPU6502op[0x7A] = function(m) { m.imp(); m.nop(); };
/* *RRA aby */ CPU65C02op[0x7B] = function(m) { m.imp(); m.nop(); };
/* *NOP abx */ //CPU6502op[0x7C] = function(m) { m.abx(); m.nop(); };
/* *RRA abx */ CPU65C02op[0x7F] = function(m) { m.imp(); m.nop(); };
/* *NOP imm */ //CPU6502op[0x80] = function(m) { m.imm(); m.nop(); };
/* *NOP imm */ CPU65C02op[0x82] = function(m) { m.imp(); m.nop(); };
/* *SAX izx */ CPU65C02op[0x83] = function(m) { m.imp(); m.nop(); };
/* *SAX zp  */ CPU65C02op[0x87] = function(m) { m.imp(); m.nop(); };
/* *NOP imm */ //CPU6502op[0x89] = function(m) { m.imm(); m.nop(); };
/* *XAA imm */ CPU65C02op[0x8B] = function(m) { m.imp(); m.nop(); };
/* *SAX abs */ CPU65C02op[0x8F] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //CPU6502op[0x92] = function(m) { m.imp(); m.kil(); };
/* *AHX izy */ CPU65C02op[0x93] = function(m) { m.imp(); m.nop(); };
/* *SAX zpy */ CPU65C02op[0x97] = function(m) { m.imp(); m.nop(); };
/* *TAS aby */ CPU65C02op[0x9B] = function(m) { m.imp(); m.nop(); };
/* *SHY abx */ //CPU6502op[0x9C] = function(m) { m.abx(); m.shy(); };
/* *SHX aby */ //CPU6502op[0x9E] = function(m) { m.aby(); m.shx(); };
/* *AHX aby */ CPU65C02op[0x9F] = function(m) { m.imp(); m.nop(); };
/* *LAX izx */ CPU65C02op[0xA3] = function(m) { m.imp(); m.nop(); };
/* *LAX zp  */ CPU65C02op[0xA7] = function(m) { m.imp(); m.nop(); };
/* *LAX imm */ CPU65C02op[0xAB] = function(m) { m.imp(); m.nop(); };
/* *LAX abs */ CPU65C02op[0xAF] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //CPU6502op[0xB2] = function(m) { m.imp(); m.kil(); };
/* *LAX izy */ CPU65C02op[0xB3] = function(m) { m.imp(); m.nop(); };
/* *LAX zpy */ CPU65C02op[0xB7] = function(m) { m.imp(); m.nop(); };
/* *LAS aby */ CPU65C02op[0xBB] = function(m) { m.imp(); m.nop(); };
/* *LAX aby */ CPU65C02op[0xBF] = function(m) { m.imp(); m.nop(); };
/* *NOP imm */ CPU65C02op[0xC2] = function(m) { m.imp(); m.nop(); };
/* *DCP izx */ CPU65C02op[0xC3] = function(m) { m.imp(); m.nop(); };
/* *DCP zp  */ CPU65C02op[0xC7] = function(m) { m.imp(); m.nop(); };
/* *AXS imm */ CPU65C02op[0xCB] = function(m) { m.imp(); m.nop(); };
/* *DCP abs */ CPU65C02op[0xCF] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //CPU6502op[0xD2] = function(m) { m.imp(); m.kil(); };
/* *DCP izy */ CPU65C02op[0xD3] = function(m) { m.imp(); m.nop(); };
/* *NOP zpx */ CPU65C02op[0xD4] = function(m) { m.imp(); m.nop(); };
/* *DCP zpx */ CPU65C02op[0xD7] = function(m) { m.imp(); m.nop(); };
/* *NOP     */ //CPU6502op[0xDA] = function(m) { m.imp(); m.nop(); };
/* *STP     */ CPU65C02op[0xDB] = function(m) { m.imp(); m.nop(); };
/* *NOP abx */ CPU65C02op[0xDC] = function(m) { m.imp(); m.nop(); };
/* *DCP abx */ CPU65C02op[0xDF] = function(m) { m.imp(); m.nop(); };
/* *NOP imm */ CPU65C02op[0xE2] = function(m) { m.imp(); m.nop(); };
/* *ISC izx */ CPU65C02op[0xE3] = function(m) { m.imp(); m.nop(); };
/* *ISC zp  */ CPU65C02op[0xE7] = function(m) { m.imp(); m.nop(); };
/* *SBC imm */ CPU65C02op[0xEB] = function(m) { m.imp(); m.nop(); };
/* *ISC abs */ CPU65C02op[0xEF] = function(m) { m.imp(); m.nop(); };
/* *KIL     */ //CPU6502op[0xF2] = function(m) { m.imp(); m.kil(); };
/* *ISC izy */ CPU65C02op[0xF3] = function(m) { m.imp(); m.nop(); };
/* *NOP zpx */ CPU65C02op[0xF4] = function(m) { m.imp(); m.nop(); };
/* *ISC zpx */ CPU65C02op[0xF7] = function(m) { m.imp(); m.nop(); };
/* *NOP     */ //CPU6502op[0xFA] = function(m) { m.imp(); m.nop(); };
/* *ISC aby */ CPU65C02op[0xFB] = function(m) { m.imp(); m.nop(); };
/* *NOP abx */ CPU65C02op[0xFC] = function(m) { m.imp(); m.nop(); };
/* *ISC abx */ CPU65C02op[0xFF] = function(m) { m.imp(); m.nop(); };

module.exports = CPU65C02op;