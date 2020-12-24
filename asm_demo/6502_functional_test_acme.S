; Target assembler: acme v0.96.4 []
; 6502bench SourceGen v1.7.3
        !CPU    6502
*       =       $0000
        !pseudopc $0000 {
L0000   !FILL   10,$00
irq_a   !BYTE   $00
irq_x   !BYTE   $00
zpt     !BYTE   $00
ad1     !BYTE   $00
ad2     !BYTE   $00
adrl    !BYTE   $00
adrh    !BYTE   $00
adrf    !BYTE   $00
sb2     !BYTE   $00
zp1     !HEX    C3824100
zp7f    !BYTE   $7F
zpOR    !HEX    001F7180
zpAN    !HEX    0FFF7F80
zpEO    !HEX    FF0F8F8F
ind1    !WORD   abs1
        !WORD   abs1+1
        !WORD   abs1+2
        !WORD   abs1+3
L002C   !WORD   abs7f
inw1    !WORD   abs1-248
indt    !WORD   ada2
        !WORD   sba2
        !WORD   sba2+1
        !WORD   sba2+2
inwt    !WORD   zp_bss_end+177
indAN   !WORD   absAN
        !WORD   absAN+1
        !WORD   absAN+2
        !WORD   absAN+3
indEO   !WORD   absEO
        !WORD   absEO+1
L0046   !WORD   absEO+2
        !WORD   absEO+3
indOR   !WORD   absOR
        !WORD   absOR+1
        !WORD   absOR+2
        !WORD   absOR+3
adi2    !WORD   ada2
sbi2    !WORD   sba2
adiy2   !WORD   ada2-255
sbiy2   !WORD   sba2-255
zp_bss_end
        !FILL   422,$FF
        } ;!pseudopc
        !pseudopc $0200 {
test_case
        !BYTE   $00
ram_chksm
        !WORD   $0000
; add/subtract operand copy - abs tests write area
ada2    !BYTE   $00
sba2    !FILL   4,$00

ex_andi AND     #$00
        RTS

ex_eori EOR     #$00
        RTS

ex_orai ORA     #$00
        RTS

ex_adci ADC     #$00
        RTS

ex_sbci SBC     #$00
        RTS

abs1    !HEX    C3824100
abs7f   !BYTE   $7F
; loads
fLDx    !HEX    80800002
; shifts
rROL    !HEX    86048200
rROLc   !HEX    87058301
rROR    !HEX    61412000
rRORc   !HEX    E1C1A080
fROL    !HEX    81018002
fROLc   !HEX    81018000
fROR    !HEX    01000102
fRORc   !HEX    81808180
; increments (decrements)
rINC    !HEX    7F80FF0001
fINC    !HEX    0080800200
; logical memory operand
absOR   !HEX    001F7180
absAN   !HEX    0FFF7F80
absEO   !HEX    FF0F8F8F
; logical accu operand
absORa  !HEX    00F11F00
absANa  !HEX    F0FFFFFF
absEOa  !HEX    FFF0F00F
; logical results
absrlo  !HEX    00FF7F80
absflo  !HEX    02800080
        !FILL   406,$FF

        } ;!pseudopc
        !pseudopc $0400 {
start   CLD
        LDX     #$FF
        TXS
        LDA     #$00       ;*** test 0 = initialize
        STA     test_case
        LDX     #$05
        JMP     psb_test

psb_bwok
        LDY     #$05
        BNE     psb_forw

@L0412  JMP     @L0412     ;branch should be taken

        DEY                ;forward landing zone
        DEY
        DEY
        DEY
        DEY
psb_forw
        DEY
        DEY
        DEY
        DEY
        DEY
        BEQ     psb_fwok
@L0421  JMP     @L0421

        DEX                ;backward landing zone
        DEX
        DEX
        DEX
        DEX
psb_back
        DEX
        DEX
        DEX
        DEX
        DEX
        BEQ     psb_bwok
@L0430  JMP     @L0430

psb_test
        BNE     psb_back

@L0435  JMP     @L0435

psb_fwok
        LDA     test_case  ;previous test
        CMP     #$00
@L043D  BNE     @L043D
        LDA     #$01
        STA     test_case
        LDY     #$FE       ;testing maximum range, not -1/-2 (invalid/self adr)
range_loop
        DEY
        TYA
        TAX
        BPL     range_fw
        CLC
        ADC     #$02
        NOP
        NOP
        NOP
        NOP
        NOP
range_fw
        NOP
        NOP
        NOP
        NOP
        NOP
        EOR     #$7F
        STA     range_op+1
        LDA     #$00
        JMP     range_op

        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
range_op
        BEQ     @L0525
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
@L0525  DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        DEX
        NOP
        NOP
        NOP
        NOP
        NOP
        BEQ     range_ok
@L056D  JMP     @L056D

        NOP
        NOP
        NOP
        NOP
        NOP
range_ok
        NOP
        NOP
        NOP
        NOP
        NOP
        CPY     #$00
        BEQ     range_end
        JMP     range_loop

range_end
        LDA     test_case
        CMP     #$01
@L0586  BNE     @L0586
        LDA     #$02
        STA     test_case
        CPY     #$01
        BNE     test_bne
@L0591  JMP     @L0591

test_bne
        LDA     #$00
        CMP     #$00
@L0598  BNE     @L0598
@L059A  BCC     @L059A
@L059C  BMI     @L059C
        CMP     #$01
@L05A0  BEQ     @L05A0
@L05A2  BCS     @L05A2
@L05A4  BPL     @L05A4
        TAX
        CPX     #$00
@L05A9  BNE     @L05A9
@L05AB  BCC     @L05AB
@L05AD  BMI     @L05AD
        CPX     #$01
@L05B1  BEQ     @L05B1
@L05B3  BCS     @L05B3
@L05B5  BPL     @L05B5
        TAY
        CPY     #$00
@L05BA  BNE     @L05BA
@L05BC  BCC     @L05BC
@L05BE  BMI     @L05BE
        CPY     #$01
@L05C2  BEQ     @L05C2
@L05C4  BCS     @L05C4
@L05C6  BPL     @L05C6
        LDA     test_case
        CMP     #$02
@L05CD  BNE     @L05CD
        LDA     #$03
        STA     test_case
; testing stack operations PHA PHP PLA PLP
        LDX     #$FF       ;initialize stack
        TXS
        LDA     #$55
        PHA
        LDA     #$AA
        PHA
        CMP     zp_bss_end+$1A4
@L05E0  BNE     @L05E0
        TSX
        TXA
        CMP     #$FD
@L05E6  BNE     @L05E6
        PLA
        CMP     #$AA
@L05EB  BNE     @L05EB
        PLA
        CMP     #$55
@L05F0  BNE     @L05F0
        CMP     test_case-1
@L05F5  BNE     @L05F5
        TSX
        CPX     #$FF
@L05FA  BNE     @L05FA
        LDA     test_case
        CMP     #$03
@L0601  BNE     @L0601
        LDA     #$04
        STA     test_case
        LDA     #$FF
        PHA
        PLP
        BPL     nbr1
        BVC     nbr2
        BCC     nbr3
        BNE     nbr4
        BMI     br1

@L0616  JMP     @L0616

br1     BVS     br2

        !BYTE   $4C
        !BYTE   $1B
        !BYTE   $06

br2     BCS     br3

        !BYTE   $4C
        !BYTE   $20
        !BYTE   $06

br3     BEQ     br4

        !BYTE   $4C
        !BYTE   $25
        !BYTE   $06

nbr1    JMP     nbr1

nbr2    JMP     nbr2

nbr3    JMP     nbr3

nbr4    JMP     nbr4

br4     PHP
        TSX
        CPX     #$FE
@L0638  BNE     @L0638
        PLA
        CMP     #$FF
@L063D  BNE     @L063D
        TSX
        CPX     #$FF
@L0642  BNE     @L0642
        LDA     #$00
        PHA
        PLP
        BMI     nbr11
        BVS     nbr12
        BCS     nbr13
        BEQ     nbr14
        BPL     br11

        !BYTE   $4C
        !BYTE   $52
        !BYTE   $06

br11    BVC     br12

        !BYTE   $4C
        !BYTE   $57
        !BYTE   $06

br12    BCC     br13

        !BYTE   $4C
        !BYTE   $5C
        !BYTE   $06

br13    BNE     br14

        !BYTE   $4C
        !BYTE   $61
        !BYTE   $06

nbr11   JMP     nbr11

nbr12   JMP     nbr12

nbr13   JMP     nbr13

nbr14   JMP     nbr14

br14    PHP
        PLA
        CMP     #$30
@L0674  BNE     @L0674
; crosscheck flags
        LDA     #$02
        PHA
        PLP
        BNE     brzs1
        BEQ     brzs2

brzs1   JMP     brzs1

brzs2   BCS     brzs3
        BCC     brzs4

brzs3   JMP     brzs3

brzs4   BMI     brzs5
        BPL     brzs6

brzs5   JMP     brzs5

brzs6   BVS     brzs7
        BVC     brzs8

brzs7   JMP     brzs7

brzs8   LDA     #$01
        PHA
        PLP
        BEQ     brcs1
        BNE     brcs2

brcs1   JMP     brcs1

brcs2   BCC     brcs3
        BCS     brcs4

brcs3   JMP     brcs3

brcs4   BMI     brcs5
        BPL     brcs6

brcs5   JMP     brcs5

brcs6   BVS     brcs7
        BVC     brcs8

brcs7   JMP     brcs7

brcs8   LDA     #$80
        PHA
        PLP
        BEQ     brmi1
        BNE     brmi2

brmi1   JMP     brmi1

brmi2   BCS     brmi3
        BCC     brmi4

brmi3   JMP     brmi3

brmi4   BPL     brmi5
        BMI     brmi6

brmi5   JMP     brmi5

brmi6   BVS     brmi7
        BVC     brmi8

brmi7   JMP     brmi7

brmi8   LDA     #$40
        PHA
        PLP
        BEQ     brvs1
        BNE     brvs2

brvs1   JMP     brvs1

brvs2   BCS     @L06E5
        BCC     @L06E8

@L06E5  JMP     @L06E5

@L06E8  BMI     @L06EC
        BPL     @L06EF

@L06EC  JMP     @L06EC

@L06EF  BVC     @L06F3
        BVS     @L06F6

@L06F3  JMP     @L06F3

@L06F6  LDA     #$FD
        PHA
        PLP
        BEQ     @L06FE
        BNE     @L0701

@L06FE  JMP     @L06FE

@L0701  BCC     @L0705
        BCS     @L0708

@L0705  JMP     @L0705

@L0708  BPL     @L070C
        BMI     @L070F

@L070C  JMP     @L070C

@L070F  BVC     @L0713
        BVS     @L0716

@L0713  JMP     @L0713

@L0716  LDA     #$FE
        PHA
        PLP
        BNE     @L071E
        BEQ     @L0721

@L071E  JMP     @L071E

@L0721  BCS     @L0725
        BCC     @L0728

@L0725  JMP     @L0725

@L0728  BPL     @L072C
        BMI     @L072F

@L072C  JMP     @L072C

@L072F  BVC     @L0733
        BVS     @L0736

@L0733  JMP     @L0733

@L0736  LDA     #$7F
        PHA
        PLP
        BNE     @L073E
        BEQ     @L0741

@L073E  JMP     @L073E

@L0741  BCC     @L0745
        BCS     @L0748

@L0745  JMP     @L0745

@L0748  BMI     @L074C
        BPL     @L074F

@L074C  JMP     @L074C

@L074F  BVC     @L0753
        BVS     @L0756

@L0753  JMP     @L0753

@L0756  LDA     #$BF
        PHA
        PLP
        BNE     @L075E
        BEQ     @L0761

@L075E  JMP     @L075E

@L0761  BCC     @L0765
        BCS     @L0768

@L0765  JMP     @L0765

@L0768  BPL     @L076C
        BMI     @L076F

@L076C  JMP     @L076C

@L076F  BVS     @L0773
        BVC     @L0776

@L0773  JMP     @L0773

@L0776  LDA     test_case
        CMP     #$04
@L077B  BNE     @L077B
        LDA     #$05
        STA     test_case
        LDX     #$55
        LDY     #$AA
        LDA     #$FF
        PHA
        LDA     #$01
        PLP
        PHA
        PHP
        CMP     #$01
@L0790  BNE     @L0790
        PLA
        PHA
        CMP     #$FF
@L0796  BNE     @L0796
        PLP
        LDA     #$00
        PHA
        LDA     #$00
        PLP
        PHA
        PHP
        CMP     #$00
@L07A3  BNE     @L07A3
        PLA
        PHA
        CMP     #$30
@L07A9  BNE     @L07A9
        PLP
        LDA     #$FF
        PHA
        LDA     #$FF
        PLP
        PHA
        PHP
        CMP     #$FF
@L07B6  BNE     @L07B6
        PLA
        PHA
        CMP     #$FF
@L07BC  BNE     @L07BC
        PLP
        LDA     #$00
        PHA
        LDA     #$01
        PLP
        PHA
        PHP
        CMP     #$01
@L07C9  BNE     @L07C9
        PLA
        PHA
        CMP     #$30
@L07CF  BNE     @L07CF
        PLP
        LDA     #$FF
        PHA
        LDA     #$00
        PLP
        PHA
        PHP
        CMP     #$00
@L07DC  BNE     @L07DC
        PLA
        PHA
        CMP     #$FF
@L07E2  BNE     @L07E2
        PLP
        LDA     #$00
        PHA
        LDA     #$FF
        PLP
        PHA
        PHP
        CMP     #$FF
@L07EF  BNE     @L07EF
        PLA
        PHA
        CMP     #$30
@L07F5  BNE     @L07F5
        PLP
        LDA     #$FF
        PHA
        LDA     #$00
        PLP
        PLA
        PHP
        CMP     #$FF
@L0802  BNE     @L0802
        PLA
        PHA
        CMP     #$FD
@L0808  BNE     @L0808
        PLP
        LDA     #$00
        PHA
        LDA     #$FF
        PLP
        PLA
        PHP
        CMP     #$00
@L0815  BNE     @L0815
        PLA
        PHA
        CMP     #$32
@L081B  BNE     @L081B
        PLP
        LDA     #$FF
        PHA
        LDA     #$FE
        PLP
        PLA
        PHP
        CMP     #$01
@L0828  BNE     @L0828
        PLA
        PHA
        CMP     #$7D
@L082E  BNE     @L082E
        PLP
        LDA     #$00
        PHA
        LDA     #$00
        PLP
        PLA
        PHP
        CMP     #$FF
@L083B  BNE     @L083B
        PLA
        PHA
        CMP     #$B0
@L0841  BNE     @L0841
        PLP
        LDA     #$FF
        PHA
        LDA     #$FF
        PLP
        PLA
        PHP
        CMP     #$00
@L084E  BNE     @L084E
        PLA
        PHA
        CMP     #$7F
@L0854  BNE     @L0854
        PLP
        LDA     #$00
        PHA
        LDA     #$FE
        PLP
        PLA
        PHP
        CMP     #$01
@L0861  BNE     @L0861
        PLA
        PHA
        CMP     #$30
@L0867  BNE     @L0867
        PLP
        CPX     #$55
@L086C  BNE     @L086C
        CPY     #$AA
@L0870  BNE     @L0870
        LDA     test_case
        CMP     #$05
@L0877  BNE     @L0877
        LDA     #$06
        STA     test_case
        LDA     #$00
        PHA
        LDA     #$3C
        PLP
        EOR     #$C3
        PHP
        CMP     #$FF
@L0889  BNE     @L0889
        PLA
        PHA
        CMP     #$B0
@L088F  BNE     @L088F
        PLP
        LDA     #$00
        PHA
        LDA     #$C3
        PLP
        EOR     #$C3
        PHP
        CMP     #$00
@L089D  BNE     @L089D
        PLA
        PHA
        CMP     #$32
@L08A3  BNE     @L08A3
        PLP
        LDA     test_case
        CMP     #$06
@L08AB  BNE     @L08AB
        LDA     #$07
        STA     test_case
        LDX     #$24
        LDY     #$42
        LDA     #$00
        PHA
        LDA     #$18
        PLP
        NOP
        PHP
        CMP     #$18
@L08C0  BNE     @L08C0
        PLA
        PHA
        CMP     #$30
@L08C6  BNE     @L08C6
        PLP
        CPX     #$24
@L08CB  BNE     @L08CB
        CPY     #$42
@L08CF  BNE     @L08CF
        LDX     #$DB
        LDY     #$BD
        LDA     #$FF
        PHA
        LDA     #$E7
        PLP
        NOP
        PHP
        CMP     #$E7
@L08DF  BNE     @L08DF
        PLA
        PHA
        CMP     #$FF
@L08E5  BNE     @L08E5
        PLP
        CPX     #$DB
@L08EA  BNE     @L08EA
        CPY     #$BD
@L08EE  BNE     @L08EE
        LDA     test_case
        CMP     #$07
@L08F5  BNE     @L08F5
        LDA     #$08
        STA     test_case
        LDA     #$00
        PHA
        PLP
        LDA     #$46
        LDX     #$41
        LDY     #$52
        JMP     L36EF

        NOP
        NOP
@L090B  BNE     @L090B
        INX
        INX
far_ret BEQ     far_ret
@L0911  BPL     @L0911
@L0913  BCC     @L0913
@L0915  BVC     @L0915
        CMP     #$EC
@L0919  BNE     @L0919
        CPX     #$42
@L091D  BNE     @L091D
        CPY     #$4F
@L0921  BNE     @L0921
        DEX
        INY
        INY
        INY
        EOR     #$AA
        JMP     @L0932

        NOP
        NOP
@L092E  BNE     @L092E
        INX
        INX
@L0932  BEQ     @L0932
@L0934  BMI     @L0934
@L0936  BCC     @L0936
@L0938  BVC     @L0938
        CMP     #$46
@L093C  BNE     @L093C
        CPX     #$41
@L0940  BNE     @L0940
        CPY     #$52
@L0944  BNE     @L0944
        LDA     test_case
        CMP     #$08
@L094B  BNE     @L094B
        LDA     #$09
        STA     test_case
        LDA     #$00
        PHA
        PLP
        LDA     #$49
        LDX     #$4E
        LDY     #$44
        JMP     (ptr_tst_ind)

        NOP
@L0960  BNE     @L0960
        DEY
        DEY
ind_ret PHP
        DEY
        DEY
        DEY
        PLP
@L0969  BEQ     @L0969
@L096B  BPL     @L096B
@L096D  BCC     @L096D
@L096F  BVC     @L096F
        CMP     #$E3
@L0973  BNE     @L0973
        CPX     #$4F
@L0977  BNE     @L0977
        CPY     #$3E
@L097B  BNE     @L097B
        TSX
        CPX     #$FF
@L0980  BNE     @L0980
        LDA     test_case
        CMP     #$09
@L0987  BNE     @L0987
        LDA     #$0A
        STA     test_case
        LDA     #$00
        PHA
        PLP
        LDA     #$4A
        LDX     #$53
        LDY     #$52
        JSR     test_jsr
        PHP
        DEY
        DEY
        DEY
        PLP
@L09A0  BEQ     @L09A0
@L09A2  BPL     @L09A2
@L09A4  BCC     @L09A4
@L09A6  BVC     @L09A6
        CMP     #$E0
@L09AA  BNE     @L09AA
        CPX     #$54
@L09AE  BNE     @L09AE
        CPY     #$4C
@L09B2  BNE     @L09B2
        TSX
        CPX     #$FF
@L09B7  BNE     @L09B7
        LDA     test_case
        CMP     #$0A
@L09BE  BNE     @L09BE
        LDA     #$0B
        STA     test_case
        LDA     #$00
        PHA
        LDA     #$42
        LDX     #$52
        LDY     #$4B
        PLP
        BRK

        DEY
        PHP
        DEY
        DEY
        DEY
        CMP     #$E8
@L09D7  BNE     @L09D7
        CPX     #$53
@L09DB  BNE     @L09DB
        CPY     #$45
@L09DF  BNE     @L09DF
        PLA
        CMP     #$30
@L09E4  BNE     @L09E4
        TSX
        CPX     #$FF
@L09E9  BNE     @L09E9
        LDA     #$FF
        PHA
        LDA     #$BD
        LDX     #$AD
        LDY     #$B4
        PLP
        BRK

        DEY
        PHP
        DEY
        DEY
        DEY
        CMP     #$17
@L09FD  BNE     @L09FD
        CPX     #$AE
@L0A01  BNE     @L0A01
        CPY     #$AE
@L0A05  BNE     @L0A05
        PLA
        CMP     #$FF
@L0A0A  BNE     @L0A0A
        TSX
        CPX     #$FF
@L0A0F  BNE     @L0A0F
        LDA     test_case
        CMP     #$0B
@L0A16  BNE     @L0A16
        LDA     #$0C
        STA     test_case
        LDA     #$FF
        PHA
        PLP
        CLC
        PHP
        PLA
        PHA
        CMP     #$FE
@L0A27  BNE     @L0A27
        PLP
        SEC
        PHP
        PLA
        PHA
        CMP     #$FF
@L0A30  BNE     @L0A30
        PLP
        CLI
        PHP
        PLA
        PHA
        CMP     #$FB
@L0A39  BNE     @L0A39
        PLP
        SEI
        PHP
        PLA
        PHA
        CMP     #$FF
@L0A42  BNE     @L0A42
        PLP
        CLD
        PHP
        PLA
        PHA
        CMP     #$F7
@L0A4B  BNE     @L0A4B
        PLP
        SED
        PHP
        PLA
        PHA
        CMP     #$FF
@L0A54  BNE     @L0A54
        PLP
        CLV
        PHP
        PLA
        PHA
        CMP     #$BF
@L0A5D  BNE     @L0A5D
        PLP
        LDA     #$00
        PHA
        PLP
        PHP
        PLA
        PHA
        CMP     #$30
@L0A69  BNE     @L0A69
        PLP
        SEC
        PHP
        PLA
        PHA
        CMP     #$31
@L0A72  BNE     @L0A72
        PLP
        CLC
        PHP
        PLA
        PHA
        CMP     #$30
@L0A7B  BNE     @L0A7B
        PLP
        SEI
        PHP
        PLA
        PHA
        CMP     #$34
@L0A84  BNE     @L0A84
        PLP
        CLI
        PHP
        PLA
        PHA
        CMP     #$30
@L0A8D  BNE     @L0A8D
        PLP
        SED
        PHP
        PLA
        PHA
        CMP     #$38
@L0A96  BNE     @L0A96
        PLP
        CLD
        PHP
        PLA
        PHA
        CMP     #$30
@L0A9F  BNE     @L0A9F
        PLP
        LDA     #$40
        PHA
        PLP
        PHP
        PLA
        PHA
        CMP     #$70
@L0AAB  BNE     @L0AAB
        PLP
        CLV
        PHP
        PLA
        PHA
        CMP     #$30
@L0AB4  BNE     @L0AB4
        PLP
        LDA     test_case
        CMP     #$0C
@L0ABC  BNE     @L0ABC
        LDA     #$0D
        STA     test_case
        LDX     #$FE
        LDA     #$FF
        PHA
        PLP
        INX
        PHP
        CPX     #$FF
@L0ACD  BNE     @L0ACD
        PLA
        PHA
        CMP     #$FD
@L0AD3  BNE     @L0AD3
        PLP
        INX
        PHP
        CPX     #$00
@L0ADA  BNE     @L0ADA
        PLA
        PHA
        CMP     #$7F
@L0AE0  BNE     @L0AE0
        PLP
        INX
        PHP
        CPX     #$01
@L0AE7  BNE     @L0AE7
        PLA
        PHA
        CMP     #$7D
@L0AED  BNE     @L0AED
        PLP
        DEX
        PHP
        CPX     #$00
@L0AF4  BNE     @L0AF4
        PLA
        PHA
        CMP     #$7F
@L0AFA  BNE     @L0AFA
        PLP
        DEX
        PHP
        CPX     #$FF
@L0B01  BNE     @L0B01
        PLA
        PHA
        CMP     #$FD
@L0B07  BNE     @L0B07
        PLP
        DEX
        LDA     #$00
        PHA
        PLP
        INX
        PHP
        CPX     #$FF
@L0B13  BNE     @L0B13
        PLA
        PHA
        CMP     #$B0
@L0B19  BNE     @L0B19
        PLP
        INX
        PHP
        CPX     #$00
@L0B20  BNE     @L0B20
        PLA
        PHA
        CMP     #$32
@L0B26  BNE     @L0B26
        PLP
        INX
        PHP
        CPX     #$01
@L0B2D  BNE     @L0B2D
        PLA
        PHA
        CMP     #$30
@L0B33  BNE     @L0B33
        PLP
        DEX
        PHP
        CPX     #$00
@L0B3A  BNE     @L0B3A
        PLA
        PHA
        CMP     #$32
@L0B40  BNE     @L0B40
        PLP
        DEX
        PHP
        CPX     #$FF
@L0B47  BNE     @L0B47
        PLA
        PHA
        CMP     #$B0
@L0B4D  BNE     @L0B4D
        PLP
        LDY     #$FE
        LDA     #$FF
        PHA
        PLP
        INY
        PHP
        CPY     #$FF
@L0B5A  BNE     @L0B5A
        PLA
        PHA
        CMP     #$FD
@L0B60  BNE     @L0B60
        PLP
        INY
        PHP
        CPY     #$00
@L0B67  BNE     @L0B67
        PLA
        PHA
        CMP     #$7F
@L0B6D  BNE     @L0B6D
        PLP
        INY
        PHP
        CPY     #$01
@L0B74  BNE     @L0B74
        PLA
        PHA
        CMP     #$7D
@L0B7A  BNE     @L0B7A
        PLP
        DEY
        PHP
        CPY     #$00
@L0B81  BNE     @L0B81
        PLA
        PHA
        CMP     #$7F
@L0B87  BNE     @L0B87
        PLP
        DEY
        PHP
        CPY     #$FF
@L0B8E  BNE     @L0B8E
        PLA
        PHA
        CMP     #$FD
@L0B94  BNE     @L0B94
        PLP
        DEY
        LDA     #$00
        PHA
        PLP
        INY
        PHP
        CPY     #$FF
@L0BA0  BNE     @L0BA0
        PLA
        PHA
        CMP     #$B0
@L0BA6  BNE     @L0BA6
        PLP
        INY
        PHP
        CPY     #$00
@L0BAD  BNE     @L0BAD
        PLA
        PHA
        CMP     #$32
@L0BB3  BNE     @L0BB3
        PLP
        INY
        PHP
        CPY     #$01
@L0BBA  BNE     @L0BBA
        PLA
        PHA
        CMP     #$30
@L0BC0  BNE     @L0BC0
        PLP
        DEY
        PHP
        CPY     #$00
@L0BC7  BNE     @L0BC7
        PLA
        PHA
        CMP     #$32
@L0BCD  BNE     @L0BCD
        PLP
        DEY
        PHP
        CPY     #$FF
@L0BD4  BNE     @L0BD4
        PLA
        PHA
        CMP     #$B0
@L0BDA  BNE     @L0BDA
        PLP
        LDX     #$FF
        LDA     #$FF
        PHA
        PLP
        TXA
        PHP
        CMP     #$FF
@L0BE7  BNE     @L0BE7
        PLA
        PHA
        CMP     #$FD
@L0BED  BNE     @L0BED
        PLP
        PHP
        INX
        PLP
        TXA
        PHP
        CMP     #$00
@L0BF7  BNE     @L0BF7
        PLA
        PHA
        CMP     #$7F
@L0BFD  BNE     @L0BFD
        PLP
        PHP
        INX
        PLP
        TXA
        PHP
        CMP     #$01
@L0C07  BNE     @L0C07
        PLA
        PHA
        CMP     #$7D
@L0C0D  BNE     @L0C0D
        PLP
        LDA     #$00
        PHA
        PLP
        TXA
        PHP
        CMP     #$01
@L0C18  BNE     @L0C18
        PLA
        PHA
        CMP     #$30
@L0C1E  BNE     @L0C1E
        PLP
        PHP
        DEX
        PLP
        TXA
        PHP
        CMP     #$00
@L0C28  BNE     @L0C28
        PLA
        PHA
        CMP     #$32
@L0C2E  BNE     @L0C2E
        PLP
        PHP
        DEX
        PLP
        TXA
        PHP
        CMP     #$FF
@L0C38  BNE     @L0C38
        PLA
        PHA
        CMP     #$B0
@L0C3E  BNE     @L0C3E
        PLP
        LDY     #$FF
        LDA     #$FF
        PHA
        PLP
        TYA
        PHP
        CMP     #$FF
@L0C4B  BNE     @L0C4B
        PLA
        PHA
        CMP     #$FD
@L0C51  BNE     @L0C51
        PLP
        PHP
        INY
        PLP
        TYA
        PHP
        CMP     #$00
@L0C5B  BNE     @L0C5B
        PLA
        PHA
        CMP     #$7F
@L0C61  BNE     @L0C61
        PLP
        PHP
        INY
        PLP
        TYA
        PHP
        CMP     #$01
@L0C6B  BNE     @L0C6B
        PLA
        PHA
        CMP     #$7D
@L0C71  BNE     @L0C71
        PLP
        LDA     #$00
        PHA
        PLP
        TYA
        PHP
        CMP     #$01
@L0C7C  BNE     @L0C7C
        PLA
        PHA
        CMP     #$30
@L0C82  BNE     @L0C82
        PLP
        PHP
        DEY
        PLP
        TYA
        PHP
        CMP     #$00
@L0C8C  BNE     @L0C8C
        PLA
        PHA
        CMP     #$32
@L0C92  BNE     @L0C92
        PLP
        PHP
        DEY
        PLP
        TYA
        PHP
        CMP     #$FF
@L0C9C  BNE     @L0C9C
        PLA
        PHA
        CMP     #$B0
@L0CA2  BNE     @L0CA2
        PLP
        LDA     #$FF
        PHA
        LDX     #$FF
        TXA
        PLP
        TAY
        PHP
        CPY     #$FF
@L0CB0  BNE     @L0CB0
        PLA
        PHA
        CMP     #$FD
@L0CB6  BNE     @L0CB6
        PLP
        PHP
        INX
        TXA
        PLP
        TAY
        PHP
        CPY     #$00
@L0CC1  BNE     @L0CC1
        PLA
        PHA
        CMP     #$7F
@L0CC7  BNE     @L0CC7
        PLP
        PHP
        INX
        TXA
        PLP
        TAY
        PHP
        CPY     #$01
@L0CD2  BNE     @L0CD2
        PLA
        PHA
        CMP     #$7D
@L0CD8  BNE     @L0CD8
        PLP
        LDA     #$00
        PHA
        LDA     #$00
        TXA
        PLP
        TAY
        PHP
        CPY     #$01
@L0CE6  BNE     @L0CE6
        PLA
        PHA
        CMP     #$30
@L0CEC  BNE     @L0CEC
        PLP
        PHP
        DEX
        TXA
        PLP
        TAY
        PHP
        CPY     #$00
@L0CF7  BNE     @L0CF7
        PLA
        PHA
        CMP     #$32
@L0CFD  BNE     @L0CFD
        PLP
        PHP
        DEX
        TXA
        PLP
        TAY
        PHP
        CPY     #$FF
@L0D08  BNE     @L0D08
        PLA
        PHA
        CMP     #$B0
@L0D0E  BNE     @L0D0E
        PLP
        LDA     #$FF
        PHA
        LDY     #$FF
        TYA
        PLP
        TAX
        PHP
        CPX     #$FF
@L0D1C  BNE     @L0D1C
        PLA
        PHA
        CMP     #$FD
@L0D22  BNE     @L0D22
        PLP
        PHP
        INY
        TYA
        PLP
        TAX
        PHP
        CPX     #$00
@L0D2D  BNE     @L0D2D
        PLA
        PHA
        CMP     #$7F
@L0D33  BNE     @L0D33
        PLP
        PHP
        INY
        TYA
        PLP
        TAX
        PHP
        CPX     #$01
@L0D3E  BNE     @L0D3E
        PLA
        PHA
        CMP     #$7D
@L0D44  BNE     @L0D44
        PLP
        LDA     #$00
        PHA
        LDA     #$00
        TYA
        PLP
        TAX
        PHP
        CPX     #$01
@L0D52  BNE     @L0D52
        PLA
        PHA
        CMP     #$30
@L0D58  BNE     @L0D58
        PLP
        PHP
        DEY
        TYA
        PLP
        TAX
        PHP
        CPX     #$00
@L0D63  BNE     @L0D63
        PLA
        PHA
        CMP     #$32
@L0D69  BNE     @L0D69
        PLP
        PHP
        DEY
        TYA
        PLP
        TAX
        PHP
        CPX     #$FF
@L0D74  BNE     @L0D74
        PLA
        PHA
        CMP     #$B0
@L0D7A  BNE     @L0D7A
        PLP
        LDA     test_case
        CMP     #$0D
@L0D82  BNE     @L0D82
        LDA     #$0E
        STA     test_case
        LDX     #$01
        LDA     #$FF
        PHA
        PLP
        TXS
        PHP
        LDA     zp_bss_end+167
        CMP     #$FF
@L0D96  BNE     @L0D96
        LDA     #$00
        PHA
        PLP
        TXS
        PHP
        LDA     zp_bss_end+167
        CMP     #$30
@L0DA3  BNE     @L0DA3
        DEX
        LDA     #$FF
        PHA
        PLP
        TXS
        PHP
        LDA     zp_bss_end+166
        CMP     #$FF
@L0DB1  BNE     @L0DB1
        LDA     #$00
        PHA
        PLP
        TXS
        PHP
        LDA     zp_bss_end+166
        CMP     #$30
@L0DBE  BNE     @L0DBE
        DEX
        LDA     #$FF
        PHA
        PLP
        TXS
        PHP
        LDA     test_case-1
        CMP     #$FF
@L0DCC  BNE     @L0DCC
        LDA     #$00
        PHA
        PLP
        TXS
        PHP
        LDA     test_case-1
        CMP     #$30
        LDX     #$01
        TXS
        LDA     #$FF
        PHA
        PLP
        TSX
        PHP
        CPX     #$01
@L0DE4  BNE     @L0DE4
        LDA     zp_bss_end+167
        CMP     #$7D
@L0DEB  BNE     @L0DEB
        LDA     #$FF
        PHA
        PLP
        TSX
        PHP
        CPX     #$00
@L0DF5  BNE     @L0DF5
        LDA     zp_bss_end+166
        CMP     #$7F
@L0DFC  BNE     @L0DFC
        LDA     #$FF
        PHA
        PLP
        TSX
        PHP
        CPX     #$FF
@L0E06  BNE     @L0E06
        LDA     test_case-1
        CMP     #$FD
@L0E0D  BNE     @L0E0D
        LDX     #$01
        TXS
        LDA     #$00
        PHA
        PLP
        TSX
        PHP
        CPX     #$01
@L0E1A  BNE     @L0E1A
        LDA     zp_bss_end+167
        CMP     #$30
@L0E21  BNE     @L0E21
        LDA     #$00
        PHA
        PLP
        TSX
        PHP
        CPX     #$00
@L0E2B  BNE     @L0E2B
        LDA     zp_bss_end+166
        CMP     #$32
@L0E32  BNE     @L0E32
        LDA     #$00
        PHA
        PLP
        TSX
        PHP
        CPX     #$FF
@L0E3C  BNE     @L0E3C
        LDA     test_case-1
        CMP     #$B0
@L0E43  BNE     @L0E43
        PLA
        LDA     test_case
        CMP     #$0E
@L0E4B  BNE     @L0E4B
        LDA     #$0F
        STA     test_case
        LDY     #$03
@L0E54  LDA     #$00
        PHA
        PLP
        LDX+1   zp1,Y
        PHP
        TXA
        EOR     #$C3
        PLP
        STA     ada2,Y
        PHP
        EOR     #$C3
        CMP     abs1,Y
@L0E68  BNE     @L0E68
        PLA
        EOR     #$30
        CMP     fLDx,Y
@L0E70  BNE     @L0E70
        DEY
        BPL     @L0E54
        LDY     #$03
@L0E77  LDA     #$FF
        PHA
        PLP
        LDX+1   zp1,Y
        PHP
        TXA
        EOR     #$C3
        PLP
        STA     ada2,Y
        PHP
        EOR     #$C3
        CMP     abs1,Y
@L0E8B  BNE     @L0E8B
        PLA
        EOR     #$7D
        CMP     fLDx,Y
@L0E93  BNE     @L0E93
        DEY
        BPL     @L0E77
        LDY     #$03
@L0E9A  LDA     #$00
        PHA
        PLP
        LDX     abs1,Y
        PHP
        TXA
        EOR     #$C3
        TAX
        PLP
        STX+1   zpt,Y
        PHP
        EOR     #$C3
        CMP     zp1,Y
@L0EAF  BNE     @L0EAF
        PLA
        EOR     #$30
        CMP     fLDx,Y
@L0EB7  BNE     @L0EB7
        DEY
        BPL     @L0E9A
        LDY     #$03
@L0EBE  LDA     #$FF
        PHA
        PLP
        LDX     abs1,Y
        PHP
        TXA
        EOR     #$C3
        TAX
        PLP
        STX+1   zpt,Y
        PHP
        EOR     #$C3
        CMP     zp1,Y
@L0ED3  BNE     @L0ED3
        PLA
        EOR     #$7D
        CMP     fLDx,Y
@L0EDB  BNE     @L0EDB
        DEY
        BPL     @L0EBE
        LDY     #$03
        LDX     #$00
@L0EE4  LDA     zpt,Y
        EOR     #$C3
        CMP     zp1,Y
@L0EEC  BNE     @L0EEC
        STX+1   zpt,Y
        LDA     ada2,Y
        EOR     #$C3
        CMP     abs1,Y
@L0EF8  BNE     @L0EF8
        TXA
        STA     ada2,Y
        DEY
        BPL     @L0EE4
        LDA     test_case
        CMP     #$0F
@L0F06  BNE     @L0F06
        LDA     #$10
        STA     test_case
        LDY     #$FD
@L0F0F  LDX+1   zpOR+1,Y
        TXA
        STA     zp_bss_end+175,Y
        DEY
        CPY     #$FA
        BCS     @L0F0F
        LDY     #$FD
@L0F1C  LDX     zp_bss_end+195,Y
        STX+1   sb2,Y
        DEY
        CPY     #$FA
        BCS     @L0F1C
        LDY     #$03
        LDX     #$00
@L0F2A  LDA     zpt,Y
        CMP     zp1,Y
@L0F30  BNE     @L0F30
        STX+1   zpt,Y
        LDA     ada2,Y
        CMP     abs1,Y
@L0F3A  BNE     @L0F3A
        TXA
        STA     ada2,Y
        DEY
        BPL     @L0F2A
        LDA     test_case
        CMP     #$10
@L0F48  BNE     @L0F48
        LDA     #$11
        STA     test_case
        LDX     #$03
@L0F51  LDA     #$00
        PHA
        PLP
        LDY+1   zp1,X
        PHP
        TYA
        EOR     #$C3
        PLP
        STA     ada2,X
        PHP
        EOR     #$C3
        CMP     abs1,X
@L0F65  BNE     @L0F65
        PLA
        EOR     #$30
        CMP     fLDx,X
@L0F6D  BNE     @L0F6D
        DEX
        BPL     @L0F51
        LDX     #$03
@L0F74  LDA     #$FF
        PHA
        PLP
        LDY+1   zp1,X
        PHP
        TYA
        EOR     #$C3
        PLP
        STA     ada2,X
        PHP
        EOR     #$C3
        CMP     abs1,X
@L0F88  BNE     @L0F88
        PLA
        EOR     #$7D
        CMP     fLDx,X
@L0F90  BNE     @L0F90
        DEX
        BPL     @L0F74
        LDX     #$03
@L0F97  LDA     #$00
        PHA
        PLP
        LDY     abs1,X
        PHP
        TYA
        EOR     #$C3
        TAY
        PLP
        STY+1   zpt,X
        PHP
        EOR     #$C3
        CMP+1   zp1,X
@L0FAB  BNE     @L0FAB
        PLA
        EOR     #$30
        CMP     fLDx,X
@L0FB3  BNE     @L0FB3
        DEX
        BPL     @L0F97
        LDX     #$03
@L0FBA  LDA     #$FF
        PHA
        PLP
        LDY     abs1,X
        PHP
        TYA
        EOR     #$C3
        TAY
        PLP
        STY+1   zpt,X
        PHP
        EOR     #$C3
        CMP+1   zp1,X
@L0FCE  BNE     @L0FCE
        PLA
        EOR     #$7D
        CMP     fLDx,X
@L0FD6  BNE     @L0FD6
        DEX
        BPL     @L0FBA
        LDX     #$03
        LDY     #$00
@L0FDF  LDA+1   zpt,X
        EOR     #$C3
        CMP+1   zp1,X
@L0FE5  BNE     @L0FE5
        STY+1   zpt,X
        LDA     ada2,X
        EOR     #$C3
        CMP     abs1,X
@L0FF1  BNE     @L0FF1
        TXA
        STA     ada2,X
        DEX
        BPL     @L0FDF
        LDA     test_case
        CMP     #$11
@L0FFF  BNE     @L0FFF
        LDA     #$12
        STA     test_case
        LDX     #$FD
@L1008  LDY+1   zpOR+1,X
        TYA
        STA     zp_bss_end+175,X
        DEX
        CPX     #$FA
        BCS     @L1008
        LDX     #$FD
@L1015  LDY     zp_bss_end+195,X
        STY+1   sb2,X
        DEX
        CPX     #$FA
        BCS     @L1015
        LDX     #$03
        LDY     #$00
@L1023  LDA+1   zpt,X
        CMP+1   zp1,X
@L1027  BNE     @L1027
        STY+1   zpt,X
        LDA     ada2,X
        CMP     abs1,X
@L1031  BNE     @L1031
        TXA
        STA     ada2,X
        DEX
        BPL     @L1023
        LDA     test_case
        CMP     #$12
@L103F  BNE     @L103F
        LDA     #$13
        STA     test_case
        LDA     #$00
        PHA
        PLP
        LDX+1   zp1
        PHP
        TXA
        EOR     #$C3
        TAX
        PLP
        STX     ada2
        PHP
        EOR     #$C3
        TAX
        CPX     #$C3
@L105B  BNE     @L105B
        PLA
        EOR     #$30
        CMP     fLDx
@L1063  BNE     @L1063
        LDA     #$00
        PHA
        PLP
        LDX+1   zp1+1
        PHP
        TXA
        EOR     #$C3
        TAX
        PLP
        STX     sba2
        PHP
        EOR     #$C3
        TAX
        CPX     #$82
@L107A  BNE     @L107A
        PLA
        EOR     #$30
        CMP     fLDx+1
@L1082  BNE     @L1082
        LDA     #$00
        PHA
        PLP
        LDX+1   zp1+2
        PHP
        TXA
        EOR     #$C3
        TAX
        PLP
        STX     sba2+1
        PHP
        EOR     #$C3
        TAX
        CPX     #$41
@L1099  BNE     @L1099
        PLA
        EOR     #$30
        CMP     fLDx+2
@L10A1  BNE     @L10A1
        LDA     #$00
        PHA
        PLP
        LDX+1   zp1+3
        PHP
        TXA
        EOR     #$C3
        TAX
        PLP
        STX     sba2+2
        PHP
        EOR     #$C3
        TAX
        CPX     #$00
@L10B8  BNE     @L10B8
        PLA
        EOR     #$30
        CMP     fLDx+3
@L10C0  BNE     @L10C0
        LDA     #$FF
        PHA
        PLP
        LDX+1   zp1
        PHP
        TXA
        EOR     #$C3
        TAX
        PLP
        STX     ada2
        PHP
        EOR     #$C3
        TAX
        CPX     #$C3
@L10D7  BNE     @L10D7
        PLA
        EOR     #$7D
        CMP     fLDx
@L10DF  BNE     @L10DF
        LDA     #$FF
        PHA
        PLP
        LDX+1   zp1+1
        PHP
        TXA
        EOR     #$C3
        TAX
        PLP
        STX     sba2
        PHP
        EOR     #$C3
        TAX
        CPX     #$82
@L10F6  BNE     @L10F6
        PLA
        EOR     #$7D
        CMP     fLDx+1
@L10FE  BNE     @L10FE
        LDA     #$FF
        PHA
        PLP
        LDX+1   zp1+2
        PHP
        TXA
        EOR     #$C3
        TAX
        PLP
        STX     sba2+1
        PHP
        EOR     #$C3
        TAX
        CPX     #$41
@L1115  BNE     @L1115
        PLA
        EOR     #$7D
        CMP     fLDx+2
@L111D  BNE     @L111D
        LDA     #$FF
        PHA
        PLP
        LDX+1   zp1+3
        PHP
        TXA
        EOR     #$C3
        TAX
        PLP
        STX     sba2+2
        PHP
        EOR     #$C3
        TAX
        CPX     #$00
@L1134  BNE     @L1134
        PLA
        EOR     #$7D
        CMP     fLDx+3
@L113C  BNE     @L113C
        LDA     #$00
        PHA
        PLP
        LDX     abs1
        PHP
        TXA
        EOR     #$C3
        TAX
        PLP
        STX+1   zpt
        PHP
        EOR     #$C3
        CMP+1   zp1
@L1152  BNE     @L1152
        PLA
        EOR     #$30
        CMP     fLDx
@L115A  BNE     @L115A
        LDA     #$00
        PHA
        PLP
        LDX     abs1+1
        PHP
        TXA
        EOR     #$C3
        TAX
        PLP
        STX+1   ad1
        PHP
        EOR     #$C3
        CMP+1   zp1+1
@L1170  BNE     @L1170
        PLA
        EOR     #$30
        CMP     fLDx+1
@L1178  BNE     @L1178
        LDA     #$00
        PHA
        PLP
        LDX     abs1+2
        PHP
        TXA
        EOR     #$C3
        TAX
        PLP
        STX+1   ad2
        PHP
        EOR     #$C3
        CMP+1   zp1+2
@L118E  BNE     @L118E
        PLA
        EOR     #$30
        CMP     fLDx+2
@L1196  BNE     @L1196
        LDA     #$00
        PHA
        PLP
        LDX     abs1+3
        PHP
        TXA
        EOR     #$C3
        TAX
        PLP
        STX+1   adrl
        PHP
        EOR     #$C3
        CMP+1   zp1+3
@L11AC  BNE     @L11AC
        PLA
        EOR     #$30
        CMP     fLDx+3
@L11B4  BNE     @L11B4
        LDA     #$FF
        PHA
        PLP
        LDX     abs1
        PHP
        TXA
        EOR     #$C3
        TAX
        PLP
        STX+1   zpt
        PHP
        EOR     #$C3
        TAX
        CPX+1   zp1
@L11CB  BNE     @L11CB
        PLA
        EOR     #$7D
        CMP     fLDx
@L11D3  BNE     @L11D3
        LDA     #$FF
        PHA
        PLP
        LDX     abs1+1
        PHP
        TXA
        EOR     #$C3
        TAX
        PLP
        STX+1   ad1
        PHP
        EOR     #$C3
        TAX
        CPX+1   zp1+1
@L11EA  BNE     @L11EA
        PLA
        EOR     #$7D
        CMP     fLDx+1
@L11F2  BNE     @L11F2
        LDA     #$FF
        PHA
        PLP
        LDX     abs1+2
        PHP
        TXA
        EOR     #$C3
        TAX
        PLP
        STX+1   ad2
        PHP
        EOR     #$C3
        TAX
        CPX+1   zp1+2
@L1209  BNE     @L1209
        PLA
        EOR     #$7D
        CMP     fLDx+2
@L1211  BNE     @L1211
        LDA     #$FF
        PHA
        PLP
        LDX     abs1+3
        PHP
        TXA
        EOR     #$C3
        TAX
        PLP
        STX+1   adrl
        PHP
        EOR     #$C3
        TAX
        CPX+1   zp1+3
@L1228  BNE     @L1228
        PLA
        EOR     #$7D
        CMP     fLDx+3
@L1230  BNE     @L1230
        LDA     #$00
        PHA
        PLP
        LDX     #$C3
        PHP
        CPX     abs1
@L123C  BNE     @L123C
        PLA
        EOR     #$30
        CMP     fLDx
@L1244  BNE     @L1244
        LDA     #$00
        PHA
        PLP
        LDX     #$82
        PHP
        CPX     abs1+1
@L1250  BNE     @L1250
        PLA
        EOR     #$30
        CMP     fLDx+1
@L1258  BNE     @L1258
        LDA     #$00
        PHA
        PLP
        LDX     #$41
        PHP
        CPX     abs1+2
@L1264  BNE     @L1264
        PLA
        EOR     #$30
        CMP     fLDx+2
@L126C  BNE     @L126C
        LDA     #$00
        PHA
        PLP
        LDX     #$00
        PHP
        CPX     abs1+3
@L1278  BNE     @L1278
        PLA
        EOR     #$30
        CMP     fLDx+3
@L1280  BNE     @L1280
        LDA     #$FF
        PHA
        PLP
        LDX     #$C3
        PHP
        CPX     abs1
@L128C  BNE     @L128C
        PLA
        EOR     #$7D
        CMP     fLDx
@L1294  BNE     @L1294
        LDA     #$FF
        PHA
        PLP
        LDX     #$82
        PHP
        CPX     abs1+1
@L12A0  BNE     @L12A0
        PLA
        EOR     #$7D
        CMP     fLDx+1
@L12A8  BNE     @L12A8
        LDA     #$FF
        PHA
        PLP
        LDX     #$41
        PHP
        CPX     abs1+2
@L12B4  BNE     @L12B4
        PLA
        EOR     #$7D
        CMP     fLDx+2
@L12BC  BNE     @L12BC
        LDA     #$FF
        PHA
        PLP
        LDX     #$00
        PHP
        CPX     abs1+3
@L12C8  BNE     @L12C8
        PLA
        EOR     #$7D
        CMP     fLDx+3
@L12D0  BNE     @L12D0
        LDX     #$00
        LDA+1   zpt
        EOR     #$C3
        CMP+1   zp1
@L12DA  BNE     @L12DA
        STX+1   zpt
        LDA     ada2
        EOR     #$C3
        CMP     abs1
@L12E6  BNE     @L12E6
        STX     ada2
        LDA+1   ad1
        EOR     #$C3
        CMP+1   zp1+1
@L12F1  BNE     @L12F1
        STX+1   ad1
        LDA     sba2
        EOR     #$C3
        CMP     abs1+1
@L12FD  BNE     @L12FD
        STX     sba2
        LDA+1   ad2
        EOR     #$C3
        CMP+1   zp1+2
@L1308  BNE     @L1308
        STX+1   ad2
        LDA     sba2+1
        EOR     #$C3
        CMP     abs1+2
@L1314  BNE     @L1314
        STX     sba2+1
        LDA+1   adrl
        EOR     #$C3
        CMP+1   zp1+3
@L131F  BNE     @L131F
        STX+1   adrl
        LDA     sba2+2
        EOR     #$C3
        CMP     abs1+3
@L132B  BNE     @L132B
        STX     sba2+2
        LDA     test_case
        CMP     #$13
@L1335  BNE     @L1335
        LDA     #$14
        STA     test_case
        LDA     #$00
        PHA
        PLP
        LDY+1   zp1
        PHP
        TYA
        EOR     #$C3
        TAY
        PLP
        STY     ada2
        PHP
        EOR     #$C3
        TAY
        CPY     #$C3
@L1351  BNE     @L1351
        PLA
        EOR     #$30
        CMP     fLDx
@L1359  BNE     @L1359
        LDA     #$00
        PHA
        PLP
        LDY+1   zp1+1
        PHP
        TYA
        EOR     #$C3
        TAY
        PLP
        STY     sba2
        PHP
        EOR     #$C3
        TAY
        CPY     #$82
@L1370  BNE     @L1370
        PLA
        EOR     #$30
        CMP     fLDx+1
@L1378  BNE     @L1378
        LDA     #$00
        PHA
        PLP
        LDY+1   zp1+2
        PHP
        TYA
        EOR     #$C3
        TAY
        PLP
        STY     sba2+1
        PHP
        EOR     #$C3
        TAY
        CPY     #$41
@L138F  BNE     @L138F
        PLA
        EOR     #$30
        CMP     fLDx+2
@L1397  BNE     @L1397
        LDA     #$00
        PHA
        PLP
        LDY+1   zp1+3
        PHP
        TYA
        EOR     #$C3
        TAY
        PLP
        STY     sba2+2
        PHP
        EOR     #$C3
        TAY
        CPY     #$00
@L13AE  BNE     @L13AE
        PLA
        EOR     #$30
        CMP     fLDx+3
@L13B6  BNE     @L13B6
        LDA     #$FF
        PHA
        PLP
        LDY+1   zp1
        PHP
        TYA
        EOR     #$C3
        TAY
        PLP
        STY     ada2
        PHP
        EOR     #$C3
        TAY
        CPY     #$C3
@L13CD  BNE     @L13CD
        PLA
        EOR     #$7D
        CMP     fLDx
@L13D5  BNE     @L13D5
        LDA     #$FF
        PHA
        PLP
        LDY+1   zp1+1
        PHP
        TYA
        EOR     #$C3
        TAY
        PLP
        STY     sba2
        PHP
        EOR     #$C3
        TAY
        CPY     #$82
@L13EC  BNE     @L13EC
        PLA
        EOR     #$7D
        CMP     fLDx+1
@L13F4  BNE     @L13F4
        LDA     #$FF
        PHA
        PLP
        LDY+1   zp1+2
        PHP
        TYA
        EOR     #$C3
        TAY
        PLP
        STY     sba2+1
        PHP
        EOR     #$C3
        TAY
        CPY     #$41
@L140B  BNE     @L140B
        PLA
        EOR     #$7D
        CMP     fLDx+2
@L1413  BNE     @L1413
        LDA     #$FF
        PHA
        PLP
        LDY+1   zp1+3
        PHP
        TYA
        EOR     #$C3
        TAY
        PLP
        STY     sba2+2
        PHP
        EOR     #$C3
        TAY
        CPY     #$00
@L142A  BNE     @L142A
        PLA
        EOR     #$7D
        CMP     fLDx+3
@L1432  BNE     @L1432
        LDA     #$00
        PHA
        PLP
        LDY     abs1
        PHP
        TYA
        EOR     #$C3
        TAY
        PLP
        STY+1   zpt
        PHP
        EOR     #$C3
        TAY
        CPY+1   zp1
@L1449  BNE     @L1449
        PLA
        EOR     #$30
        CMP     fLDx
@L1451  BNE     @L1451
        LDA     #$00
        PHA
        PLP
        LDY     abs1+1
        PHP
        TYA
        EOR     #$C3
        TAY
        PLP
        STY+1   ad1
        PHP
        EOR     #$C3
        TAY
        CPY+1   zp1+1
@L1468  BNE     @L1468
        PLA
        EOR     #$30
        CMP     fLDx+1
@L1470  BNE     @L1470
        LDA     #$00
        PHA
        PLP
        LDY     abs1+2
        PHP
        TYA
        EOR     #$C3
        TAY
        PLP
        STY+1   ad2
        PHP
        EOR     #$C3
        TAY
        CPY+1   zp1+2
@L1487  BNE     @L1487
        PLA
        EOR     #$30
        CMP     fLDx+2
@L148F  BNE     @L148F
        LDA     #$00
        PHA
        PLP
        LDY     abs1+3
        PHP
        TYA
        EOR     #$C3
        TAY
        PLP
        STY+1   adrl
        PHP
        EOR     #$C3
        TAY
        CPY+1   zp1+3
@L14A6  BNE     @L14A6
        PLA
        EOR     #$30
        CMP     fLDx+3
@L14AE  BNE     @L14AE
        LDA     #$FF
        PHA
        PLP
        LDY     abs1
        PHP
        TYA
        EOR     #$C3
        TAY
        PLP
        STY+1   zpt
        PHP
        EOR     #$C3
        TAY
        CMP+1   zp1
@L14C5  BNE     @L14C5
        PLA
        EOR     #$7D
        CMP     fLDx
@L14CD  BNE     @L14CD
        LDA     #$FF
        PHA
        PLP
        LDY     abs1+1
        PHP
        TYA
        EOR     #$C3
        TAY
        PLP
        STY+1   ad1
        PHP
        EOR     #$C3
        TAY
        CMP+1   zp1+1
@L14E4  BNE     @L14E4
        PLA
        EOR     #$7D
        CMP     fLDx+1
@L14EC  BNE     @L14EC
        LDA     #$FF
        PHA
        PLP
        LDY     abs1+2
        PHP
        TYA
        EOR     #$C3
        TAY
        PLP
        STY+1   ad2
        PHP
        EOR     #$C3
        TAY
        CMP+1   zp1+2
@L1503  BNE     @L1503
        PLA
        EOR     #$7D
        CMP     fLDx+2
@L150B  BNE     @L150B
        LDA     #$FF
        PHA
        PLP
        LDY     abs1+3
        PHP
        TYA
        EOR     #$C3
        TAY
        PLP
        STY+1   adrl
        PHP
        EOR     #$C3
        TAY
        CMP+1   zp1+3
@L1522  BNE     @L1522
        PLA
        EOR     #$7D
        CMP     fLDx+3
@L152A  BNE     @L152A
        LDA     #$00
        PHA
        PLP
        LDY     #$C3
        PHP
        CPY     abs1
@L1536  BNE     @L1536
        PLA
        EOR     #$30
        CMP     fLDx
@L153E  BNE     @L153E
        LDA     #$00
        PHA
        PLP
        LDY     #$82
        PHP
        CPY     abs1+1
@L154A  BNE     @L154A
        PLA
        EOR     #$30
        CMP     fLDx+1
@L1552  BNE     @L1552
        LDA     #$00
        PHA
        PLP
        LDY     #$41
        PHP
        CPY     abs1+2
@L155E  BNE     @L155E
        PLA
        EOR     #$30
        CMP     fLDx+2
@L1566  BNE     @L1566
        LDA     #$00
        PHA
        PLP
        LDY     #$00
        PHP
        CPY     abs1+3
@L1572  BNE     @L1572
        PLA
        EOR     #$30
        CMP     fLDx+3
@L157A  BNE     @L157A
        LDA     #$FF
        PHA
        PLP
        LDY     #$C3
        PHP
        CPY     abs1
@L1586  BNE     @L1586
        PLA
        EOR     #$7D
        CMP     fLDx
@L158E  BNE     @L158E
        LDA     #$FF
        PHA
        PLP
        LDY     #$82
        PHP
        CPY     abs1+1
@L159A  BNE     @L159A
        PLA
        EOR     #$7D
        CMP     fLDx+1
@L15A2  BNE     @L15A2
        LDA     #$FF
        PHA
        PLP
        LDY     #$41
        PHP
        CPY     abs1+2
@L15AE  BNE     @L15AE
        PLA
        EOR     #$7D
        CMP     fLDx+2
@L15B6  BNE     @L15B6
        LDA     #$FF
        PHA
        PLP
        LDY     #$00
        PHP
        CPY     abs1+3
@L15C2  BNE     @L15C2
        PLA
        EOR     #$7D
        CMP     fLDx+3
@L15CA  BNE     @L15CA
        LDY     #$00
        LDA+1   zpt
        EOR     #$C3
        CMP+1   zp1
@L15D4  BNE     @L15D4
        STY+1   zpt
        LDA     ada2
        EOR     #$C3
        CMP     abs1
@L15E0  BNE     @L15E0
        STY     ada2
        LDA+1   ad1
        EOR     #$C3
        CMP+1   zp1+1
@L15EB  BNE     @L15EB
        STY+1   ad1
        LDA     sba2
        EOR     #$C3
        CMP     abs1+1
@L15F7  BNE     @L15F7
        STY     sba2
        LDA+1   ad2
        EOR     #$C3
        CMP+1   zp1+2
@L1602  BNE     @L1602
        STY+1   ad2
        LDA     sba2+1
        EOR     #$C3
        CMP     abs1+2
@L160E  BNE     @L160E
        STY     sba2+1
        LDA+1   adrl
        EOR     #$C3
        CMP+1   zp1+3
@L1619  BNE     @L1619
        STY+1   adrl
        LDA     sba2+2
        EOR     #$C3
        CMP     abs1+3
@L1625  BNE     @L1625
        STY     sba2+2
        LDA     test_case
        CMP     #$14
@L162F  BNE     @L162F
        LDA     #$15
        STA     test_case
        LDX     #$03
@L1638  LDA     #$00
        PHA
        PLP
        LDA+1   zp1,X
        PHP
        EOR     #$C3
        PLP
        STA     ada2,X
        PHP
        EOR     #$C3
        CMP     abs1,X
@L164B  BNE     @L164B
        PLA
        EOR     #$30
        CMP     fLDx,X
@L1653  BNE     @L1653
        DEX
        BPL     @L1638
        LDX     #$03
@L165A  LDA     #$FF
        PHA
        PLP
        LDA+1   zp1,X
        PHP
        EOR     #$C3
        PLP
        STA     ada2,X
        PHP
        EOR     #$C3
        CMP     abs1,X
@L166D  BNE     @L166D
        PLA
        EOR     #$7D
        CMP     fLDx,X
@L1675  BNE     @L1675
        DEX
        BPL     @L165A
        LDX     #$03
@L167C  LDA     #$00
        PHA
        PLP
        LDA     abs1,X
        PHP
        EOR     #$C3
        PLP
        STA+1   zpt,X
        PHP
        EOR     #$C3
        CMP+1   zp1,X
@L168E  BNE     @L168E
        PLA
        EOR     #$30
        CMP     fLDx,X
@L1696  BNE     @L1696
        DEX
        BPL     @L167C
        LDX     #$03
@L169D  LDA     #$FF
        PHA
        PLP
        LDA     abs1,X
        PHP
        EOR     #$C3
        PLP
        STA+1   zpt,X
        PHP
        EOR     #$C3
        CMP+1   zp1,X
@L16AF  BNE     @L16AF
        PLA
        EOR     #$7D
        CMP     fLDx,X
@L16B7  BNE     @L16B7
        DEX
        BPL     @L169D
        LDX     #$03
        LDY     #$00
@L16C0  LDA+1   zpt,X
        EOR     #$C3
        CMP+1   zp1,X
@L16C6  BNE     @L16C6
        STY+1   zpt,X
        LDA     ada2,X
        EOR     #$C3
        CMP     abs1,X
@L16D2  BNE     @L16D2
        TXA
        STA     ada2,X
        DEX
        BPL     @L16C0
        LDA     test_case
        CMP     #$15
@L16E0  BNE     @L16E0
        LDA     #$16
        STA     test_case
        LDY     #$03
@L16E9  LDA     #$00
        PHA
        PLP
        LDA     (ind1),Y
        PHP
        EOR     #$C3
        PLP
        STA     ada2,Y
        PHP
        EOR     #$C3
        CMP     abs1,Y
@L16FC  BNE     @L16FC
        PLA
        EOR     #$30
        CMP     fLDx,Y
@L1704  BNE     @L1704
        DEY
        BPL     @L16E9
        LDY     #$03
@L170B  LDA     #$FF
        PHA
        PLP
        LDA     (ind1),Y
        PHP
        EOR     #$C3
        PLP
        STA     ada2,Y
        PHP
        EOR     #$C3
        CMP     abs1,Y
@L171E  BNE     @L171E
        PLA
        EOR     #$7D
        CMP     fLDx,Y
@L1726  BNE     @L1726
        DEY
        BPL     @L170B
        LDY     #$03
        LDX     #$00
@L172F  LDA     ada2,Y
        EOR     #$C3
        CMP     abs1,Y
@L1737  BNE     @L1737
        TXA
        STA     ada2,Y
        DEY
        BPL     @L172F
        LDY     #$03
@L1742  LDA     #$00
        PHA
        PLP
        LDA     abs1,Y
        PHP
        EOR     #$C3
        PLP
        STA     (indt),Y
        PHP
        EOR     #$C3
        CMP     (ind1),Y
@L1754  BNE     @L1754
        PLA
        EOR     #$30
        CMP     fLDx,Y
@L175C  BNE     @L175C
        DEY
        BPL     @L1742
        LDY     #$03
@L1763  LDA     #$FF
        PHA
        PLP
        LDA     abs1,Y
        PHP
        EOR     #$C3
        PLP
        STA     (indt),Y
        PHP
        EOR     #$C3
        CMP     (ind1),Y
@L1775  BNE     @L1775
        PLA
        EOR     #$7D
        CMP     fLDx,Y
@L177D  BNE     @L177D
        DEY
        BPL     @L1763
        LDY     #$03
        LDX     #$00
@L1786  LDA     ada2,Y
        EOR     #$C3
        CMP     abs1,Y
@L178E  BNE     @L178E
        TXA
        STA     ada2,Y
        DEY
        BPL     @L1786
        LDX     #$06
        LDY     #$03
@L179B  LDA     #$00
        PHA
        PLP
        LDA     (ind1,X)
        PHP
        EOR     #$C3
        PLP
        STA     (indt,X)
        PHP
        EOR     #$C3
        CMP     abs1,Y
@L17AD  BNE     @L17AD
        PLA
        EOR     #$30
        CMP     fLDx,Y
@L17B5  BNE     @L17B5
        DEX
        DEX
        DEY
        BPL     @L179B
        LDX     #$06
        LDY     #$03
@L17C0  LDA     #$FF
        PHA
        PLP
        LDA     (ind1,X)
        PHP
        EOR     #$C3
        PLP
        STA     (indt,X)
        PHP
        EOR     #$C3
        CMP     abs1,Y
@L17D2  BNE     @L17D2
        PLA
        EOR     #$7D
        CMP     fLDx,Y
@L17DA  BNE     @L17DA
        DEX
        DEX
        DEY
        BPL     @L17C0
        LDY     #$03
        LDX     #$00
@L17E5  LDA     ada2,Y
        EOR     #$C3
        CMP     abs1,Y
@L17ED  BNE     @L17ED
        TXA
        STA     ada2,Y
        DEY
        BPL     @L17E5
        LDA     test_case
        CMP     #$16
@L17FB  BNE     @L17FB
        LDA     #$17
        STA     test_case
; indexed wraparound test (only zp should wrap)
        LDX     #$FD
tldax6  LDA+1   zpOR+1,X
        STA     zp_bss_end+175,X
        DEX
        CPX     #$FA
        BCS     tldax6
        LDX     #$FD
tldax7  LDA     zp_bss_end+195,X
        STA+1   sb2,X
        DEX
        CPX     #$FA
        BCS     tldax7
        LDX     #$03
        LDY     #$00
@L181E  LDA+1   zpt,X
        CMP+1   zp1,X
@L1822  BNE     @L1822
        STY+1   zpt,X
        LDA     ada2,X
        CMP     abs1,X
@L182C  BNE     @L182C
        TXA
        STA     ada2,X
        DEX
        BPL     @L181E
        LDY     #$FB
        LDX     #$FE
@L1839  LDA     (L002C,X)
        STA     zp_bss_end+177,Y
        DEX
        DEX
        DEY
        CPY     #$F8
        BCS     @L1839
        LDY     #$03
        LDX     #$00
@L1849  LDA     ada2,Y
        CMP     abs1,Y
@L184F  BNE     @L184F
        TXA
        STA     ada2,Y
        DEY
        BPL     @L1849
        LDY     #$FB
@L185A  LDA     zp_bss_end+197,Y
        STA     (inwt),Y
        DEY
        CPY     #$F8
        BCS     @L185A
        LDY     #$03
        LDX     #$00
@L1868  LDA     ada2,Y
        CMP     abs1,Y
@L186E  BNE     @L186E
        TXA
        STA     ada2,Y
        DEY
        BPL     @L1868
        LDY     #$FB
        LDX     #$FE
@L187B  LDA     (inw1),Y
        STA     (inwt,X)
        DEX
        DEX
        DEY
        CPY     #$F8
        BCS     @L187B
        LDY     #$03
        LDX     #$00
@L188A  LDA     ada2,Y
        CMP     abs1,Y
@L1890  BNE     @L1890
        TXA
        STA     ada2,Y
        DEY
        BPL     @L188A
        LDA     test_case
        CMP     #$17
@L189E  BNE     @L189E
        LDA     #$18
        STA     test_case
        LDA     #$00
        PHA
        PLP
        LDA+1   zp1
        PHP
        EOR     #$C3
        PLP
        STA     ada2
        PHP
        EOR     #$C3
        CMP     #$C3
@L18B7  BNE     @L18B7
        PLA
        EOR     #$30
        CMP     fLDx
@L18BF  BNE     @L18BF
        LDA     #$00
        PHA
        PLP
        LDA+1   zp1+1
        PHP
        EOR     #$C3
        PLP
        STA     sba2
        PHP
        EOR     #$C3
        CMP     #$82
@L18D3  BNE     @L18D3
        PLA
        EOR     #$30
        CMP     fLDx+1
@L18DB  BNE     @L18DB
        LDA     #$00
        PHA
        PLP
        LDA+1   zp1+2
        PHP
        EOR     #$C3
        PLP
        STA     sba2+1
        PHP
        EOR     #$C3
        CMP     #$41
@L18EF  BNE     @L18EF
        PLA
        EOR     #$30
        CMP     fLDx+2
@L18F7  BNE     @L18F7
        LDA     #$00
        PHA
        PLP
        LDA+1   zp1+3
        PHP
        EOR     #$C3
        PLP
        STA     sba2+2
        PHP
        EOR     #$C3
        CMP     #$00
@L190B  BNE     @L190B
        PLA
        EOR     #$30
        CMP     fLDx+3
@L1913  BNE     @L1913
        LDA     #$FF
        PHA
        PLP
        LDA+1   zp1
        PHP
        EOR     #$C3
        PLP
        STA     ada2
        PHP
        EOR     #$C3
        CMP     #$C3
@L1927  BNE     @L1927
        PLA
        EOR     #$7D
        CMP     fLDx
@L192F  BNE     @L192F
        LDA     #$FF
        PHA
        PLP
        LDA+1   zp1+1
        PHP
        EOR     #$C3
        PLP
        STA     sba2
        PHP
        EOR     #$C3
        CMP     #$82
@L1943  BNE     @L1943
        PLA
        EOR     #$7D
        CMP     fLDx+1
@L194B  BNE     @L194B
        LDA     #$FF
        PHA
        PLP
        LDA+1   zp1+2
        PHP
        EOR     #$C3
        PLP
        STA     sba2+1
        PHP
        EOR     #$C3
        CMP     #$41
@L195F  BNE     @L195F
        PLA
        EOR     #$7D
        CMP     fLDx+2
@L1967  BNE     @L1967
        LDA     #$FF
        PHA
        PLP
        LDA+1   zp1+3
        PHP
        EOR     #$C3
        PLP
        STA     sba2+2
        PHP
        EOR     #$C3
        CMP     #$00
@L197B  BNE     @L197B
        PLA
        EOR     #$7D
        CMP     fLDx+3
@L1983  BNE     @L1983
        LDA     #$00
        PHA
        PLP
        LDA     abs1
        PHP
        EOR     #$C3
        PLP
        STA+1   zpt
        PHP
        EOR     #$C3
        CMP+1   zp1
@L1997  BNE     @L1997
        PLA
        EOR     #$30
        CMP     fLDx
@L199F  BNE     @L199F
        LDA     #$00
        PHA
        PLP
        LDA     abs1+1
        PHP
        EOR     #$C3
        PLP
        STA+1   ad1
        PHP
        EOR     #$C3
        CMP+1   zp1+1
@L19B3  BNE     @L19B3
        PLA
        EOR     #$30
        CMP     fLDx+1
@L19BB  BNE     @L19BB
        LDA     #$00
        PHA
        PLP
        LDA     abs1+2
        PHP
        EOR     #$C3
        PLP
        STA+1   ad2
        PHP
        EOR     #$C3
        CMP+1   zp1+2
@L19CF  BNE     @L19CF
        PLA
        EOR     #$30
        CMP     fLDx+2
@L19D7  BNE     @L19D7
        LDA     #$00
        PHA
        PLP
        LDA     abs1+3
        PHP
        EOR     #$C3
        PLP
        STA+1   adrl
        PHP
        EOR     #$C3
        CMP+1   zp1+3
@L19EB  BNE     @L19EB
        PLA
        EOR     #$30
        CMP     fLDx+3
@L19F3  BNE     @L19F3
        LDA     #$FF
        PHA
        PLP
        LDA     abs1
        PHP
        EOR     #$C3
        PLP
        STA+1   zpt
        PHP
        EOR     #$C3
        CMP+1   zp1
@L1A07  BNE     @L1A07
        PLA
        EOR     #$7D
        CMP     fLDx
@L1A0F  BNE     @L1A0F
        LDA     #$FF
        PHA
        PLP
        LDA     abs1+1
        PHP
        EOR     #$C3
        PLP
        STA+1   ad1
        PHP
        EOR     #$C3
        CMP+1   zp1+1
@L1A23  BNE     @L1A23
        PLA
        EOR     #$7D
        CMP     fLDx+1
@L1A2B  BNE     @L1A2B
        LDA     #$FF
        PHA
        PLP
        LDA     abs1+2
        PHP
        EOR     #$C3
        PLP
        STA+1   ad2
        PHP
        EOR     #$C3
        CMP+1   zp1+2
@L1A3F  BNE     @L1A3F
        PLA
        EOR     #$7D
        CMP     fLDx+2
@L1A47  BNE     @L1A47
        LDA     #$FF
        PHA
        PLP
        LDA     abs1+3
        PHP
        EOR     #$C3
        PLP
        STA+1   adrl
        PHP
        EOR     #$C3
        CMP+1   zp1+3
@L1A5B  BNE     @L1A5B
        PLA
        EOR     #$7D
        CMP     fLDx+3
@L1A63  BNE     @L1A63
        LDA     #$00
        PHA
        PLP
        LDA     #$C3
        PHP
        CMP     abs1
@L1A6F  BNE     @L1A6F
        PLA
        EOR     #$30
        CMP     fLDx
@L1A77  BNE     @L1A77
        LDA     #$00
        PHA
        PLP
        LDA     #$82
        PHP
        CMP     abs1+1
@L1A83  BNE     @L1A83
        PLA
        EOR     #$30
        CMP     fLDx+1
@L1A8B  BNE     @L1A8B
        LDA     #$00
        PHA
        PLP
        LDA     #$41
        PHP
        CMP     abs1+2
@L1A97  BNE     @L1A97
        PLA
        EOR     #$30
        CMP     fLDx+2
@L1A9F  BNE     @L1A9F
        LDA     #$00
        PHA
        PLP
        LDA     #$00
        PHP
        CMP     abs1+3
@L1AAB  BNE     @L1AAB
        PLA
        EOR     #$30
        CMP     fLDx+3
@L1AB3  BNE     @L1AB3
        LDA     #$FF
        PHA
        PLP
        LDA     #$C3
        PHP
        CMP     abs1
@L1ABF  BNE     @L1ABF
        PLA
        EOR     #$7D
        CMP     fLDx
@L1AC7  BNE     @L1AC7
        LDA     #$FF
        PHA
        PLP
        LDA     #$82
        PHP
        CMP     abs1+1
@L1AD3  BNE     @L1AD3
        PLA
        EOR     #$7D
        CMP     fLDx+1
@L1ADB  BNE     @L1ADB
        LDA     #$FF
        PHA
        PLP
        LDA     #$41
        PHP
        CMP     abs1+2
@L1AE7  BNE     @L1AE7
        PLA
        EOR     #$7D
        CMP     fLDx+2
@L1AEF  BNE     @L1AEF
        LDA     #$FF
        PHA
        PLP
        LDA     #$00
        PHP
        CMP     abs1+3
@L1AFB  BNE     @L1AFB
        PLA
        EOR     #$7D
        CMP     fLDx+3
@L1B03  BNE     @L1B03
        LDX     #$00
        LDA+1   zpt
        EOR     #$C3
        CMP+1   zp1
@L1B0D  BNE     @L1B0D
        STX+1   zpt
        LDA     ada2
        EOR     #$C3
        CMP     abs1
@L1B19  BNE     @L1B19
        STX     ada2
        LDA+1   ad1
        EOR     #$C3
        CMP+1   zp1+1
@L1B24  BNE     @L1B24
        STX+1   ad1
        LDA     sba2
        EOR     #$C3
        CMP     abs1+1
@L1B30  BNE     @L1B30
        STX     sba2
        LDA+1   ad2
        EOR     #$C3
        CMP+1   zp1+2
@L1B3B  BNE     @L1B3B
        STX+1   ad2
        LDA     sba2+1
        EOR     #$C3
        CMP     abs1+2
@L1B47  BNE     @L1B47
        STX     sba2+1
        LDA+1   adrl
        EOR     #$C3
        CMP+1   zp1+3
@L1B52  BNE     @L1B52
        STX+1   adrl
        LDA     sba2+2
        EOR     #$C3
        CMP     abs1+3
@L1B5E  BNE     @L1B5E
        STX     sba2+2
        LDA     test_case
        CMP     #$18
@L1B68  BNE     @L1B68
        LDA     #$19
        STA     test_case
        LDA     #$00
        PHA
        LDA     #$FF
        PLP
        BIT+1   zp1+3
        PHP
        CMP     #$FF
@L1B7A  BNE     @L1B7A
        PLA
        PHA
        CMP     #$32
@L1B80  BNE     @L1B80
        PLP
        LDA     #$00
        PHA
        LDA     #$01
        PLP
        BIT+1   zp1+2
        PHP
        CMP     #$01
@L1B8E  BNE     @L1B8E
        PLA
        PHA
        CMP     #$70
@L1B94  BNE     @L1B94
        PLP
        LDA     #$00
        PHA
        LDA     #$01
        PLP
        BIT+1   zp1+1
        PHP
        CMP     #$01
@L1BA2  BNE     @L1BA2
        PLA
        PHA
        CMP     #$B2
@L1BA8  BNE     @L1BA8
        PLP
        LDA     #$00
        PHA
        LDA     #$01
        PLP
        BIT+1   zp1
        PHP
        CMP     #$01
@L1BB6  BNE     @L1BB6
        PLA
        PHA
        CMP     #$F0
@L1BBC  BNE     @L1BBC
        PLP
        LDA     #$FF
        PHA
        LDA     #$FF
        PLP
        BIT+1   zp1+3
        PHP
        CMP     #$FF
@L1BCA  BNE     @L1BCA
        PLA
        PHA
        CMP     #$3F
@L1BD0  BNE     @L1BD0
        PLP
        LDA     #$FF
        PHA
        LDA     #$01
        PLP
        BIT+1   zp1+2
        PHP
        CMP     #$01
@L1BDE  BNE     @L1BDE
        PLA
        PHA
        CMP     #$7D
@L1BE4  BNE     @L1BE4
        PLP
        LDA     #$FF
        PHA
        LDA     #$01
        PLP
        BIT+1   zp1+1
        PHP
        CMP     #$01
@L1BF2  BNE     @L1BF2
        PLA
        PHA
        CMP     #$BF
@L1BF8  BNE     @L1BF8
        PLP
        LDA     #$FF
        PHA
        LDA     #$01
        PLP
        BIT+1   zp1
        PHP
        CMP     #$01
@L1C06  BNE     @L1C06
        PLA
        PHA
        CMP     #$FD
@L1C0C  BNE     @L1C0C
        PLP
        LDA     #$00
        PHA
        LDA     #$FF
        PLP
        BIT     abs1+3
        PHP
        CMP     #$FF
@L1C1B  BNE     @L1C1B
        PLA
        PHA
        CMP     #$32
@L1C21  BNE     @L1C21
        PLP
        LDA     #$00
        PHA
        LDA     #$01
        PLP
        BIT     abs1+2
        PHP
        CMP     #$01
@L1C30  BNE     @L1C30
        PLA
        PHA
        CMP     #$70
@L1C36  BNE     @L1C36
        PLP
        LDA     #$00
        PHA
        LDA     #$01
        PLP
        BIT     abs1+1
        PHP
        CMP     #$01
@L1C45  BNE     @L1C45
        PLA
        PHA
        CMP     #$B2
@L1C4B  BNE     @L1C4B
        PLP
        LDA     #$00
        PHA
        LDA     #$01
        PLP
        BIT     abs1
        PHP
        CMP     #$01
@L1C5A  BNE     @L1C5A
        PLA
        PHA
        CMP     #$F0
@L1C60  BNE     @L1C60
        PLP
        LDA     #$FF
        PHA
        LDA     #$FF
        PLP
        BIT     abs1+3
        PHP
        CMP     #$FF
@L1C6F  BNE     @L1C6F
        PLA
        PHA
        CMP     #$3F
@L1C75  BNE     @L1C75
        PLP
        LDA     #$FF
        PHA
        LDA     #$01
        PLP
        BIT     abs1+2
        PHP
        CMP     #$01
@L1C84  BNE     @L1C84
        PLA
        PHA
        CMP     #$7D
@L1C8A  BNE     @L1C8A
        PLP
        LDA     #$FF
        PHA
        LDA     #$01
        PLP
        BIT     abs1+1
        PHP
        CMP     #$01
@L1C99  BNE     @L1C99
        PLA
        PHA
        CMP     #$BF
@L1C9F  BNE     @L1C9F
        PLP
        LDA     #$FF
        PHA
        LDA     #$01
        PLP
        BIT     abs1
        PHP
        CMP     #$01
@L1CAE  BNE     @L1CAE
        PLA
        PHA
        CMP     #$FD
@L1CB4  BNE     @L1CB4
        PLP
        LDA     test_case
        CMP     #$19
@L1CBC  BNE     @L1CBC
        LDA     #$1A
        STA     test_case
        LDA     #$00
        PHA
        LDX     #$80
        PLP
        CPX+1   zp7f
        PHP
        PLA
        PHA
        CMP     #$31
@L1CD0  BNE     @L1CD0
        PLP
        DEX
        CPX+1   zp7f
        PHP
        PLA
        PHA
        CMP     #$33
@L1CDB  BNE     @L1CDB
        PLP
        DEX
        CPX+1   zp7f
        PHP
        CPX     #$7E
@L1CE4  BNE     @L1CE4
        PLA
        PHA
        CMP     #$B0
@L1CEA  BNE     @L1CEA
        PLP
        LDA     #$FF
        PHA
        LDX     #$80
        PLP
        CPX+1   zp7f
        PHP
        PLA
        PHA
        CMP     #$7D
@L1CFA  BNE     @L1CFA
        PLP
        DEX
        CPX+1   zp7f
        PHP
        PLA
        PHA
        CMP     #$7F
@L1D05  BNE     @L1D05
        PLP
        DEX
        CPX+1   zp7f
        PHP
        CPX     #$7E
@L1D0E  BNE     @L1D0E
        PLA
        PHA
        CMP     #$FC
@L1D14  BNE     @L1D14
        PLP
        LDA     #$00
        PHA
        LDX     #$80
        PLP
        CPX     abs7f
        PHP
        PLA
        PHA
        CMP     #$31
@L1D25  BNE     @L1D25
        PLP
        DEX
        CPX     abs7f
        PHP
        PLA
        PHA
        CMP     #$33
@L1D31  BNE     @L1D31
        PLP
        DEX
        CPX     abs7f
        PHP
        CPX     #$7E
@L1D3B  BNE     @L1D3B
        PLA
        PHA
        CMP     #$B0
@L1D41  BNE     @L1D41
        PLP
        LDA     #$FF
        PHA
        LDX     #$80
        PLP
        CPX     abs7f
        PHP
        PLA
        PHA
        CMP     #$7D
@L1D52  BNE     @L1D52
        PLP
        DEX
        CPX     abs7f
        PHP
        PLA
        PHA
        CMP     #$7F
@L1D5E  BNE     @L1D5E
        PLP
        DEX
        CPX     abs7f
        PHP
        CPX     #$7E
@L1D68  BNE     @L1D68
        PLA
        PHA
        CMP     #$FC
@L1D6E  BNE     @L1D6E
        PLP
        LDA     #$00
        PHA
        LDX     #$80
        PLP
        CPX     #$7F
        PHP
        PLA
        PHA
        CMP     #$31
@L1D7E  BNE     @L1D7E
        PLP
        DEX
        CPX     #$7F
        PHP
        PLA
        PHA
        CMP     #$33
@L1D89  BNE     @L1D89
        PLP
        DEX
        CPX     #$7F
        PHP
        CPX     #$7E
@L1D92  BNE     @L1D92
        PLA
        PHA
        CMP     #$B0
@L1D98  BNE     @L1D98
        PLP
        LDA     #$FF
        PHA
        LDX     #$80
        PLP
        CPX     #$7F
        PHP
        PLA
        PHA
        CMP     #$7D
@L1DA8  BNE     @L1DA8
        PLP
        DEX
        CPX     #$7F
        PHP
        PLA
        PHA
        CMP     #$7F
@L1DB3  BNE     @L1DB3
        PLP
        DEX
        CPX     #$7F
        PHP
        CPX     #$7E
@L1DBC  BNE     @L1DBC
        PLA
        PHA
        CMP     #$FC
@L1DC2  BNE     @L1DC2
        PLP
        LDA     test_case
        CMP     #$1A
@L1DCA  BNE     @L1DCA
        LDA     #$1B
        STA     test_case
        LDA     #$00
        PHA
        LDY     #$80
        PLP
        CPY+1   zp7f
        PHP
        PLA
        PHA
        CMP     #$31
@L1DDE  BNE     @L1DDE
        PLP
        DEY
        CPY+1   zp7f
        PHP
        PLA
        PHA
        CMP     #$33
@L1DE9  BNE     @L1DE9
        PLP
        DEY
        CPY+1   zp7f
        PHP
        CPY     #$7E
@L1DF2  BNE     @L1DF2
        PLA
        PHA
        CMP     #$B0
@L1DF8  BNE     @L1DF8
        PLP
        LDA     #$FF
        PHA
        LDY     #$80
        PLP
        CPY+1   zp7f
        PHP
        PLA
        PHA
        CMP     #$7D
@L1E08  BNE     @L1E08
        PLP
        DEY
        CPY+1   zp7f
        PHP
        PLA
        PHA
        CMP     #$7F
@L1E13  BNE     @L1E13
        PLP
        DEY
        CPY+1   zp7f
        PHP
        CPY     #$7E
@L1E1C  BNE     @L1E1C
        PLA
        PHA
        CMP     #$FC
@L1E22  BNE     @L1E22
        PLP
        LDA     #$00
        PHA
        LDY     #$80
        PLP
        CPY     abs7f
        PHP
        PLA
        PHA
        CMP     #$31
@L1E33  BNE     @L1E33
        PLP
        DEY
        CPY     abs7f
        PHP
        PLA
        PHA
        CMP     #$33
@L1E3F  BNE     @L1E3F
        PLP
        DEY
        CPY     abs7f
        PHP
        CPY     #$7E
@L1E49  BNE     @L1E49
        PLA
        PHA
        CMP     #$B0
@L1E4F  BNE     @L1E4F
        PLP
        LDA     #$FF
        PHA
        LDY     #$80
        PLP
        CPY     abs7f
        PHP
        PLA
        PHA
        CMP     #$7D
@L1E60  BNE     @L1E60
        PLP
        DEY
        CPY     abs7f
        PHP
        PLA
        PHA
        CMP     #$7F
@L1E6C  BNE     @L1E6C
        PLP
        DEY
        CPY     abs7f
        PHP
        CPY     #$7E
@L1E76  BNE     @L1E76
        PLA
        PHA
        CMP     #$FC
@L1E7C  BNE     @L1E7C
        PLP
        LDA     #$00
        PHA
        LDY     #$80
        PLP
        CPY     #$7F
        PHP
        PLA
        PHA
        CMP     #$31
@L1E8C  BNE     @L1E8C
        PLP
        DEY
        CPY     #$7F
        PHP
        PLA
        PHA
        CMP     #$33
@L1E97  BNE     @L1E97
        PLP
        DEY
        CPY     #$7F
        PHP
        CPY     #$7E
@L1EA0  BNE     @L1EA0
        PLA
        PHA
        CMP     #$B0
@L1EA6  BNE     @L1EA6
        PLP
        LDA     #$FF
        PHA
        LDY     #$80
        PLP
        CPY     #$7F
        PHP
        PLA
        PHA
        CMP     #$7D
@L1EB6  BNE     @L1EB6
        PLP
        DEY
        CPY     #$7F
        PHP
        PLA
        PHA
        CMP     #$7F
@L1EC1  BNE     @L1EC1
        PLP
        DEY
        CPY     #$7F
        PHP
        CPY     #$7E
@L1ECA  BNE     @L1ECA
        PLA
        PHA
        CMP     #$FC
@L1ED0  BNE     @L1ED0
        PLP
        LDA     test_case
        CMP     #$1B
@L1ED8  BNE     @L1ED8
        LDA     #$1C
        STA     test_case
        LDA     #$00
        PHA
        LDA     #$80
        PLP
        CMP+1   zp7f
        PHP
        CMP     #$80
@L1EEA  BNE     @L1EEA
        PLA
        PHA
        CMP     #$31
@L1EF0  BNE     @L1EF0
        PLP
        LDA     #$00
        PHA
        LDA     #$7F
        PLP
        CMP+1   zp7f
        PHP
        CMP     #$7F
@L1EFE  BNE     @L1EFE
        PLA
        PHA
        CMP     #$33
@L1F04  BNE     @L1F04
        PLP
        LDA     #$00
        PHA
        LDA     #$7E
        PLP
        CMP+1   zp7f
        PHP
        CMP     #$7E
@L1F12  BNE     @L1F12
        PLA
        PHA
        CMP     #$B0
@L1F18  BNE     @L1F18
        PLP
        LDA     #$FF
        PHA
        LDA     #$80
        PLP
        CMP+1   zp7f
        PHP
        CMP     #$80
@L1F26  BNE     @L1F26
        PLA
        PHA
        CMP     #$7D
@L1F2C  BNE     @L1F2C
        PLP
        LDA     #$FF
        PHA
        LDA     #$7F
        PLP
        CMP+1   zp7f
        PHP
        CMP     #$7F
@L1F3A  BNE     @L1F3A
        PLA
        PHA
        CMP     #$7F
@L1F40  BNE     @L1F40
        PLP
        LDA     #$FF
        PHA
        LDA     #$7E
        PLP
        CMP+1   zp7f
        PHP
        CMP     #$7E
@L1F4E  BNE     @L1F4E
        PLA
        PHA
        CMP     #$FC
@L1F54  BNE     @L1F54
        PLP
        LDA     #$00
        PHA
        LDA     #$80
        PLP
        CMP     abs7f
        PHP
        CMP     #$80
@L1F63  BNE     @L1F63
        PLA
        PHA
        CMP     #$31
@L1F69  BNE     @L1F69
        PLP
        LDA     #$00
        PHA
        LDA     #$7F
        PLP
        CMP     abs7f
        PHP
        CMP     #$7F
@L1F78  BNE     @L1F78
        PLA
        PHA
        CMP     #$33
@L1F7E  BNE     @L1F7E
        PLP
        LDA     #$00
        PHA
        LDA     #$7E
        PLP
        CMP     abs7f
        PHP
        CMP     #$7E
@L1F8D  BNE     @L1F8D
        PLA
        PHA
        CMP     #$B0
@L1F93  BNE     @L1F93
        PLP
        LDA     #$FF
        PHA
        LDA     #$80
        PLP
        CMP     abs7f
        PHP
        CMP     #$80
@L1FA2  BNE     @L1FA2
        PLA
        PHA
        CMP     #$7D
@L1FA8  BNE     @L1FA8
        PLP
        LDA     #$FF
        PHA
        LDA     #$7F
        PLP
        CMP     abs7f
        PHP
        CMP     #$7F
@L1FB7  BNE     @L1FB7
        PLA
        PHA
        CMP     #$7F
@L1FBD  BNE     @L1FBD
        PLP
        LDA     #$FF
        PHA
        LDA     #$7E
        PLP
        CMP     abs7f
        PHP
        CMP     #$7E
@L1FCC  BNE     @L1FCC
        PLA
        PHA
        CMP     #$FC
@L1FD2  BNE     @L1FD2
        PLP
        LDA     #$00
        PHA
        LDA     #$80
        PLP
        CMP     #$7F
        PHP
        CMP     #$80
@L1FE0  BNE     @L1FE0
        PLA
        PHA
        CMP     #$31
@L1FE6  BNE     @L1FE6
        PLP
        LDA     #$00
        PHA
        LDA     #$7F
        PLP
        CMP     #$7F
        PHP
        CMP     #$7F
@L1FF4  BNE     @L1FF4
        PLA
        PHA
        CMP     #$33
@L1FFA  BNE     @L1FFA
        PLP
        LDA     #$00
        PHA
        LDA     #$7E
        PLP
        CMP     #$7F
        PHP
        CMP     #$7E
@L2008  BNE     @L2008
        PLA
        PHA
        CMP     #$B0
@L200E  BNE     @L200E
        PLP
        LDA     #$FF
        PHA
        LDA     #$80
        PLP
        CMP     #$7F
        PHP
        CMP     #$80
@L201C  BNE     @L201C
        PLA
        PHA
        CMP     #$7D
@L2022  BNE     @L2022
        PLP
        LDA     #$FF
        PHA
        LDA     #$7F
        PLP
        CMP     #$7F
        PHP
        CMP     #$7F
@L2030  BNE     @L2030
        PLA
        PHA
        CMP     #$7F
@L2036  BNE     @L2036
        PLP
        LDA     #$FF
        PHA
        LDA     #$7E
        PLP
        CMP     #$7F
        PHP
        CMP     #$7E
@L2044  BNE     @L2044
        PLA
        PHA
        CMP     #$FC
@L204A  BNE     @L204A
        PLP
        LDX     #$04
        LDA     #$00
        PHA
        LDA     #$80
        PLP
        CMP+1   zp1,X
        PHP
        CMP     #$80
@L205A  BNE     @L205A
        PLA
        PHA
        CMP     #$31
@L2060  BNE     @L2060
        PLP
        LDA     #$00
        PHA
        LDA     #$7F
        PLP
        CMP+1   zp1,X
        PHP
        CMP     #$7F
@L206E  BNE     @L206E
        PLA
        PHA
        CMP     #$33
@L2074  BNE     @L2074
        PLP
        LDA     #$00
        PHA
        LDA     #$7E
        PLP
        CMP+1   zp1,X
        PHP
        CMP     #$7E
@L2082  BNE     @L2082
        PLA
        PHA
        CMP     #$B0
@L2088  BNE     @L2088
        PLP
        LDA     #$FF
        PHA
        LDA     #$80
        PLP
        CMP+1   zp1,X
        PHP
        CMP     #$80
@L2096  BNE     @L2096
        PLA
        PHA
        CMP     #$7D
@L209C  BNE     @L209C
        PLP
        LDA     #$FF
        PHA
        LDA     #$7F
        PLP
        CMP+1   zp1,X
        PHP
        CMP     #$7F
@L20AA  BNE     @L20AA
        PLA
        PHA
        CMP     #$7F
@L20B0  BNE     @L20B0
        PLP
        LDA     #$FF
        PHA
        LDA     #$7E
        PLP
        CMP+1   zp1,X
        PHP
        CMP     #$7E
@L20BE  BNE     @L20BE
        PLA
        PHA
        CMP     #$FC
@L20C4  BNE     @L20C4
        PLP
        LDA     #$00
        PHA
        LDA     #$80
        PLP
        CMP     abs1,X
        PHP
        CMP     #$80
@L20D3  BNE     @L20D3
        PLA
        PHA
        CMP     #$31
@L20D9  BNE     @L20D9
        PLP
        LDA     #$00
        PHA
        LDA     #$7F
        PLP
        CMP     abs1,X
        PHP
        CMP     #$7F
@L20E8  BNE     @L20E8
        PLA
        PHA
        CMP     #$33
@L20EE  BNE     @L20EE
        PLP
        LDA     #$00
        PHA
        LDA     #$7E
        PLP
        CMP     abs1,X
        PHP
        CMP     #$7E
@L20FD  BNE     @L20FD
        PLA
        PHA
        CMP     #$B0
@L2103  BNE     @L2103
        PLP
        LDA     #$FF
        PHA
        LDA     #$80
        PLP
        CMP     abs1,X
        PHP
        CMP     #$80
@L2112  BNE     @L2112
        PLA
        PHA
        CMP     #$7D
@L2118  BNE     @L2118
        PLP
        LDA     #$FF
        PHA
        LDA     #$7F
        PLP
        CMP     abs1,X
        PHP
        CMP     #$7F
@L2127  BNE     @L2127
        PLA
        PHA
        CMP     #$7F
@L212D  BNE     @L212D
        PLP
        LDA     #$FF
        PHA
        LDA     #$7E
        PLP
        CMP     abs1,X
        PHP
        CMP     #$7E
@L213C  BNE     @L213C
        PLA
        PHA
        CMP     #$FC
@L2142  BNE     @L2142
        PLP
        LDY     #$04
        LDX     #$08
        LDA     #$00
        PHA
        LDA     #$80
        PLP
        CMP     abs1,Y
        PHP
        CMP     #$80
@L2155  BNE     @L2155
        PLA
        PHA
        CMP     #$31
@L215B  BNE     @L215B
        PLP
        LDA     #$00
        PHA
        LDA     #$7F
        PLP
        CMP     abs1,Y
        PHP
        CMP     #$7F
@L216A  BNE     @L216A
        PLA
        PHA
        CMP     #$33
@L2170  BNE     @L2170
        PLP
        LDA     #$00
        PHA
        LDA     #$7E
        PLP
        CMP     abs1,Y
        PHP
        CMP     #$7E
@L217F  BNE     @L217F
        PLA
        PHA
        CMP     #$B0
@L2185  BNE     @L2185
        PLP
        LDA     #$FF
        PHA
        LDA     #$80
        PLP
        CMP     abs1,Y
        PHP
        CMP     #$80
@L2194  BNE     @L2194
        PLA
        PHA
        CMP     #$7D
@L219A  BNE     @L219A
        PLP
        LDA     #$FF
        PHA
        LDA     #$7F
        PLP
        CMP     abs1,Y
        PHP
        CMP     #$7F
@L21A9  BNE     @L21A9
        PLA
        PHA
        CMP     #$7F
@L21AF  BNE     @L21AF
        PLP
        LDA     #$FF
        PHA
        LDA     #$7E
        PLP
        CMP     abs1,Y
        PHP
        CMP     #$7E
@L21BE  BNE     @L21BE
        PLA
        PHA
        CMP     #$FC
@L21C4  BNE     @L21C4
        PLP
        LDA     #$00
        PHA
        LDA     #$80
        PLP
        CMP     (ind1,X)
        PHP
        CMP     #$80
@L21D2  BNE     @L21D2
        PLA
        PHA
        CMP     #$31
@L21D8  BNE     @L21D8
        PLP
        LDA     #$00
        PHA
        LDA     #$7F
        PLP
        CMP     (ind1,X)
        PHP
        CMP     #$7F
@L21E6  BNE     @L21E6
        PLA
        PHA
        CMP     #$33
@L21EC  BNE     @L21EC
        PLP
        LDA     #$00
        PHA
        LDA     #$7E
        PLP
        CMP     (ind1,X)
        PHP
        CMP     #$7E
@L21FA  BNE     @L21FA
        PLA
        PHA
        CMP     #$B0
@L2200  BNE     @L2200
        PLP
        LDA     #$FF
        PHA
        LDA     #$80
        PLP
        CMP     (ind1,X)
        PHP
        CMP     #$80
@L220E  BNE     @L220E
        PLA
        PHA
        CMP     #$7D
@L2214  BNE     @L2214
        PLP
        LDA     #$FF
        PHA
        LDA     #$7F
        PLP
        CMP     (ind1,X)
        PHP
        CMP     #$7F
@L2222  BNE     @L2222
        PLA
        PHA
        CMP     #$7F
@L2228  BNE     @L2228
        PLP
        LDA     #$FF
        PHA
        LDA     #$7E
        PLP
        CMP     (ind1,X)
        PHP
        CMP     #$7E
@L2236  BNE     @L2236
        PLA
        PHA
        CMP     #$FC
@L223C  BNE     @L223C
        PLP
        LDA     #$00
        PHA
        LDA     #$80
        PLP
        CMP     (ind1),Y
        PHP
        CMP     #$80
@L224A  BNE     @L224A
        PLA
        PHA
        CMP     #$31
@L2250  BNE     @L2250
        PLP
        LDA     #$00
        PHA
        LDA     #$7F
        PLP
        CMP     (ind1),Y
        PHP
        CMP     #$7F
@L225E  BNE     @L225E
        PLA
        PHA
        CMP     #$33
@L2264  BNE     @L2264
        PLP
        LDA     #$00
        PHA
        LDA     #$7E
        PLP
        CMP     (ind1),Y
        PHP
        CMP     #$7E
@L2272  BNE     @L2272
        PLA
        PHA
        CMP     #$B0
@L2278  BNE     @L2278
        PLP
        LDA     #$FF
        PHA
        LDA     #$80
        PLP
        CMP     (ind1),Y
        PHP
        CMP     #$80
@L2286  BNE     @L2286
        PLA
        PHA
        CMP     #$7D
@L228C  BNE     @L228C
        PLP
        LDA     #$FF
        PHA
        LDA     #$7F
        PLP
        CMP     (ind1),Y
        PHP
        CMP     #$7F
@L229A  BNE     @L229A
        PLA
        PHA
        CMP     #$7F
@L22A0  BNE     @L22A0
        PLP
        LDA     #$FF
        PHA
        LDA     #$7E
        PLP
        CMP     (ind1),Y
        PHP
        CMP     #$7E
@L22AE  BNE     @L22AE
        PLA
        PHA
        CMP     #$FC
@L22B4  BNE     @L22B4
        PLP
        LDA     test_case
        CMP     #$1C
@L22BC  BNE     @L22BC
        LDA     #$1D
        STA     test_case
        LDX     #$03
@L22C5  LDA     #$00
        PHA
        LDA+1   zp1,X
        PLP
        ASL
        PHP
        CMP     rROL,X
@L22D0  BNE     @L22D0
        PLA
        EOR     #$30
        CMP     fROL,X
@L22D8  BNE     @L22D8
        DEX
        BPL     @L22C5
        LDX     #$03
@L22DF  LDA     #$FF
        PHA
        LDA+1   zp1,X
        PLP
        ASL
        PHP
        CMP     rROL,X
@L22EA  BNE     @L22EA
        PLA
        EOR     #$7C
        CMP     fROL,X
@L22F2  BNE     @L22F2
        DEX
        BPL     @L22DF
        LDX     #$03
@L22F9  LDA     #$00
        PHA
        LDA+1   zp1,X
        PLP
        LSR
        PHP
        CMP     rROR,X
@L2304  BNE     @L2304
        PLA
        EOR     #$30
        CMP     fROR,X
@L230C  BNE     @L230C
        DEX
        BPL     @L22F9
        LDX     #$03
@L2313  LDA     #$FF
        PHA
        LDA+1   zp1,X
        PLP
        LSR
        PHP
        CMP     rROR,X
@L231E  BNE     @L231E
        PLA
        EOR     #$7C
        CMP     fROR,X
@L2326  BNE     @L2326
        DEX
        BPL     @L2313
        LDX     #$03
@L232D  LDA     #$00
        PHA
        LDA+1   zp1,X
        PLP
        ROL
        PHP
        CMP     rROL,X
@L2338  BNE     @L2338
        PLA
        EOR     #$30
        CMP     fROL,X
@L2340  BNE     @L2340
        DEX
        BPL     @L232D
        LDX     #$03
@L2347  LDA     #$FE
        PHA
        LDA+1   zp1,X
        PLP
        ROL
        PHP
        CMP     rROL,X
@L2352  BNE     @L2352
        PLA
        EOR     #$7C
        CMP     fROL,X
@L235A  BNE     @L235A
        DEX
        BPL     @L2347
        LDX     #$03
@L2361  LDA     #$01
        PHA
        LDA+1   zp1,X
        PLP
        ROL
        PHP
        CMP     rROLc,X
@L236C  BNE     @L236C
        PLA
        EOR     #$30
        CMP     fROLc,X
@L2374  BNE     @L2374
        DEX
        BPL     @L2361
        LDX     #$03
@L237B  LDA     #$FF
        PHA
        LDA+1   zp1,X
        PLP
        ROL
        PHP
        CMP     rROLc,X
@L2386  BNE     @L2386
        PLA
        EOR     #$7C
        CMP     fROLc,X
@L238E  BNE     @L238E
        DEX
        BPL     @L237B
        LDX     #$03
@L2395  LDA     #$00
        PHA
        LDA+1   zp1,X
        PLP
        ROR
        PHP
        CMP     rROR,X
@L23A0  BNE     @L23A0
        PLA
        EOR     #$30
        CMP     fROR,X
@L23A8  BNE     @L23A8
        DEX
        BPL     @L2395
        LDX     #$03
@L23AF  LDA     #$FE
        PHA
        LDA+1   zp1,X
        PLP
        ROR
        PHP
        CMP     rROR,X
@L23BA  BNE     @L23BA
        PLA
        EOR     #$7C
        CMP     fROR,X
@L23C2  BNE     @L23C2
        DEX
        BPL     @L23AF
        LDX     #$03
@L23C9  LDA     #$01
        PHA
        LDA+1   zp1,X
        PLP
        ROR
        PHP
        CMP     rRORc,X
@L23D4  BNE     @L23D4
        PLA
        EOR     #$30
        CMP     fRORc,X
@L23DC  BNE     @L23DC
        DEX
        BPL     @L23C9
        LDX     #$03
@L23E3  LDA     #$FF
        PHA
        LDA+1   zp1,X
        PLP
        ROR
        PHP
        CMP     rRORc,X
@L23EE  BNE     @L23EE
        PLA
        EOR     #$7C
        CMP     fRORc,X
@L23F6  BNE     @L23F6
        DEX
        BPL     @L23E3
        LDA     test_case
        CMP     #$1D
@L2400  BNE     @L2400
        LDA     #$1E
        STA     test_case
        LDX     #$03
@L2409  LDA     #$00
        PHA
        LDA+1   zp1,X
        STA+1   zpt
        PLP
        ASL+1   zpt
        PHP
        LDA+1   zpt
        CMP     rROL,X
@L2419  BNE     @L2419
        PLA
        EOR     #$30
        CMP     fROL,X
@L2421  BNE     @L2421
        DEX
        BPL     @L2409
        LDX     #$03
@L2428  LDA     #$FF
        PHA
        LDA+1   zp1,X
        STA+1   zpt
        PLP
        ASL+1   zpt
        PHP
        LDA+1   zpt
        CMP     rROL,X
@L2438  BNE     @L2438
        PLA
        EOR     #$7C
        CMP     fROL,X
@L2440  BNE     @L2440
        DEX
        BPL     @L2428
        LDX     #$03
@L2447  LDA     #$00
        PHA
        LDA+1   zp1,X
        STA+1   zpt
        PLP
        LSR+1   zpt
        PHP
        LDA+1   zpt
        CMP     rROR,X
@L2457  BNE     @L2457
        PLA
        EOR     #$30
        CMP     fROR,X
@L245F  BNE     @L245F
        DEX
        BPL     @L2447
        LDX     #$03
@L2466  LDA     #$FF
        PHA
        LDA+1   zp1,X
        STA+1   zpt
        PLP
        LSR+1   zpt
        PHP
        LDA+1   zpt
        CMP     rROR,X
@L2476  BNE     @L2476
        PLA
        EOR     #$7C
        CMP     fROR,X
@L247E  BNE     @L247E
        DEX
        BPL     @L2466
        LDX     #$03
@L2485  LDA     #$00
        PHA
        LDA+1   zp1,X
        STA+1   zpt
        PLP
        ROL+1   zpt
        PHP
        LDA+1   zpt
        CMP     rROL,X
@L2495  BNE     @L2495
        PLA
        EOR     #$30
        CMP     fROL,X
@L249D  BNE     @L249D
        DEX
        BPL     @L2485
        LDX     #$03
@L24A4  LDA     #$FE
        PHA
        LDA+1   zp1,X
        STA+1   zpt
        PLP
        ROL+1   zpt
        PHP
        LDA+1   zpt
        CMP     rROL,X
@L24B4  BNE     @L24B4
        PLA
        EOR     #$7C
        CMP     fROL,X
@L24BC  BNE     @L24BC
        DEX
        BPL     @L24A4
        LDX     #$03
@L24C3  LDA     #$01
        PHA
        LDA+1   zp1,X
        STA+1   zpt
        PLP
        ROL+1   zpt
        PHP
        LDA+1   zpt
        CMP     rROLc,X
@L24D3  BNE     @L24D3
        PLA
        EOR     #$30
        CMP     fROLc,X
@L24DB  BNE     @L24DB
        DEX
        BPL     @L24C3
        LDX     #$03
@L24E2  LDA     #$FF
        PHA
        LDA+1   zp1,X
        STA+1   zpt
        PLP
        ROL+1   zpt
        PHP
        LDA+1   zpt
        CMP     rROLc,X
@L24F2  BNE     @L24F2
        PLA
        EOR     #$7C
        CMP     fROLc,X
@L24FA  BNE     @L24FA
        DEX
        BPL     @L24E2
        LDX     #$03
@L2501  LDA     #$00
        PHA
        LDA+1   zp1,X
        STA+1   zpt
        PLP
        ROR+1   zpt
        PHP
        LDA+1   zpt
        CMP     rROR,X
@L2511  BNE     @L2511
        PLA
        EOR     #$30
        CMP     fROR,X
@L2519  BNE     @L2519
        DEX
        BPL     @L2501
        LDX     #$03
@L2520  LDA     #$FE
        PHA
        LDA+1   zp1,X
        STA+1   zpt
        PLP
        ROR+1   zpt
        PHP
        LDA+1   zpt
        CMP     rROR,X
@L2530  BNE     @L2530
        PLA
        EOR     #$7C
        CMP     fROR,X
@L2538  BNE     @L2538
        DEX
        BPL     @L2520
        LDX     #$03
@L253F  LDA     #$01
        PHA
        LDA+1   zp1,X
        STA+1   zpt
        PLP
        ROR+1   zpt
        PHP
        LDA+1   zpt
        CMP     rRORc,X
@L254F  BNE     @L254F
        PLA
        EOR     #$30
        CMP     fRORc,X
@L2557  BNE     @L2557
        DEX
        BPL     @L253F
        LDX     #$03
@L255E  LDA     #$FF
        PHA
        LDA+1   zp1,X
        STA+1   zpt
        PLP
        ROR+1   zpt
        PHP
        LDA+1   zpt
        CMP     rRORc,X
@L256E  BNE     @L256E
        PLA
        EOR     #$7C
        CMP     fRORc,X
@L2576  BNE     @L2576
        DEX
        BPL     @L255E
        LDA     test_case
        CMP     #$1E
@L2580  BNE     @L2580
        LDA     #$1F
        STA     test_case
        LDX     #$03
@L2589  LDA     #$00
        PHA
        LDA+1   zp1,X
        STA     ada2
        PLP
        ASL     ada2
        PHP
        LDA     ada2
        CMP     rROL,X
@L259C  BNE     @L259C
        PLA
        EOR     #$30
        CMP     fROL,X
@L25A4  BNE     @L25A4
        DEX
        BPL     @L2589
        LDX     #$03
@L25AB  LDA     #$FF
        PHA
        LDA+1   zp1,X
        STA     ada2
        PLP
        ASL     ada2
        PHP
        LDA     ada2
        CMP     rROL,X
@L25BE  BNE     @L25BE
        PLA
        EOR     #$7C
        CMP     fROL,X
@L25C6  BNE     @L25C6
        DEX
        BPL     @L25AB
        LDX     #$03
@L25CD  LDA     #$00
        PHA
        LDA+1   zp1,X
        STA     ada2
        PLP
        LSR     ada2
        PHP
        LDA     ada2
        CMP     rROR,X
@L25E0  BNE     @L25E0
        PLA
        EOR     #$30
        CMP     fROR,X
@L25E8  BNE     @L25E8
        DEX
        BPL     @L25CD
        LDX     #$03
@L25EF  LDA     #$FF
        PHA
        LDA+1   zp1,X
        STA     ada2
        PLP
        LSR     ada2
        PHP
        LDA     ada2
        CMP     rROR,X
@L2602  BNE     @L2602
        PLA
        EOR     #$7C
        CMP     fROR,X
@L260A  BNE     @L260A
        DEX
        BPL     @L25EF
        LDX     #$03
@L2611  LDA     #$00
        PHA
        LDA+1   zp1,X
        STA     ada2
        PLP
        ROL     ada2
        PHP
        LDA     ada2
        CMP     rROL,X
@L2624  BNE     @L2624
        PLA
        EOR     #$30
        CMP     fROL,X
@L262C  BNE     @L262C
        DEX
        BPL     @L2611
        LDX     #$03
@L2633  LDA     #$FE
        PHA
        LDA+1   zp1,X
        STA     ada2
        PLP
        ROL     ada2
        PHP
        LDA     ada2
        CMP     rROL,X
@L2646  BNE     @L2646
        PLA
        EOR     #$7C
        CMP     fROL,X
@L264E  BNE     @L264E
        DEX
        BPL     @L2633
        LDX     #$03
@L2655  LDA     #$01
        PHA
        LDA+1   zp1,X
        STA     ada2
        PLP
        ROL     ada2
        PHP
        LDA     ada2
        CMP     rROLc,X
@L2668  BNE     @L2668
        PLA
        EOR     #$30
        CMP     fROLc,X
@L2670  BNE     @L2670
        DEX
        BPL     @L2655
        LDX     #$03
@L2677  LDA     #$FF
        PHA
        LDA+1   zp1,X
        STA     ada2
        PLP
        ROL     ada2
        PHP
        LDA     ada2
        CMP     rROLc,X
@L268A  BNE     @L268A
        PLA
        EOR     #$7C
        CMP     fROLc,X
@L2692  BNE     @L2692
        DEX
        BPL     @L2677
        LDX     #$03
@L2699  LDA     #$00
        PHA
        LDA+1   zp1,X
        STA     ada2
        PLP
        ROR     ada2
        PHP
        LDA     ada2
        CMP     rROR,X
@L26AC  BNE     @L26AC
        PLA
        EOR     #$30
        CMP     fROR,X
@L26B4  BNE     @L26B4
        DEX
        BPL     @L2699
        LDX     #$03
@L26BB  LDA     #$FE
        PHA
        LDA+1   zp1,X
        STA     ada2
        PLP
        ROR     ada2
        PHP
        LDA     ada2
        CMP     rROR,X
@L26CE  BNE     @L26CE
        PLA
        EOR     #$7C
        CMP     fROR,X
@L26D6  BNE     @L26D6
        DEX
        BPL     @L26BB
        LDX     #$03
@L26DD  LDA     #$01
        PHA
        LDA+1   zp1,X
        STA     ada2
        PLP
        ROR     ada2
        PHP
        LDA     ada2
        CMP     rRORc,X
@L26F0  BNE     @L26F0
        PLA
        EOR     #$30
        CMP     fRORc,X
@L26F8  BNE     @L26F8
        DEX
        BPL     @L26DD
        LDX     #$03
@L26FF  LDA     #$FF
        PHA
        LDA+1   zp1,X
        STA     ada2
        PLP
        ROR     ada2
        PHP
        LDA     ada2
        CMP     rRORc,X
@L2712  BNE     @L2712
        PLA
        EOR     #$7C
        CMP     fRORc,X
@L271A  BNE     @L271A
        DEX
        BPL     @L26FF
        LDA     test_case
        CMP     #$1F
@L2724  BNE     @L2724
        LDA     #$20
        STA     test_case
        LDX     #$03
@L272D  LDA     #$00
        PHA
        LDA+1   zp1,X
        STA+1   zpt,X
        PLP
        ASL+1   zpt,X
        PHP
        LDA+1   zpt,X
        CMP     rROL,X
@L273D  BNE     @L273D
        PLA
        EOR     #$30
        CMP     fROL,X
@L2745  BNE     @L2745
        DEX
        BPL     @L272D
        LDX     #$03
@L274C  LDA     #$FF
        PHA
        LDA+1   zp1,X
        STA+1   zpt,X
        PLP
        ASL+1   zpt,X
        PHP
        LDA+1   zpt,X
        CMP     rROL,X
@L275C  BNE     @L275C
        PLA
        EOR     #$7C
        CMP     fROL,X
@L2764  BNE     @L2764
        DEX
        BPL     @L274C
        LDX     #$03
@L276B  LDA     #$00
        PHA
        LDA+1   zp1,X
        STA+1   zpt,X
        PLP
        LSR+1   zpt,X
        PHP
        LDA+1   zpt,X
        CMP     rROR,X
@L277B  BNE     @L277B
        PLA
        EOR     #$30
        CMP     fROR,X
@L2783  BNE     @L2783
        DEX
        BPL     @L276B
        LDX     #$03
@L278A  LDA     #$FF
        PHA
        LDA+1   zp1,X
        STA+1   zpt,X
        PLP
        LSR+1   zpt,X
        PHP
        LDA+1   zpt,X
        CMP     rROR,X
@L279A  BNE     @L279A
        PLA
        EOR     #$7C
        CMP     fROR,X
@L27A2  BNE     @L27A2
        DEX
        BPL     @L278A
        LDX     #$03
@L27A9  LDA     #$00
        PHA
        LDA+1   zp1,X
        STA+1   zpt,X
        PLP
        ROL+1   zpt,X
        PHP
        LDA+1   zpt,X
        CMP     rROL,X
@L27B9  BNE     @L27B9
        PLA
        EOR     #$30
        CMP     fROL,X
@L27C1  BNE     @L27C1
        DEX
        BPL     @L27A9
        LDX     #$03
@L27C8  LDA     #$FE
        PHA
        LDA+1   zp1,X
        STA+1   zpt,X
        PLP
        ROL+1   zpt,X
        PHP
        LDA+1   zpt,X
        CMP     rROL,X
@L27D8  BNE     @L27D8
        PLA
        EOR     #$7C
        CMP     fROL,X
@L27E0  BNE     @L27E0
        DEX
        BPL     @L27C8
        LDX     #$03
@L27E7  LDA     #$01
        PHA
        LDA+1   zp1,X
        STA+1   zpt,X
        PLP
        ROL+1   zpt,X
        PHP
        LDA+1   zpt,X
        CMP     rROLc,X
@L27F7  BNE     @L27F7
        PLA
        EOR     #$30
        CMP     fROLc,X
@L27FF  BNE     @L27FF
        DEX
        BPL     @L27E7
        LDX     #$03
@L2806  LDA     #$FF
        PHA
        LDA+1   zp1,X
        STA+1   zpt,X
        PLP
        ROL+1   zpt,X
        PHP
        LDA+1   zpt,X
        CMP     rROLc,X
@L2816  BNE     @L2816
        PLA
        EOR     #$7C
        CMP     fROLc,X
@L281E  BNE     @L281E
        DEX
        BPL     @L2806
        LDX     #$03
@L2825  LDA     #$00
        PHA
        LDA+1   zp1,X
        STA+1   zpt,X
        PLP
        ROR+1   zpt,X
        PHP
        LDA+1   zpt,X
        CMP     rROR,X
@L2835  BNE     @L2835
        PLA
        EOR     #$30
        CMP     fROR,X
@L283D  BNE     @L283D
        DEX
        BPL     @L2825
        LDX     #$03
@L2844  LDA     #$FE
        PHA
        LDA+1   zp1,X
        STA+1   zpt,X
        PLP
        ROR+1   zpt,X
        PHP
        LDA+1   zpt,X
        CMP     rROR,X
@L2854  BNE     @L2854
        PLA
        EOR     #$7C
        CMP     fROR,X
@L285C  BNE     @L285C
        DEX
        BPL     @L2844
        LDX     #$03
@L2863  LDA     #$01
        PHA
        LDA+1   zp1,X
        STA+1   zpt,X
        PLP
        ROR+1   zpt,X
        PHP
        LDA+1   zpt,X
        CMP     rRORc,X
@L2873  BNE     @L2873
        PLA
        EOR     #$30
        CMP     fRORc,X
@L287B  BNE     @L287B
        DEX
        BPL     @L2863
        LDX     #$03
@L2882  LDA     #$FF
        PHA
        LDA+1   zp1,X
        STA+1   zpt,X
        PLP
        ROR+1   zpt,X
        PHP
        LDA+1   zpt,X
        CMP     rRORc,X
@L2892  BNE     @L2892
        PLA
        EOR     #$7C
        CMP     fRORc,X
@L289A  BNE     @L289A
        DEX
        BPL     @L2882
        LDA     test_case
        CMP     #$20
@L28A4  BNE     @L28A4
        LDA     #$21
        STA     test_case
        LDX     #$03
@L28AD  LDA     #$00
        PHA
        LDA+1   zp1,X
        STA     ada2,X
        PLP
        ASL     ada2,X
        PHP
        LDA     ada2,X
        CMP     rROL,X
@L28C0  BNE     @L28C0
        PLA
        EOR     #$30
        CMP     fROL,X
@L28C8  BNE     @L28C8
        DEX
        BPL     @L28AD
        LDX     #$03
@L28CF  LDA     #$FF
        PHA
        LDA+1   zp1,X
        STA     ada2,X
        PLP
        ASL     ada2,X
        PHP
        LDA     ada2,X
        CMP     rROL,X
@L28E2  BNE     @L28E2
        PLA
        EOR     #$7C
        CMP     fROL,X
@L28EA  BNE     @L28EA
        DEX
        BPL     @L28CF
        LDX     #$03
@L28F1  LDA     #$00
        PHA
        LDA+1   zp1,X
        STA     ada2,X
        PLP
        LSR     ada2,X
        PHP
        LDA     ada2,X
        CMP     rROR,X
@L2904  BNE     @L2904
        PLA
        EOR     #$30
        CMP     fROR,X
@L290C  BNE     @L290C
        DEX
        BPL     @L28F1
        LDX     #$03
@L2913  LDA     #$FF
        PHA
        LDA+1   zp1,X
        STA     ada2,X
        PLP
        LSR     ada2,X
        PHP
        LDA     ada2,X
        CMP     rROR,X
@L2926  BNE     @L2926
        PLA
        EOR     #$7C
        CMP     fROR,X
@L292E  BNE     @L292E
        DEX
        BPL     @L2913
        LDX     #$03
@L2935  LDA     #$00
        PHA
        LDA+1   zp1,X
        STA     ada2,X
        PLP
        ROL     ada2,X
        PHP
        LDA     ada2,X
        CMP     rROL,X
@L2948  BNE     @L2948
        PLA
        EOR     #$30
        CMP     fROL,X
@L2950  BNE     @L2950
        DEX
        BPL     @L2935
        LDX     #$03
@L2957  LDA     #$FE
        PHA
        LDA+1   zp1,X
        STA     ada2,X
        PLP
        ROL     ada2,X
        PHP
        LDA     ada2,X
        CMP     rROL,X
@L296A  BNE     @L296A
        PLA
        EOR     #$7C
        CMP     fROL,X
@L2972  BNE     @L2972
        DEX
        BPL     @L2957
        LDX     #$03
@L2979  LDA     #$01
        PHA
        LDA+1   zp1,X
        STA     ada2,X
        PLP
        ROL     ada2,X
        PHP
        LDA     ada2,X
        CMP     rROLc,X
@L298C  BNE     @L298C
        PLA
        EOR     #$30
        CMP     fROLc,X
@L2994  BNE     @L2994
        DEX
        BPL     @L2979
        LDX     #$03
@L299B  LDA     #$FF
        PHA
        LDA+1   zp1,X
        STA     ada2,X
        PLP
        ROL     ada2,X
        PHP
        LDA     ada2,X
        CMP     rROLc,X
@L29AE  BNE     @L29AE
        PLA
        EOR     #$7C
        CMP     fROLc,X
@L29B6  BNE     @L29B6
        DEX
        BPL     @L299B
        LDX     #$03
@L29BD  LDA     #$00
        PHA
        LDA+1   zp1,X
        STA     ada2,X
        PLP
        ROR     ada2,X
        PHP
        LDA     ada2,X
        CMP     rROR,X
@L29D0  BNE     @L29D0
        PLA
        EOR     #$30
        CMP     fROR,X
@L29D8  BNE     @L29D8
        DEX
        BPL     @L29BD
        LDX     #$03
@L29DF  LDA     #$FE
        PHA
        LDA+1   zp1,X
        STA     ada2,X
        PLP
        ROR     ada2,X
        PHP
        LDA     ada2,X
        CMP     rROR,X
@L29F2  BNE     @L29F2
        PLA
        EOR     #$7C
        CMP     fROR,X
@L29FA  BNE     @L29FA
        DEX
        BPL     @L29DF
        LDX     #$03
@L2A01  LDA     #$01
        PHA
        LDA+1   zp1,X
        STA     ada2,X
        PLP
        ROR     ada2,X
        PHP
        LDA     ada2,X
        CMP     rRORc,X
@L2A14  BNE     @L2A14
        PLA
        EOR     #$30
        CMP     fRORc,X
@L2A1C  BNE     @L2A1C
        DEX
        BPL     @L2A01
        LDX     #$03
@L2A23  LDA     #$FF
        PHA
        LDA+1   zp1,X
        STA     ada2,X
        PLP
        ROR     ada2,X
        PHP
        LDA     ada2,X
        CMP     rRORc,X
@L2A36  BNE     @L2A36
        PLA
        EOR     #$7C
        CMP     fRORc,X
@L2A3E  BNE     @L2A3E
        DEX
        BPL     @L2A23
        LDA     test_case
        CMP     #$21
@L2A48  BNE     @L2A48
        LDA     #$22
        STA     test_case
        LDX     #$00
        LDA     #$7E
        STA+1   zpt
@L2A55  LDA     #$00
        PHA
        PLP
        INC+1   zpt
        PHP
        LDA+1   zpt
        CMP     rINC,X
@L2A61  BNE     @L2A61
        PLA
        EOR     #$30
        CMP     fINC,X
@L2A69  BNE     @L2A69
        INX
        CPX     #$02
        BNE     @L2A74
        LDA     #$FE
        STA+1   zpt
@L2A74  CPX     #$05
        BNE     @L2A55
        DEX
        INC+1   zpt
@L2A7B  LDA     #$00
        PHA
        PLP
        DEC+1   zpt
        PHP
        LDA+1   zpt
        CMP     rINC,X
@L2A87  BNE     @L2A87
        PLA
        EOR     #$30
        CMP     fINC,X
@L2A8F  BNE     @L2A8F
        DEX
        BMI     @L2A9E
        CPX     #$01
        BNE     @L2A7B
        LDA     #$81
        STA+1   zpt
        BNE     @L2A7B

@L2A9E  LDX     #$00
        LDA     #$7E
        STA+1   zpt
@L2AA4  LDA     #$FF
        PHA
        PLP
        INC+1   zpt
        PHP
        LDA+1   zpt
        CMP     rINC,X
@L2AB0  BNE     @L2AB0
        PLA
        EOR     #$7D
        CMP     fINC,X
@L2AB8  BNE     @L2AB8
        INX
        CPX     #$02
        BNE     @L2AC3
        LDA     #$FE
        STA+1   zpt
@L2AC3  CPX     #$05
        BNE     @L2AA4
        DEX
        INC+1   zpt
@L2ACA  LDA     #$FF
        PHA
        PLP
        DEC+1   zpt
        PHP
        LDA+1   zpt
        CMP     rINC,X
@L2AD6  BNE     @L2AD6
        PLA
        EOR     #$7D
        CMP     fINC,X
@L2ADE  BNE     @L2ADE
        DEX
        BMI     @L2AED
        CPX     #$01
        BNE     @L2ACA
        LDA     #$81
        STA+1   zpt
        BNE     @L2ACA

@L2AED  LDA     test_case
        CMP     #$22
@L2AF2  BNE     @L2AF2
        LDA     #$23
        STA     test_case
        LDX     #$00
        LDA     #$7E
        STA     ada2
@L2B00  LDA     #$00
        PHA
        PLP
        INC     ada2
        PHP
        LDA     ada2
        CMP     rINC,X
@L2B0E  BNE     @L2B0E
        PLA
        EOR     #$30
        CMP     fINC,X
@L2B16  BNE     @L2B16
        INX
        CPX     #$02
        BNE     @L2B22
        LDA     #$FE
        STA     ada2
@L2B22  CPX     #$05
        BNE     @L2B00
        DEX
        INC     ada2
@L2B2A  LDA     #$00
        PHA
        PLP
        DEC     ada2
        PHP
        LDA     ada2
        CMP     rINC,X
@L2B38  BNE     @L2B38
        PLA
        EOR     #$30
        CMP     fINC,X
@L2B40  BNE     @L2B40
        DEX
        BMI     @L2B50
        CPX     #$01
        BNE     @L2B2A
        LDA     #$81
        STA     ada2
        BNE     @L2B2A

@L2B50  LDX     #$00
        LDA     #$7E
        STA     ada2
@L2B57  LDA     #$FF
        PHA
        PLP
        INC     ada2
        PHP
        LDA     ada2
        CMP     rINC,X
@L2B65  BNE     @L2B65
        PLA
        EOR     #$7D
        CMP     fINC,X
@L2B6D  BNE     @L2B6D
        INX
        CPX     #$02
        BNE     @L2B79
        LDA     #$FE
        STA     ada2
@L2B79  CPX     #$05
        BNE     @L2B57
        DEX
        INC     ada2
@L2B81  LDA     #$FF
        PHA
        PLP
        DEC     ada2
        PHP
        LDA     ada2
        CMP     rINC,X
@L2B8F  BNE     @L2B8F
        PLA
        EOR     #$7D
        CMP     fINC,X
@L2B97  BNE     @L2B97
        DEX
        BMI     @L2BA7
        CPX     #$01
        BNE     @L2B81
        LDA     #$81
        STA     ada2
        BNE     @L2B81

@L2BA7  LDA     test_case
        CMP     #$23
@L2BAC  BNE     @L2BAC
        LDA     #$24
        STA     test_case
        LDX     #$00
        LDA     #$7E
@L2BB7  STA+1   zpt,X
        LDA     #$00
        PHA
        PLP
        INC+1   zpt,X
        PHP
        LDA+1   zpt,X
        CMP     rINC,X
@L2BC5  BNE     @L2BC5
        PLA
        EOR     #$30
        CMP     fINC,X
@L2BCD  BNE     @L2BCD
        LDA+1   zpt,X
        INX
        CPX     #$02
        BNE     @L2BD8
        LDA     #$FE
@L2BD8  CPX     #$05
        BNE     @L2BB7
        DEX
        LDA     #$02
@L2BDF  STA+1   zpt,X
        LDA     #$00
        PHA
        PLP
        DEC+1   zpt,X
        PHP
        LDA+1   zpt,X
        CMP     rINC,X
@L2BED  BNE     @L2BED
        PLA
        EOR     #$30
        CMP     fINC,X
@L2BF5  BNE     @L2BF5
        LDA+1   zpt,X
        DEX
        BMI     @L2C04
        CPX     #$01
        BNE     @L2BDF
        LDA     #$81
        BNE     @L2BDF

@L2C04  LDX     #$00
        LDA     #$7E
@L2C08  STA+1   zpt,X
        LDA     #$FF
        PHA
        PLP
        INC+1   zpt,X
        PHP
        LDA+1   zpt,X
        CMP     rINC,X
@L2C16  BNE     @L2C16
        PLA
        EOR     #$7D
        CMP     fINC,X
@L2C1E  BNE     @L2C1E
        LDA+1   zpt,X
        INX
        CPX     #$02
        BNE     @L2C29
        LDA     #$FE
@L2C29  CPX     #$05
        BNE     @L2C08
        DEX
        LDA     #$02
@L2C30  STA+1   zpt,X
        LDA     #$FF
        PHA
        PLP
        DEC+1   zpt,X
        PHP
        LDA+1   zpt,X
        CMP     rINC,X
@L2C3E  BNE     @L2C3E
        PLA
        EOR     #$7D
        CMP     fINC,X
@L2C46  BNE     @L2C46
        LDA+1   zpt,X
        DEX
        BMI     @L2C55
        CPX     #$01
        BNE     @L2C30
        LDA     #$81
        BNE     @L2C30

@L2C55  LDA     test_case
        CMP     #$24
@L2C5A  BNE     @L2C5A
        LDA     #$25
        STA     test_case
        LDX     #$00
        LDA     #$7E
@L2C65  STA     ada2,X
        LDA     #$00
        PHA
        PLP
        INC     ada2,X
        PHP
        LDA     ada2,X
        CMP     rINC,X
@L2C76  BNE     @L2C76
        PLA
        EOR     #$30
        CMP     fINC,X
@L2C7E  BNE     @L2C7E
        LDA     ada2,X
        INX
        CPX     #$02
        BNE     @L2C8A
        LDA     #$FE
@L2C8A  CPX     #$05
        BNE     @L2C65
        DEX
        LDA     #$02
@L2C91  STA     ada2,X
        LDA     #$00
        PHA
        PLP
        DEC     ada2,X
        PHP
        LDA     ada2,X
        CMP     rINC,X
@L2CA2  BNE     @L2CA2
        PLA
        EOR     #$30
        CMP     fINC,X
@L2CAA  BNE     @L2CAA
        LDA     ada2,X
        DEX
        BMI     @L2CBA
        CPX     #$01
        BNE     @L2C91
        LDA     #$81
        BNE     @L2C91

@L2CBA  LDX     #$00
        LDA     #$7E
@L2CBE  STA     ada2,X
        LDA     #$FF
        PHA
        PLP
        INC     ada2,X
        PHP
        LDA     ada2,X
        CMP     rINC,X
@L2CCF  BNE     @L2CCF
        PLA
        EOR     #$7D
        CMP     fINC,X
@L2CD7  BNE     @L2CD7
        LDA     ada2,X
        INX
        CPX     #$02
        BNE     @L2CE3
        LDA     #$FE
@L2CE3  CPX     #$05
        BNE     @L2CBE
        DEX
        LDA     #$02
@L2CEA  STA     ada2,X
        LDA     #$FF
        PHA
        PLP
        DEC     ada2,X
        PHP
        LDA     ada2,X
        CMP     rINC,X
@L2CFB  BNE     @L2CFB
        PLA
        EOR     #$7D
        CMP     fINC,X
@L2D03  BNE     @L2D03
        LDA     ada2,X
        DEX
        BMI     @L2D13
        CPX     #$01
        BNE     @L2CEA
        LDA     #$81
        BNE     @L2CEA

@L2D13  LDA     test_case
        CMP     #$25
@L2D18  BNE     @L2D18
        LDA     #$26
        STA     test_case
        LDX     #$03
@L2D21  LDA+1   zpAN,X
        STA     ex_andi+1
        LDA     #$00
        PHA
        LDA     absANa,X
        PLP
        JSR     ex_andi
        PHP
        CMP     absrlo,X
@L2D34  BNE     @L2D34
        PLA
        EOR     #$30
        CMP     absflo,X
@L2D3C  BNE     @L2D3C
        DEX
        BPL     @L2D21
        LDX     #$03
@L2D43  LDA+1   zpAN,X
        STA     ex_andi+1
        LDA     #$FF
        PHA
        LDA     absANa,X
        PLP
        JSR     ex_andi
        PHP
        CMP     absrlo,X
@L2D56  BNE     @L2D56
        PLA
        EOR     #$7D
        CMP     absflo,X
@L2D5E  BNE     @L2D5E
        DEX
        BPL     @L2D43
        LDX     #$03
@L2D65  LDA+1   zpAN,X
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     absANa,X
        PLP
        AND+1   zpt
        PHP
        CMP     absrlo,X
@L2D76  BNE     @L2D76
        PLA
        EOR     #$30
        CMP     absflo,X
@L2D7E  BNE     @L2D7E
        DEX
        BPL     @L2D65
        LDX     #$03
@L2D85  LDA+1   zpAN,X
        STA+1   zpt
        LDA     #$FF
        PHA
        LDA     absANa,X
        PLP
        AND+1   zpt
        PHP
        CMP     absrlo,X
@L2D96  BNE     @L2D96
        PLA
        EOR     #$7D
        CMP     absflo,X
@L2D9E  BNE     @L2D9E
        DEX
        BPL     @L2D85
        LDX     #$03
@L2DA5  LDA+1   zpAN,X
        STA     ada2
        LDA     #$00
        PHA
        LDA     absANa,X
        PLP
        AND     ada2
        PHP
        CMP     absrlo,X
@L2DB8  BNE     @L2DB8
        PLA
        EOR     #$30
        CMP     absflo,X
@L2DC0  BNE     @L2DC0
        DEX
        BPL     @L2DA5
        LDX     #$03
        LDA+1   zpAN,X
        STA     ada2
        LDA     #$FF
        PHA
        LDA     absANa,X
        PLP
        AND     ada2
        PHP
        CMP     absrlo,X
@L2DDA  BNE     @L2DDA
        PLA
        EOR     #$7D
        CMP     absflo,X
@L2DE2  BNE     @L2DE2
        DEX
        BPL     @L2DE9
        LDX     #$03
@L2DE9  LDA     #$00
        PHA
        LDA     absANa,X
        PLP
        AND+1   zpAN,X
        PHP
        CMP     absrlo,X
@L2DF6  BNE     @L2DF6
        PLA
        EOR     #$30
        CMP     absflo,X
@L2DFE  BNE     @L2DFE
        DEX
        BPL     @L2DE9
        LDX     #$03
@L2E05  LDA     #$FF
        PHA
        LDA     absANa,X
        PLP
        AND+1   zpAN,X
        PHP
        CMP     absrlo,X
@L2E12  BNE     @L2E12
        PLA
        EOR     #$7D
        CMP     absflo,X
@L2E1A  BNE     @L2E1A
        DEX
        BPL     @L2E05
        LDX     #$03
@L2E21  LDA     #$00
        PHA
        LDA     absANa,X
        PLP
        AND     absAN,X
        PHP
        CMP     absrlo,X
@L2E2F  BNE     @L2E2F
        PLA
        EOR     #$30
        CMP     absflo,X
@L2E37  BNE     @L2E37
        DEX
        BPL     @L2E21
        LDX     #$03
@L2E3E  LDA     #$FF
        PHA
        LDA     absANa,X
        PLP
        AND     absAN,X
        PHP
        CMP     absrlo,X
@L2E4C  BNE     @L2E4C
        PLA
        EOR     #$7D
        CMP     absflo,X
@L2E54  BNE     @L2E54
        DEX
        BPL     @L2E3E
        LDY     #$03
@L2E5B  LDA     #$00
        PHA
        LDA     absANa,Y
        PLP
        AND     absAN,Y
        PHP
        CMP     absrlo,Y
@L2E69  BNE     @L2E69
        PLA
        EOR     #$30
        CMP     absflo,Y
@L2E71  BNE     @L2E71
        DEY
        BPL     @L2E5B
        LDY     #$03
@L2E78  LDA     #$FF
        PHA
        LDA     absANa,Y
        PLP
        AND     absAN,Y
        PHP
        CMP     absrlo,Y
@L2E86  BNE     @L2E86
        PLA
        EOR     #$7D
        CMP     absflo,Y
@L2E8E  BNE     @L2E8E
        DEY
        BPL     @L2E78
        LDX     #$06
        LDY     #$03
@L2E97  LDA     #$00
        PHA
        LDA     absANa,Y
        PLP
        AND     (indAN,X)
        PHP
        CMP     absrlo,Y
@L2EA4  BNE     @L2EA4
        PLA
        EOR     #$30
        CMP     absflo,Y
@L2EAC  BNE     @L2EAC
        DEX
        DEX
        DEY
        BPL     @L2E97
        LDX     #$06
        LDY     #$03
@L2EB7  LDA     #$FF
        PHA
        LDA     absANa,Y
        PLP
        AND     (indAN,X)
        PHP
        CMP     absrlo,Y
@L2EC4  BNE     @L2EC4
        PLA
        EOR     #$7D
        CMP     absflo,Y
@L2ECC  BNE     @L2ECC
        DEX
        DEX
        DEY
        BPL     @L2EB7
        LDY     #$03
@L2ED5  LDA     #$00
        PHA
        LDA     absANa,Y
        PLP
        AND     (indAN),Y
        PHP
        CMP     absrlo,Y
@L2EE2  BNE     @L2EE2
        PLA
        EOR     #$30
        CMP     absflo,Y
@L2EEA  BNE     @L2EEA
        DEY
        BPL     @L2ED5
        LDY     #$03
@L2EF1  LDA     #$FF
        PHA
        LDA     absANa,Y
        PLP
        AND     (indAN),Y
        PHP
        CMP     absrlo,Y
@L2EFE  BNE     @L2EFE
        PLA
        EOR     #$7D
        CMP     absflo,Y
@L2F06  BNE     @L2F06
        DEY
        BPL     @L2EF1
        LDA     test_case
        CMP     #$26
@L2F10  BNE     @L2F10
        LDA     #$27
        STA     test_case
;EOR
        LDX     #$03
teor  LDA+1   zpEO,X
        STA     ex_eori+1
        LDA     #$00
        PHA
        LDA     absEOa,X
        PLP
        JSR     ex_eori
        PHP
        CMP     absrlo,X
@L2F2C  BNE     @L2F2C
        PLA
        EOR     #$30
        CMP     absflo,X
@L2F34  BNE     @L2F34
        DEX
        BPL     teor
        LDX     #$03
teor1  LDA+1    zpEO,X
        STA     ex_eori+1
        LDA     #$FF
        PHA
        LDA     absEOa,X
        PLP
        JSR     ex_eori
        PHP
        CMP     absrlo,X
@L2F4E  BNE     @L2F4E
        PLA
        EOR     #$7D
        CMP     absflo,X
@L2F56  BNE     @L2F56
        DEX
        BPL     teor1
        LDX     #$03
teor2  LDA+1   zpEO,X
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     absEOa,X
        PLP
        EOR+1   zpt
        PHP
        CMP     absrlo,X
@L2F6E  BNE     @L2F6E
        PLA
        EOR     #$30
        CMP     absflo,X
@L2F76  BNE     @L2F76
        DEX
        BPL     teor2
        LDX     #$03
teor3  LDA+1   zpEO,X
        STA+1   zpt
        LDA     #$FF
        PHA
        LDA     absEOa,X
        PLP
        EOR+1   zpt
        PHP
        CMP     absrlo,X
@L2F8E  BNE     @L2F8E
        PLA
        EOR     #$7D
        CMP     absflo,X
@L2F96  BNE     @L2F96
        DEX
        BPL     teor3
        LDX     #$03
teor4   LDA+1   zpEO,X
        STA     ada2
        LDA     #$00
        PHA
        LDA     absEOa,X
        PLP
        EOR     ada2
        PHP
        CMP     absrlo,X
@L2FB0  BNE     @L2FB0
        PLA
        EOR     #$30
        CMP     absflo,X
@L2FB8  BNE     @L2FB8
        DEX
        BPL     teor4
        LDX     #$03
teor5   LDA+1   zpEO,X
        STA     ada2
        LDA     #$FF
        PHA
        LDA     absEOa,X
        PLP
        EOR     ada2
        PHP
        CMP     absrlo,X
@L2FD2  BNE     @L2FD2
        PLA
        EOR     #$7D
        CMP     absflo,X
@L2FDA  BNE     @L2FDA
        DEX
        BPL     teor5
        LDX     #$03
teor6  LDA      #$00
        PHA
        LDA     absEOa,X
        PLP
        EOR+1   zpEO,X
        PHP
        CMP     absrlo,X
@L2FEE  BNE     @L2FEE
        PLA
        EOR     #$30
        CMP     absflo,X
@L2FF6  BNE     @L2FF6
        DEX
        BPL     teor6
        LDX     #$03
teor7  LDA      #$FF
        PHA
        LDA     absEOa,X
        PLP
        EOR+1   zpEO,X
        PHP
        CMP     absrlo,X
@L300A  BNE     @L300A
        PLA
        EOR     #$7D
        CMP     absflo,X
@L3012  BNE     @L3012
        DEX
        BPL     teor7
        LDX     #$03
teor8   LDA     #$00
        PHA
        LDA     absEOa,X
        PLP
        EOR     absEO,X
        PHP
        CMP     absrlo,X
@L3027  BNE     @L3027
        PLA
        EOR     #$30
        CMP     absflo,X
@L302F  BNE     @L302F
        DEX
        BPL     teor8
        LDX     #$03
teor9   LDA     #$FF
        PHA
        LDA     absEOa,X
        PLP
        EOR     absEO,X
        PHP
        CMP     absrlo,X
@L3044  BNE     @L3044
        PLA
        EOR     #$7D
        CMP     absflo,X
@L304C  BNE     @L304C
        DEX
        BPL     teor9
        LDY     #$03
teor10  LDA     #$00
        PHA
        LDA     absEOa,Y
        PLP
        EOR     absEO,Y
        PHP
        CMP     absrlo,Y
@L3061  BNE     @L3061
        PLA
        EOR     #$30
        CMP     absflo,Y
@L3069  BNE     @L3069
        DEY
        BPL     teor10
        LDY     #$03
teor11  LDA     #$FF
        PHA
        LDA     absEOa,Y
        PLP
        EOR     absEO,Y
        PHP
        CMP     absrlo,Y
@L307E  BNE     @L307E
        PLA
        EOR     #$7D
        CMP     absflo,Y
@L3086  BNE     @L3086
        DEY
        BPL     teor11
        LDX     #$06
        LDY     #$03
teor12  LDA     #$00
        PHA
        LDA     absEOa,Y
        PLP
        EOR     (indEO,X)
        PHP
        CMP     absrlo,Y
@L309C  BNE     @L309C
        PLA
        EOR     #$30
        CMP     absflo,Y
@L30A4  BNE     @L30A4
        DEX
        DEX
        DEY
        BPL     teor12
        LDX     #$06
        LDY     #$03
teor13  LDA     #$FF
        PHA
        LDA     absEOa,Y
        PLP
        EOR     (indEO,X)
        PHP
        CMP     absrlo,Y
@L30BC  BNE     @L30BC
        PLA
        EOR     #$7D
        CMP     absflo,Y
@L30C4  BNE     @L30C4
        DEX
        DEX
        DEY
        BPL     teor13
        LDY     #$03
teor14  LDA     #$00
        PHA
        LDA     absEOa,Y
        PLP
        EOR     (indEO),Y
        PHP
        CMP     absrlo,Y
@L30DA  BNE     @L30DA
        PLA
        EOR     #$30
        CMP     absflo,Y
@L30E2  BNE     @L30E2
        DEY
        BPL     teor14
        LDY     #$03
teor15  LDA     #$FF
        PHA
        LDA     absEOa,Y
        PLP
        EOR     (indEO),Y
        PHP
        CMP     absrlo,Y
@L30F6  BNE     @L30F6
        PLA
        EOR     #$7D
        CMP     absflo,Y
@L30FE  BNE     @L30FE
        DEY
        BPL     teor15
        LDA     test_case
        CMP     #$27
@L3108  BNE     @L3108
        LDA     #$28
        STA     test_case
; OR
        LDX     #$03
@L3111  LDA+1   zpOR,X
        STA     ex_orai+1
        LDA     #$00
        PHA
        LDA     absORa,X
        PLP
        JSR     ex_orai
        PHP
        CMP     absrlo,X
@L3124  BNE     @L3124
        PLA
        EOR     #$30
        CMP     absflo,X
@L312C  BNE     @L312C
        DEX
        BPL     @L3111
        LDX     #$03
@L3133  LDA+1   zpOR,X
        STA     ex_orai+1
        LDA     #$FF
        PHA
        LDA     absORa,X
        PLP
        JSR     ex_orai
        PHP
        CMP     absrlo,X
@L3146  BNE     @L3146
        PLA
        EOR     #$7D
        CMP     absflo,X
@L314E  BNE     @L314E
        DEX
        BPL     @L3133
        LDX     #$03
@L3155  LDA+1   zpOR,X
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     absORa,X
        PLP
        ORA+1   zpt
        PHP
        CMP     absrlo,X
@L3166  BNE     @L3166
        PLA
        EOR     #$30
        CMP     absflo,X
@L316E  BNE     @L316E
        DEX
        BPL     @L3155
        LDX     #$03
@L3175  LDA+1   zpOR,X
        STA+1   zpt
        LDA     #$FF
        PHA
        LDA     absORa,X
        PLP
        ORA+1   zpt
        PHP
        CMP     absrlo,X
@L3186  BNE     @L3186
        PLA
        EOR     #$7D
        CMP     absflo,X
@L318E  BNE     @L318E
        DEX
        BPL     @L3175
        LDX     #$03
@L3195  LDA+1   zpOR,X
        STA     ada2
        LDA     #$00
        PHA
        LDA     absORa,X
        PLP
        ORA     ada2
        PHP
        CMP     absrlo,X
@L31A8  BNE     @L31A8
        PLA
        EOR     #$30
        CMP     absflo,X
@L31B0  BNE     @L31B0
        DEX
        BPL     @L3195
        LDX     #$03
        LDA+1   zpOR,X
        STA     ada2
        LDA     #$FF
        PHA
        LDA     absORa,X
        PLP
        ORA     ada2
        PHP
        CMP     absrlo,X
@L31CA  BNE     @L31CA
        PLA
        EOR     #$7D
        CMP     absflo,X
@L31D2  BNE     @L31D2
        DEX
        BPL     @L31D9
        LDX     #$03
@L31D9  LDA     #$00
        PHA
        LDA     absORa,X
        PLP
        ORA+1   zpOR,X
        PHP
        CMP     absrlo,X
@L31E6  BNE     @L31E6
        PLA
        EOR     #$30
        CMP     absflo,X
@L31EE  BNE     @L31EE
        DEX
        BPL     @L31D9
        LDX     #$03
@L31F5  LDA     #$FF
        PHA
        LDA     absORa,X
        PLP
        ORA+1   zpOR,X
        PHP
        CMP     absrlo,X
@L3202  BNE     @L3202
        PLA
        EOR     #$7D
        CMP     absflo,X
@L320A  BNE     @L320A
        DEX
        BPL     @L31F5
        LDX     #$03
@L3211  LDA     #$00
        PHA
        LDA     absORa,X
        PLP
        ORA     absOR,X
        PHP
        CMP     absrlo,X
@L321F  BNE     @L321F
        PLA
        EOR     #$30
        CMP     absflo,X
@L3227  BNE     @L3227
        DEX
        BPL     @L3211
        LDX     #$03
@L322E  LDA     #$FF
        PHA
        LDA     absORa,X
        PLP
        ORA     absOR,X
        PHP
        CMP     absrlo,X
@L323C  BNE     @L323C
        PLA
        EOR     #$7D
        CMP     absflo,X
@L3244  BNE     @L3244
        DEX
        BPL     @L322E
        LDY     #$03
@L324B  LDA     #$00
        PHA
        LDA     absORa,Y
        PLP
        ORA     absOR,Y
        PHP
        CMP     absrlo,Y
@L3259  BNE     @L3259
        PLA
        EOR     #$30
        CMP     absflo,Y
@L3261  BNE     @L3261
        DEY
        BPL     @L324B
        LDY     #$03
@L3268  LDA     #$FF
        PHA
        LDA     absORa,Y
        PLP
        ORA     absOR,Y
        PHP
        CMP     absrlo,Y
@L3276  BNE     @L3276
        PLA
        EOR     #$7D
        CMP     absflo,Y
@L327E  BNE     @L327E
        DEY
        BPL     @L3268
        LDX     #$06
        LDY     #$03
@L3287  LDA     #$00
        PHA
        LDA     absORa,Y
        PLP
        ORA     (indOR,X)
        PHP
        CMP     absrlo,Y
@L3294  BNE     @L3294
        PLA
        EOR     #$30
        CMP     absflo,Y
@L329C  BNE     @L329C
        DEX
        DEX
        DEY
        BPL     @L3287
        LDX     #$06
        LDY     #$03
@L32A7  LDA     #$FF
        PHA
        LDA     absORa,Y
        PLP
        ORA     (indOR,X)
        PHP
        CMP     absrlo,Y
@L32B4  BNE     @L32B4
        PLA
        EOR     #$7D
        CMP     absflo,Y
@L32BC  BNE     @L32BC
        DEX
        DEX
        DEY
        BPL     @L32A7
        LDY     #$03
@L32C5  LDA     #$00
        PHA
        LDA     absORa,Y
        PLP
        ORA     (indOR),Y
        PHP
        CMP     absrlo,Y
@L32D2  BNE     @L32D2
        PLA
        EOR     #$30
        CMP     absflo,Y
@L32DA  BNE     @L32DA
        DEY
        BPL     @L32C5
        LDY     #$03
@L32E1  LDA     #$FF
        PHA
        LDA     absORa,Y
        PLP
        ORA     (indOR),Y
        PHP
        CMP     absrlo,Y
@L32EE  BNE     @L32EE
        PLA
        EOR     #$7D
        CMP     absflo,Y
@L32F6  BNE     @L32F6
        DEY
        BPL     @L32E1
        CLI
        LDA     test_case
        CMP     #$28
@L3301  BNE     @L3301
        LDA     #$29
        STA     test_case
        CLD
        LDX     #$0E
        LDY     #$FF
        LDA     #$00
        STA+1   zpt
        STA+1   ad1
        STA+1   ad2
        STA     ada2
        STA+1   adrl
        STA+1   adrh
        LDA     #$FF
        STA+1   sb2
        STA     sba2
        LDA     #$02
        STA+1   adrf
@L3327  CLC
        JSR     L35A2
        INC+1   zpt
        INC+1   adrl
        PHP
        PHP
        PLA
        AND     #$82
        PLP
        BNE     @L3339
        INC+1   adrh
@L3339  ORA+1   adrh
        STA+1   adrf
        SEC
        JSR     L35A2
        DEC+1   zpt
        INC+1   ad1
        BNE     @L3327
        LDA     #$00
        STA+1   adrh
        INC     ada2
        INC+1   ad2
        PHP
        PLA
        AND     #$82
        STA+1   adrf
        DEC+1   sb2
        DEC     sba2
        LDA+1   ad2
        STA+1   adrl
        BNE     @L3327
        LDA     test_case
        CMP     #$29
@L3366  BNE     @L3366
        LDA     #$2A
        STA     test_case
        SED
        LDX     #$0E
        LDY     #$FF
        LDA     #$99
        STA+1   ad1
        STA+1   ad2
        STA     ada2
        STA+1   adrl
        LDA     #$01
        STA+1   zpt
        STA+1   adrh
        LDA     #$00
        STA+1   sb2
        STA     sba2
@L338A  SEC
        JSR     chkdad
        DEC+1   zpt
        LDA+1   adrl
        BNE     @L339C
        DEC+1   adrh
        LDA     #$99
        STA+1   adrl
        BNE     @L33AE

@L339C  AND     #$0F
        BNE     @L33AC
        DEC+1   adrl
        DEC+1   adrl
        DEC+1   adrl
        DEC+1   adrl
        DEC+1   adrl
        DEC+1   adrl
@L33AC  DEC+1   adrl
@L33AE  CLC
        JSR     chkdad
        INC+1   zpt
        LDA+1   ad1
        BEQ     @L33CD
        AND     #$0F
        BNE     @L33C8
        DEC+1   ad1
        DEC+1   ad1
        DEC+1   ad1
        DEC+1   ad1
        DEC+1   ad1
        DEC+1   ad1
@L33C8  DEC+1   ad1
        JMP     @L338A

@L33CD  LDA     #$99
        STA+1   ad1
        LDA+1   ad2
        BEQ     @L3405
        AND     #$0F
        BNE     @L33F1
        DEC+1   ad2
        DEC+1   ad2
        DEC+1   ad2
        DEC+1   ad2
        DEC+1   ad2
        DEC+1   ad2
        INC+1   sb2
        INC+1   sb2
        INC+1   sb2
        INC+1   sb2
        INC+1   sb2
        INC+1   sb2
@L33F1  DEC+1   ad2
        INC+1   sb2
        LDA+1   sb2
        STA     sba2
        LDA+1   ad2
        STA     ada2
        STA+1   adrl
        INC+1   adrh
        BNE     @L338A
@L3405  LDA     test_case
        CMP     #$2A
@L340A  BNE     @L340A
        LDA     #$2B
        STA     test_case
        CLC
        CLD
        PHP
        LDA     #$55
        ADC     #$55
        CMP     #$AA
@L341A  BNE     @L341A
        CLC
        SED
        PHP
        LDA     #$55
        ADC     #$55
        CMP     #$10
@L3425  BNE     @L3425
        CLD
        PLP
        LDA     #$55
        ADC     #$55
        CMP     #$10
@L342F  BNE     @L342F
        PLP
        LDA     #$55
        ADC     #$55
        CMP     #$AA
@L3438  BNE     @L3438
        CLC
        LDA     #$34
        PHA
        LDA     #$55
        PHA
        PHP
        SED
        LDA     #$34
        PHA
        LDA     #$4C
        PHA
        PHP
        CLD
        RTI

dec_rti_ret
        LDA     #$55
        ADC     #$55
        CMP     #$10
@L3452  BNE     @L3452
        RTI

bin_rti_ret
        LDA     #$55
        ADC     #$55
        CMP     #$AA
@L345B  BNE     @L345B
        LDA     test_case
        CMP     #$2B
@L3462  BNE     @L3462
        LDA     #$F0
        STA     test_case
; final RAM integrity test
; verifies that none of the previous tests has altered RAM outside of the
; designated write areas.
;
; S U C C E S S ************************************************
; -------------
@L3469  JMP     @L3469     ;if you get here everything went well

        JMP     start      ;run again

chkdad  PHP
        LDA+1   ad1
        ADC+1   ad2
        PHP
        CMP+1   adrl
@L3477  BNE     @L3477
        PLA
        AND     #$01
        CMP+1   adrh
@L347E  BNE     @L347E
        PLP
        PHP
        LDA+1   ad1
        SBC+1   sb2
        PHP
        CMP+1   adrl
@L3489  BNE     @L3489
        PLA
        AND     #$01
        CMP+1   adrh
@L3490  BNE     @L3490
        PLP
        PHP
        LDA+1   ad1
        ADC     ada2
        PHP
        CMP+1   adrl
@L349C  BNE     @L349C
        PLA
        AND     #$01
        CMP+1   adrh
@L34A3  BNE     @L34A3
        PLP
        PHP
        LDA+1   ad1
        SBC     sba2
        PHP
        CMP+1   adrl
@L34AF  BNE     @L34AF
        PLA
        AND     #$01
        CMP+1   adrh
@L34B6  BNE     @L34B6
        PLP
        PHP
        LDA+1   ad2
        STA     ex_adci+1
        LDA+1   ad1
        JSR     ex_adci
        PHP
        CMP+1   adrl
@L34C7  BNE     @L34C7
        PLA
        AND     #$01
        CMP+1   adrh
@L34CE  BNE     @L34CE
        PLP
        PHP
        LDA+1   sb2
        STA     abs1-2
        LDA+1   ad1
        JSR     ex_sbci
        PHP
        CMP+1   adrl
@L34DF  BNE     @L34DF
        PLA
        AND     #$01
        CMP+1   adrh
@L34E6  BNE     @L34E6
        PLP
        PHP
        LDA+1   ad1
        ADC+1   L0000,X
        PHP
        CMP+1   adrl
@L34F1  BNE     @L34F1
        PLA
        AND     #$01
        CMP+1   adrh
@L34F8  BNE     @L34F8
        PLP
        PHP
        LDA+1   ad1
        SBC+1   L0000+4,X
        PHP
        CMP+1   adrl
@L3503  BNE     @L3503
        PLA
        AND     #$01
        CMP+1   adrh
@L350A  BNE     @L350A
        PLP
        PHP
        LDA+1   ad1
        ADC     zp_bss_end+$19B,X
        PHP
        CMP+1   adrl
@L3516  BNE     @L3516
        PLA
        AND     #$01
        CMP+1   adrh
@L351D  BNE     @L351D
        PLP
        PHP
        LDA+1   ad1
        SBC     zp_bss_end+$19C,X
        PHP
        CMP+1   adrl
@L3529  BNE     @L3529
        PLA
        AND     #$01
        CMP+1   adrh
@L3530  BNE     @L3530
        PLP
        PHP
        LDA+1   ad1
        ADC     zp_bss_end+170,Y
        PHP
        CMP+1   adrl
@L353C  BNE     @L353C
        PLA
        AND     #$01
        CMP+1   adrh
@L3543  BNE     @L3543
        PLP
        PHP
        LDA+1   ad1
        SBC     zp_bss_end+171,Y
        PHP
        CMP+1   adrl
@L354F  BNE     @L354F
        PLA
        AND     #$01
        CMP+1   adrh
@L3556  BNE     @L3556
        PLP
        PHP
        LDA+1   ad1
        ADC     (indEO+2,X)
        PHP
        CMP+1   adrl
@L3561  BNE     @L3561
        PLA
        AND     #$01
        CMP+1   adrh
@L3568  BNE     @L3568
        PLP
        PHP
        LDA+1   ad1
        SBC     (L0046,X)
        PHP
        CMP+1   adrl
@L3573  BNE     @L3573
        PLA
        AND     #$01
        CMP+1   adrh
@L357A  BNE     @L357A
        PLP
        PHP
        LDA+1   ad1
        ADC     (adiy2),Y
        PHP
        CMP+1   adrl
@L3585  BNE     @L3585
        PLA
        AND     #$01
        CMP+1   adrh
@L358C  BNE     @L358C
        PLP
        PHP
        LDA+1   ad1
        SBC     (sbiy2),Y
        PHP
        CMP+1   adrl
@L3597  BNE     @L3597
        PLA
        AND     #$01
        CMP+1   adrh
@L359E  BNE     @L359E
        PLP
        RTS

L35A2   LDA+1   adrf
        AND     #$83
        PHA
        LDA+1   ad1
        EOR+1   ad2
        BMI     @L35B7
        LDA+1   ad1
        EOR+1   adrl
        BPL     @L35B7
        PLA
        ORA     #$40
        PHA
@L35B7  PLA
        STA+1   adrf
        PHP
        LDA+1   ad1
        ADC+1   ad2
        PHP
        CMP+1   adrl
@L35C2  BNE     @L35C2
        PLA
        AND     #$C3
        CMP+1   adrf
@L35C9  BNE     @L35C9
        PLP
        PHP
        LDA+1   ad1
        SBC+1   sb2
        PHP
        CMP+1   adrl
@L35D4  BNE     @L35D4
        PLA
        AND     #$C3
        CMP+1   adrf
@L35DB  BNE     @L35DB
        PLP
        PHP
        LDA+1   ad1
        ADC     ada2
        PHP
        CMP+1   adrl
@L35E7  BNE     @L35E7
        PLA
        AND     #$C3
        CMP+1   adrf
@L35EE  BNE     @L35EE
        PLP
        PHP
        LDA+1   ad1
        SBC     sba2
        PHP
        CMP+1   adrl
@L35FA  BNE     @L35FA
        PLA
        AND     #$C3
        CMP+1   adrf
@L3601  BNE     @L3601
        PLP
        PHP
        LDA+1   ad2
        STA     ex_adci+1
        LDA+1   ad1
        JSR     ex_adci
        PHP
        CMP+1   adrl
@L3612  BNE     @L3612
        PLA
        AND     #$C3
        CMP+1   adrf
@L3619  BNE     @L3619
        PLP
        PHP
        LDA+1   sb2
        STA     abs1-2
        LDA+1   ad1
        JSR     ex_sbci
        PHP
        CMP+1   adrl
@L362A  BNE     @L362A
        PLA
        AND     #$C3
        CMP+1   adrf
@L3631  BNE     @L3631
        PLP
        PHP
        LDA+1   ad1
        ADC+1   L0000,X
        PHP
        CMP+1   adrl
@L363C  BNE     @L363C
        PLA
        AND     #$C3
        CMP+1   adrf
@L3643  BNE     @L3643
        PLP
        PHP
        LDA+1   ad1
        SBC+1   L0000+4,X
        PHP
        CMP+1   adrl
@L364E  BNE     @L364E
        PLA
        AND     #$C3
        CMP+1   adrf
@L3655  BNE     @L3655
        PLP
        PHP
        LDA+1   ad1
        ADC     zp_bss_end+$19B,X
        PHP
        CMP+1   adrl
@L3661  BNE     @L3661
        PLA
        AND     #$C3
        CMP+1   adrf
@L3668  BNE     @L3668
        PLP
        PHP
        LDA+1   ad1
        SBC     zp_bss_end+$19C,X
        PHP
        CMP+1   adrl
@L3674  BNE     @L3674
        PLA
        AND     #$C3
        CMP+1   adrf
@L367B  BNE     @L367B
        PLP
        PHP
        LDA+1   ad1
        ADC     zp_bss_end+170,Y
        PHP
        CMP+1   adrl
@L3687  BNE     @L3687
        PLA
        AND     #$C3
        CMP+1   adrf
@L368E  BNE     @L368E
        PLP
        PHP
        LDA+1   ad1
        SBC     zp_bss_end+171,Y
        PHP
        CMP+1   adrl
@L369A  BNE     @L369A
        PLA
        AND     #$C3
        CMP+1   adrf
@L36A1  BNE     @L36A1
        PLP
        PHP
        LDA+1   ad1
        ADC     (indEO+2,X)
        PHP
        CMP+1   adrl
@L36AC  BNE     @L36AC
        PLA
        AND     #$C3
        CMP+1   adrf
@L36B3  BNE     @L36B3
        PLP
        PHP
        LDA+1   ad1
        SBC     (L0046,X)
        PHP
        CMP+1   adrl
@L36BE  BNE     @L36BE
        PLA
        AND     #$C3
        CMP+1   adrf
@L36C5  BNE     @L36C5
        PLP
        PHP
        LDA+1   ad1
        ADC     (adiy2),Y
        PHP
        CMP+1   adrl
@L36D0  BNE     @L36D0
        PLA
        AND     #$C3
        CMP+1   adrf
@L36D7  BNE     @L36D7
        PLP
        PHP
        LDA+1   ad1
        SBC     (sbiy2),Y
        PHP
        CMP+1   adrl
@L36E2  BNE     @L36E2
        PLA
        AND     #$C3
        CMP+1   adrf
@L36E9  BNE     @L36E9
        PLP
        RTS

        !BYTE   $88
        !BYTE   $88

L36EF   PHP
        DEY
        DEY
        DEY
        PLP
@L36F4  BCS     @L36F4
@L36F6  BVS     @L36F6
@L36F8  BMI     @L36F8
@L36FA  BEQ     @L36FA
        CMP     #$46
@L36FE  BNE     @L36FE
        CPX     #$41
@L3702  BNE     @L3702
        CPY     #$4F
@L3706  BNE     @L3706
        PHA
        TXA
        PHA
        TSX
        CPX     #$FD
@L370E  BNE     @L370E
        PLA
        TAX
        LDA     #$FF
        PHA
        PLP
        PLA                ;restore a
        INX                ;return registers with modifications
        EOR     #$AA       ;N=1, V=1, Z=0, C=1
        JMP     far_ret

        !BYTE   $00
ptr_tst_ind
        !WORD   test_ind
ptr_ind_ret
        !WORD   ind_ret

@L3722  JMP     @L3722

        DEY
        DEY
test_ind
        PHP
        DEY
        DEY
        DEY
        PLP
@L372C  BCS     @L372C
@L372E  BVS     @L372E
@L3730  BMI     @L3730
@L3732  BEQ     @L3732
        CMP     #$49
@L3736  BNE     @L3736
        CPX     #$4E
@L373A  BNE     @L373A
        CPY     #$41
@L373E  BNE     @L373E
        PHA
        TXA
        PHA
        TSX
        CPX     #$FD
@L3746  BNE     @L3746
        PLA
        TAX
        LDA     #$FF
        PHA
        PLP
        PLA
        INX
        EOR     #$AA
        JMP     (ptr_ind_ret)

@L3755  JMP     @L3755

        JMP     start

; target for the jump subroutine test
        DEY
        DEY
test_jsr
        PHP
        DEY
        DEY
        DEY
        PLP
@L3762  BCS     @L3762
@L3764  BVS     @L3764
@L3766  BMI     @L3766
@L3768  BEQ     @L3768
        CMP     #$4A
@L376C  BNE     @L376C
        CPX     #$53
@L3770  BNE     @L3770
        CPY     #$4F
@L3774  BNE     @L3774
        PHA
        TXA
        PHA
        TSX
        CPX     #$FB
@L377C  BNE     @L377C
        LDA     test_case-1
        CMP     #$09
@L3783  BNE     @L3783
        LDA     zp_bss_end+$1A4
        CMP     #$9A
@L378A  BNE     @L378A
        LDA     #$FF
        PHA
        PLP
        PLA
        TAX
        PLA
        INX
        EOR     #$AA
        RTS

@L3797  JMP     @L3797

        JMP     start

nmi_trap
        JMP     nmi_trap

        JMP     start

res_trap
        JMP     res_trap

        JMP     start

        DEY
        DEY
irq_trap
        PHP
        DEY
        DEY
        DEY
        CMP     #$BD
        BEQ     break2
        CMP     #$42
@L37B5  BNE     @L37B5
        CPX     #$52
@L37B9  BNE     @L37B9
        CPY     #$48
@L37BD  BNE     @L37BD
        STA+1   irq_a
        STX+1   irq_x
        TSX
        LDA     zp_bss_end+168,X
        CMP     #$30
@L37C9  BNE     @L37C9
        PLA
        CMP     #$34
@L37CE  BNE     @L37CE
        TSX
        CPX     #$FC
@L37D3  BNE     @L37D3
        LDA     test_case-1
        CMP     #$09
@L37DA  BNE     @L37DA
        LDA     zp_bss_end+$1A4
        CMP     #$D1
@L37E1  BNE     @L37E1
        LDA     #$FF
        PHA
        LDX+1   irq_x
        INX
        LDA+1   irq_a
        EOR     #$AA
        PLP
        RTI

@L37EF  JMP     @L37EF

        JMP     start

break2  CPX     #$AD
@L37F7  BNE     @L37F7
        CPY     #$B1
@L37FB  BNE     @L37FB
        STA+1   irq_a
        STX+1   irq_x
        TSX
        LDA     zp_bss_end+168,X
        CMP     #$FF
@L3807  BNE     @L3807
        PLA
        ORA     #$08
        CMP     #$FF
@L380E  BNE     @L380E
        TSX
        CPX     #$FC
@L3813  BNE     @L3813
        LDA     test_case-1
        CMP     #$09
@L381A  BNE     @L381A
        LDA     zp_bss_end+$1A4
        CMP     #$F7
@L3821  BNE     @L3821
        LDA     #$04
        PHA
        LDX+1   irq_x
        INX
        LDA+1   irq_a
        EOR     #$AA
        PLP
        RTI

@L382F  JMP     @L382F

        JMP     start

        !FILL   51141,$FF
        !WORD   nmi_trap
        !WORD   res_trap
        !WORD   irq_trap
        } ;!pseudopc
