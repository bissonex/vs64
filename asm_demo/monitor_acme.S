; Target assembler: acme v0.96.4 []
; 6502bench SourceGen v1.7.3
        !CPU    65C02
WNDBTM  =       $23
CH      =       $24
CV      =       $25
BASL    =       $28
BASH    =       $29
BAS2L   =       $2A
BAS2H   =       $2B
LMNEM   =       $2C
RMNEM   =       $2D
FORMAT  =       $2E
LENGTH  =       $2F
MODE    =       $31
INVFLG  =       $32
PROMPT  =       $33
YSAV    =       $34
LL      =       $35
PCL     =       $3A
PCH     =       $3B
AIL     =       $3C
A1H     =       $3D
A2L     =       $3E
A2H     =       $3F
A3L     =       $40
A3H     =       $41
A4L     =       $42
A4H     =       $43
FMT     =       $44
ACC     =       $45
XREG    =       $46
YREG    =       $47
STATUS  =       $48
SPNT    =       $49
RNDL    =       $4E
RNDH    =       $4F
IN      =       $0200
IRQLOC  =       $03FE
PORTB   =       $C000
PORTA   =       $C001
DDRB    =       $C002
DDRA    =       $C003
TAPEIN  =       $C004
TAPEOUT =       $C100
VDATA   =       $C200      ;VDP RAM
VREG    =       $C201      ;VDP REGISTER
SID_FREQL1 =    $C401
SID_CTRL1 =     $C404
SID_ATTACK =    $C405
SID_FREQH3 =    $C40F
SID_MAIN_VOLUME = $C418
SERIAL_OUT =    $6000

*       =       $F600
        !AS
        !RS
MINIASM JMP     RESETZ

; ***********************
; *                     *
; *      APPLE-II       *
; *   MINI-ASSEMBLER    *
; *                     *
; *  COPYRIGHT 1977 BY  *
; * APPLE COMPUTER INC. *
; *                     *
; * ALL RIGHTS RESERVED *
; *                     *
; *     S. WOZNIAK      *
; *      A. BAUM        *
; ***********************
REL     SBC     #$81       ;IS FMT COMPATIBLE
        LSR                ;WITH RELATIVE MODE?
        BNE     ERR3       ;  NO.
        LDY     A2H
        LDX     A2L        ;DOUBLE DECREMENT
        BNE     REL2
        DEY
REL2    DEX
        TXA
        CLC
        SBC     PCL        ;FORM ADDR-PC-2
        STA     A2L
        BPL     REL3
        INY
REL3    TYA
        SBC     PCH
ERR3    BNE     ERR        ;ERROR IF >1-BYTE BRANCH
FINDOP  LDY     LENGTH
FNDOP2  LDA     A1H,Y      ;MOVE INST TO (PC)
        STA     (PCL),Y
        DEY
        BPL     FNDOP2
        JSR     CURSUP
        JSR     CURSUP     ;RESTORE CURSOR
        JSR     INSTDSP    ;TYPE FORMATTED LINE
        JSR     PCADJ      ;UPDATE PC
        STY     PCH
        STA     PCL
        JMP     NXTLINE    ;GET NEXT LINE

EXIT    JMP     MON

FAKEMON3
        JSR     TOSUB      ;GO TO DELIM HANDLER
        LDY     YSAV       ;RESTORE Y-INDEX
FAKEMON JSR     GETNUM     ;READ PARAM
        STY     YSAV       ;SAVE Y-INDEX
        LDY     #$0E       ;INIT DELIMITER INDEX
FAKEMON2
        DEY                ;CHECK NEXT DELIM
        BMI     RESETZ     ;ERR IF UNRECOGNIZED DELIM
        CMP     CHRTBL,Y   ;COMPARE WITH DELIM TABLE
        BNE     FAKEMON2   ;NO MATCH
        CPY     #$0B       ;MATCH, IS IT CR?
        BNE     FAKEMON3   ;NO, HANDLE IT IN MONITOR
        LDA     MODE
        LDY     #$00
        DEC     YSAV
        JSR     BL1        ;HANDLE CR OUTSIDE MONITOR
        JMP     NXTLINE

TRYNEXT LDA     A1H        ;GET TRIAL OPCODE
        JSR     INSDS2     ;GET FMT+LENGTH FOR OPCODE
        TAX
        LDA     MNEMR,X    ;GET LOWER MNEMONIC BYTE
        CMP     A4L        ;MATCH?
        BNE     NEXTOP     ;NO. TRY NEXT OPCODE.
        LDA     MNEML,X    ;GET UPPER MNEMONIC BYTE
        CMP     A4H        ;MATCH?
        BNE     NEXTOP     ;NO. TRY NEXT OPCODE
        LDA     FMT
        LDY     FORMAT     ;GET TRIAL FORMAT
        CPY     #$9D       ;TRIAL FORMAT RELATIVE?
        BEQ     REL        ;YES.
NREL    CMP     FORMAT     ;SAME FORMAT?
        BEQ     FINDOP     ;YES.
NEXTOP  DEC     A1H        ;NO, TRY NEXT OPCODE
        BNE     TRYNEXT
        INC     FMT        ;NO MORE, TRY WITH LEN=2
        DEC     LL         ;WAS LL=2 ALREADY?
        BEQ     TRYNEXT
ERR     LDY     YSAV       ;YES, UNRECOGNIZED INST.
ERR2    TYA
        TAX
        JSR     PRBL2      ;PRINT ^ UNDER LAST READ
        LDA     #'^'       ;CHAR TO INDICATE ERROR
        JSR     COUT       ;POSITION
RESETZ  NOP
NXTLINE LDA     #'"'
        STA     PROMPT     ;INITIALIZE PROMPT
        JSR     GETLNZ     ;GET LINE
        JSR     ZMODE      ;INIT SCREEN STUFF
        LDA     IN         ;GET CHAR
        CMP     #' '       ;ASCII BLANK
        BEQ     SPACE      ;YES
        INY
        CMP     #'X'
        BEQ     EXIT
        CMP     #')'       ;ASCII '$' IN COL 1?
        BEQ     FAKEMON    ;YES SIMULATE MONITOR
        DEY                ;NO, BACKUP A CHAR
        JSR     GETNUM     ;GET A NUMBER
        CMP     #$93       ;':' TERMINATOR?
