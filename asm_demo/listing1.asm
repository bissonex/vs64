!cpu    sweet16

IN      =       $200
*=      $300

        LDA IN,Y
        CMP #"M"
        JSR SW16
MLOOP   LD  @R1
        ST  @R2
        DCR R3
        BNZ MLOOP
        RTN
NOMOVE  CMP #"E"
        BEQ EXIT
        INY

SW16    NOP
        RTS

EXIT    BRK
