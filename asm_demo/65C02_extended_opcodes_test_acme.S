; Target assembler: acme v0.96.4 []
; 6502bench SourceGen v1.7.3
        !CPU    65c02
*       =       $0000
        !pseudopc $0000 {
        BRK

        !BYTE   $00
        !BYTE   $00
        !BYTE   $00
L0004   !FILL   6,$00
irq_a   !BYTE   $00
irq_x   !BYTE   $00
zpt     !BYTE   $00
ad1     !BYTE   $00
ad2     !BYTE   $00
adrl    !BYTE   $00
adrh    !BYTE   $00
adrf    !BYTE   $00
sb2     !BYTE   $00
        !BYTE   $C3
        !BYTE   $82
        !BYTE   $41
        !BYTE   $00
        !BYTE   $7F
        !BYTE   $00
        !BYTE   $1F
        !BYTE   $71
        !BYTE   $80
        !BYTE   $0F
        !BYTE   $FF
        !BYTE   $7F
        !BYTE   $80
        !BYTE   $FF
        !BYTE   $0F
        !BYTE   $8F
        !BYTE   $8F
ind1    !WORD   abs1
        !WORD   abs1+1
        !WORD   abs1+2
        !WORD   abs1+3
        !WORD   abs7f
inw1    !WORD   abs1-248
indt    !WORD   abst
        !WORD   abst+1
        !WORD   abst+2
        !WORD   abst+3
inwt    !WORD   L010D
indAN   !WORD   $0247
        !WORD   $0248
        !BYTE   $49
        !BYTE   $02
        !BYTE   $4A
        !BYTE   $02
indEO   !BYTE   $4B
        !BYTE   $02
        !BYTE   $4C
        !BYTE   $02
L0046   !BYTE   $4D
        !BYTE   $02
        !BYTE   $4E
        !BYTE   $02
indOR   !BYTE   $43
        !BYTE   $02
        !BYTE   $44
        !BYTE   $02
        !BYTE   $45
        !BYTE   $02
        !BYTE   $46
        !BYTE   $02
L0052   !BYTE   $05
        !BYTE   $02
L0054   !BYTE   $06
        !BYTE   $02
L0056   !BYTE   $06
        !BYTE   $01
L0058   !BYTE   $07
        !BYTE   $01
        !FILL   172,$FF
L0106   !BYTE   $FF
L0107   !FILL   6,$FF
L010D   !FILL   234,$FF
L01F7   !BYTE   $FF
L01F8   !FILL   6,$FF
L01FE   !BYTE   $FF
        !BYTE   $FF
pg_x    !FILL   2,$00
test_case
        !BYTE   $00
ram_chksm
        !FILL   2,$00
abst    !BYTE   $00
ada2    !BYTE   $00
sba2    !BYTE   $00
        !BYTE   $00
        !BYTE   $00

ex_adci ADC     #$00
        RTS

ex_sbci SBC     #$00
        RTS

abs1    !BYTE   $C3
        !BYTE   $82
        !BYTE   $41
        !BYTE   $00
abs7f   !BYTE   $7F
fLDx    !BYTE   $80
        !BYTE   $80
        !BYTE   $00
        !BYTE   $02
rROL    !BYTE   $86
        !BYTE   $04
        !BYTE   $82
        !BYTE   $00
rROLc   !BYTE   $87
        !BYTE   $05
        !BYTE   $83
        !BYTE   $01
        !BYTE   $61
        !BYTE   $41
        !BYTE   $20
        !BYTE   $00
        !BYTE   $E1
        !BYTE   $C1
        !BYTE   $A0
        !BYTE   $80
        !BYTE   $81
        !BYTE   $01
        !BYTE   $80
        !BYTE   $02
        !BYTE   $81
        !BYTE   $01
        !BYTE   $80
        !BYTE   $00
        !BYTE   $01
        !BYTE   $00
        !BYTE   $01
        !BYTE   $02
        !BYTE   $81
        !BYTE   $80
        !BYTE   $81
        !BYTE   $80
        !BYTE   $7F
        !BYTE   $80
        !BYTE   $FF
        !BYTE   $00
        !BYTE   $01
        !BYTE   $00
        !BYTE   $80
        !BYTE   $80
        !BYTE   $02
        !BYTE   $00
        !BYTE   $00
        !BYTE   $1F
        !BYTE   $71
        !BYTE   $80
        !BYTE   $0F
        !BYTE   $FF
        !BYTE   $7F
        !BYTE   $80
        !BYTE   $FF
        !BYTE   $0F
        !BYTE   $8F
        !BYTE   $8F
absORa  !BYTE   $00
        !BYTE   $F1
        !BYTE   $1F
        !BYTE   $00
absANa  !BYTE   $F0
        !BYTE   $FF
        !BYTE   $FF
        !BYTE   $FF
absEOa  !BYTE   $FF
        !BYTE   $F0
        !BYTE   $F0
        !BYTE   $0F
absrlo  !BYTE   $00
        !BYTE   $FF
        !BYTE   $7F
        !BYTE   $80
absflo  !BYTE   $02
        !BYTE   $80
        !BYTE   $00
        !BYTE   $80
        !FILL   150,$FF
jxi_tab !BYTE   $FF
        !BYTE   $FF
        !BYTE   $FF
        !BYTE   $FF
ji_tab  !BYTE   $FF
        !BYTE   $FF
        !BYTE   $FF
        !BYTE   $FF
L0301   !FILL   255,$FF

        } ;!pseudopc
        !pseudopc $0400 {
start   CLD
        LDX     #$FF
        TXS
        LDA     #$00       ;*** test 0 = initialize
        STA     test_case
        LDA     test_case  ;previous test
        CMP     #$00
; trap_ne         ;test is out of sequence
fail    BNE     fail
; test_num = test_num + 1
        LDA     #$01
        STA     test_case
; testing stack operations PHX PHY PLX PLY
        LDA     #$99       ;protect a
        LDX     #$FF       ;initialize stack
        TXS
        LDX     #$55
        PHX
        LDX     #$AA
        PHX
        CPX     $01FE      ;on stack ?
trap_ne BNE     trap_ne    ;failed not equal (non zero)
        TSX
        CPX     #$FD       ;sp decremented?
@L0428  BNE     @L0428     ;failed not equal (non zero)
        PLY
        CPY     #$AA       ;successful retreived from stack?
@L042D  BNE     @L042D     ;failed not equal (non zero)
        PLY
        CPY     #$55
@L0432  BNE     @L0432
        CPY     pg_x-1
@L0437  BNE     @L0437
        TSX
        CPX     #$FF
@L043C  BNE     @L043C
        LDY     #$A5
        PHY
        LDY     #$5A
        PHY
        CPY     L01FE
@L0447  BNE     @L0447
        TSX
        CPX     #$FD
@L044C  BNE     @L044C
        PLX
        CPX     #$5A
@L0451  BNE     @L0451
        PLX
        CPX     #$A5
@L0456  BNE     @L0456
        CPX     pg_x-1
@L045B  BNE     @L045B
        TSX
        CPX     #$FF
@L0460  BNE     @L0460
        CMP     #$99
@L0464  BNE     @L0464
        LDA     test_case
        CMP     #$01
@L046B  BNE     @L046B
        LDA     #$02
        STA     test_case
        LDY     #$AA
        LDA     #$FF
        PHA
        LDX     #$01
        PLP
        PHX
        PHP
        CPX     #$01
@L047E  BNE     @L047E
        PLA
        PHA
        CMP     #$FF
@L0484  BNE     @L0484
        PLP
        LDA     #$00
        PHA
        LDX     #$00
        PLP
        PHX
        PHP
        CPX     #$00
@L0491  BNE     @L0491
        PLA
        PHA
        CMP     #$30
@L0497  BNE     @L0497
        PLP
        LDA     #$FF
        PHA
        LDX     #$FF
        PLP
        PHX
        PHP
        CPX     #$FF
@L04A4  BNE     @L04A4
        PLA
        PHA
        CMP     #$FF
@L04AA  BNE     @L04AA
        PLP
        LDA     #$00
        PHA
        LDX     #$01
        PLP
        PHX
        PHP
        CPX     #$01
@L04B7  BNE     @L04B7
        PLA
        PHA
        CMP     #$30
@L04BD  BNE     @L04BD
        PLP
        LDA     #$FF
        PHA
        LDX     #$00
        PLP
        PHX
        PHP
        CPX     #$00
@L04CA  BNE     @L04CA
        PLA
        PHA
        CMP     #$FF
@L04D0  BNE     @L04D0
        PLP
        LDA     #$00
        PHA
        LDX     #$FF
        PLP
        PHX
        PHP
        CPX     #$FF
@L04DD  BNE     @L04DD
        PLA
        PHA
        CMP     #$30
@L04E3  BNE     @L04E3
        PLP
        LDA     #$FF
        PHA
        LDX     #$00
        PLP
        PLX
        PHP
        CPX     #$FF
@L04F0  BNE     @L04F0
        PLA
        PHA
        CMP     #$FD
@L04F6  BNE     @L04F6
        PLP
        LDA     #$00
        PHA
        LDX     #$FF
        PLP
        PLX
        PHP
        CPX     #$00
@L0503  BNE     @L0503
        PLA
        PHA
        CMP     #$32
@L0509  BNE     @L0509
        PLP
        LDA     #$FF
        PHA
        LDX     #$FE
        PLP
        PLX
        PHP
        CPX     #$01
@L0516  BNE     @L0516
        PLA
        PHA
        CMP     #$7D
@L051C  BNE     @L051C
        PLP
        LDA     #$00
        PHA
        LDX     #$00
        PLP
        PLX
        PHP
        CPX     #$FF
@L0529  BNE     @L0529
        PLA
        PHA
        CMP     #$B0
@L052F  BNE     @L052F
        PLP
        LDA     #$FF
        PHA
        LDX     #$FF
        PLP
        PLX
        PHP
        CPX     #$00
@L053C  BNE     @L053C
        PLA
        PHA
        CMP     #$7F
@L0542  BNE     @L0542
        PLP
        LDA     #$00
        PHA
        LDX     #$FE
        PLP
        PLX
        PHP
        CPX     #$01
@L054F  BNE     @L054F
        PLA
        PHA
        CMP     #$30
@L0555  BNE     @L0555
        PLP
        CPY     #$AA
@L055A  BNE     @L055A
        LDA     test_case
        CMP     #$02
@L0561  BNE     @L0561
        LDA     #$03
        STA     test_case
        LDX     #$55
        LDA     #$FF
        PHA
        LDY     #$01
        PLP
        PHY
        PHP
        CPY     #$01
@L0574  BNE     @L0574
        PLA
        PHA
        CMP     #$FF
@L057A  BNE     @L057A
        PLP
        LDA     #$00
        PHA
        LDY     #$00
        PLP
        PHY
        PHP
        CPY     #$00
@L0587  BNE     @L0587
        PLA
        PHA
        CMP     #$30
@L058D  BNE     @L058D
        PLP
        LDA     #$FF
        PHA
        LDY     #$FF
        PLP
        PHY
        PHP
        CPY     #$FF
@L059A  BNE     @L059A
        PLA
        PHA
        CMP     #$FF
@L05A0  BNE     @L05A0
        PLP
        LDA     #$00
        PHA
        LDY     #$01
        PLP
        PHY
        PHP
        CPY     #$01
@L05AD  BNE     @L05AD
        PLA
        PHA
        CMP     #$30
@L05B3  BNE     @L05B3
        PLP
        LDA     #$FF
        PHA
        LDY     #$00
        PLP
        PHY
        PHP
        CPY     #$00
@L05C0  BNE     @L05C0
        PLA
        PHA
        CMP     #$FF
@L05C6  BNE     @L05C6
        PLP
        LDA     #$00
        PHA
        LDY     #$FF
        PLP
        PHY
        PHP
        CPY     #$FF
@L05D3  BNE     @L05D3
        PLA
        PHA
        CMP     #$30
@L05D9  BNE     @L05D9
        PLP
        LDA     #$FF
        PHA
        LDY     #$00
        PLP
        PLY
        PHP
        CPY     #$FF
@L05E6  BNE     @L05E6
        PLA
        PHA
        CMP     #$FD
@L05EC  BNE     @L05EC
        PLP
        LDA     #$00
        PHA
        LDY     #$FF
        PLP
        PLY
        PHP
        CPY     #$00
@L05F9  BNE     @L05F9
        PLA
        PHA
        CMP     #$32
@L05FF  BNE     @L05FF
        PLP
        LDA     #$FF
        PHA
        LDY     #$FE
        PLP
        PLY
        PHP
        CPY     #$01
@L060C  BNE     @L060C
        PLA
        PHA
        CMP     #$7D
@L0612  BNE     @L0612
        PLP
        LDA     #$00
        PHA
        LDY     #$00
        PLP
        PLY
        PHP
        CPY     #$FF
@L061F  BNE     @L061F
        PLA
        PHA
        CMP     #$B0
@L0625  BNE     @L0625
        PLP
        LDA     #$FF
        PHA
        LDY     #$FF
        PLP
        PLY
        PHP
        CPY     #$00
@L0632  BNE     @L0632
        PLA
        PHA
        CMP     #$7F
@L0638  BNE     @L0638
        PLP
        LDA     #$00
        PHA
        LDY     #$FE
        PLP
        PLY
        PHP
        CPY     #$01
@L0645  BNE     @L0645
        PLA
        PHA
        CMP     #$30
@L064B  BNE     @L064B
        PLP
        CPX     #$55
@L0650  BNE     @L0650
        LDA     test_case
        CMP     #$03
@L0657  BNE     @L0657
        LDA     #$04
        STA     test_case
        LDX     #$81
        LDY     #$7E
        LDA     #$FF
        PHA
        LDA     #$00
        PLP
        BRA     @L066D

        !BYTE   $4C
        !BYTE   $6A
        !BYTE   $06

@L066D  PHP
        CMP     #$00
@L0670  BNE     @L0670
        PLA
        PHA
        CMP     #$FF
@L0676  BNE     @L0676
        PLP
        LDA     #$00
        PHA
        LDA     #$FF
        PLP
        BRA     @L0684

        !BYTE   $4C
        !BYTE   $81
        !BYTE   $06

@L0684  PHP
        CMP     #$FF
@L0687  BNE     @L0687
        PLA
        PHA
        CMP     #$30
@L068D  BNE     @L068D
        PLP
        CPX     #$81
@L0692  BNE     @L0692
        CPY     #$7E
@L0696  BNE     @L0696
        LDA     test_case
        CMP     #$04
@L069D  BNE     @L069D
        LDA     #$05
        STA     test_case
        LDY     #$00
        BRA     @L0709

@L06A8  CPY     #$01
@L06AA  BNE     @L06AA
        INY
        BRA     @L0702

@L06AF  CPY     #$03
@L06B1  BNE     @L06B1
        INY
        BRA     @L06FB

@L06B6  CPY     #$05
@L06B8  BNE     @L06B8
        INY
        LDY     #$00
        BRA     @L06C3

        !xor    $80 {
        !text   "HHHH"
        }

@L06C3  BRA     @L06C8

        !BYTE   $C8
        !BYTE   $C8
        !BYTE   $C8

@L06C8  INY
        BRA     @L06CD

        !BYTE   $C8
        !BYTE   $C8

@L06CD  INY
        INY
        BRA     @L06D2

        !BYTE   $C8

@L06D2  INY
        INY
        INY
        BRA     @L06D7

@L06D7  INY
        INY
        INY
        INY
        CPY     #$0A
@L06DD  BNE     @L06DD
        BRA     @L06F3

@L06E1  DEY
        DEY
        DEY
        DEY
        BRA     @L06F5

@L06E7  DEY
        DEY
        DEY
        BRA     @L06E1

@L06EC  DEY
        DEY
        BRA     @L06E7

@L06F0  DEY
        BRA     @L06EC

@L06F3  BRA     @L06F0

@L06F5  CPY     #$00
@L06F7  BNE     @L06F7
        BRA     @L0710

@L06FB  CPY     #$04
@L06FD  BNE     @L06FD
        INY
        BRA     @L06B6

@L0702  CPY     #$02
@L0704  BNE     @L0704
        INY
        BRA     @L06AF

@L0709  CPY     #$00
@L070B  BNE     @L070B
        INY
        BRA     @L06A8

@L0710  LDA     test_case
        CMP     #$05
@L0715  BNE     @L0715
        LDA     #$06
        STA     test_case
        LDX     #$11
        LDY     #$22
        LDA     #$01
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$33
        PLP
        !BYTE   $0F
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $8F
        !BYTE   $0C
        !BYTE   $06

@L0730  JMP     @L0730

@L0733  JMP     @L0733

        PHP
        CMP     #$33
@L0739  BNE     @L0739
        PLA
        PHA
        CMP     #$30
@L073F  BNE     @L073F
        PLP
        LDA     #$FF
        PHA
        LDA     #$CC
        PLP
        !BYTE   $0F
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $8F
        !BYTE   $0C
        !BYTE   $06

@L074E  JMP     @L074E

@L0751  JMP     @L0751

        PHP
        CMP     #$CC
@L0757  BNE     @L0757
        PLA
        PHA
        CMP     #$FF
@L075D  BNE     @L075D
        PLP
        LDA+1   zpt
        CMP     #$01
@L0764  BNE     @L0764
        LDA     #$FE
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$33
        PLP
        !BYTE   $8F
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $0F
        !BYTE   $0C
        !BYTE   $06

@L0776  JMP     @L0776

@L0779  JMP     @L0779

        PHP
        CMP     #$33
@L077F  BNE     @L077F
        PLA
        PHA
        CMP     #$30
@L0785  BNE     @L0785
        PLP
        LDA     #$FF
        PHA
        LDA     #$CC
        PLP
        !BYTE   $8F
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $0F
        !BYTE   $0C
        !BYTE   $06

@L0794  JMP     @L0794

@L0797  JMP     @L0797

        PHP
        CMP     #$CC
@L079D  BNE     @L079D
        PLA
        PHA
        CMP     #$FF
@L07A3  BNE     @L07A3
        PLP
        LDA+1   zpt
        CMP     #$FE
@L07AA  BNE     @L07AA
        LDA     #$02
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$33
        PLP
        !BYTE   $1F
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $9F
        !BYTE   $0C
        !BYTE   $06

@L07BC  JMP     @L07BC

@L07BF  JMP     @L07BF

        PHP
        CMP     #$33
@L07C5  BNE     @L07C5
        PLA
        PHA
        CMP     #$30
@L07CB  BNE     @L07CB
        PLP
        LDA     #$FF
        PHA
        LDA     #$CC
        PLP
        !BYTE   $1F
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $9F
        !BYTE   $0C
        !BYTE   $06

@L07DA  JMP     @L07DA

@L07DD  JMP     @L07DD

        PHP
        CMP     #$CC
@L07E3  BNE     @L07E3
        PLA
        PHA
        CMP     #$FF
@L07E9  BNE     @L07E9
        PLP
        LDA+1   zpt
        CMP     #$02
@L07F0  BNE     @L07F0
        LDA     #$FD
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$33
        PLP
        !BYTE   $9F
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $1F
        !BYTE   $0C
        !BYTE   $06

@L0802  JMP     @L0802

@L0805  JMP     @L0805

        PHP
        CMP     #$33
@L080B  BNE     @L080B
        PLA
        PHA
        CMP     #$30
@L0811  BNE     @L0811
        PLP
        LDA     #$FF
        PHA
        LDA     #$CC
        PLP
        !BYTE   $9F
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $1F
        !BYTE   $0C
        !BYTE   $06

@L0820  JMP     @L0820

@L0823  JMP     @L0823

        PHP
        CMP     #$CC
@L0829  BNE     @L0829
        PLA
        PHA
        CMP     #$FF
@L082F  BNE     @L082F
        PLP
        LDA+1   zpt
        CMP     #$FD
@L0836  BNE     @L0836
        LDA     #$04
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$33
        PLP
        !BYTE   $2F
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $AF
        !BYTE   $0C
        !BYTE   $06

@L0848  JMP     @L0848

@L084B  JMP     @L084B

        PHP
        CMP     #$33
@L0851  BNE     @L0851
        PLA
        PHA
        CMP     #$30
@L0857  BNE     @L0857
        PLP
        LDA     #$FF
        PHA
        LDA     #$CC
        PLP
        !BYTE   $2F
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $AF
        !BYTE   $0C
        !BYTE   $06

@L0866  JMP     @L0866

@L0869  JMP     @L0869

        PHP
        CMP     #$CC
@L086F  BNE     @L086F
        PLA
        PHA
        CMP     #$FF
@L0875  BNE     @L0875
        PLP
        LDA+1   zpt
        CMP     #$04
@L087C  BNE     @L087C
        LDA     #$FB
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$33
        PLP
        !BYTE   $AF
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $2F
        !BYTE   $0C
        !BYTE   $06

@L088E  JMP     @L088E

@L0891  JMP     @L0891

        PHP
        CMP     #$33
@L0897  BNE     @L0897
        PLA
        PHA
        CMP     #$30
@L089D  BNE     @L089D
        PLP
        LDA     #$FF
        PHA
        LDA     #$CC
        PLP
        !BYTE   $AF
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $2F
        !BYTE   $0C
        !BYTE   $06

@L08AC  JMP     @L08AC

@L08AF  JMP     @L08AF

        PHP
        CMP     #$CC
@L08B5  BNE     @L08B5
        PLA
        PHA
        CMP     #$FF
@L08BB  BNE     @L08BB
        PLP
        LDA+1   zpt
        CMP     #$FB
@L08C2  BNE     @L08C2
        LDA     #$08
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$33
        PLP
        !BYTE   $3F
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $BF
        !BYTE   $0C
        !BYTE   $06

@L08D4  JMP     @L08D4

@L08D7  JMP     @L08D7

        PHP
        CMP     #$33
@L08DD  BNE     @L08DD
        PLA
        PHA
        CMP     #$30
@L08E3  BNE     @L08E3
        PLP
        LDA     #$FF
        PHA
        LDA     #$CC
        PLP
        !BYTE   $3F
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $BF
        !BYTE   $0C
        !BYTE   $06

@L08F2  JMP     @L08F2

@L08F5  JMP     @L08F5

        PHP
        CMP     #$CC
@L08FB  BNE     @L08FB
        PLA
        PHA
        CMP     #$FF
@L0901  BNE     @L0901
        PLP
        LDA+1   zpt
        CMP     #$08
@L0908  BNE     @L0908
        LDA     #$F7
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$33
        PLP
        !BYTE   $BF
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $3F
        !BYTE   $0C
        !BYTE   $06

@L091A  JMP     @L091A

@L091D  JMP     @L091D

        PHP
        CMP     #$33
@L0923  BNE     @L0923
        PLA
        PHA
        CMP     #$30
@L0929  BNE     @L0929
        PLP
        LDA     #$FF
        PHA
        LDA     #$CC
        PLP
        !BYTE   $BF
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $3F
        !BYTE   $0C
        !BYTE   $06

@L0938  JMP     @L0938

@L093B  JMP     @L093B

        PHP
        CMP     #$CC
@L0941  BNE     @L0941
        PLA
        PHA
        CMP     #$FF
@L0947  BNE     @L0947
        PLP
        LDA+1   zpt
        CMP     #$F7
@L094E  BNE     @L094E
        LDA     #$10
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$33
        PLP
        !BYTE   $4F
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $CF
        !BYTE   $0C
        !BYTE   $06

@L0960  JMP     @L0960

@L0963  JMP     @L0963

        PHP
        CMP     #$33
@L0969  BNE     @L0969
        PLA
        PHA
        CMP     #$30
@L096F  BNE     @L096F
        PLP
        LDA     #$FF
        PHA
        LDA     #$CC
        PLP
        !BYTE   $4F
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $CF
        !BYTE   $0C
        !BYTE   $06

@L097E  JMP     @L097E

@L0981  JMP     @L0981

        PHP
        CMP     #$CC
@L0987  BNE     @L0987
        PLA
        PHA
        CMP     #$FF
@L098D  BNE     @L098D
        PLP
        LDA+1   zpt
        CMP     #$10
@L0994  BNE     @L0994
        LDA     #$EF
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$33
        PLP
        !BYTE   $CF
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $4F
        !BYTE   $0C
        !BYTE   $06

@L09A6  JMP     @L09A6

@L09A9  JMP     @L09A9

        !BYTE   $08

        CMP     #$33
@L09AF  BNE     @L09AF
        PLA
        PHA
        CMP     #$30
@L09B5  BNE     @L09B5
        PLP
        LDA     #$FF
        PHA
        LDA     #$CC
        PLP
        !BYTE   $CF
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $4F
        !BYTE   $0C
        !BYTE   $06

@L09C4  JMP     @L09C4

@L09C7  JMP     @L09C7

        PHP
        CMP     #$CC
@L09CD  BNE     @L09CD
        PLA
        PHA
        CMP     #$FF
@L09D3  BNE     @L09D3
        PLP
        LDA+1   zpt
        CMP     #$EF
@L09DA  BNE     @L09DA
        LDA     #$20
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$33
        PLP
        !BYTE   $5F
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $DF
        !BYTE   $0C
        !BYTE   $06

@L09EC  JMP     @L09EC

@L09EF  JMP     @L09EF

        PHP
        CMP     #$33
@L09F5  BNE     @L09F5
        PLA
        PHA
        CMP     #$30
@L09FB  BNE     @L09FB
        PLP
        LDA     #$FF
        PHA
        LDA     #$CC
        PLP
        !BYTE   $5F
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $DF
        !BYTE   $0C
        !BYTE   $06

@L0A0A  JMP     @L0A0A

@L0A0D  JMP     @L0A0D

        PHP
        CMP     #$CC
@L0A13  BNE     @L0A13
        PLA
        PHA
        CMP     #$FF
@L0A19  BNE     @L0A19
        PLP
        LDA+1   zpt
        CMP     #$20
@L0A20  BNE     @L0A20
        LDA     #$DF
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$33
        PLP
        !BYTE   $DF
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $5F
        !BYTE   $0C
        !BYTE   $06

@L0A32  JMP     @L0A32

@L0A35  JMP     @L0A35

        PHP
        CMP     #$33
@L0A3B  BNE     @L0A3B
        PLA
        PHA
        CMP     #$30
@L0A41  BNE     @L0A41
        PLP
        LDA     #$FF
        PHA
        LDA     #$CC
        PLP
        !BYTE   $DF
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $5F
        !BYTE   $0C
        !BYTE   $06

@L0A50  JMP     @L0A50

@L0A53  JMP     @L0A53

        PHP
        CMP     #$CC
@L0A59  BNE     @L0A59
        PLA
        PHA
        CMP     #$FF
@L0A5F  BNE     @L0A5F
        PLP
        LDA+1   zpt
        CMP     #$DF
@L0A66  BNE     @L0A66
        LDA     #$40
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$33
        PLP
        !BYTE   $6F
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $EF
        !BYTE   $0C
        !BYTE   $06

@L0A78  JMP     @L0A78

@L0A7B  JMP     @L0A7B

        PHP
        CMP     #$33
@L0A81  BNE     @L0A81
        PLA
        PHA
        CMP     #$30
@L0A87  BNE     @L0A87
        PLP
        LDA     #$FF
        PHA
        LDA     #$CC
        PLP
        !BYTE   $6F
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $EF
        !BYTE   $0C
        !BYTE   $06

@L0A96  JMP     @L0A96

@L0A99  JMP     @L0A99

        PHP
        CMP     #$CC
@L0A9F  BNE     @L0A9F
        PLA
        PHA
        CMP     #$FF
@L0AA5  BNE     @L0AA5
        PLP
        LDA+1   zpt
        CMP     #$40
@L0AAC  BNE     @L0AAC
        LDA     #$BF
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$33
        PLP
        !BYTE   $EF
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $6F
        !BYTE   $0C
        !BYTE   $06

@L0ABE  JMP     @L0ABE

@L0AC1  JMP     @L0AC1

        PHP
        CMP     #$33
@L0AC7  BNE     @L0AC7
        PLA
        PHA
        CMP     #$30
@L0ACD  BNE     @L0ACD
        PLP
        LDA     #$FF
        PHA
        LDA     #$CC
        PLP
        !BYTE   $EF
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $6F
        !BYTE   $0C
        !BYTE   $06

@L0ADC  JMP     @L0ADC

@L0ADF  JMP     @L0ADF

        PHP
        CMP     #$CC
@L0AE5  BNE     @L0AE5
        PLA
        PHA
        CMP     #$FF
@L0AEB  BNE     @L0AEB
        PLP
        LDA+1   zpt
        CMP     #$BF
@L0AF2  BNE     @L0AF2
        LDA     #$80
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$33
        PLP
        !BYTE   $7F
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $FF
        !BYTE   $0C
        !BYTE   $06

@L0B04  JMP     @L0B04

@L0B07  JMP     @L0B07

        PHP
        CMP     #$33
@L0B0D  BNE     @L0B0D
        PLA
        PHA
        CMP     #$30
@L0B13  BNE     @L0B13
        PLP
        LDA     #$FF
        PHA
        LDA     #$CC
        PLP
        !BYTE   $7F
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $FF
        !BYTE   $0C
        !BYTE   $06

@L0B22  JMP     @L0B22

@L0B25  JMP     @L0B25

        PHP
        CMP     #$CC
@L0B2B  BNE     @L0B2B
        PLA
        PHA
        CMP     #$FF
@L0B31  BNE     @L0B31
        PLP
        LDA+1   zpt
        CMP     #$80
@L0B38  BNE     @L0B38
        LDA     #$7F
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$33
        PLP
        !BYTE   $FF
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $7F
        !BYTE   $0C
        !BYTE   $06

@L0B4A  JMP     @L0B4A

@L0B4D  JMP     @L0B4D

        PHP
        CMP     #$33
@L0B53  BNE     @L0B53
        PLA
        PHA
        CMP     #$30
@L0B59  BNE     @L0B59
        PLP
        LDA     #$FF
        PHA
        LDA     #$CC
        PLP
        !BYTE   $FF
        !BYTE   $0C
        !BYTE   $06
        !BYTE   $7F
        !BYTE   $0C
        !BYTE   $06

@L0B68  JMP     @L0B68

@L0B6B  JMP     @L0B6B

        PHP
        CMP     #$CC
@L0B71  BNE     @L0B71
        PLA
        PHA
        CMP     #$FF
@L0B77  BNE     @L0B77
        PLP
        LDA+1   zpt
        CMP     #$7F
@L0B7E  BNE     @L0B7E
        CPX     #$11
@L0B82  BNE     @L0B82
        CPY     #$22
@L0B86  BNE     @L0B86
        LDA     test_case
        CMP     #$06
@L0B8D  BNE     @L0B8D
        LDA     #$07
        STA     test_case
        LDA     #$00
        STA+1   zpt
@L0B98  LDA     #$00
        !BYTE   $0F
        !BYTE   $0C
        !BYTE   $02

        EOR     #$01
        !BYTE   $1F
        !BYTE   $0C
        !BYTE   $02

        EOR     #$02
        !BYTE   $2F
        !BYTE   $0C
        !BYTE   $02

        EOR     #$04
        !BYTE   $3F
        !BYTE   $0C
        !BYTE   $02

        EOR     #$08
        !BYTE   $4F
        !BYTE   $0C
        !BYTE   $02

        EOR     #$10
        !BYTE   $5F
        !BYTE   $0C
        !BYTE   $02

        EOR     #$20
        !BYTE   $6F
        !BYTE   $0C
        !BYTE   $02

        EOR     #$40
        !BYTE   $7F
        !BYTE   $0C
        !BYTE   $02

        EOR     #$80
        EOR+1   zpt
@L0BC4  BNE     @L0BC4
        LDA     #$FF
        !BYTE   $8F
        !BYTE   $0C
        !BYTE   $02

        EOR     #$01
        !BYTE   $9F
        !BYTE   $0C
        !BYTE   $02

        EOR     #$02
        !BYTE   $AF
        !BYTE   $0C
        !BYTE   $02

        EOR     #$04
        !BYTE   $BF
        !BYTE   $0C
        !BYTE   $02

        EOR     #$08
        !BYTE   $CF
        !BYTE   $0C
        !BYTE   $02

        EOR     #$10
        !BYTE   $DF
        !BYTE   $0C
        !BYTE   $02

        EOR     #$20
        !BYTE   $EF
        !BYTE   $0C
        !BYTE   $02

        EOR     #$40
        !BYTE   $FF
        !BYTE   $0C
        !BYTE   $02

        EOR     #$80
        EOR+1   zpt
@L0BF2  BNE     @L0BF2
        INC+1   zpt
        BNE     @L0B98
        LDA     test_case
        CMP     #$07
@L0BFD  BNE     @L0BFD
        LDA     #$08
        STA     test_case
        LDY     #$42
        LDX     #$02
        !BYTE   $02
        INY
        DEX
        DEX
@L0C0C  BNE     @L0C0C
        LDA     #$00
        PHA
        LDA     #$FD
        PLP
        !BYTE   $02
        NOP
        NOP
        PHP
        CMP     #$FD
@L0C1A  BNE     @L0C1A
        PLA
        PHA
        CMP     #$30
@L0C20  BNE     @L0C20
        PLP
        LDA     #$FF
        PHA
        LDA     #$A8
        PLP
        !BYTE   $02
        NOP
        NOP
        PHP
        CMP     #$A8
@L0C2F  BNE     @L0C2F
        PLA
        PHA
        CMP     #$FF
@L0C35  BNE     @L0C35
        PLP
        CPY     #$42
@L0C3A  BNE     @L0C3A
        CPX     #$00
@L0C3E  BNE     @L0C3E
        LDY     #$42
        LDX     #$02
        !BYTE   $22
        INY
        DEX
        DEX
@L0C48  BNE     @L0C48
        LDA     #$00
        PHA
        LDA     #$DD
        PLP
        !BYTE   $22
        NOP
        NOP
        PHP
        CMP     #$DD
@L0C56  BNE     @L0C56
        PLA
        PHA
        CMP     #$30
@L0C5C  BNE     @L0C5C
        PLP
        LDA     #$FF
        PHA
        LDA     #$88
        PLP
        !BYTE   $22
        NOP
        NOP
        PHP
        CMP     #$88
@L0C6B  BNE     @L0C6B
        PLA
        PHA
        CMP     #$FF
@L0C71  BNE     @L0C71
        PLP
        CPY     #$42
@L0C76  BNE     @L0C76
        CPX     #$00
@L0C7A  BNE     @L0C7A
        LDY     #$42
        LDX     #$02
        !BYTE   $42
        INY
        DEX
        DEX
@L0C84  BNE     @L0C84
        LDA     #$00
        PHA
        LDA     #$BD
        PLP
        !BYTE   $42
        NOP
        NOP
        PHP
        CMP     #$BD
@L0C92  BNE     @L0C92
        PLA
        PHA
        CMP     #$30
@L0C98  BNE     @L0C98
        PLP
        LDA     #$FF
        PHA
        LDA     #$68
        PLP
        !BYTE   $42
        NOP
        NOP
        PHP
        CMP     #$68
@L0CA7  BNE     @L0CA7
        PLA
        PHA
        CMP     #$FF
@L0CAD  BNE     @L0CAD
        PLP
        CPY     #$42
@L0CB2  BNE     @L0CB2
        CPX     #$00
@L0CB6  BNE     @L0CB6
        LDY     #$42
        LDX     #$02
        !BYTE   $62
        INY
        DEX
        DEX
@L0CC0  BNE     @L0CC0
        LDA     #$00
        PHA
        LDA     #$9D
        PLP
        !BYTE   $62
        NOP
        NOP
        PHP
        CMP     #$9D
@L0CCE  BNE     @L0CCE
        PLA
        PHA
        CMP     #$30
@L0CD4  BNE     @L0CD4
        PLP
        LDA     #$FF
        PHA
        LDA     #$48
        PLP
        !BYTE   $62
        NOP
        NOP
        PHP
        CMP     #$48
@L0CE3  BNE     @L0CE3
        PLA
        PHA
        CMP     #$FF
@L0CE9  BNE     @L0CE9
        PLP
        CPY     #$42
@L0CEE  BNE     @L0CEE
        CPX     #$00
@L0CF2  BNE     @L0CF2
        LDY     #$42
        LDX     #$02
        !BYTE   $82
        INY
        DEX
        DEX
@L0CFC  BNE     @L0CFC
        LDA     #$00
        PHA
        LDA     #$7D
        PLP
        !BYTE   $82
        NOP
        NOP
        PHP
        CMP     #$7D
@L0D0A  BNE     @L0D0A
        PLA
        PHA
        CMP     #$30
@L0D10  BNE     @L0D10
        PLP
        LDA     #$FF
        PHA
        LDA     #$28
        PLP
        !BYTE   $82
        NOP
        NOP
        PHP
        CMP     #$28
@L0D1F  BNE     @L0D1F
        PLA
        PHA
        CMP     #$FF
@L0D25  BNE     @L0D25
        PLP
        CPY     #$42
@L0D2A  BNE     @L0D2A
        CPX     #$00
@L0D2E  BNE     @L0D2E
        LDY     #$42
        LDX     #$02
        !BYTE   $C2
        INY
        DEX
        DEX
@L0D38  BNE     @L0D38
        LDA     #$00
        PHA
        LDA     #$3D
        PLP
        !BYTE   $C2
        NOP
        NOP
        PHP
        CMP     #$3D
@L0D46  BNE     @L0D46
        PLA
        PHA
        CMP     #$30
@L0D4C  BNE     @L0D4C
        PLP
        LDA     #$FF
        PHA
        LDA     #$E8
        PLP
        !BYTE   $C2
        NOP
        NOP
        PHP
        CMP     #$E8
@L0D5B  BNE     @L0D5B
        PLA
        PHA
        CMP     #$FF
@L0D61  BNE     @L0D61
        PLP
        CPY     #$42
@L0D66  BNE     @L0D66
        CPX     #$00
@L0D6A  BNE     @L0D6A
        LDY     #$42
        LDX     #$02
        !BYTE   $E2
        INY
        DEX
        DEX
@L0D74  BNE     @L0D74
        LDA     #$00
        PHA
        LDA     #$1D
        PLP
        !BYTE   $E2
        NOP
        NOP
        PHP
        CMP     #$1D
@L0D82  BNE     @L0D82
        PLA
        PHA
        CMP     #$30
@L0D88  BNE     @L0D88
        PLP
        LDA     #$FF
        PHA
        LDA     #$C8
        PLP
        !BYTE   $E2
        NOP
        NOP
        PHP
        CMP     #$C8
@L0D97  BNE     @L0D97
        PLA
        PHA
        CMP     #$FF
@L0D9D  BNE     @L0D9D
        PLP
        CPY     #$42
@L0DA2  BNE     @L0DA2
        CPX     #$00
@L0DA6  BNE     @L0DA6
        LDY     #$42
        LDX     #$02
        !BYTE   $44
        INY
        DEX
        DEX
@L0DB0  BNE     @L0DB0
        LDA     #$00
        PHA
        LDA     #$BB
        PLP
        !BYTE   $44
        NOP
        NOP
        PHP
        CMP     #$BB
@L0DBE  BNE     @L0DBE
        PLA
        PHA
        CMP     #$30
@L0DC4  BNE     @L0DC4
        PLP
        LDA     #$FF
        PHA
        LDA     #$66
        PLP
        !BYTE   $44
        NOP
        NOP
        PHP
        CMP     #$66
@L0DD3  BNE     @L0DD3
        PLA
        PHA
        CMP     #$FF
@L0DD9  BNE     @L0DD9
        PLP
        CPY     #$42
@L0DDE  BNE     @L0DDE
        CPX     #$00
@L0DE2  BNE     @L0DE2
        LDY     #$42
        LDX     #$02
        !BYTE   $54
        INY
        DEX
        DEX
@L0DEC  BNE     @L0DEC
        LDA     #$00
        PHA
        LDA     #$AB
        PLP
        !BYTE   $54
        NOP
        NOP
        PHP
        CMP     #$AB
@L0DFA  BNE     @L0DFA
        PLA
        PHA
        CMP     #$30
@L0E00  BNE     @L0E00
        PLP
        LDA     #$FF
        PHA
        LDA     #$56
        PLP
        !BYTE   $54
        NOP
        NOP
        PHP
        CMP     #$56
@L0E0F  BNE     @L0E0F
        PLA
        PHA
        CMP     #$FF
@L0E15  BNE     @L0E15
        PLP
        CPY     #$42
@L0E1A  BNE     @L0E1A
        CPX     #$00
@L0E1E  BNE     @L0E1E
        LDY     #$42
        LDX     #$02
        !BYTE   $D4
        INY
        DEX
        DEX
@L0E28  BNE     @L0E28
        LDA     #$00
        PHA
        LDA     #$2B
        PLP
        !BYTE   $D4
        NOP
        NOP
        PHP
        CMP     #$2B
@L0E36  BNE     @L0E36
        PLA
        PHA
        CMP     #$30
@L0E3C  BNE     @L0E3C
        PLP
        LDA     #$FF
        PHA
        LDA     #$D6
        PLP
        !BYTE   $D4
        NOP
        NOP
        PHP
        CMP     #$D6
@L0E4B  BNE     @L0E4B
        PLA
        PHA
        CMP     #$FF
@L0E51  BNE     @L0E51
        PLP
        CPY     #$42
@L0E56  BNE     @L0E56
        CPX     #$00
@L0E5A  BNE     @L0E5A
        LDY     #$42
        LDX     #$02
        !BYTE   $F4
        INY
        DEX
        DEX
@L0E64  BNE     @L0E64
        LDA     #$00
        PHA
        LDA     #$0B
        PLP
        !BYTE   $F4
        NOP
        NOP
        PHP
        CMP     #$0B
@L0E72  BNE     @L0E72
        PLA
        PHA
        CMP     #$30
@L0E78  BNE     @L0E78
        PLP
        LDA     #$FF
        PHA
        LDA     #$B6
        PLP
        !BYTE   $F4
        NOP
        NOP
        PHP
        CMP     #$B6
@L0E87  BNE     @L0E87
        PLA
        PHA
        CMP     #$FF
@L0E8D  BNE     @L0E8D
        PLP
        CPY     #$42
@L0E92  BNE     @L0E92
        CPX     #$00
@L0E96  BNE     @L0E96
        LDY     #$42
        LDX     #$01
        !BYTE   $5C
        INY
        INY
        DEX
@L0EA0  BNE     @L0EA0
        LDA     #$00
        PHA
        LDA     #$A3
        PLP
        !BYTE   $5C
        NOP
        NOP
        PHP
        CMP     #$A3
@L0EAE  BNE     @L0EAE
        PLA
        PHA
        CMP     #$30
@L0EB4  BNE     @L0EB4
        PLP
        LDA     #$FF
        PHA
        LDA     #$4E
        PLP
        !BYTE   $5C
        NOP
        NOP
        PHP
        CMP     #$4E
@L0EC3  BNE     @L0EC3
        PLA
        PHA
        CMP     #$FF
@L0EC9  BNE     @L0EC9
        PLP
        CPY     #$42
@L0ECE  BNE     @L0ECE
        CPX     #$00
@L0ED2  BNE     @L0ED2
        LDY     #$42
        LDX     #$01
        !BYTE   $DC
        INY
        INY
        DEX
@L0EDC  BNE     @L0EDC
        LDA     #$00
        PHA
        LDA     #$23
        PLP
        !BYTE   $DC
        NOP
        NOP
        PHP
        CMP     #$23
@L0EEA  BNE     @L0EEA
        PLA
        PHA
        CMP     #$30
@L0EF0  BNE     @L0EF0
        PLP
        LDA     #$FF
        PHA
        LDA     #$CE
        PLP
        !BYTE   $DC
        NOP
        NOP
        PHP
        CMP     #$CE
@L0EFF  BNE     @L0EFF
        PLA
        PHA
        CMP     #$FF
@L0F05  BNE     @L0F05
        PLP
        CPY     #$42
@L0F0A  BNE     @L0F0A
        CPX     #$00
@L0F0E  BNE     @L0F0E
        LDY     #$42
        LDX     #$01
        !BYTE   $FC
        INY
        INY
        DEX
@L0F18  BNE     @L0F18
        LDA     #$00
        PHA
        LDA     #$03
        PLP
        !BYTE   $FC
        NOP
        NOP
        PHP
        CMP     #$03
@L0F26  BNE     @L0F26
        PLA
        PHA
        CMP     #$30
@L0F2C  BNE     @L0F2C
        PLP
        LDA     #$FF
        PHA
        LDA     #$AE
        PLP
        !BYTE   $FC
        NOP
        NOP
        PHP
        CMP     #$AE
@L0F3B  BNE     @L0F3B
        PLA
        PHA
        CMP     #$FF
@L0F41  BNE     @L0F41
        PLP
        CPY     #$42
@L0F46  BNE     @L0F46
        CPX     #$00
@L0F4A  BNE     @L0F4A
        LDY     #$42
        LDX     #$03
        !BYTE   $03
        DEX
        DEX
        DEX
@L0F54  BNE     @L0F54
        LDA     #$00
        PHA
        LDA     #$FC
        PLP
        !BYTE   $03
        NOP
        NOP
        PHP
        CMP     #$FC
@L0F62  BNE     @L0F62
        PLA
        PHA
        CMP     #$30
@L0F68  BNE     @L0F68
        PLP
        LDA     #$FF
        PHA
        LDA     #$A7
        PLP
        !BYTE   $03
        NOP
        NOP
        PHP
        CMP     #$A7
@L0F77  BNE     @L0F77
        PLA
        PHA
        CMP     #$FF
@L0F7D  BNE     @L0F7D
        PLP
        CPY     #$42
@L0F82  BNE     @L0F82
        CPX     #$00
@L0F86  BNE     @L0F86
        LDY     #$42
        LDX     #$03
        !BYTE   $13
        DEX
        DEX
        DEX
@L0F90  BNE     @L0F90
        LDA     #$00
        PHA
        LDA     #$EC
        PLP
        !BYTE   $13
        NOP
        NOP
        PHP
        CMP     #$EC
@L0F9E  BNE     @L0F9E
        PLA
        PHA
        CMP     #$30
@L0FA4  BNE     @L0FA4
        PLP
        LDA     #$FF
        PHA
        LDA     #$97
        PLP
        !BYTE   $13
        NOP
        NOP
        PHP
        CMP     #$97
@L0FB3  BNE     @L0FB3
        PLA
        PHA
        CMP     #$FF
@L0FB9  BNE     @L0FB9
        PLP
        CPY     #$42
@L0FBE  BNE     @L0FBE
        CPX     #$00
@L0FC2  BNE     @L0FC2
        LDY     #$42
        LDX     #$03
        !BYTE   $23
        DEX
        DEX
        DEX
@L0FCC  BNE     @L0FCC
        LDA     #$00
        PHA
        LDA     #$DC
        PLP
        !BYTE   $23
        NOP
        NOP
        PHP
        CMP     #$DC
@L0FDA  BNE     @L0FDA
        PLA
        PHA
        CMP     #$30
@L0FE0  BNE     @L0FE0
        PLP
        LDA     #$FF
        PHA
        LDA     #$87
        PLP
        !BYTE   $23
        NOP
        NOP
        PHP
        CMP     #$87
@L0FEF  BNE     @L0FEF
        PLA
        PHA
        CMP     #$FF
@L0FF5  BNE     @L0FF5
        PLP
        CPY     #$42
@L0FFA  BNE     @L0FFA
        CPX     #$00
@L0FFE  BNE     @L0FFE
        LDY     #$42
        LDX     #$03
        !BYTE   $33
        DEX
        DEX
        DEX
@L1008  BNE     @L1008
        LDA     #$00
        PHA
        LDA     #$CC
        PLP
        !BYTE   $33
        NOP
        NOP
        PHP
        CMP     #$CC
@L1016  BNE     @L1016
        PLA
        PHA
        CMP     #$30
@L101C  BNE     @L101C
        PLP
        LDA     #$FF
        PHA
        LDA     #$77
        PLP
        !BYTE   $33
        NOP
        NOP
        PHP
        CMP     #$77
@L102B  BNE     @L102B
        PLA
        PHA
        CMP     #$FF
@L1031  BNE     @L1031
        PLP
        CPY     #$42
@L1036  BNE     @L1036
        CPX     #$00
@L103A  BNE     @L103A
        LDY     #$42
        LDX     #$03
        !BYTE   $43
        DEX
        DEX
        DEX
@L1044  BNE     @L1044
        LDA     #$00
        PHA
        LDA     #$BC
        PLP
        !BYTE   $43
        NOP
        NOP
        PHP
        CMP     #$BC
@L1052  BNE     @L1052
        PLA
        PHA
        CMP     #$30
@L1058  BNE     @L1058
        PLP
        LDA     #$FF
        PHA
        LDA     #$67
        PLP
        !BYTE   $43
        NOP
        NOP
        PHP
        CMP     #$67
@L1067  BNE     @L1067
        PLA
        PHA
        CMP     #$FF
@L106D  BNE     @L106D
        PLP
        CPY     #$42
@L1072  BNE     @L1072
        CPX     #$00
@L1076  BNE     @L1076
        LDY     #$42
        LDX     #$03
        !BYTE   $53
        DEX
        DEX
        DEX
@L1080  BNE     @L1080
        LDA     #$00
        PHA
        LDA     #$AC
        PLP
        !BYTE   $53
        NOP
        NOP
        PHP
        CMP     #$AC
@L108E  BNE     @L108E
        PLA
        PHA
        CMP     #$30
@L1094  BNE     @L1094
        PLP
        LDA     #$FF
        PHA
        LDA     #$57
        PLP
        !BYTE   $53
        NOP
        NOP
        PHP
        CMP     #$57
@L10A3  BNE     @L10A3
        PLA
        PHA
        CMP     #$FF
@L10A9  BNE     @L10A9
        PLP
        CPY     #$42
@L10AE  BNE     @L10AE
        CPX     #$00
@L10B2  BNE     @L10B2
        LDY     #$42
        LDX     #$03
        !BYTE   $63
        DEX
        DEX
        DEX
@L10BC  BNE     @L10BC
        LDA     #$00
        PHA
        LDA     #$9C
        PLP
        !BYTE   $63
        NOP
        NOP
        PHP
        CMP     #$9C
@L10CA  BNE     @L10CA
        PLA
        PHA
        CMP     #$30
@L10D0  BNE     @L10D0
        PLP
        LDA     #$FF
        PHA
        LDA     #$47
        PLP
        !BYTE   $63
        NOP
        NOP
        PHP
        CMP     #$47
@L10DF  BNE     @L10DF
        PLA
        PHA
        CMP     #$FF
@L10E5  BNE     @L10E5
        PLP
        CPY     #$42
@L10EA  BNE     @L10EA
        CPX     #$00
@L10EE  BNE     @L10EE
        LDY     #$42
        LDX     #$03
        !BYTE   $73
        DEX
        DEX
        DEX
@L10F8  BNE     @L10F8
        LDA     #$00
        PHA
        LDA     #$8C
        PLP
        !BYTE   $73
        NOP
        NOP
        PHP
        CMP     #$8C
@L1106  BNE     @L1106
        PLA
        PHA
        CMP     #$30
@L110C  BNE     @L110C
        PLP
        LDA     #$FF
        PHA
        LDA     #$37
        PLP
        !BYTE   $73
        NOP
        NOP
        PHP
        CMP     #$37
@L111B  BNE     @L111B
        PLA
        PHA
        CMP     #$FF
@L1121  BNE     @L1121
        PLP
        CPY     #$42
@L1126  BNE     @L1126
        CPX     #$00
@L112A  BNE     @L112A
        LDY     #$42
        LDX     #$03
        !BYTE   $83
        DEX
        DEX
        DEX
@L1134  BNE     @L1134
        LDA     #$00
        PHA
        LDA     #$7C
        PLP
        !BYTE   $83
        NOP
        NOP
        PHP
        CMP     #$7C
@L1142  BNE     @L1142
        PLA
        PHA
        CMP     #$30
@L1148  BNE     @L1148
        PLP
        LDA     #$FF
        PHA
        LDA     #$27
        PLP
        !BYTE   $83
        NOP
        NOP
        PHP
        CMP     #$27
@L1157  BNE     @L1157
        PLA
        PHA
        CMP     #$FF
@L115D  BNE     @L115D
        PLP
        CPY     #$42
@L1162  BNE     @L1162
        CPX     #$00
@L1166  BNE     @L1166
        LDY     #$42
        LDX     #$03
        !BYTE   $93
        DEX
        DEX
        DEX
@L1170  BNE     @L1170
        LDA     #$00
        PHA
        LDA     #$6C
        PLP
        !BYTE   $93
        NOP
        NOP
        PHP
        CMP     #$6C
@L117E  BNE     @L117E
        PLA
        PHA
        CMP     #$30
@L1184  BNE     @L1184
        PLP
        LDA     #$FF
        PHA
        LDA     #$17
        PLP
        !BYTE   $93
        NOP
        NOP
        PHP
        CMP     #$17
@L1193  BNE     @L1193
        PLA
        PHA
        CMP     #$FF
@L1199  BNE     @L1199
        PLP
        CPY     #$42
@L119E  BNE     @L119E
        CPX     #$00
@L11A2  BNE     @L11A2
        LDY     #$42
        LDX     #$03
        !BYTE   $A3
        DEX
        DEX
        DEX
@L11AC  BNE     @L11AC
        LDA     #$00
        PHA
        LDA     #$5C
        PLP
        !BYTE   $A3
        NOP
        NOP
        PHP
        CMP     #$5C
@L11BA  BNE     @L11BA
        PLA
        PHA
        CMP     #$30
@L11C0  BNE     @L11C0
        PLP
        LDA     #$FF
        PHA
        LDA     #$07
        PLP
        !BYTE   $A3
        NOP
        NOP
        PHP
        CMP     #$07
@L11CF  BNE     @L11CF
        PLA
        PHA
        CMP     #$FF
@L11D5  BNE     @L11D5
        PLP
        CPY     #$42
@L11DA  BNE     @L11DA
        CPX     #$00
@L11DE  BNE     @L11DE
        LDY     #$42
        LDX     #$03
        !BYTE   $B3
        DEX
        DEX
        DEX
@L11E8  BNE     @L11E8
        LDA     #$00
        PHA
        LDA     #$4C
        PLP
        !BYTE   $B3
        NOP
        NOP
        PHP
        CMP     #$4C
@L11F6  BNE     @L11F6
        PLA
        PHA
        CMP     #$30
@L11FC  BNE     @L11FC
        PLP
        LDA     #$FF
        PHA
        LDA     #$F7
        PLP
        !BYTE   $B3
        NOP
        NOP
        PHP
        CMP     #$F7
@L120B  BNE     @L120B
        PLA
        PHA
        CMP     #$FF
@L1211  BNE     @L1211
        PLP
        CPY     #$42
@L1216  BNE     @L1216
        CPX     #$00
@L121A  BNE     @L121A
        LDY     #$42
        LDX     #$03
        !BYTE   $C3
        DEX
        DEX
        DEX
@L1224  BNE     @L1224
        LDA     #$00
        PHA
        LDA     #$3C
        PLP
        !BYTE   $C3
        NOP
        NOP
        PHP
        CMP     #$3C
@L1232  BNE     @L1232
        PLA
        PHA
        CMP     #$30
@L1238  BNE     @L1238
        PLP
        LDA     #$FF
        PHA
        LDA     #$E7
        PLP
        !BYTE   $C3
        NOP
        NOP
        PHP
        CMP     #$E7
@L1247  BNE     @L1247
        PLA
        PHA
        CMP     #$FF
@L124D  BNE     @L124D
        PLP
        CPY     #$42
@L1252  BNE     @L1252
        CPX     #$00
@L1256  BNE     @L1256
        LDY     #$42
        LDX     #$03
        !BYTE   $D3
        DEX
        DEX
        DEX
@L1260  BNE     @L1260
        LDA     #$00
        PHA
        LDA     #$2C
        PLP
        !BYTE   $D3
        NOP
        NOP
        PHP
        CMP     #$2C
@L126E  BNE     @L126E
        PLA
        PHA
        CMP     #$30
@L1274  BNE     @L1274
        PLP
        LDA     #$FF
        PHA
        LDA     #$D7
        PLP
        !BYTE   $D3
        NOP
        NOP
        PHP
        CMP     #$D7
@L1283  BNE     @L1283
        PLA
        PHA
        CMP     #$FF
@L1289  BNE     @L1289
        PLP
        CPY     #$42
@L128E  BNE     @L128E
        CPX     #$00
@L1292  BNE     @L1292
        LDY     #$42
        LDX     #$03
        !BYTE   $E3
        DEX
        DEX
        DEX
@L129C  BNE     @L129C
        LDA     #$00
        PHA
        LDA     #$1C
        PLP
        !BYTE   $E3
        NOP
        NOP
        PHP
        CMP     #$1C
@L12AA  BNE     @L12AA
        PLA
        PHA
        CMP     #$30
@L12B0  BNE     @L12B0
        PLP
        LDA     #$FF
        PHA
        LDA     #$C7
        PLP
        !BYTE   $E3
        NOP
        NOP
        PHP
        CMP     #$C7
@L12BF  BNE     @L12BF
        PLA
        PHA
        CMP     #$FF
@L12C5  BNE     @L12C5
        PLP
        CPY     #$42
@L12CA  BNE     @L12CA
        CPX     #$00
@L12CE  BNE     @L12CE
        LDY     #$42
        LDX     #$03
        !BYTE   $F3
        DEX
        DEX
        DEX
@L12D8  BNE     @L12D8
        LDA     #$00
        PHA
        LDA     #$0C
        PLP
        !BYTE   $F3
        NOP
        NOP
        PHP
        CMP     #$0C
@L12E6  BNE     @L12E6
        PLA
        PHA
        CMP     #$30
@L12EC  BNE     @L12EC
        PLP
        LDA     #$FF
        PHA
        LDA     #$B7
        PLP
        !BYTE   $F3
        NOP
        NOP
        PHP
        CMP     #$B7
@L12FB  BNE     @L12FB
        PLA
        PHA
        CMP     #$FF
@L1301  BNE     @L1301
        PLP
        CPY     #$42
@L1306  BNE     @L1306
        CPX     #$00
@L130A  BNE     @L130A
        LDY     #$42
        LDX     #$03
        !BYTE   $0B
        DEX
        DEX
        DEX
@L1314  BNE     @L1314
        LDA     #$00
        PHA
        LDA     #$F4
        PLP
        !BYTE   $0B
        NOP
        NOP
        PHP
        CMP     #$F4
@L1322  BNE     @L1322
        PLA
        PHA
        CMP     #$30
@L1328  BNE     @L1328
        PLP
        LDA     #$FF
        PHA
        LDA     #$9F
        PLP
        !BYTE   $0B
        NOP
        NOP
        PHP
        CMP     #$9F
@L1337  BNE     @L1337
        PLA
        PHA
        CMP     #$FF
@L133D  BNE     @L133D
        PLP
        CPY     #$42
@L1342  BNE     @L1342
        CPX     #$00
@L1346  BNE     @L1346
        LDY     #$42
        LDX     #$03
        !BYTE   $1B
        DEX
        DEX
        DEX
@L1350  BNE     @L1350
        LDA     #$00
        PHA
        LDA     #$E4
        PLP
        !BYTE   $1B
        NOP
        NOP
        PHP
        CMP     #$E4
@L135E  BNE     @L135E
        PLA
        PHA
        CMP     #$30
@L1364  BNE     @L1364
        PLP
        LDA     #$FF
        PHA
        LDA     #$8F
        PLP
        !BYTE   $1B
        NOP
        NOP
        PHP
        CMP     #$8F
@L1373  BNE     @L1373
        PLA
        PHA
        CMP     #$FF
@L1379  BNE     @L1379
        PLP
        CPY     #$42
@L137E  BNE     @L137E
        CPX     #$00
@L1382  BNE     @L1382
        LDY     #$42
        LDX     #$03
        !BYTE   $2B
        DEX
        DEX
        DEX
@L138C  BNE     @L138C
        LDA     #$00
        PHA
        LDA     #$D4
        PLP
        !BYTE   $2B
        NOP
        NOP
        PHP
        CMP     #$D4
@L139A  BNE     @L139A
        PLA
        PHA
        CMP     #$30
@L13A0  BNE     @L13A0
        PLP
        LDA     #$FF
        PHA
        LDA     #$7F
        PLP
        !BYTE   $2B
        NOP
        NOP
        PHP
        CMP     #$7F
@L13AF  BNE     @L13AF
        PLA
        PHA
        CMP     #$FF
@L13B5  BNE     @L13B5
        PLP
        CPY     #$42
@L13BA  BNE     @L13BA
        CPX     #$00
@L13BE  BNE     @L13BE
        LDY     #$42
        LDX     #$03
        !BYTE   $3B
        DEX
        DEX
        DEX
@L13C8  BNE     @L13C8
        LDA     #$00
        PHA
        LDA     #$C4
        PLP
        !BYTE   $3B
        NOP
        NOP
        PHP
        CMP     #$C4
@L13D6  BNE     @L13D6
        PLA
        PHA
        CMP     #$30
@L13DC  BNE     @L13DC
        PLP
        LDA     #$FF
        PHA
        LDA     #$6F
        PLP
        !BYTE   $3B
        NOP
        NOP
        PHP
        CMP     #$6F
@L13EB  BNE     @L13EB
        PLA
        PHA
        CMP     #$FF
@L13F1  BNE     @L13F1
        PLP
        CPY     #$42
@L13F6  BNE     @L13F6
        CPX     #$00
@L13FA  BNE     @L13FA
        LDY     #$42
        LDX     #$03
        !BYTE   $4B
        DEX
        DEX
        DEX
@L1404  BNE     @L1404
        LDA     #$00
        PHA
        LDA     #$B4
        PLP
        !BYTE   $4B
        NOP
        NOP
        PHP
        CMP     #$B4
@L1412  BNE     @L1412
        PLA
        PHA
        CMP     #$30
@L1418  BNE     @L1418
        PLP
        LDA     #$FF
        PHA
        LDA     #$5F
        PLP
        !BYTE   $4B
        NOP
        NOP
        PHP
        CMP     #$5F
@L1427  BNE     @L1427
        PLA
        PHA
        CMP     #$FF
@L142D  BNE     @L142D
        PLP
        CPY     #$42
@L1432  BNE     @L1432
        CPX     #$00
@L1436  BNE     @L1436
        LDY     #$42
        LDX     #$03
        !BYTE   $5B
        DEX
        DEX
        DEX
@L1440  BNE     @L1440
        LDA     #$00
        PHA
        LDA     #$A4
        PLP
        !BYTE   $5B
        NOP
        NOP
        PHP
        CMP     #$A4
@L144E  BNE     @L144E
        PLA
        PHA
        CMP     #$30
@L1454  BNE     @L1454
        PLP
        LDA     #$FF
        PHA
        LDA     #$4F
        PLP
        !BYTE   $5B
        NOP
        NOP
        PHP
        CMP     #$4F
@L1463  BNE     @L1463
        PLA
        PHA
        CMP     #$FF
@L1469  BNE     @L1469
        PLP
        CPY     #$42
@L146E  BNE     @L146E
        CPX     #$00
@L1472  BNE     @L1472
        LDY     #$42
        LDX     #$03
        !BYTE   $6B
        DEX
        DEX
        DEX
@L147C  BNE     @L147C
        LDA     #$00
        PHA
        LDA     #$94
        PLP
        !BYTE   $6B
        NOP
        NOP
        PHP
        CMP     #$94
@L148A  BNE     @L148A
        PLA
        PHA
        CMP     #$30
@L1490  BNE     @L1490
        PLP
        LDA     #$FF
        PHA
        LDA     #$3F
        PLP
        !BYTE   $6B
        NOP
        NOP
        PHP
        CMP     #$3F
@L149F  BNE     @L149F
        PLA
        PHA
        CMP     #$FF
@L14A5  BNE     @L14A5
        PLP
        CPY     #$42
@L14AA  BNE     @L14AA
        CPX     #$00
@L14AE  BNE     @L14AE
        LDY     #$42
        LDX     #$03
        !BYTE   $7B
        DEX
        DEX
        DEX
@L14B8  BNE     @L14B8
        LDA     #$00
        PHA
        LDA     #$84
        PLP
        !BYTE   $7B
        NOP
        NOP
        PHP
        CMP     #$84
@L14C6  BNE     @L14C6
        PLA
        PHA
        CMP     #$30
@L14CC  BNE     @L14CC
        PLP
        LDA     #$FF
        PHA
        LDA     #$2F
        PLP
        !BYTE   $7B
        NOP
        NOP
        PHP
        CMP     #$2F
@L14DB  BNE     @L14DB
        PLA
        PHA
        CMP     #$FF
@L14E1  BNE     @L14E1
        PLP
        CPY     #$42
@L14E6  BNE     @L14E6
        CPX     #$00
@L14EA  BNE     @L14EA
        LDY     #$42
        LDX     #$03
        !BYTE   $8B
        DEX
        DEX
        DEX
@L14F4  BNE     @L14F4
        LDA     #$00
        PHA
        LDA     #$74
        PLP
        !BYTE   $8B
        NOP
        NOP
        PHP
        CMP     #$74
@L1502  BNE     @L1502
        PLA
        PHA
        CMP     #$30
@L1508  BNE     @L1508
        PLP
        LDA     #$FF
        PHA
        LDA     #$1F
        PLP
        !BYTE   $8B
        NOP
        NOP
        PHP
        CMP     #$1F
@L1517  BNE     @L1517
        PLA
        PHA
        CMP     #$FF
@L151D  BNE     @L151D
        PLP
        CPY     #$42
@L1522  BNE     @L1522
        CPX     #$00
@L1526  BNE     @L1526
        LDY     #$42
        LDX     #$03
        !BYTE   $9B
        DEX
        DEX
        DEX
@L1530  BNE     @L1530
        LDA     #$00
        PHA
        LDA     #$64
        PLP
        !BYTE   $9B
        NOP
        NOP
        PHP
        CMP     #$64
@L153E  BNE     @L153E
        PLA
        PHA
        CMP     #$30
@L1544  BNE     @L1544
        PLP
        LDA     #$FF
        PHA
        LDA     #$0F
        PLP
        !BYTE   $9B
        NOP
        NOP
        PHP
        CMP     #$0F
@L1553  BNE     @L1553
        PLA
        PHA
        CMP     #$FF
@L1559  BNE     @L1559
        PLP
        CPY     #$42
@L155E  BNE     @L155E
        CPX     #$00
@L1562  BNE     @L1562
        LDY     #$42
        LDX     #$03
        !BYTE   $AB
        DEX
        DEX
        DEX
@L156C  BNE     @L156C
        LDA     #$00
        PHA
        LDA     #$54
        PLP
        !BYTE   $AB
        NOP
        NOP
        PHP
        CMP     #$54
@L157A  BNE     @L157A
        PLA
        PHA
        CMP     #$30
@L1580  BNE     @L1580
        PLP
        LDA     #$FF
        PHA
        LDA     #$FF
        PLP
        !BYTE   $AB
        NOP
        NOP
        PHP
        CMP     #$FF
@L158F  BNE     @L158F
        PLA
        PHA
        CMP     #$FF
@L1595  BNE     @L1595
        PLP
        CPY     #$42
@L159A  BNE     @L159A
        CPX     #$00
@L159E  BNE     @L159E
        LDY     #$42
        LDX     #$03
        !BYTE   $BB
        DEX
        DEX
        DEX
@L15A8  BNE     @L15A8
        LDA     #$00
        PHA
        LDA     #$44
        PLP
        !BYTE   $BB
        NOP
        NOP
        PHP
        CMP     #$44
@L15B6  BNE     @L15B6
        PLA
        PHA
        CMP     #$30
@L15BC  BNE     @L15BC
        PLP
        LDA     #$FF
        PHA
        LDA     #$EF
        PLP
        !BYTE   $BB
        NOP
        NOP
        PHP
        CMP     #$EF
@L15CB  BNE     @L15CB
        PLA
        PHA
        CMP     #$FF
@L15D1  BNE     @L15D1
        PLP
        CPY     #$42
@L15D6  BNE     @L15D6
        CPX     #$00
@L15DA  BNE     @L15DA
        LDY     #$42
        LDX     #$03
        !BYTE   $EB
        DEX
        DEX
        DEX
@L15E4  BNE     @L15E4
        LDA     #$00
        PHA
        LDA     #$14
        PLP
        !BYTE   $EB
        NOP
        NOP
        PHP
        CMP     #$14
@L15F2  BNE     @L15F2
        PLA
        PHA
        CMP     #$30
@L15F8  BNE     @L15F8
        PLP
        LDA     #$FF
        PHA
        LDA     #$BF
        PLP
        !BYTE   $EB
        NOP
        NOP
        PHP
        CMP     #$BF
@L1607  BNE     @L1607
        PLA
        PHA
        CMP     #$FF
@L160D  BNE     @L160D
        PLP
        CPY     #$42
@L1612  BNE     @L1612
        CPX     #$00
@L1616  BNE     @L1616
        LDY     #$42
        LDX     #$03
        !BYTE   $FB
        DEX
        DEX
        DEX
@L1620  BNE     @L1620
        LDA     #$00
        PHA
        LDA     #$04
        PLP
        !BYTE   $FB
        NOP
        NOP
        PHP
        CMP     #$04
@L162E  BNE     @L162E
        PLA
        PHA
        CMP     #$30
@L1634  BNE     @L1634
        PLP
        LDA     #$FF
        PHA
        LDA     #$AF
        PLP
        !BYTE   $FB
        NOP
        NOP
        PHP
        CMP     #$AF
@L1643  BNE     @L1643
        PLA
        PHA
        CMP     #$FF
@L1649  BNE     @L1649
        PLP
        CPY     #$42
@L164E  BNE     @L164E
        CPX     #$00
@L1652  BNE     @L1652
        LDA     test_case
        CMP     #$08
@L1659  BNE     @L1659
        LDA     #$09
        STA     test_case
        LDX     #$03
@L1662  LDA     ji_adr,X
        STA     ji_tab,X
        DEX
        BPL     @L1662
        LDA     #$28
        STA     pg_x
        LDA     #$00
        PHA
        PLP
        LDA     #'I'
        LDX     #'N'
        LDY     #'D'       ;N=0, V=0, Z=0, C=0
        JMP     (ji_tab)

        NOP
@L167E  BNE     @L167E
        DEY
        DEY
ji_ret  PHP                ;either SP or Y count will fail, if we do not hit
        DEY
        DEY
        DEY
        PLP
@L1687  BEQ     @L1687
@L1689  BPL     @L1689
@L168B  BCC     @L168B
@L168D  BVC     @L168D
        CMP     #$E3
@L1691  BNE     @L1691
        CPX     #$4F
@L1695  BNE     @L1695
        CPY     #$3E
@L1699  BNE     @L1699
        TSX
        CPX     #$FF
@L169E  BNE     @L169E
        LDA     test_case
        CMP     #$09
@L16A5  BNE     @L16A5
        LDA     #$0A
        STA     test_case
        LDX     #$0B
@L16AE  LDA     jxi_adr,X
        STA     jxi_tab,X
        DEX
        BPL     @L16AE
        LDA     #$27
        STA     pg_x
        LDA     #$00
        PHA
        PLP
        LDA     #$58
        LDX     #$04
        LDY     #$49
        JMP     (jxi_tab,X)

        NOP
@L16CA  BNE     @L16CA
        DEY
        DEY
jxi_ret PHP
        DEY
        DEY
        DEY
        PLP
@L16D3  BEQ     @L16D3
@L16D5  BPL     @L16D5
@L16D7  BCC     @L16D7
@L16D9  BVC     @L16D9
        CMP     #$F2
@L16DD  BNE     @L16DD
        CPX     #$06
@L16E1  BNE     @L16E1
        CPY     #$43
@L16E5  BNE     @L16E5
        TSX
        CPX     #$FF
@L16EA  BNE     @L16EA
        LDA     #$08
        STA     ji_tab+3
        LDA     #$17
        STA     L0301
        LDA     #$05
        STA     pg_x
        LDA     #$17
        STA     pg_x+1
        LDX     #$FF
        JMP     (pg_x+1,X)

jxp_px  JMP     jxp_px

next_test
        LDA     test_case
        CMP     #$0A
@L170D  BNE     @L170D
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
brk_ret0
        PHP
        DEY
        DEY
        DEY
        CMP     #$E8
@L1726  BNE     @L1726
        CPX     #$53
@L172A  BNE     @L172A
        CPY     #$45
@L172E  BNE     @L172E
        PLA
        CMP     #$30
@L1733  BNE     @L1733
        TSX
        CPX     #$FF
@L1738  BNE     @L1738
        LDA     #$FF
        PHA
        LDA     #$BD
        LDX     #$AD
        LDY     #$B4
        PLP
        BRK

        DEY
brk_ret1
        PHP
        DEY
        DEY
        DEY
        CMP     #$17
@L174C  BNE     @L174C
        CPX     #$AE
@L1750  BNE     @L1750
        CPY     #$AE
@L1754  BNE     @L1754
        PLA
        CMP     #$FF
@L1759  BNE     @L1759
        TSX
        CPX     #$FF
@L175E  BNE     @L175E
        LDA     test_case
        CMP     #$0B
@L1765  BNE     @L1765
        LDA     #$0C
        STA     test_case
        LDX     #$AC
        LDY     #$DC
        LDA     #$FF
        PHA
        LDA     #$FE
        PLP
        INC
        PHA
        PHP
        CMP     #$FF
@L177B  BNE     @L177B
        PLA
        PHA
        CMP     #$FD
@L1781  BNE     @L1781
        PLP
        PLA
        INC
        PHA
        PHP
        CMP     #$00
@L178A  BNE     @L178A
        PLA
        PHA
        CMP     #$7F
@L1790  BNE     @L1790
        PLP
        PLA
        INC
        PHA
        PHP
        CMP     #$01
@L1799  BNE     @L1799
        PLA
        PHA
        CMP     #$7D
@L179F  BNE     @L179F
        PLP
        PLA
        DEC
        PHA
        PHP
        CMP     #$00
@L17A8  BNE     @L17A8
        PLA
        PHA
        CMP     #$7F
@L17AE  BNE     @L17AE
        PLP
        PLA
        DEC
        PHA
        PHP
        CMP     #$FF
@L17B7  BNE     @L17B7
        PLA
        PHA
        CMP     #$FD
@L17BD  BNE     @L17BD
        PLP
        PLA
        DEC
        LDA     #$00
        PHA
        LDA     #$FE
        PLP
        INC
        PHA
        PHP
        CMP     #$FF
@L17CD  BNE     @L17CD
        PLA
        PHA
        CMP     #$B0
@L17D3  BNE     @L17D3
        PLP
        PLA
        INC
        PHA
        PHP
        CMP     #$00
@L17DC  BNE     @L17DC
        PLA
        PHA
        CMP     #$32
@L17E2  BNE     @L17E2
        PLP
        PLA
        INC
        PHA
        PHP
        CMP     #$01
@L17EB  BNE     @L17EB
        PLA
        PHA
        CMP     #$30
@L17F1  BNE     @L17F1
        PLP
        PLA
        DEC
        PHA
        PHP
        CMP     #$00
@L17FA  BNE     @L17FA
        PLA
        PHA
        CMP     #$32
@L1800  BNE     @L1800
        PLP
        PLA
        DEC
        PHA
        PHP
        CMP     #$FF
@L1809  BNE     @L1809
        PLA
        PHA
        CMP     #$B0
@L180F  BNE     @L180F
        PLP
        PLA
        CPX     #$AC
@L1815  BNE     @L1815
        CPY     #$DC
@L1819  BNE     @L1819
        TSX
        CPX     #$FF
@L181E  BNE     @L181E
        LDA     test_case
        CMP     #$0C
@L1825  BNE     @L1825
        LDA     #$0D
        STA     test_case
        LDX     #$99
        LDY     #$66
        LDA     #$00
        PHA
        PLP
        LDA     (ind1)
        PHP
        EOR     #$C3
        PLP
        STA     (indt)
        PHP
        EOR     #$C3
        CMP     #$C3
@L1841  BNE     @L1841
        PLA
        EOR     #$30
        CMP     fLDx
@L1849  BNE     @L1849
        LDA     #$00
        PHA
        PLP
        LDA     (ind1+2)
        PHP
        EOR     #$C3
        PLP
        STA     (indt+2)
        PHP
        EOR     #$C3
        CMP     #$82
@L185C  BNE     @L185C
        PLA
        EOR     #$30
        CMP     fLDx+1
@L1864  BNE     @L1864
        LDA     #$00
        PHA
        PLP
        LDA     (ind1+4)
        PHP
        EOR     #$C3
        PLP
        STA     (indt+4)
        PHP
        EOR     #$C3
        CMP     #$41
@L1877  BNE     @L1877
        PLA
        EOR     #$30
        CMP     fLDx+2
@L187F  BNE     @L187F
        LDA     #$00
        PHA
        PLP
        LDA     (ind1+6)
        PHP
        EOR     #$C3
        PLP
        STA     (indt+6)
        PHP
        EOR     #$C3
        CMP     #$00
@L1892  BNE     @L1892
        PLA
        EOR     #$30
        CMP     fLDx+3
@L189A  BNE     @L189A
        CPX     #$99
@L189E  BNE     @L189E
        CPY     #$66
@L18A2  BNE     @L18A2
        LDY     #$03
        LDX     #$00
@L18A8  LDA     abst,Y
        EOR     #$C3
        CMP     abs1,Y
@L18B0  BNE     @L18B0
        TXA
        STA     abst,Y
        DEY
        BPL     @L18A8
        LDX     #$99
        LDY     #$66
        LDA     #$FF
        PHA
        PLP
        LDA     (ind1)
        PHP
        EOR     #$C3
        PLP
        STA     (indt)
        PHP
        EOR     #$C3
        CMP     #$C3
@L18CE  BNE     @L18CE
        PLA
        EOR     #$7D
        CMP     fLDx
@L18D6  BNE     @L18D6
        LDA     #$FF
        PHA
        PLP
        LDA     (ind1+2)
        PHP
        EOR     #$C3
        PLP
        STA     (indt+2)
        PHP
        EOR     #$C3
        CMP     #$82
@L18E9  BNE     @L18E9
        PLA
        EOR     #$7D
        CMP     fLDx+1
@L18F1  BNE     @L18F1
        LDA     #$FF
        PHA
        PLP
        LDA     (ind1+4)
        PHP
        EOR     #$C3
        PLP
        STA     (indt+4)
        PHP
        EOR     #$C3
        CMP     #$41
@L1904  BNE     @L1904
        PLA
        EOR     #$7D
        CMP     fLDx+2
@L190C  BNE     @L190C
        LDA     #$FF
        PHA
        PLP
        LDA     (ind1+6)
        PHP
        EOR     #$C3
        PLP
        STA     (indt+6)
        PHP
        EOR     #$C3
        CMP     #$00
@L191F  BNE     @L191F
        PLA
        EOR     #$7D
        CMP     fLDx+3
@L1927  BNE     @L1927
        CPX     #$99
@L192B  BNE     @L192B
        CPY     #$66
@L192F  BNE     @L192F
        LDY     #$03
        LDX     #$00
@L1935  LDA     abst,Y
        EOR     #$C3
        CMP     abs1,Y
@L193D  BNE     @L193D
        TXA
        STA     abst,Y
        DEY
        BPL     @L1935
        TSX
        CPX     #$FF
@L1949  BNE     @L1949
        LDA     test_case
        CMP     #$0D
@L1950  BNE     @L1950
        LDA     #$0E
        STA     test_case
        LDY     #$7B
        LDX     #$04
        LDA     #$07
@L195D  STA+1   zpt,X
        ASL
        DEX
        BPL     @L195D
        LDX     #$04
        LDA     #$FF
        PHA
        LDA     #$55
        PLP
        STZ+1   zpt
        STZ+1   ad1
        STZ+1   ad2
        STZ+1   adrl
        STZ+1   adrh
        PHP
        CMP     #$55
@L1978  BNE     @L1978
        PLA
        PHA
        CMP     #$FF
@L197E  BNE     @L197E
        PLP
@L1981  LDA+1   zpt,X
@L1983  BNE     @L1983
        DEX
        BPL     @L1981
        LDX     #$04
        LDA     #$07
@L198C  STA+1   zpt,X
        ASL
        DEX
        BPL     @L198C
        LDX     #$04
        LDA     #$00
        PHA
        LDA     #$AA
        PLP
        STZ+1   zpt
        STZ+1   ad1
        STZ+1   ad2
        STZ+1   adrl
        STZ+1   adrh
        PHP
        CMP     #$AA
@L19A7  BNE     @L19A7
        PLA
        PHA
        CMP     #$30
@L19AD  BNE     @L19AD
        PLP
@L19B0  LDA+1   zpt,X
@L19B2  BNE     @L19B2
        DEX
        BPL     @L19B0
        LDX     #$04
        LDA     #$07
@L19BB  STA     abst,X
        ASL
        DEX
        BPL     @L19BB
        LDX     #$04
        LDA     #$FF
        PHA
        LDA     #$55
        PLP
        STZ     abst
        STZ     ada2
        STZ     sba2
        STZ     sba2+1
        STZ     sba2+2
        PHP
        CMP     #$55
@L19DC  BNE     @L19DC
        PLA
        PHA
        CMP     #$FF
@L19E2  BNE     @L19E2
        PLP
@L19E5  LDA     abst,X
@L19E8  BNE     @L19E8
        DEX
        BPL     @L19E5
        LDX     #$04
        LDA     #$07
@L19F1  STA     abst,X
        ASL
        DEX
        BPL     @L19F1
        LDX     #$04
        LDA     #$00
        PHA
        LDA     #$AA
        PLP
        STZ     abst
        STZ     ada2
        STZ     sba2
        STZ     sba2+1
        STZ     sba2+2
        PHP
        CMP     #$AA
@L1A12  BNE     @L1A12
        PLA
        PHA
        CMP     #$30
@L1A18  BNE     @L1A18
        PLP
@L1A1B  LDA     abst,X
@L1A1E  BNE     @L1A1E
        DEX
        BPL     @L1A1B
        LDX     #$04
        LDA     #$07
@L1A27  STA+1   zpt,X
        ASL
        DEX
        BPL     @L1A27
        LDX     #$04
@L1A2F  LDA     #$FF
        PHA
        LDA     #$55
        PLP
        STZ+1   zpt,X
        PHP
        CMP     #$55
@L1A3A  BNE     @L1A3A
        PLA
        PHA
        CMP     #$FF
@L1A40  BNE     @L1A40
        PLP
        DEX
        BPL     @L1A2F
        LDX     #$04
@L1A48  LDA+1   zpt,X
@L1A4A  BNE     @L1A4A
        DEX
        BPL     @L1A48
        LDX     #$04
        LDA     #$07
tstz13  STA+1   zpt,X
        ASL
        DEX
        BPL     tstz13
        LDX     #$04
tstz16  LDA     #$00
        PHA
        LDA     #$AA
        PLP
        STZ+1   zpt,X
        PHP
        CMP     #$AA
@L1A66  BNE     @L1A66
        PLA
        PHA
        CMP     #$30
@L1A6C  BNE     @L1A6C
        PLP
        DEX
        BPL     tstz16
        LDX     #$04
tstz14  LDA+1   zpt,X
@L1A76  BNE     @L1A76
        DEX
        BPL     tstz14
        LDX     #$04
        LDA     #$07
@L1A7F  STA     abst,X
        ASL
        DEX
        BPL     @L1A7F
        LDX     #$04
@L1A88  LDA     #$FF
        PHA
        LDA     #$55
        PLP
        STZ     abst,X
        PHP
        CMP     #$55
@L1A94  BNE     @L1A94
        PLA
        PHA
        CMP     #$FF
@L1A9A  BNE     @L1A9A
        PLP
        DEX
        BPL     @L1A88
        LDX     #$04
@L1AA2  LDA     abst,X
@L1AA5  BNE     @L1AA5
        DEX
        BPL     @L1AA2
        LDX     #$04
        LDA     #$07
@L1AAE  STA     abst,X
        ASL
        DEX
        BPL     @L1AAE
        LDX     #$04
@L1AB7  LDA     #$00
        PHA
        LDA     #$AA
        PLP
        STZ     abst,X
        PHP
        CMP     #$AA
@L1AC3  BNE     @L1AC3
        PLA
        PHA
        CMP     #$30
@L1AC9  BNE     @L1AC9
        PLP
        DEX
        BPL     @L1AB7
        LDX     #$04
@L1AD1  LDA     abst,X
@L1AD4  BNE     @L1AD4
        DEX
        BPL     @L1AD1
        CPY     #$7B
@L1ADB  BNE     @L1ADB
        TSX
        CPX     #$FF
@L1AE0  BNE     @L1AE0
        LDA     test_case
        CMP     #$0E
@L1AE7  BNE     @L1AE7
        LDA     #$0F
        STA     test_case
        LDY     #$42
        LDX     #$03
        LDA     #$00
        PHA
        LDA     #$FF
        PLP
        BIT+1   sb2+1,X
        PHP
        CMP     #$FF
@L1AFD  BNE     @L1AFD
        PLA
        PHA
        CMP     #$32
@L1B03  BNE     @L1B03
        PLP
        DEX
        LDA     #$00
        PHA
        LDA     #$01
        PLP
        BIT+1   sb2+1,X
        PHP
        CMP     #$01
@L1B12  BNE     @L1B12
        PLA
        PHA
        CMP     #$70
@L1B18  BNE     @L1B18
        PLP
        DEX
        LDA     #$00
        PHA
        LDA     #$01
        PLP
        BIT+1   sb2+1,X
        PHP
        CMP     #$01
@L1B27  BNE     @L1B27
        PLA
        PHA
        CMP     #$B2
@L1B2D  BNE     @L1B2D
        PLP
        DEX
        LDA     #$00
        PHA
        LDA     #$01
        PLP
        BIT+1   sb2+1,X
        PHP
        CMP     #$01
@L1B3C  BNE     @L1B3C
        PLA
        PHA
        CMP     #$F0
@L1B42  BNE     @L1B42
        PLP
        LDA     #$FF
        PHA
        LDA     #$01
        PLP
        BIT+1   sb2+1,X
        PHP
        CMP     #$01
@L1B50  BNE     @L1B50
        PLA
        PHA
        CMP     #$FD
@L1B56  BNE     @L1B56
        PLP
        INX
        LDA     #$FF
        PHA
        LDA     #$01
        PLP
        BIT+1   sb2+1,X
        PHP
        CMP     #$01
@L1B65  BNE     @L1B65
        PLA
        PHA
        CMP     #$BF
@L1B6B  BNE     @L1B6B
        PLP
        INX
        LDA     #$FF
        PHA
        LDA     #$01
        PLP
        BIT+1   sb2+1,X
        PHP
        CMP     #$01
@L1B7A  BNE     @L1B7A
        PLA
        PHA
        CMP     #$7D
@L1B80  BNE     @L1B80
        PLP
        INX
        LDA     #$FF
        PHA
        LDA     #$FF
        PLP
        BIT+1   sb2+1,X
        PHP
        CMP     #$FF
@L1B8F  BNE     @L1B8F
        PLA
        PHA
        CMP     #$3F
@L1B95  BNE     @L1B95
        PLP
        LDA     #$00
        PHA
        LDA     #$FF
        PLP
        BIT     abs1,X
        PHP
        CMP     #$FF
@L1BA4  BNE     @L1BA4
        PLA
        PHA
        CMP     #$32
@L1BAA  BNE     @L1BAA
        PLP
        DEX
        LDA     #$00
        PHA
        LDA     #$01
        PLP
        BIT     abs1,X
        PHP
        CMP     #$01
@L1BBA  BNE     @L1BBA
        PLA
        PHA
        CMP     #$70
@L1BC0  BNE     @L1BC0
        PLP
        DEX
        LDA     #$00
        PHA
        LDA     #$01
        PLP
        BIT     abs1,X
        PHP
        CMP     #$01
@L1BD0  BNE     @L1BD0
        PLA
        PHA
        CMP     #$B2
@L1BD6  BNE     @L1BD6
        PLP
        DEX
        LDA     #$00
        PHA
        LDA     #$01
        PLP
        BIT     abs1,X
        PHP
        CMP     #$01
@L1BE6  BNE     @L1BE6
        PLA
        PHA
        CMP     #$F0
@L1BEC  BNE     @L1BEC
        PLP
        LDA     #$FF
        PHA
        LDA     #$01
        PLP
        BIT     abs1,X
        PHP
        CMP     #$01
@L1BFB  BNE     @L1BFB
        PLA
        PHA
        CMP     #$FD
@L1C01  BNE     @L1C01
        PLP
        INX
        LDA     #$FF
        PHA
        LDA     #$01
        PLP
        BIT     abs1,X
        PHP
        CMP     #$01
@L1C11  BNE     @L1C11
        PLA
        PHA
        CMP     #$BF
@L1C17  BNE     @L1C17
        PLP
        INX
        LDA     #$FF
        PHA
        LDA     #$01
        PLP
        BIT     abs1,X
        PHP
        CMP     #$01
@L1C27  BNE     @L1C27
        PLA
        PHA
        CMP     #$7D
@L1C2D  BNE     @L1C2D
        PLP
        INX
        LDA     #$FF
        PHA
        LDA     #$FF
        PLP
        BIT     abs1,X
        PHP
        CMP     #$FF
@L1C3D  BNE     @L1C3D
        PLA
        PHA
        CMP     #$3F
@L1C43  BNE     @L1C43
        PLP
        LDA     #$00
        PHA
        LDA     #$FF
        PLP
        BIT     #$00
        PHP
        CMP     #$FF
@L1C51  BNE     @L1C51
        PLA
        PHA
        CMP     #$32
@L1C57  BNE     @L1C57
        PLP
        DEX
        LDA     #$00
        PHA
        LDA     #$01
        PLP
        BIT     #$41
        PHP
        CMP     #$01
@L1C66  BNE     @L1C66
        PLA
        PHA
        CMP     #$30
@L1C6C  BNE     @L1C6C
        PLP
        DEX
        LDA     #$00
        PHA
        LDA     #$01
        PLP
        BIT     #$82
        PHP
        CMP     #$01
@L1C7B  BNE     @L1C7B
        PLA
        PHA
        CMP     #$32
@L1C81  BNE     @L1C81
        PLP
        DEX
        LDA     #$00
        PHA
        LDA     #$01
        PLP
        BIT     #$C3
        PHP
        CMP     #$01
@L1C90  BNE     @L1C90
        PLA
        PHA
        CMP     #$30
@L1C96  BNE     @L1C96
        PLP
        LDA     #$FF
        PHA
        LDA     #$01
        PLP
        BIT     #$C3
        PHP
        CMP     #$01
@L1CA4  BNE     @L1CA4
        PLA
        PHA
        CMP     #$FD
@L1CAA  BNE     @L1CAA
        PLP
        INX
        LDA     #$FF
        PHA
        LDA     #$01
        PLP
        BIT     #$82
        PHP
        CMP     #$01
@L1CB9  BNE     @L1CB9
        PLA
        PHA
        CMP     #$FF
@L1CBF  BNE     @L1CBF
        PLP
        INX
        LDA     #$FF
        PHA
        LDA     #$01
        PLP
        BIT     #$41
        PHP
        CMP     #$01
@L1CCE  BNE     @L1CCE
        PLA
        PHA
        CMP     #$FD
@L1CD4  BNE     @L1CD4
        PLP
        INX
        LDA     #$FF
        PHA
        LDA     #$FF
        PLP
        BIT     #$00
        PHP
        CMP     #$FF
@L1CE3  BNE     @L1CE3
        PLA
        PHA
        CMP     #$FF
@L1CE9  BNE     @L1CE9
        PLP
        CPX     #$03
@L1CEE  BNE     @L1CEE
        CPY     #$42
@L1CF2  BNE     @L1CF2
        TSX
        CPX     #$FF
@L1CF7  BNE     @L1CF7
        LDA     test_case
        CMP     #$0F
@L1CFE  BNE     @L1CFE
        LDA     #$10
        STA     test_case
        LDX     #$C0
        LDY     #$00
        STZ+1   ad1
@L1D0B  TYA
        AND+1   ad1
        PHP
        PLA
        AND     #$02
        STA+1   ad2
        TYA
        EOR     #$FF
        ORA+1   ad1
        EOR     #$FF
        STA+1   adrl
        TYA
        ORA+1   ad1
        STA+1   adrh
        STY+1   zpt
        LDA     #$FF
        PHA
        LDA+1   ad1
        PLP
        TRB+1   zpt
        PHP
        CMP+1   ad1
@L1D2F  BNE     @L1D2F
        PLA
        PHA
        ORA     #$02
        CMP     #$FF
@L1D37  BNE     @L1D37
        PLA
        AND     #$02
        CMP+1   ad2
@L1D3E  BNE     @L1D3E
        LDA+1   adrl
        CMP+1   zpt
@L1D44  BNE     @L1D44
        STY     abst
        LDA     #$FF
        PHA
        LDA+1   ad1
        PLP
        TRB     abst
        PHP
        CMP+1   ad1
@L1D55  BNE     @L1D55
        PLA
        PHA
        ORA     #$02
        CMP     #$FF
@L1D5D  BNE     @L1D5D
        PLA
        AND     #$02
        CMP+1   ad2
@L1D64  BNE     @L1D64
        LDA+1   adrl
        CMP+1   zpt
@L1D6A  BNE     @L1D6A
        STY+1   zpt
        LDA     #$00
        PHA
        LDA+1   ad1
        PLP
        TRB+1   zpt
        PHP
        CMP+1   ad1
@L1D79  BNE     @L1D79
        PLA
        PHA
        ORA     #$02
        CMP     #$32
@L1D81  BNE     @L1D81
        PLA
        AND     #$02
        CMP+1   ad2
@L1D88  BNE     @L1D88
        LDA+1   adrl
        CMP+1   zpt
@L1D8E  BNE     @L1D8E
        STY     abst
        LDA     #$00
        PHA
        LDA+1   ad1
        PLP
        TRB     abst
        PHP
        CMP+1   ad1
@L1D9F  BNE     @L1D9F
        PLA
        PHA
        ORA     #$02
        CMP     #$32
@L1DA7  BNE     @L1DA7
        PLA
        AND     #$02
        CMP+1   ad2
@L1DAE  BNE     @L1DAE
        LDA+1   adrl
        CMP+1   zpt
@L1DB4  BNE     @L1DB4
        STY+1   zpt
        LDA     #$FF
        PHA
        LDA+1   ad1
        PLP
        TSB+1   zpt
        PHP
        CMP+1   ad1
@L1DC3  BNE     @L1DC3
        PLA
        PHA
        ORA     #$02
        CMP     #$FF
@L1DCB  BNE     @L1DCB
        PLA
        AND     #$02
        CMP+1   ad2
@L1DD2  BNE     @L1DD2
        LDA+1   adrh
        CMP+1   zpt
@L1DD8  BNE     @L1DD8
        STY     abst
        LDA     #$FF
        PHA
        LDA+1   ad1
        PLP
        TSB     abst
        PHP
        CMP+1   ad1
@L1DE9  BNE     @L1DE9
        PLA
        PHA
        ORA     #$02
        CMP     #$FF
@L1DF1  BNE     @L1DF1
        PLA
        AND     #$02
        CMP+1   ad2
@L1DF8  BNE     @L1DF8
        LDA+1   adrh
        CMP+1   zpt
@L1DFE  BNE     @L1DFE
        STY+1   zpt
        LDA     #$00
        PHA
        LDA+1   ad1
        PLP
        TSB+1   zpt
        PHP
        CMP+1   ad1
@L1E0D  BNE     @L1E0D
        PLA
        PHA
        ORA     #$02
        CMP     #$32
@L1E15  BNE     @L1E15
        PLA
        AND     #$02
        CMP+1   ad2
@L1E1C  BNE     @L1E1C
        LDA+1   adrh
        CMP+1   zpt
@L1E22  BNE     @L1E22
        STY     abst
        LDA     #$00
        PHA
        LDA+1   ad1
        PLP
        TSB     abst
        PHP
        CMP+1   ad1
@L1E33  BNE     @L1E33
        PLA
        PHA
        ORA     #$02
        CMP     #$32
@L1E3B  BNE     @L1E3B
        PLA
        AND     #$02
        CMP+1   ad2
@L1E42  BNE     @L1E42
        LDA+1   adrh
        CMP+1   zpt
@L1E48  BNE     @L1E48
        INY
        BNE     @L1E51
        INC+1   ad1
        BEQ     @L1E54
@L1E51  JMP     @L1D0B

@L1E54  CPX     #$C0
@L1E56  BNE     @L1E56
        TSX
        CPX     #$FF
@L1E5B  BNE     @L1E5B
        LDA     test_case
        CMP     #$10
@L1E62  BNE     @L1E62
        LDA     #$11
        STA     test_case
        LDX     #$BA
        LDY     #$D0
        LDA     #$FF
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$A5
        PLP
        !BYTE   $07
        !BYTE   $0C

        PHP
        CMP     #$A5
@L1E7C  BNE     @L1E7C
        PLA
        PHA
        CMP     #$30
@L1E82  BNE     @L1E82
        PLP
        LDA+1   zpt
        CMP     #$FE
@L1E89  BNE     @L1E89
        LDA     #$01
        STA+1   zpt
        LDA     #$FF
        PHA
        LDA     #$5A
        PLP
        !BYTE   $07
        !BYTE   $0C

        PHP
        CMP     #$5A
@L1E9A  BNE     @L1E9A
        PLA
        PHA
        CMP     #$FF
@L1EA0  BNE     @L1EA0
        PLP
        LDA+1   zpt
@L1EA5  BNE     @L1EA5
        LDA     #$FF
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$A5
        PLP
        !BYTE   $17
        !BYTE   $0C

        PHP
        CMP     #$A5
@L1EB6  BNE     @L1EB6
        PLA
        PHA
        CMP     #$30
@L1EBC  BNE     @L1EBC
        PLP
        LDA+1   zpt
        CMP     #$FD
@L1EC3  BNE     @L1EC3
        LDA     #$02
        STA+1   zpt
        LDA     #$FF
        PHA
        LDA     #$5A
        PLP
        !BYTE   $17
        !BYTE   $0C

        PHP
        CMP     #$5A
@L1ED4  BNE     @L1ED4
        PLA
        PHA
        CMP     #$FF
@L1EDA  BNE     @L1EDA
        PLP
        LDA+1   zpt
@L1EDF  BNE     @L1EDF
        LDA     #$FF
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$A5
        PLP
        !BYTE   $27
        !BYTE   $0C

        PHP
        CMP     #$A5
@L1EF0  BNE     @L1EF0
        PLA
        PHA
        CMP     #$30
@L1EF6  BNE     @L1EF6
        PLP
        LDA+1   zpt
        CMP     #$FB
@L1EFD  BNE     @L1EFD
        LDA     #$04
        STA+1   zpt
        LDA     #$FF
        PHA
        LDA     #$5A
        PLP
        !BYTE   $27
        !BYTE   $0C

        PHP
        CMP     #$5A
@L1F0E  BNE     @L1F0E
        PLA
        PHA
        CMP     #$FF
@L1F14  BNE     @L1F14
        PLP
        LDA+1   zpt
@L1F19  BNE     @L1F19
        LDA     #$FF
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$A5
        PLP
        !BYTE   $37
        !BYTE   $0C

        PHP
        CMP     #$A5
@L1F2A  BNE     @L1F2A
        PLA
        PHA
        CMP     #$30
@L1F30  BNE     @L1F30
        PLP
        LDA+1   zpt
        CMP     #$F7
@L1F37  BNE     @L1F37
        LDA     #$08
        STA+1   zpt
        LDA     #$FF
        PHA
        LDA     #$5A
        PLP
        !BYTE   $37
        !BYTE   $0C

        PHP
        CMP     #$5A
@L1F48  BNE     @L1F48
        PLA
        PHA
        CMP     #$FF
@L1F4E  BNE     @L1F4E
        PLP
        LDA+1   zpt
@L1F53  BNE     @L1F53
        LDA     #$FF
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$A5
        PLP
        !BYTE   $47
        !BYTE   $0C

        PHP
        CMP     #$A5
@L1F64  BNE     @L1F64
        PLA
        PHA
        CMP     #$30
@L1F6A  BNE     @L1F6A
        PLP
        LDA+1   zpt
        CMP     #$EF
@L1F71  BNE     @L1F71
        LDA     #$10
        STA+1   zpt
        LDA     #$FF
        PHA
        LDA     #$5A
        PLP
        !BYTE   $47
        !BYTE   $0C

        PHP
        CMP     #$5A
@L1F82  BNE     @L1F82
        PLA
        PHA
        CMP     #$FF
@L1F88  BNE     @L1F88
        PLP
        LDA+1   zpt
@L1F8D  BNE     @L1F8D
        LDA     #$FF
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$A5
        PLP
        !BYTE   $57
        !BYTE   $0C

        PHP
        CMP     #$A5
@L1F9E  BNE     @L1F9E
        PLA
        PHA
        CMP     #$30
@L1FA4  BNE     @L1FA4
        PLP
        LDA+1   zpt
        CMP     #$DF
@L1FAB  BNE     @L1FAB
        LDA     #$20
        STA+1   zpt
        LDA     #$FF
        PHA
        LDA     #$5A
        PLP
        !BYTE   $57
        !BYTE   $0C

        PHP
        CMP     #$5A
@L1FBC  BNE     @L1FBC
        PLA
        PHA
        CMP     #$FF
@L1FC2  BNE     @L1FC2
        PLP
        LDA+1   zpt
@L1FC7  BNE     @L1FC7
        LDA     #$FF
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$A5
        PLP
        !BYTE   $67
        !BYTE   $0C

        PHP
        CMP     #$A5
@L1FD8  BNE     @L1FD8
        PLA
        PHA
        CMP     #$30
@L1FDE  BNE     @L1FDE
        PLP
        LDA+1   zpt
        CMP     #$BF
@L1FE5  BNE     @L1FE5
        LDA     #$40
        STA+1   zpt
        LDA     #$FF
        PHA
        LDA     #$5A
        PLP
        !BYTE   $67
        !BYTE   $0C

        PHP
        CMP     #$5A
@L1FF6  BNE     @L1FF6
        PLA
        PHA
        CMP     #$FF
@L1FFC  BNE     @L1FFC
        PLP
        LDA+1   zpt
@L2001  BNE     @L2001
        LDA     #$FF
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$A5
        PLP
        !BYTE   $77
        !BYTE   $0C

        PHP
        CMP     #$A5
@L2012  BNE     @L2012
        PLA
        PHA
        CMP     #$30
@L2018  BNE     @L2018
        PLP
        LDA+1   zpt
        CMP     #$7F
@L201F  BNE     @L201F
        LDA     #$80
        STA+1   zpt
        LDA     #$FF
        PHA
        LDA     #$5A
        PLP
        !BYTE   $77
        !BYTE   $0C

        PHP
        CMP     #$5A
@L2030  BNE     @L2030
        PLA
        PHA
        CMP     #$FF
@L2036  BNE     @L2036
        PLP
        LDA+1   zpt
@L203B  BNE     @L203B
        LDA     #$FE
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$A5
        PLP
        !BYTE   $87
        !BYTE   $0C

        PHP
        CMP     #$A5
@L204C  BNE     @L204C
        PLA
        PHA
        CMP     #$30
@L2052  BNE     @L2052
        PLP
        LDA+1   zpt
        CMP     #$FF
@L2059  BNE     @L2059
        LDA     #$00
        STA+1   zpt
        LDA     #$FF
        PHA
        LDA     #$5A
        PLP
        !BYTE   $87
        !BYTE   $0C

        PHP
        CMP     #$5A
@L206A  BNE     @L206A
        PLA
        PHA
        CMP     #$FF
@L2070  BNE     @L2070
        PLP
        LDA+1   zpt
        CMP     #$01
@L2077  BNE     @L2077
        LDA     #$FD
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$A5
        PLP
        !BYTE   $97
        !BYTE   $0C

        PHP
        CMP     #$A5
@L2088  BNE     @L2088
        PLA
        PHA
        CMP     #$30
@L208E  BNE     @L208E
        PLP
        LDA+1   zpt
        CMP     #$FF
@L2095  BNE     @L2095
        LDA     #$00
        STA+1   zpt
        LDA     #$FF
        PHA
        LDA     #$5A
        PLP
        !BYTE   $97
        !BYTE   $0C

        PHP
        CMP     #$5A
@L20A6  BNE     @L20A6
        PLA
        PHA
        CMP     #$FF
@L20AC  BNE     @L20AC
        PLP
        LDA+1   zpt
        CMP     #$02
@L20B3  BNE     @L20B3
        LDA     #$FB
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$A5
        PLP
        !BYTE   $A7
        !BYTE   $0C

        PHP
        CMP     #$A5
@L20C4  BNE     @L20C4
        PLA
        PHA
        CMP     #$30
@L20CA  BNE     @L20CA
        PLP
        LDA+1   zpt
        CMP     #$FF
@L20D1  BNE     @L20D1
        LDA     #$00
        STA+1   zpt
        LDA     #$FF
        PHA
        LDA     #$5A
        PLP
        !BYTE   $A7
        !BYTE   $0C

        PHP
        CMP     #$5A
@L20E2  BNE     @L20E2
        PLA
        PHA
        CMP     #$FF
@L20E8  BNE     @L20E8
        PLP
        LDA+1   zpt
        CMP     #$04
@L20EF  BNE     @L20EF
        LDA     #$F7
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$A5
        PLP
        !BYTE   $B7
        !BYTE   $0C

        PHP
        CMP     #$A5
@L2100  BNE     @L2100
        PLA
        PHA
        CMP     #$30
@L2106  BNE     @L2106
        PLP
        LDA+1   zpt
        CMP     #$FF
@L210D  BNE     @L210D
        LDA     #$00
        STA+1   zpt
        LDA     #$FF
        PHA
        LDA     #$5A
        PLP
        !BYTE   $B7
        !BYTE   $0C

        PHP
        CMP     #$5A
@L211E  BNE     @L211E
        PLA
        PHA
        CMP     #$FF
@L2124  BNE     @L2124
        PLP
        LDA+1   zpt
        CMP     #$08
@L212B  BNE     @L212B
        LDA     #$EF
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$A5
        PLP
        !BYTE   $C7
        !BYTE   $0C

        PHP
        CMP     #$A5
@L213C  BNE     @L213C
        PLA
        PHA
        CMP     #$30
@L2142  BNE     @L2142
        PLP
        LDA+1   zpt
        CMP     #$FF
@L2149  BNE     @L2149
        LDA     #$00
        STA+1   zpt
        LDA     #$FF
        PHA
        LDA     #$5A
        PLP
        !BYTE   $C7
        !BYTE   $0C

        PHP
        CMP     #$5A
@L215A  BNE     @L215A
        PLA
        PHA
        CMP     #$FF
@L2160  BNE     @L2160
        PLP
        LDA+1   zpt
        CMP     #$10
@L2167  BNE     @L2167
        LDA     #$DF
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$A5
        PLP
        !BYTE   $D7
        !BYTE   $0C

        PHP
        CMP     #$A5
@L2178  BNE     @L2178
        PLA
        PHA
        CMP     #$30
@L217E  BNE     @L217E
        PLP
        LDA+1   zpt
        CMP     #$FF
@L2185  BNE     @L2185
        LDA     #$00
        STA+1   zpt
        LDA     #$FF
        PHA
        LDA     #$5A
        PLP
        !BYTE   $D7
        !BYTE   $0C

        PHP
        CMP     #$5A
@L2196  BNE     @L2196
        PLA
        PHA
        CMP     #$FF
@L219C  BNE     @L219C
        PLP
        LDA+1   zpt
        CMP     #$20
@L21A3  BNE     @L21A3
        LDA     #$BF
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$A5
        PLP
        !BYTE   $E7
        !BYTE   $0C

        PHP
        CMP     #$A5
@L21B4  BNE     @L21B4
        PLA
        PHA
        CMP     #$30
@L21BA  BNE     @L21BA
        PLP
        LDA+1   zpt
        CMP     #$FF
@L21C1  BNE     @L21C1
        LDA     #$00
        STA+1   zpt
        LDA     #$FF
        PHA
        LDA     #$5A
        PLP
        !BYTE   $E7
        !BYTE   $0C

        PHP
        CMP     #$5A
@L21D2  BNE     @L21D2
        PLA
        PHA
        CMP     #$FF
@L21D8  BNE     @L21D8
        PLP
        LDA+1   zpt
        CMP     #$40
@L21DF  BNE     @L21DF
        LDA     #$7F
        STA+1   zpt
        LDA     #$00
        PHA
        LDA     #$A5
        PLP
        !BYTE   $F7
        !BYTE   $0C

        PHP
        CMP     #$A5
@L21F0  BNE     @L21F0
        PLA
        PHA
        CMP     #$30
@L21F6  BNE     @L21F6
        PLP
        LDA+1   zpt
        CMP     #$FF
@L21FD  BNE     @L21FD
        LDA     #$00
        STA+1   zpt
        LDA     #$FF
        PHA
        LDA     #$5A
        PLP
        !BYTE   $F7
        !BYTE   $0C

        PHP
        CMP     #$5A
@L220E  BNE     @L220E
        PLA
        PHA
        CMP     #$FF
@L2214  BNE     @L2214
        PLP
        LDA+1   zpt
        CMP     #$80
@L221B  BNE     @L221B
        CPX     #$BA
@L221F  BNE     @L221F
        CPY     #$D0
@L2223  BNE     @L2223
        TSX
        CPX     #$FF
@L2228  BNE     @L2228
        LDA     test_case
        CMP     #$11
@L222F  BNE     @L222F
        LDA     #$12
        STA     test_case
        LDX     #$DE
        LDY     #$AD
        LDA     #$00
        PHA
        LDA     #$80
        PLP
        CMP     (ind1+8)
        PHP
        CMP     #$80
@L2245  BNE     @L2245
        PLA
        PHA
        CMP     #$31
@L224B  BNE     @L224B
        PLP
        LDA     #$00
        PHA
        LDA     #$7F
        PLP
        CMP     (ind1+8)
        PHP
        CMP     #$7F
@L2259  BNE     @L2259
        PLA
        PHA
        CMP     #$33
@L225F  BNE     @L225F
        PLP
        LDA     #$00
        PHA
        LDA     #$7E
        PLP
        CMP     (ind1+8)
        PHP
        CMP     #$7E
@L226D  BNE     @L226D
        PLA
        PHA
        CMP     #$B0
@L2273  BNE     @L2273
        PLP
        LDA     #$FF
        PHA
        LDA     #$80
        PLP
        CMP     (ind1+8)
        PHP
        CMP     #$80
@L2281  BNE     @L2281
        PLA
        PHA
        CMP     #$7D
@L2287  BNE     @L2287
        PLP
        LDA     #$FF
        PHA
        LDA     #$7F
        PLP
        CMP     (ind1+8)
        PHP
        CMP     #$7F
@L2295  BNE     @L2295
        PLA
        PHA
        CMP     #$7F
@L229B  BNE     @L229B
        PLP
        LDA     #$FF
        PHA
        LDA     #$7E
        PLP
        CMP     (ind1+8)
        PHP
        CMP     #$7E
@L22A9  BNE     @L22A9
        PLA
        PHA
        CMP     #$FC
@L22AF  BNE     @L22AF
        PLP
        CPX     #$DE
@L22B4  BNE     @L22B4
        CPY     #$AD
@L22B8  BNE     @L22B8
        TSX
        CPX     #$FF
@L22BD  BNE     @L22BD
        LDA     test_case
        CMP     #$12
@L22C4  BNE     @L22C4
        LDA     #$13
        STA     test_case
        LDX     #$42
        LDY     #$00
        LDA+1   indAN
        STA+1   zpt
        LDA+1   indAN+1
        STA+1   ad1
@L22D7  LDA     #$00
        PHA
        LDA     absANa,Y
        PLP
        AND     (zpt)
        PHP
        CMP     absrlo,Y
@L22E4  BNE     @L22E4
        PLA
        EOR     #$30
        CMP     absflo,Y
@L22EC  BNE     @L22EC
        INC+1   zpt
        INY
        CPY     #$04
        BNE     @L22D7
        DEY
        DEC+1   zpt
@L22F8  LDA     #$FF
        PHA
        LDA     absANa,Y
        PLP
        AND     (zpt)
        PHP
        CMP     absrlo,Y
@L2305  BNE     @L2305
        PLA
        EOR     #$7D
        CMP     absflo,Y
@L230D  BNE     @L230D
        DEC+1   zpt
        DEY
        BPL     @L22F8
        LDY     #$00
        LDA+1   indEO
        STA+1   zpt
        LDA+1   indEO+1
        STA+1   ad1
@L231E  LDA     #$00
        PHA
        LDA     absEOa,Y
        PLP
        EOR     (zpt)
        PHP
        CMP     absrlo,Y
@L232B  BNE     @L232B
        PLA
        EOR     #$30
        CMP     absflo,Y
@L2333  BNE     @L2333
        INC+1   zpt
        INY
        CPY     #$04
        BNE     @L231E
        DEY
        DEC+1   zpt
@L233F  LDA     #$FF
        PHA
        LDA     absEOa,Y
        PLP
        EOR     (zpt)
        PHP
        CMP     absrlo,Y
@L234C  BNE     @L234C
        PLA
        EOR     #$7D
        CMP     absflo,Y
@L2354  BNE     @L2354
        DEC+1   zpt
        DEY
        BPL     @L233F
        LDY     #$00
        LDA+1   indOR
        STA+1   zpt
        LDA+1   indOR+1
        STA+1   ad1
@L2365  LDA     #$00
        PHA
        LDA     absORa,Y
        PLP
        ORA     (zpt)
        PHP
        CMP     absrlo,Y
@L2372  BNE     @L2372
        PLA
        EOR     #$30
        CMP     absflo,Y
@L237A  BNE     @L237A
        INC+1   zpt
        INY
        CPY     #$04
        BNE     @L2365
        DEY
        DEC+1   zpt
@L2386  LDA     #$FF
        PHA
        LDA     absORa,Y
        PLP
        ORA     (zpt)
        PHP
        CMP     absrlo,Y
@L2393  BNE     @L2393
        PLA
        EOR     #$7D
        CMP     absflo,Y
@L239B  BNE     @L239B
        DEC+1   zpt
        DEY
        BPL     @L2386
        CPX     #$42
@L23A4  BNE     @L23A4
        TSX
        CPX     #$FF
@L23A9  BNE     @L23A9
        LDA     test_case
        CMP     #$13
@L23B0  BNE     @L23B0
        LDA     #$14
        STA     test_case
        CLI
        CLD
        LDX     #$0E
        LDY     #$FF
        LDA     #$00
        STA+1   zpt
        STA+1   ad1
        STA+1   ad2
        STA     abst
        STA+1   adrl
        STA+1   adrh
        LDA     #$FF
        STA+1   sb2
        STA     ada2
        LDA     #$02
        STA+1   adrf
tadd    CLC
        JSR     chkadd
        INC+1   zpt
        INC+1   adrl
        PHP
        PHP
        PLA
        AND     #$82
        PLP
        BNE     tadd1
        INC+1   adrh
tadd1   ORA+1   adrh
        STA+1   adrf
        SEC
        JSR     chkadd
        DEC+1   zpt
        INC+1   ad1
        BNE     tadd
        LDA     #$00
        STA+1   adrh
        INC     abst
        INC+1   ad2
        PHP
        PLA
        AND     #$82
        STA+1   adrf
        DEC+1   sb2
        DEC     ada2
        LDA+1   ad2
        STA+1   adrl
        BNE     tadd
        CPX     #$0E
@L2413  BNE     @L2413
        CPY     #$FF
@L2417  BNE     @L2417
        TSX
        CPX     #$FF
@L241C  BNE     @L241C
        LDA     test_case
        CMP     #$14
@L2423  BNE     @L2423
        LDA     #$15
        STA     test_case
        SED
        LDX     #$0E
        LDY     #$FF
        LDA     #$99
        STA+1   ad1
        STA+1   ad2
        STA     abst
        STA+1   adrl
        LDA     #$01
        STA+1   zpt
        STA+1   adrh
        LDA     #$81
        STA+1   adrf
        LDA     #$00
        STA+1   sb2
        STA     ada2
tdad    SEC
        JSR     chkdad
        DEC+1   zpt
        LDA+1   adrl
        BNE     tdad1
        DEC+1   adrh
        LDA     #$99
        STA+1   adrl
        BNE     tdad3

tdad1   AND     #$0F
        BNE     tdad2
        DEC+1   adrl
        DEC+1   adrl
        DEC+1   adrl
        DEC+1   adrl
        DEC+1   adrl
        DEC+1   adrl
tdad2   DEC+1   adrl
tdad3   PHP
        PLA
        AND     #$82
        ORA+1   adrh
        STA+1   adrf
        CLC
        JSR     chkdad
        INC+1   zpt
        LDA+1   ad1
        BEQ     tdad5
        AND     #$0F
        BNE     tdad4
        DEC+1   ad1
        DEC+1   ad1
        DEC+1   ad1
        DEC+1   ad1
        DEC+1   ad1
        DEC+1   ad1
tdad4   DEC+1   ad1
        JMP     tdad

tdad5   LDA     #$99
        STA+1   ad1
        LDA+1   ad2
        BEQ     tdad7
        AND     #$0F
        BNE     tdad6
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
tdad6   DEC+1   ad2
        INC+1   sb2
        LDA+1   sb2
        STA     ada2
        LDA+1   ad2
        STA     abst
        STA+1   adrl
        PHP
        PLA
        AND     #$82
        ORA     #$01
        STA+1   adrf
        INC+1   adrh
        JMP     tdad

tdad7   CPX     #$0E
@L24D9  BNE     @L24D9
        CPY     #$FF
@L24DD  BNE     @L24DD
        TSX
        CPX     #$FF
@L24E2  BNE     @L24E2
        CLD
        LDA     test_case
        CMP     #$15
@L24EA  BNE     @L24EA
        LDA     #$F0
        STA     test_case
;  S U C C E S S ************************************************
;  -------------
@L24F1  JMP     @L24F1     ;test passed, no errors

;  S U C C E S S ************************************************
;  -------------
        JMP     start      ;run again

; core subroutine of the decimal add/subtract test
; *** WARNING - tests documented behavior only! ***
;   only valid BCD operands are tested, V flag is ignored
; iterates through all valid combinations of operands and carry input
; uses increments/decrements to predict result & carry flag
chkdad  PHP                ;decimal ADC / SBC zp
        LDA+1   ad1
        ADC+1   ad2
        PHP
        CMP+1   adrl
@L24FF  BNE     @L24FF
        PLA
        AND     #$83
        CMP+1   adrf
@L2506  BNE     @L2506
        PLP
        PHP
        LDA+1   ad1
        SBC+1   sb2
        PHP
        CMP+1   adrl
@L2511  BNE     @L2511
        PLA
        AND     #$83
        CMP+1   adrf
@L2518  BNE     @L2518
        PLP
        PHP
        LDA+1   ad1
        ADC     abst
        PHP
        CMP+1   adrl
@L2524  BNE     @L2524
        PLA
        AND     #$83
        CMP+1   adrf
@L252B  BNE     @L252B
        PLP
        PHP
        LDA+1   ad1
        SBC     ada2
        PHP
        CMP+1   adrl
@L2537  BNE     @L2537
        PLA
        AND     #$83
        CMP+1   adrf
@L253E  BNE     @L253E
        PLP
        PHP
        LDA+1   ad2
        STA     ex_adci+1
        LDA+1   ad1
        JSR     ex_adci
        PHP
        CMP+1   adrl
@L254F  BNE     @L254F
        PLA
        AND     #$83
        CMP+1   adrf
@L2556  BNE     @L2556
        PLP
        PHP
        LDA+1   sb2
        STA     ex_sbci+1
        LDA+1   ad1
        JSR     ex_sbci
        PHP
        CMP+1   adrl
@L2567  BNE     @L2567
        PLA
        AND     #$83
        CMP+1   adrf
@L256E  BNE     @L256E
        PLP
        PHP
        LDA+1   ad1
        ADC     0,X
        PHP
        CMP+1   adrl
@L2579  BNE     @L2579
        PLA
        AND     #$83
        CMP+1   adrf
@L2580  BNE     @L2580
        PLP
        PHP
        LDA+1   ad1
        SBC+1   L0004,X
        PHP
        CMP+1   adrl
@L258B  BNE     @L258B
        PLA
        AND     #$83
        CMP+1   adrf
@L2592  BNE     @L2592
        PLP
        PHP
        LDA+1   ad1
        ADC     L01F7,X
        PHP
        CMP+1   adrl
@L259E  BNE     @L259E
        PLA
        AND     #$83
        CMP+1   adrf
@L25A5  BNE     @L25A5
        PLP
        PHP
        LDA+1   ad1
        SBC     L01F8,X
        PHP
        CMP+1   adrl
@L25B1  BNE     @L25B1
        PLA
        AND     #$83
        CMP+1   adrf
@L25B8  BNE     @L25B8
        PLP
        PHP
        LDA+1   ad1
        ADC     L0106,Y
        PHP
        CMP+1   adrl
@L25C4  BNE     @L25C4
        PLA
        AND     #$83
        CMP+1   adrf
@L25CB  BNE     @L25CB
        PLP
        PHP
        LDA+1   ad1
        SBC     L0107,Y
        PHP
        CMP+1   adrl
@L25D7  BNE     @L25D7
        PLA
        AND     #$83
        CMP+1   adrf
@L25DE  BNE     @L25DE
        PLP
        PHP
        LDA+1   ad1
        ADC     (indEO+2,X)
        PHP
        CMP+1   adrl
@L25E9  BNE     @L25E9
        PLA
        AND     #$83
        CMP+1   adrf
@L25F0  BNE     @L25F0
        PLP
        PHP
        LDA+1   ad1
        SBC     (L0046,X)
        PHP
        CMP+1   adrl
@L25FB  BNE     @L25FB
        PLA
        AND     #$83
        CMP+1   adrf
@L2602  BNE     @L2602
        PLP
        PHP
        LDA+1   ad1
        ADC     (L0056),Y
        PHP
        CMP+1   adrl
@L260D  BNE     @L260D
        PLA
        AND     #$83
        CMP+1   adrf
@L2614  BNE     @L2614
        PLP
        PHP
        LDA+1   ad1
        SBC     (L0058),Y
        PHP
        CMP+1   adrl
@L261F  BNE     @L261F
        PLA
        AND     #$83
        CMP+1   adrf
@L2626  BNE     @L2626
        PLP
        PHP
        LDA+1   ad1
        ADC     (L0052)
        PHP
        CMP+1   adrl
@L2631  BNE     @L2631
        PLA
        AND     #$83
        CMP+1   adrf
@L2638  BNE     @L2638
        PLP
        PHP
        LDA+1   ad1
        SBC     (L0054)
        PHP
        CMP+1   adrl
@L2643  BNE     @L2643
        PLA
        AND     #$83
        CMP+1   adrf
@L264A  BNE     @L264A
        PLP
        RTS

chkadd  LDA+1   adrf
        AND     #$83
        PHA
        LDA+1   ad1
        EOR+1   ad2
        BMI     @L2663
        LDA+1   ad1
        EOR+1   adrl
        BPL     @L2663
        PLA
        ORA     #$40
        PHA
@L2663  PLA
        STA+1   adrf
        PHP
        LDA+1   ad1
        ADC     (L0052)
        PHP
        CMP+1   adrl
@L266E  BNE     @L266E
        PLA
        AND     #$C3
        CMP+1   adrf
@L2675  BNE     @L2675
        PLP
        PHP
        LDA+1   ad1
        SBC     (L0054)
        PHP
        CMP+1   adrl
@L2680  BNE     @L2680
        PLA
        AND     #$C3
        CMP+1   adrf
@L2687  BNE     @L2687
        PLP
        RTS

; target for the jump indirect test
ji_adr  !WORD   test_ji
        !WORD   ji_ret

        DEY
        DEY
test_ji PHP
        DEY
        DEY
        DEY
        PLP
@L2696  BCS     @L2696
@L2698  BVS     @L2698
@L269A  BMI     @L269A
@L269C  BEQ     @L269C
        CMP     #'I'
@L26A0  BNE     @L26A0
        CPX     #'N'
@L26A4  BNE     @L26A4
        CPY     #'A'
@L26A8  BNE     @L26A8
        PHA
        TXA
        PHA
        TSX
        CPX     #$FD
@L26B0  BNE     @L26B0
        PLA
        TAX
        LDA     #$FF
        PHA
        PLP
        PLA
        INX
        EOR     #$AA
        JMP     (ji_tab+2)

        NOP
        NOP
@L26C1  JMP     @L26C1

        JMP     start

jxi_adr !WORD   trap_ind
        !WORD   trap_ind
        !WORD   test_jxi
        !WORD   jxi_ret
        !WORD   trap_ind
        !WORD   trap_ind

        DEY
        DEY
test_jxi
        PHP
        DEY
        DEY
        DEY
        PLP
@L26DA  BCS     @L26DA
@L26DC  BVS     @L26DC
@L26DE  BMI     @L26DE
@L26E0  BEQ     @L26E0
        CMP     #$58
@L26E4  BNE     @L26E4
        CPX     #$04
@L26E8  BNE     @L26E8
        CPY     #$46
@L26EC  BNE     @L26EC
        PHA
        TXA
        PHA
        TSX
        CPX     #$FD
@L26F4  BNE     @L26F4
        PLA
        TAX
        LDA     #$FF
        PHA
        PLP
        PLA
        INX
        INX
        EOR     #$AA
        JMP     (jxi_tab,X)

        NOP
        NOP
@L2706  JMP     @L2706

        JMP     start

        NOP
        NOP
trap_ind
        NOP
        NOP
@L2710  JMP     @L2710

        JMP     start

; trap in case of unexpected IRQ, NMI, BRK, RESET
nmi_trap
        JMP     nmi_trap   ;check stack for conditions at NMI

        JMP     start      ;catastrophic error - cannot continue

res_trap
        JMP     res_trap   ;unexpected RESET

        JMP     start      ;catastrophic error - cannot continue

        DEY
        DEY
irq_trap
        PHP                ;BRK test or unexpected BRK or IRQ
        DEY
        DEY
        DEY
; next traps could be caused by unexpected BRK or IRQ
; check stack for BREAK and originating location
; possible jump/branch into weeds (uninitialized space)
        CMP     #$BD
        BEQ     break2
        CMP     #$42
@L272E  BNE     @L272E
        CPX     #'R'
@L2732  BNE     @L2732
        CPY     #$48
@L2736  BNE     @L2736
        STA+1   irq_a
        STX+1   irq_x
        TSX
        LDA     $0102,X
        CMP     #$30
@L2742  BNE     @L2742
        PLA
        CMP     #$34
@L2747  BNE     @L2747
        TSX
        CPX     #$FC
@L274C  BNE     @L274C
        LDA     pg_x-1
        CMP     #$17
@L2753  BNE     @L2753
        LDA     L01FE
        CMP     #$20
@L275A  BNE     @L275A
        LDA     #$FF
        PHA
        LDX+1   irq_x
        INX
        LDA+1   irq_a
        EOR     #$AA
        PLP
        RTI

@L2768  JMP     @L2768

        JMP     start

break2  CPX     #$AD
@L2770  BNE     @L2770
        CPY     #$B1
@L2774  BNE     @L2774
        STA+1   irq_a
        STX+1   irq_x
        TSX
        LDA     $0102,X
        CMP     #$FF
@L2780  BNE     @L2780
        PLA
        CMP     #$F7
@L2785  BNE     @L2785
        TSX
        CPX     #$FC
@L278A  BNE     @L278A
        LDA     pg_x-1
        CMP     #$17
@L2791  BNE     @L2791
        LDA     L01FE
        CMP     #$46
@L2798  BNE     @L2798
        LDA     #$04
        PHA
        LDX+1   irq_x
        INX
        LDA+1   irq_a
        EOR     #$AA
        PLP                ;N=0, V=0, Z=0, C=0 but original flags should be restored
        RTI

@L27A6  JMP     @L27A6

        JMP     start      ;catastrophic error - cannot continue

        !FILL   32,$00

        NOP
        NOP
jxi_px  NOP
        NOP
@L27D0  JMP     @L27D0

        !FILL   173,$00

        NOP
        NOP
        NOP
        NOP
@L2884  JMP     @L2884

        !FILL   55155,$FF
        } ;!pseudopc
        !pseudopc $FFFA {
        !WORD   nmi_trap
        !WORD   res_trap
        !WORD   irq_trap
        } ;!pseudopc