ERR4    BNE     ERR2       ;NO, ERR.
        TXA
        BEQ     ERR2       ;NO ADR PRECEDING COLON
        JSR     A1PCLP     ;MOVE ADR TO PCL, PCH
SPACE   LDA     #$03       ;COUNT OF CHARS IN MNEMONIC
        STA     A1H
NXTMN   JSR     GETNSP     ;GET FIRST MNEM CHAR
        ASL
        SBC     #$BE       ;SUBSTRACT OFFSET
        CMP     #$C2       ;LEGAL CHAR?
        BCC     ERR2       ;NO.
        ASL                ;COMPRESS-LEFT JUSTIFY
        ASL
        LDX     #$04
NXTM2   ASL                ;DO 5 TRIPLE WORD SHIFTS
        ROL     A4L
        ROL     A4H
        DEX
        BPL     NXTM2
        DEC     A1H        ;DONE WITH 3 CHARS?
        BEQ     NXTM2      ;YES, BUT DO 1 MORE SHIFT
        BPL     NXTMN      ;NO
FORM1   LDX     #$05       ;5 CHARS IN ADDR MODE
FORM2   JSR     GETNSP     ;GET FIRST CHAR OF ADDR
        STY     YSAV
        CMP     CHAR1,X    ;FIRST CHAR MATCH PATTERN?
        BNE     FORM3      ;NO.
        JSR     GETNSP     ;YES, GET SECOND CHAR
        CMP     CHAR2,X    ;MATCHES SECOND HALF?
        BEQ     FORM5      ;YES.
        LDA     CHAR2,X    ;NO, IS SECOND HALF ZERO?
        BEQ     FORM4      ;YES.
        CMP     #$A5       ;;NO, SECOND HALF OPTIONAL?
        BEQ     FORM4      ;YES.
        LDY     YSAV
FORM3   CLC                ;CLEAR BIT-NO MATCH
FORM4   DEY                ;BACK UP 1 CHAR
FORM5   ROL     FMT        ;FORM FORMAT BYTE
        CPX     #$03       ;TIME TO CHECK FOR ADDR.
        BNE     FORM7      ;NO
        JSR     GETNUM     ;YES
        LDA     A2H
        BEQ     FORM6      ;HIGH-ORDER BYTE ZERO
        INX                ;NO, INCR FOR 2-BYTE
FORM6   STX     LL         ;STORE LENGTH
        LDX     #$03       ;RELOAD FORMAT INDEX
        DEY                ;BACKUP A CHAR
FORM7   STX     A1H        ;SAVE INDEX
        DEX                ;DONE WITH FORMAT CHECK?
        BPL     FORM2      ;NO.
        LDA     FMT        ;YES, PUT LENGTH
        ASL                ;IN LOW BITS
        ASL
        ORA     LL
        CMP     #$20
        BCS     FORM8      ;ADD "$" IF NONZERO LENGTH
        LDX     LL         ;AND DON'T ALREADY HAVE IT
        BEQ     FORM8
        ORA     #$80
FORM8   STA     FMT
        STY     YSAV
        LDA     IN,Y       ;GET NEXT NONBLANK
        CMP     #';'       ;';' START OF COMMENT?
        BEQ     FORM9      ;YES
        CMP     #$8D       ;CARRIAGE RETURN?
        BNE     ERR4       ;NO, ERR.
FORM9   JMP     TRYNEXT

GETNSP  LDA     IN,Y
        INY
        CMP     #$A0       ;GET NEXT NON BLANK CHAR
        BEQ     GETNSP
        RTS

; ***********************
; *
; * APPLE-II
; * MONITOR II
; *
; * COPYRIGHT 1978 BY
; * APPLE COMPUTER, INC.
; *
; * ALL RIGHTS RESERVED
; *
; * STEVE WOZNIAK
; *
; ***********************
INSDS1  LDX     PCL        ;PRINT CLH, H
        LDY     PCH
        JSR     PRYX2
        JSR     PRBLNK     ;FOLLOWD BY A BLANK
        LDA     (PCL,X)    ;GET OPCODE
INSDS2  TAY
        LSR                ;EVEN/ODD TEST
        BCC     IEVEN
        AND     #$0F
        ORA     #$80
IEVEN   LSR                ;LSB INTO CARRY FOR L/R TEST
        TAX
        LDA     ADINDEX,X  ;GET FORMAT INDEX BYTE
        STX     FORMAT
        BIT     FORMAT
        BCC     RIGHT
        LSR
        LSR
        LSR
        BVS     NEXT
        LSR
RIGHT   BVS     IMPAIRL
        AND     #$0F
        BVC     NEXT

IMPAIRL AND     #$07
NEXT    TAX
        LDA     ADMODE,X
        STA     FORMAT
        AND     #$03
        STA     LENGTH
        CPY     #$89
        BNE     OR1
        LDY     #$24
OR1     CPY     #$9E
        BNE     OR2
        LDY     #$64
OR2     TYA
        LSR
        BCS     IMPAIR
        TYA
        AND     #$07
        CMP     #$06
        BEQ     IMPAIR
        TYA
        LSR
        LSR
        BCC     OP0
        ORA     #$40
OP0     LSR
        BCC     OP1
        ORA     #$40
OP1     LDY     #$00
        RTS

IMPAIR  TYA
        AND     #$0F
        TAX
        TYA
        LDY     #$03
        CPX     #$0B
        BEQ     DX3
DX1     LSR
        BCC     DX3
        LSR
DX2     LSR
        ORA     #$40
        DEY
        BNE     DX2
        INY
DX3     DEY
        BNE     DX1
        PHA
        TXA
        LSR
        PLA
        BCS     NOCH
        ORA     #$18
NOCH    RTS

INSTDSP JSR     INSDS1
        PHA
