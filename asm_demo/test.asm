    !CPU    65c02
* =  $0724

    LDA     #$00
    PHA
    LDA     #$33
    PLP
    !BYTE   $0F             ; NOP IMP
    TSB     $8F06
    ; !BYTE   $0C             ; TSB
    ; !BYTE   $06
    ; !BYTE   $8F
    TSB     $4C06
    ; !BYTE   $0C
    ; !BYTE   $06
@L0730
    ; JMP     @L0730
    BMI     next
@L0733
    JMP     @L0733
    PHP
    CMP     #$33
    !BYTE   $D0
;@L0739
    ;BNE     @L0739
next
    INC     $4868,X
    CMP     #$30

