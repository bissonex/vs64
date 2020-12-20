; Target assembler: acme v0.96.4 []
; 6502bench SourceGen v1.7.3
        !CPU    65816
VOICE1  =       $5200
VOICE2  =       $5300
VOICE3  =       $5400
SID     =       $C400
SID_FREQL_1 =   SID + $00
SID_FREQH_1 =   SID + $01
SID_CONTROL_1 = SID + $04
SID_ATTACK_1 =  SID + $05
SID_SUSTAIN_1 = SID + $06
SID_FREQL_2 =   SID + $07
SID_FREQH_2 =   SID + $08
SID_CONTROL_2 = SID + $0B
SID_ATTACK_2 =  SID + $0C
SID_SUSTAIN_2 = SID + $0D
SID_FREQL_3 =   SID + $0E
SID_FREQH_3 =   SID + $0F
SID_CONTROL_3 = SID + $12
SID_ATTACK_3 =  SID + $13
SID_SUSTAIN_3 = SID + $14
SID_VOLUME = SID + $18
;
WAIT = $FBD1


*       =       $5000
        !AS
        !RS
        LDA     #$09
        INC
        STA     SID_ATTACK_1
        LDA     #$09
        STA     SID_SUSTAIN_2
        STA     SID_ATTACK_2
        LDA     #$80
        STA     SID_SUSTAIN_3
        LDA     #$09
        STA     SID_ATTACK_3
        LDA     #$0F
        STA     SID_VOLUME              ; max volume
play
        LDX     #$00
next_sample
        LDA     VOICE1,X
        STA     SID_FREQH_1
        LDA     VOICE2,X
        STA     SID_FREQH_2
        LDA     VOICE3,X
        STA     SID_FREQH_3
        INX
        LDA     VOICE1,X
        STA     SID_FREQL_1
        LDA     VOICE2,X
        STA     SID_FREQL_2
        LDA     VOICE3,X
        STA     SID_FREQL_3
        INX
        LDA     #$21                    ; sawtooth wave + gate
        STA     SID_CONTROL_1
        STA     SID_CONTROL_2
        STA     SID_CONTROL_3
        LDA     #$40
        JSR     WAIT
        JSR     WAIT
        LDA     #$20                    ; ungate
        STA     SID_CONTROL_1
        STA     SID_CONTROL_2
        STA     SID_CONTROL_3

        CPX     #$B8
        BNE     next_sample
        RTS