PRNTOP  LDA     (PCL),Y
        JSR     PRBYTE
        LDX     #$01
PRNTBL  JSR     PRBL2
        CPY     LENGTH
        INY
        BCC     PRNTOP
        LDX     #$03
        CPY     #$04
        BCC     PRNTBL
        PLA
        TAY
        LDA     MNEML,Y
        STA     LMNEM
        LDA     MNEMR,Y
        STA     RMNEM
PRMN1   LDA     #$00
        LDY     #$05
PRMN2   ASL     RMNEM
        ROL     LMNEM
        ROL
        DEY
        BNE     PRMN2
        ADC     #'?'
        JSR     COUT
        DEX
        BNE     PRMN1
        JSR     PRBLNK
        LDY     LENGTH
        LDX     #$06
PRADR1  CPX     #$03
        BEQ     PRADR5
PRADR2  ASL     FORMAT
        BCC     PRADR3
        LDA     CHAR1-1,X
        JSR     COUT
        LDA     CHAR2-1,X
        BEQ     PRADR3
        JSR     COUT
PRADR3  DEX
        BNE     PRADR1
        RTS

PRADR4  DEY
        BMI     PRADR2
        JSR     PRBYTE
PRADR5  LDA     FORMAT
        CMP     #$E8
        LDA     (PCL),Y
        BCC     PRADR4
        JSR     PCADJ3
        TAX
        INX
        BNE     PRNTYX
        INY
PRNTYX  TYA
        JSR     PRBYTE
        TXA
        JMP     PRBYTE

PRBLNK  LDX     #$03
PRBL2   LDA     #' '
        JSR     COUT
        DEX
        BNE     PRBL2
        RTS

PCADJ   SEC
        LDA     LENGTH
PCADJ3  LDY     PCH
        TAX
        BPL     PCADJ4
        DEY
PCADJ4  ADC     PCL
        BCC     @EXIT
        INY
@EXIT   RTS

CHAR1   !BYTE   '#'
        !BYTE   '!'
        !BYTE   '#'
        !BYTE   '$'
        !BYTE   '*'
        !BYTE   '%'
CHAR2   !BYTE   'Y'
        !BYTE   $00
        !BYTE   'X'
        !BYTE   '%'
        !BYTE   '%'
        !BYTE   $00
ADINDEX !HEX    3344BB00CA54BB10
        !HEX    0044BB00CA55BB11
        !HEX    3B4FBB00CA5FBB1D
        !HEX    0B44BB0ECA55BB18
        !HEX    DA44BB00CA95BB10
        !HEX    3344BB00CA95BB21
        !HEX    3344BB00CA5CBB1E
        !HEX    3344BB00CA50BB18
        !HEX    86945B988FA55AA9
ADMODE  !HEX    829286218191594D
        !HEX    5A859D00499D4A82
        !HEX    915D49834D930000
MNEML   !HEX    1C8A1C235D8B1BA1
        !HEX    9D8A1D239D8B1DA1
        !HEX    1C2919AE69A81923
        !HEX    24531B23245319A1
        !HEX    241584535D9C1329
        !HEX    C16D348A899C118B
        !HEX    1CAEA5AE69A869AD
        !HEX    9929238AA17CA08B
        !HEX    ADADACAC1A1A1A1A
        !HEX    755B755BA55BA55B
        !HEX    A5A5A5A569696969
        !HEX    2424895B2424895D
        !HEX    8AA98BAD8AA99DA9
        !HEX    8AAE8BAEC0A5C8C9
        !HEX    84133411A56923A0
        !HEX    159C6D9CA5692953
MNEMR   !HEX    D8625A4826629488
        !HEX    5444C8546844E894
        !HEX    C4B4088474B4286E
        !HEX    74F4CC4A72F2A48A
        !HEX    221AC4C81A1ACA88
        !HEX    5C262674A6264874
        !HEX    DA44446872B24432
        !HEX    A2B2A272A222C872
        !HEX    0606C6C6AAAAAAAA
        !HEX    E2A2DEA276A276A2
        !HEX    7474747674747474
        !HEX    747494A272728426
        !HEX    4A284A08580A5A48
        !HEX    467446B29462C40C
        !HEX    C4CA26484444A2C8
        !HEX    1A1A2626727288C8
IRQ     STA     ACC        ;** IRQ HANDLER
        PLA
        PHA
        ASL
        ASL
        ASL
        BMI     BREAK      ;TEST FOR 'BRK'
        JMP     (IRQLOC)   ;USER ROUTINE VECTOR IN RAM

BREAK   PLP
        JSR     SAV1       ;SAVE REG'S ON BREAK
        PLA                ;  INCLUDING PC
        STA     PCL
        PLA
        STA     PCH
        JSR     INSDS1     ;PRINT USER PC
        JSR     RGDSP1     ;  AND REGS
        JMP     MON        ;GO TO MONITOR (NO PASS GO, NO $200)

RESET   CLD                ;DO THIS FIRST TIME
        JSR     SETVID     ;INITIALIZE GRAPHIC CONTROLLER
        JSR     HOME       ;CLEAR SCREEN
        JMP     MON        ;SHOW MONITOR PROMPT

SETVID  LDA     #$18       ;NUMBER ON LINES IN DISPLAY (24)
        STA     WNDBTM
        LDY     #$87       ;REGISTER SELECT
        LDX     #$07       ;INITIALIZE COUNTER
NXT6    LDA     REG,X      ;LOAD INIT TABLE
        JSR     SREG       ;WRITE TO VDP
        DEY                ;DECREMENT REGISTER TO ACCESS
        DEX                ;DECREMENT LOOP INDEX
        BNE     NXT6       ;DONE?
        LDY     #$40       ;BYTE2 ADDRESS SET UP
        LDA     #$00       ;BYTE1 ADDRESS SETUP 1
        JSR     SREG       ;WRITE TO VDP
        LDX     #$C0       ;COUNTER HIGH BYTE
NXTF    LDY     #$00       ;COUNTER LOW BYTE
FILL    STA     VDATA      ;WRITE TO VDP RAM
        INY                ;INCREMENT LOW COUNTER
        BNE     FILL       ;LOW COUNTER FULL
        INX                ;INCREMENT HIGH COUNTER
        BNE     NXTF       ;HIGH COUNTER FULL?
        LDY     #$25
        LDA     #$00
        JSR     SREG
        STA     $50
        LDA     #$F0
        STA     $51
        LDX     #$00
NXT9    LDA     ($50,X)
        STA     VDATA
        INC     $50
        BNE     NXT9
        INC     $51
        LDA     #$F2
        CMP     $51
        BNE     NXT9
        LDY     #$21
        LDA     #$00
        JSR     SREG
        STA     $51
        LDA     #$F0
        STA     $51
        LDX     #$00
NXT7    LDA     ($50,X)
        EOR     #$FF
        STA     VDATA
        INC     $50
        BNE     NXT7
        INC     $51
        LDA     #$F2
        CMP     $51
        BNE     NXT7
        RTS

SREG    STA     VREG       ;SET DATA TO WRITE
        STY     VREG       ;SET VDP REGISTER TO WRITE TO
        RTS

REG     !HEX    00D00000040000F0
        !HEX    60
REGDSP  JSR     CROUT      ;DISPLAY USER REG CONTENTS
RGDSP1  LDA     #$45       ;WITH LABEL
        STA     A3L
        LDA     #$00
        STA     A3H
        LDX     #$FB
RDSP1   LDA     #$A0
        JSR     COUT
        LDA     RTBL-251,X
        JSR     COUT
        LDA     #$BD
        JSR     COUT
        LDA     ACC+5,X
        JSR     PRBYTE
        INX
        BMI     RDSP1
        RTS

RTBL    !BYTE   $C1        ;REGISTER NAMES REGDSP
        !BYTE   $D8
        !BYTE   $D9
        !BYTE   $D0
        !BYTE   $D3

VIDWAIT PHA                ;CHECK FOR A PAUSE
        LDA     #$00
        STA     PORTA
        STA     DDRA
        LDA     #$FF
        STA     PORTB
        STA     DDRB
        LDA     #$04
        STA     PORTA
        STA     DDRA
        LDA     #$00
        STA     DDRB
        LDA     #$FF
        STA     PORTB
YKEY    LDA     PORTB
        CMP     #$FF
        BNE     YKEY
        PLA
        JMP     VIDOUT

BASCALC PHX
        STA     BASH
        LDA     #$00
        LDX     #$08
YOP     LSR     BASH
        BCC     YOP1
        CLC
        ADC     #$28
YOP1    ROR
        ROR     BASL
        DEX
        BNE     YOP
        STA     BASH
        PLX
        CLC
        RTS

STORE   PHA
        TYA
        CLC
        ADC     BASL
        STA     VREG
        LDA     BASH
        ADC     #$00
        ORA     #$40
        STA     VREG
        PLA
        STA     VDATA
RTS3    RTS

BELL1   CMP     #$87       ;BELL CHAR
        BNE     RTS2B      ;  NO, RETURN.
        LDA     #$00       ;  YES...
        STA     SID_FREQL1 ;PREPARE BEEP FREQUENCY
        LDA     #$09
        STA     SID_ATTACK ;AND ATTACK RATE
        LDA     #$1E
        STA     SID_FREQH3
        LDA     #$0F
        STA     SID_MAIN_VOLUME ;SET VOLUME
        LDA     #$15
        STA     SID_CTRL1
        LDA     #$FF
        JSR     WAIT
        LDA     #$14
        STA     SID_CTRL1
RTS2B   RTS

STORADV LDY     CH         ;CURSOR H INDEX TO Y-REG
        JSR     STORE
ADVANCE INC     CH         ;INCREMENT CURSOR H INDEX
        LDA     CH         ;  (MOVE RIGHT)
        CMP     #$28       ;BEYOND WINDOW WIDTH?
        BCS     CR         ;  YES, CR TO NEXT LINE
        RTS

;VIDOUT  CMP     #$A0       ;CONTROL CHAR?
VIDOUT  AND     #$7F
        STA     SERIAL_OUT
        RTS
;        BCS     STORADV    ;  NO, OUTPUT IT
;        CMP     #$8D       ;  CR?,
        BEQ     CR         ;  YES.
        CMP     #$8A       ;LINE FEED?
        BEQ     LF         ;  IF SO, DO IT
        CMP     #$88       ;BACK SPACE?
        BNE     BELL1      ;  NO, CHECK FOR BELL.
BS      DEC     CH         ;DECREMENT CURSOR H INDEX
        BPL     RTS3       ;IF POSITIVE, OK; ELSE MOVE UP.
        LDA     #$28       ;SET CH TO WINDOW WIDTH-1
        STA     CH
        DEC     CH         ;(RIGHTMOST SCREEN POS)
CURSUP  LDA     #$00       ;CURSOR V INDEX
        CMP     CV
        BCS     RTS4       ;IF TOP LINE THEN RETURN
        DEC     CV         ;DECR CURSOR V INDEX
VTAB    LDA     CV         ;GET CURSOR V INDEX
VTABZ   JSR     BASCALC    ;GENERATE BASE ADDRESS
RTS4    RTS

CLREOP  LDY     CH         ;ESC F IS CLR TO END OF LINE
        LDA     CV
CLEOP1  PHA                ;SAVE CURRENT LINE NO. ON STACK
        JSR     VTABZ      ;CALC BASE ADDRESS
        JSR     CLEOLZ     ;CLEAR TO EOL. (SETS CARRY)
        LDY     #$00       ;CLEAR FROM H INDEX=0 FOR REST
        PLA                ;INCREMENT CURRENT LINE NO.
        ADC     #$00       ;(CARRY IS STILL SET)
        CMP     WNDBTM     ;DONE TO BOTTOM OF WINDOW?
        BCC     CLEOP1     ;  NO, KEEP CLEARING LINES
        BCS     VTAB       ;  YES, VTAB TO CURRENT LINE

HOME    LDA     #$00       ;INIT V INDEX
        STA     CV         ;  AND H INDICES
        STA     CH
        TAY
        BEQ     CLEOP1     ;THEN CLEAR TO END OF PAGE.
CR      LDA     #$00       ;CURSOR TO LEFT OF INDEX
        STA     CH         ;  (RET CURSOR H=0)
LF      INC     CV         ;INCR CURSOR V. (DOWN 1 LINE)
        LDA     CV
        CMP     #$18       ;OFF SCREEN?
        BCC     VTABZ      ;  NO, SET BASE ADDR
        DEC     CV         ;DECR CURSOR V. (BACK TO BOTTOM)
SCROLL  LDA     #$00       ;START AT TOP OF SCROLL WINDOW
        PHA
        JSR     VTABZ      ;GENERATE BASE ADDRESS
SCRL1   LDA     BASL       ;COPY BASL,H
        STA     BAS2L      ; TO BAS2L,H
        LDA     BASH
        STA     BAS2H
        LDY     #$28       ;INIT Y TO RIGHTMOST INDEX
        DEY                ;  OF SCROLLING WINDOWS
        PLA
        ADC     #$01       ;INCR LINE NUMBER
        CMP     WNDBTM     ;DONE?
        BCS     SCRL3      ;  YES, FINISH
        PHA
        JSR     VTABZ      ;FORM BASL,H (BASE ADDR)
SCRL2   TYA                ;MOVE A CHAR UP ONE LINE
        CLC
        ADC     BASL       ;NEXT CHAR OF LINE
        STA     VREG
        LDA     BASH
        ADC     #$00
        STA     VREG
        LDA     VDATA
        PHA
        TYA
        ADC     BAS2L
        STA     VREG
        LDA     BAS2H
        ADC     #$00
        ORA     #$40
        STA     VREG
        PLA
        STA     VDATA
        DEY
        BPL     SCRL2
        BMI     SCRL1

SCRL3   LDY     #$00
        JSR     CLEOLZ
        BCS     VTAB
CLREOL  LDY     CH         ;CURSOR H INDEX
CLEOLZ  LDA     #$A0       ;STORE BLANKS FROM 'HERE'
CLEOL2  JSR     STORE      ;  TO END OF LINES (WNDWDTH)
        INY
        CPY     #$28
        BCC     CLEOL2
        RTS

WAIT    SEC
WAIT2   PHA
WAIT3   SBC     #$01
        BNE     WAIT3      ;1.0204 USEC
        PLA                ;(13+2712*A+512*A*A)
        SBC     #$01
        BNE     WAIT2
        RTS

NXTA4   INC     A4L        ;INCR 2-BYTE A4
        BNE     NXTA1      ;  AND A1
        INC     A4H
NXTA1   LDA     AIL        ;INCR 2-BYTE A1
        CMP     A2L        ;  AND COMPARE TO A2
        LDA     A1H        ;  (CARRY SET IF >=)
        SBC     A2H
        INC     AIL
        BNE     RTS4B
        INC     A1H
RTS4B   RTS

HEADR   LDY     #$4B       ;WRITE A*256 'LONG 1'
        JSR     ZERDLY     ;  HALF CYCLES
        BNE     HEADR      ;  (650 USEC EACH)
        ADC     #$FE
        BCS     HEADR      ;THEN A 'SHORT 0'
        LDY     #$21       ;  (400 USEC)
WRBIT   JSR     ZERDLY     ;WRITE TWO HALF CYCLES
        INY                ;  OF 250 USEC ('0')
        INY                ;  OR 500 USEC ('1')
ZERDLY  DEY
        BNE     ZERDLY
        BCC     WRTAPE     ;Y IS COUNT FOR
        LDY     #$32       ;  TIMING LOOP
ONEDLY  DEY
        BNE     ONEDLY
WRTAPE  LDY     TAPEOUT
        LDY     #$2C
        DEX
        RTS

RDBYTE  LDX     #$08       ;8 BITS TO READ
RDBYT2  PHA                ;READ TWO TRANSITIONS
        JSR     RD2BIT     ;  (FIND EDGE)
        PLA
        ROL                ;NEXT BIT
        LDY     #$3A       ;COUNT FOR SAMPLES
        DEX
        BNE     RDBYT2
        RTS

RD2BIT  JSR     RDBIT
RDBIT   DEY                ;DECR Y UNTIL
        LDA     TAPEIN     ;  TAPE TRANSITION
        EOR     LENGTH
        BPL     RDBIT
        EOR     LENGTH
        STA     LENGTH
        CPY     #$80       ;SET CARRY ON Y-REG
        RTS

RDKEY   LDY     CH
        TYA                ;SET SCREEN TO FLASH
        CLC
        ADC     BASL
        STA     VREG
        LDA     BASH
        BCC     YOP5
        ADC     #$00
YOP5    STA     VREG
        LDA     VDATA
        PHA
        AND     #$7F
        JSR     STORE
KEYIN   INC     RNDL       ;INCR RND NUMBER
        BNE     KEYIN2
        INC     RNDH
KEYIN2  LDA     #$00
        STA     PORTA
        LDA     #$FF
        STA     PORTB
        LDA     #$04
        STA     PORTA
        LDA     #$00
        STA     PORTB
        STA     DDRA
        STA     DDRB
        LDA     #$04
        STA     DDRA
YOP8    LDA     DDRB
        CMP     #$00
        BEQ     YOP8
        LDY     #$00
SHFT1   LSR
        BCC     END1
        INY
        BCS     SHFT1

END1    TYA
        ASL
        ASL
        ASL
        STA     $CE
        LDA     #$40
        JSR     WAIT
        LDA     #$FF
        STA     PORTB
        LDA     #$00
        STA     DDRA
        LDA     #$FF
        STA     DDRB
        LDA     #$04
        STA     DDRA
        LDA     #$00
        STA     DDRB
        LDA     PORTB
        LDY     #$00
SHFT2   LSR
        BCC     END2
        INY
        BCS     SHFT2

END2    TYA
        ORA     $CE
        STA     $CE
        PLA
        LDY     CH
        JSR     STORE
YOP9    LDA     PORTB
        CMP     #$FF
        BNE     YOP9
        LDA     $CE
        RTS

SHFT    JSR     RDKEY
        LDY     #$0A
NEXT10  DEY
        BMI     RDCHAR
        CMP     XTAB,Y
        BNE     NEXT10
        LDA     XMEM,Y
        SEC
        SBC     #$0F
        RTS

RDCHAR  JSR     RDKEY      ;GO READ KEY
        CMP     #$15       ;'ESC'?
        BEQ     FCTN
        CMP     #$12
        BEQ     SHFT
        LDY     #$2B
NEXT9   DEY
        BMI     RDCHAR
        CMP     XTAB,Y
        BNE     NEXT9
        LDA     XMEM,Y
        RTS

FCTN    JSR     RDKEY
        CMP     #$1A
        BNE     YEA1
        LDA     #$88
YEA1    CMP     #$22
        BNE     YEA2
        LDA     #$95
YEA2    CMP     #$15
        BNE     RTS8
        JSR     HOME
        JMP     MON

RTS8    RTS

XTAB    !HEX    01051D252D0D0929
        !HEX    2119020F2722262A
        !HEX    14041C242F1A1F03
        !HEX    0A1B10132C0B2B23
        !HEX    061E2E0E08282018
        !HEX    00070C
XMEM    !BYTE   $B0
        !BYTE   $B1
        !BYTE   $B2
        !BYTE   $B3
        !BYTE   $B4
        !BYTE   $B5
        !BYTE   $B6
        !BYTE   $B7
        !BYTE   $B8
        !BYTE   $B9
        !BYTE   $C1
        !BYTE   $C2
        !BYTE   $C3
        !BYTE   $C4
        !BYTE   $C5
        !BYTE   $C6
        !BYTE   $AB
        !BYTE   $AD
        !BYTE   $AE
        !BYTE   $BC
        !BYTE   $D6
        !BYTE   $D3
        !BYTE   $D8
        !BYTE   $BA
        !BYTE   $C7
        !BYTE   $CC
        !BYTE   $8D
        !BYTE   $A0
        !BYTE   $CD
        !BYTE   $C8
        !BYTE   $CA
        !BYTE   $CB
        !BYTE   $D1
        !BYTE   $D7
        !BYTE   $D2
        !BYTE   $D4
        !BYTE   $D9
        !BYTE   $D5
        !BYTE   $C9
        !BYTE   $CF
        !BYTE   $D0
        !BYTE   $DA
        !BYTE   $CE

NOTCR   LDA     INVFLG
        PHA
        LDA     #$FF
        STA     INVFLG     ;CONVERT TYPED CHAR TO NORMAL
        LDA     IN,X
        JSR     COUT       ;ECHO TYPE CHAR
        PLA
        STA     INVFLG
        LDA     IN,X
        CMP     #$88       ;CHECK FOR EDIT KEYS
        BEQ     BCKSPC     ;  - BACKSPACE
        CMP     #$98
        BEQ     CANCEL     ;  - CONTROL-X
        CPX     #$F8
        INX
        BNE     NEXTCHAR
CANCEL  LDA     #$DC       ;BACKSLASH AFTER CANCELLED LINE
        JSR     COUT
GETLNZ  JSR     CROUT      ;OUTPUT 'CR'
        LDA     PROMPT     ;OUTPUT PROMPT CHAR
        JSR     COUT
        LDX     #$01       ;INIT INPUT INDEX
BCKSPC  TXA
        BEQ     GETLNZ     ;WILL BACKSPACE TO 0
        DEX
NEXTCHAR
        JSR     RDCHAR
        CMP     #$95       ;USE SCREEN CHAR
        BNE     CAPTST     ;  FOR CONTROL-U
        LDA     CH
        CLC
        ADC     BASL
        STA     VREG
        LDA     BASH
        BCC     YOP6
        ADC     #$00
YOP6    STA     VREG
        LDA     VDATA
CAPTST  CMP     #$E0       ;LOWER CASE?
        BCC     ADDINP
        AND     #$DF
ADDINP  STA     IN,X       ;ADD TO INPUT BUFFER
        CMP     #$8D
        BNE     NOTCR
        JSR     CLREOL     ;CLR TO EOL IF CR
CROUT   LDA     #$8D
        BNE     COUT       ;(ALWAYS)

PRA1    LDY     A1H        ;PRINT CR,A1 IN HEX
        LDX     AIL
PRYX2   JSR     CROUT
        JSR     PRNTYX
        LDY     #$00
        LDA     #'-'       ;PRINT '-'
        JMP     COUT

XAM8    LDA     AIL
        ORA     #$07       ;SET TO FINISH AT
        STA     A2L        ;  MOD 8=7
        LDA     A1H
        STA     A2H
MOD8CHK LDA     AIL
        AND     #$07
        BNE     DATAOUT
XAM     JSR     PRA1
DATAOUT LDA     #$A0
        JSR     COUT       ;OUTPUT BLANK
        LDA     (AIL),Y
        JSR     PRBYTE     ;OUTPUT BYTE IN HEX
        JSR     NXTA1
        BCC     MOD8CHK    ;NOT DONE YET. GO CHECK MOD 8
        RTS                ;DONE

XAMPM   LSR                ;DETERMINE IF MONITOR MODE IS
        BCC     XAM        ;  EXAMINE, ADD OR SUBSTRACT
        LSR
        LSR
        LDA     A2L
        BCC     ADD
        EOR     #$FF       ;FROM 2'S COMPLEMENT TO SUBSTRACT
ADD     ADC     AIL
        PHA
        LDA     #'='       ;PRINT '=', THEN RESULT
        JSR     COUT
        PLA
PRBYTE  PHA                ;PRINT BYTE AS 2 HEX DIGITS
        LSR
        LSR
        LSR
        LSR
        JSR     PRHEXZ
        PLA
PRNHEX  AND     #$0F       ;PRINT HEX DIGIT IN A-REG
PRHEXZ  ORA     #$B0       ;LSBITS ONLY
        CMP     #$BA
        BCC     COUT
        ADC     #$06
COUT    NOP
        CMP     #$A0
        BCC     COUTZ
        AND     INVFLG
COUTZ   STY     LL         ;SAVE Y-REG
        PHA                ;SAVE A-REG
        JSR     VIDWAIT    ;OUTPUT CHR AND  CHECK FOR CTRL-S
        PLA
        LDY     LL
        RTS

BL1     DEC     YSAV
        BEQ     XAM8
BLANK   DEX                ;BLANK TO MON
        BNE     SETMDZ     ;AFTER BLANK
        CMP     #$BA       ;DATA STORE MODE?
        BNE     XAMPM      ;  NO, XAM, ADD, OR SUBSTRACT
        STA     MODE       ;KEEP IN STORE MODE
        LDA     A2L
        STA     (A3L),Y    ;STORE AS LOW BYTE AT (A3)
        INC     A3L
        BNE     RTS5
        INC     A3H
RTS5    RTS

SETMODE LDY     YSAV       ;SAVE CONVERTED ':', '+',
        LDA     IN-1,Y     ;  '-', '.' AS MODE
SETMDZ  STA     MODE
        RTS

LT      LDX     #$01
LT2     LDA     A2L,X      ;COPY A2 (2 BYTES) TO
        STA     A4L,X      ;  A4 AND A5
        STA     FMT,X
        DEX
        BPL     LT2
        RTS

MOVE    LDA     (AIL),Y    ;MOVE (A1) THRU (A2) TO (A4)
        STA     (A4L),Y
        JSR     NXTA4
        BCC     MOVE
        RTS

VFY     LDA     (AIL),Y    ;VERIFY (A1) THRU (A2)
        CMP     (A4L),Y    ;  WITH (A4)
        BEQ     VFYOK
        JSR     PRA1
        LDA     (AIL),Y
        JSR     PRBYTE
        LDA     #$A0
        JSR     COUT
        LDA     #$AA
        JSR     COUT
        LDA     (A4L),Y
        JSR     PRBYTE
        LDA     #$A1
        JSR     COUT
VFYOK   JSR     NXTA4
        BCC     VFY
        RTS

LIST    JSR     A1PC       ;MOVE A1 (2 BYTES) TO
        LDA     #$14       ;  PC IF SPEC'D AND
LIST2   PHA                ;  DISASSEMBLE 20 INSTRUCTIONS
        JSR     INSTDSP
        JSR     PCADJ      ;ADJUST PC AFTER EACH INSTRUCTION
        STA     PCL
        STY     PCH
        PLA
        SEC
        SBC     #$01       ;NEXT OF 20 INSTRUCTIONS
        BNE     LIST2
        RTS

A1PC    TXA                ;IF USER SPECIFIEC AN ADDRESS
        BEQ     A1PCRTS    ;  COPY IT FROM A1 TO PC.
A1PCLP  LDA     AIL,X      ;YEP, SO COPY IT
        STA     PCL,X
        DEX
        BPL     A1PCLP
A1PCRTS RTS

GO      JSR     A1PC       ;ADDR TO PC IF SPECIFIED
        JSR     RESTORE    ;RESTORE FAKE REGISTERS
        JMP     (PCL)      ;AND GO!

REGZ    JMP     REGDSP     ;GO DISPLAY REGISTERS

        RTS

MINI    JMP     MINIASM

STEPZ   RTS                ;STEP IS DONE

WRITE   LDA     #$40       ;TAPE WRITE ROUTINE
        JSR     HEADR      ;WRITE 10-SEC HEADER
        LDY     #$27
WR1     LDX     #$00
        EOR     (AIL,X)
        PHA
        LDA     (AIL,X)
        JSR     WRBYTE
        JSR     NXTA1
        LDY     #$1D
        PLA
        BCC     WR1
        LDY     #$22
        JSR     WRBYTE
        BEQ     BELL
WRBYTE  LDX     #$10
WRBYT2  ASL
        JSR     WRBIT
        BNE     WRBYT2
        RTS

CRMON   JSR     BL1        ;HANDLE CR AS BLANK
        PLA                ;  THEN POP STACK
        PLA                ;  AND RETURN TO MON
        BNE     MONZ       ;  (ALWAYS)
READ    LDA     #$00       ;TAPE READE - FIND TAPEIN EDGE
        STA     $C005
        STA     TAPEIN
        LDA     #$04
        STA     $C005
        JSR     RD2BIT
        LDA     #$16       ;DELAY 3.5 SECONDS
        JSR     HEADR
        STA     FORMAT     ;INITIAL CHECKSUM = $FF
        JSR     RD2BIT     ;FIND AN EDGE
RD2     LDY     #$24       ;LOOK FOR SYNC BIT
        JSR     RDBIT      ;  (SHORT 0)
        BCS     RD2        ;LOOP 'TIL FOUND
        JSR     RDBIT      ;SKIP 2ND HALF CYCLE
        LDY     #$3B       ;INDEX FOR 0/1 TEST
RD3     JSR     RDBYTE     ;READ A BYTE
        STA     (AIL,X)    ;PUT IT IN (A1)
        EOR     FORMAT     ;UPDATE RUNNING CHECKSUM
        STA     FORMAT
        JSR     NXTA1      ;INCR A1, COMPARE TO A2
        LDY     #$35       ;COMPENSATE 0/1 INDEX
        BCC     RD3        ;REPEAT 'TIL DONE
        JSR     RDBYTE     ;READ CHECKSUM BYTE
        CMP     FORMAT     ;DOES THE RECORDED CHKSM MATCH OURS?
        BEQ     BELL       ;  YES, READ OK, BEEP AND RETURN
        LDA     #$C5       ;PRINT 'ERR', THEN FALL INTO
        JSR     COUT       ;  FWEEPER
        LDA     #$D2
        JSR     COUT
        JSR     COUT
BELL    LDA     #$87       ;MAKE A JOYFUL SOUND, THEN RETURN
        JMP     COUT

RESTORE LDA     STATUS     ;RESTORE 6502 REGISTER CONTENTS
        PHA                ;  USED BY DEBUG SOFTWARE
        LDA     ACC
        LDX     XREG
        LDY     YREG
        PLP
        RTS

SAVE    STA     ACC        ;SAVE 6502 REGISTER CONTENTS
SAV1    STX     XREG       ;  FOR DEBUG SOFTWARE
        STY     YREG
        PHP
        PLA
        STA     STATUS
        TSX
        STX     SPNT
        CLD
        RTS

MON     CLD                ;MUST SET HEX MODE!
        JSR     BELL       ;FWEEPER
MONZ    LDA     #')'       ;PROMPT FOR MONITOR
        STA     PROMPT
        JSR     GETLNZ     ;READ A LINE OF INPUT
        JSR     ZMODE      ;CLEAR MONITOR MODE. SCAN IDX
NXTITM  JSR     GETNUM     ;GET ITEM, NON-HEX
        STY     YSAV       ;  CHAR IN A-REG
        LDY     #$10       ;  X-REG=0 IF NO HEX INPUT
CHRSRCH DEY
        BMI     MON        ;COMMAND NOT FOUND, BEEP & TRY AGAIN
        CMP     CHRTBL,Y   ;FIND COMMAND CHAR IN TABLE
        BNE     CHRSRCH    ;NOT THIS TIME
        JSR     TOSUB      ;GOT IT! CALL CORRESPONDING SUBROUTINE
        LDY     YSAV       ;PROCESS NEXT ENTRY ON HIS LINE
        JMP     NXTITM

DIG     LDX     #$03
        ASL
        ASL                ;GOT HEX DIGIT
        ASL                ;  SHIFT INTO A2
        ASL
NXTBIT  ASL
        ROL     A2L
        ROL     A2H
        DEX                ;LEAVE X=$FF IF DIG
        BPL     NXTBIT
NXTBAS  LDA     MODE
        BNE     NXTBS2     ;IF MODE IS ZERO.
        LDA     A2H,X      ;  THEN COPY A2 TO A1 AND A3
        STA     A1H,X
        STA     A3H,X
NXTBS2  INX
        BEQ     NXTBAS
        BNE     NXTCHR

GETNUM  LDX     #$00       ;CLEAR A2
        STX     A2L
        STX     A2H
NXTCHR  LDA     IN,Y       ;GET CHAR
        INY
        EOR     #$B0
        CMP     #$0A
        BCC     DIG        ;BR IF HEX DIGIT
        ADC     #$88
        CMP     #$FA
        BCS     DIG
        RTS

TOSUB   LDA     #>GO       ;DISPATCH TO SUBROUTINE, BY
        PHA                ;  PUSHING THE HI-ORDER SUBR ADDR,
        LDA     SUBTBL,Y   ;  THEN THE LO-ORDER SUBR ADDR
        PHA                ;  ONTO THE STACK.
        LDA     MODE       ;  (CLEARING THE MODE, SAVE THE OLD
ZMODE   LDY     #$00       ;  MODE IN A-REG).
        STY     MODE
        RTS                ;  AND 'RTS' TO THE SUBROUTINE

CHRTBL  !BYTE   $BE        ;^E  (OPEN AND DISPLAY REGISTERS)
        !BYTE   $EF        ;V   (MEMORY VERIFY)
        !BYTE   $B2        ;T   (ONCE WAS TRACE, NEVER USED. )
        !BYTE   $F1        ;X   (MINIASSEMBLER)
        !BYTE   $A6        ;'-' (SUBSTRACTION)
        !BYTE   $A4        ;'+' (ADDITION)
        !BYTE   $A7        ;'.' (ADDRESS DELIMITER)
        !BYTE   $93        ;':' (MEMORY FILL)
        !BYTE   $00        ;G   (EXECUTE PROGRAM)
        !BYTE   $05        ;L   (DISSASSEMBLE 20 INSTRS)
        !BYTE   $95        ;'<' (DELIMITER FOR MOVE, VFY)
        !BYTE   $C6        ;'CR' (END OF INPUT)
        !BYTE   $99        ;BLANK
        !BYTE   $06        ;M   (MEMORY MOVE)
        !BYTE   $F0        ;W   (WRITE TO TAPE)
        !BYTE   $EB        ;R   (READ FROM TAPE)
SUBTBL  !BYTE   <REGZ-1    ;CTRL-E
        !BYTE   <VFY-1     ;VERIFY
        !BYTE   <STEPZ-1   ;STEP
        !BYTE   <MINI-1    ;ASSEM
        !BYTE   <SETMODE-1
        !BYTE   <SETMODE-1
        !BYTE   <SETMODE-1
        !BYTE   <SETMODE-1
        !BYTE   <GO-1      ;GO
        !BYTE   <LIST-1    ;LIST
        !BYTE   <LT-1      ;ADDRESS DELIMITER
        !BYTE   <CRMON-1   ;CR (END OF INPUT)
        !BYTE   <BLANK-1   ;BLANK
        !BYTE   <MOVE-1    ;MOVE
        !BYTE   <WRITE-1   ;WRITE
        !BYTE   <READ-1    ;READ CASSETTE
        !BYTE   $00
        !BYTE   $00
        !BYTE   $00
        !BYTE   $00
        !BYTE   $00
        !BYTE   $00
        !BYTE   $00
        !BYTE   $00
        !BYTE   $00
        !BYTE   $00
        !BYTE   $00
        !BYTE   $00
        !BYTE   $00
        !BYTE   $00
        !BYTE   $00
        !BYTE   $00
        !WORD   $0000      ;COP VECTOR
        !WORD   IRQ        ;BRK VECTOR
        !WORD   $0000      ;ABORT VECTOR
        !WORD   $03FB      ;NON-MASKABLE INTERRUPT VECTOR
        !WORD   RESET      ;RESET VECTOR
        !WORD   IRQ        ;INTERRUPT REQUEST VECTOR
