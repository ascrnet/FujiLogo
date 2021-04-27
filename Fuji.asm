; ATARI Logo Fuji
; By AsCrNet 
; 2021-04-24
;-----------------------------

RTCLOK = $14
VDSLST = $200
SDLSTL = $230
COLOR0 = $2C4
COLOR1 = $2C5
COLOR2 = $2C6
CHBAS  = $2F4
TRIG0  = $D010
TRIG1  = $D011
COLPF0 = $D016
CONSOL = $D01F
SKCTL  = $D20F
WSYNC  = $D40A
VCOUNT = $D40B
NMIEN  = $D40E
SETVBV = $E45C
XITVBV = $E462	
WARMSV = $E474

    org $80

rainbow .ds 1

    org $2000

dl
:6  .by $70
    .by $70+$80
    .by $46
    .wo fuji
:8  .by $06
    .by $70
    .by $42
    .wo atari
:3  .by $02
    .by $41
    .wo dl

fuji
    .sb '        !"#         '
    .sb '        !"#         '
    .sb '        !"#         '
    .sb '        $"%         '
    .sb '        &"',$27,'         '
    .sb '       ()"*+        '
    .sb '       ,-"./        '
    .sb '      012"345       '
    .sb '      67 " 89       '
atari
    .sb '             :;<=>:; ?@ABX              '
    .sb '            CDEFGCDEFG HUY              '
    .sb '            IJKLGIJKLGMNVY              '
    .sb '            OPQRGOPQRGSTWY              '

start
    mwa #dl SDLSTL
    mwa #dli VDSLST
    mva #>font CHBAS
    mva #$C COLOR1
    mva #$0 COLOR2
    mva #$0 rainbow

    lda #7
    ldx #>vbi_rainbow
    ldy #<vbi_rainbow
    jsr SETVBV

    mva #$C0 NMIEN

loop
    lda TRIG0
    beq off_color
    lda TRIG1
    beq off_color
    lda SKCTL
    and #$04
    beq off_color
    lda CONSOL
    and #1
    bne loop
off_color
    lda RTCLOK
    add #5
wait
    cmp RTCLOK
    bne wait
    dec COLOR1
    beq exit
    jmp off_color 
exit
    jmp WARMSV

vbi_rainbow
    mwa #dli VDSLST
    mva #0 77
    jmp XITVBV

dli 
    pha
    txa
    pha
    lda RTCLOK
    cmp #$A
    bne move_rainbow
    inc rainbow
    lda rainbow
    cmp #2
    bne move_rainbow
    mva #0 rainbow
move_rainbow
    ldx #$47
    lda rainbow
    tay
move
    txa
    clc
    cpy #1
    bne up
    sbc RTCLOK
    jmp cont
up
    adc RTCLOK
cont
    sta WSYNC
    sta COLPF0
    dex
    bpl move
    pla
    tax
    pla
    rti

    org $3000
font
    .by $00,$00,$00,$00,$00,$00,$00,$00
    .by $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
    .by $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    .by $78,$78,$78,$78,$78,$78,$78,$78
    .by $1E,$1E,$3E,$3E,$3E,$3E,$3E,$3E
    .by $78,$78,$7C,$7C,$7C,$7C,$7C,$7C
    .by $3E,$3E,$7E,$7E,$7E,$7C,$7C,$FC
    .by $7C,$7C,$7E,$7E,$7E,$3E,$3E,$3F
    .by $00,$00,$00,$01,$01,$01,$03,$03
    .by $FC,$FC,$FC,$FC,$F8,$F8,$F8,$F8
    .by $3F,$3F,$3F,$3F,$1F,$1F,$1F,$1F
    .by $00,$00,$00,$80,$80,$80,$C0,$C0
    .by $03,$07,$07,$0F,$0F,$1F,$1F,$3F
    .by $F8,$F0,$F0,$F0,$F0,$E0,$E0,$E0
    .by $1F,$0F,$0F,$0F,$0F,$07,$07,$07
    .by $C0,$E0,$E0,$F0,$F0,$F8,$F8,$FC
    .by $00,$00,$01,$07,$3F,$3F,$3F,$3F
    .by $7F,$FF,$FF,$FF,$FF,$FF,$FF,$FE
    .by $C0,$C0,$C0,$80,$80,$00,$00,$00
    .by $03,$03,$03,$01,$01,$00,$00,$00
    .by $FE,$FF,$FF,$FF,$FF,$FF,$FF,$7F
    .by $00,$00,$80,$E0,$FC,$FC,$FC,$FC
    .by $3F,$3F,$3F,$3F,$3F,$3F,$3F,$3C
    .by $FE,$FC,$F8,$F0,$E0,$C0,$00,$00
    .by $7F,$3F,$1F,$0F,$07,$03,$00,$00
    .by $FC,$FC,$FC,$FC,$FC,$FC,$FC,$3C
    .by $00,$00,$03,$0F,$1F,$1F,$3F,$3F
    .by $00,$00,$C0,$F0,$F8,$F8,$FC,$FC
    .by $00,$00,$7F,$7F,$7F,$7F,$7F,$00
    .by $00,$00,$FF,$FF,$FF,$FF,$FF,$7E
    .by $00,$00,$FE,$FE,$FE,$FE,$FE,$00
    .by $00,$00,$3F,$7F,$7F,$7F,$7F,$7E
    .by $00,$00,$FF,$FF,$FF,$FF,$FF,$03
    .by $00,$00,$00,$E0,$F8,$FC,$FE,$FF
    .by $00,$00,$07,$07,$07,$07,$07,$07
    .by $00,$00,$00,$00,$00,$00,$00,$01
    .by $3F,$7F,$7E,$7E,$FC,$FC,$FC,$F8
    .by $FC,$FE,$7E,$7E,$3F,$3F,$3F,$1F
    .by $00,$00,$00,$00,$00,$00,$00,$80
    .by $7E,$7E,$7E,$7E,$7E,$7E,$7E,$7E
    .by $FF,$7F,$3F,$3F,$3F,$3F,$7F,$FF
    .by $01,$01,$03,$03,$03,$07,$07,$07
    .by $F8,$F8,$F0,$F0,$FF,$FF,$FF,$FF
    .by $1F,$1F,$0F,$0F,$FF,$FF,$FF,$FF
    .by $80,$80,$C0,$C0,$C0,$E0,$E0,$E0
    .by $03,$0F,$3F,$7F,$7F,$7F,$3F,$1F
    .by $FE,$FC,$F8,$E0,$80,$00,$80,$C0
    .by $0F,$0F,$0F,$1F,$1F,$1F,$3F,$3F
    .by $FF,$C0,$C0,$80,$80,$80,$00,$00
    .by $FF,$03,$03,$01,$01,$01,$00,$00
    .by $F0,$F0,$F0,$F8,$F8,$F8,$FC,$FC
    .by $0F,$07,$03,$01,$00,$00,$00,$00
    .by $E0,$F0,$F8,$FC,$FE,$7F,$3F,$1F
    .by $07,$87,$87,$87,$87,$87,$07,$07
    .by $07,$07,$07,$07,$07,$07,$07,$07
    .by $07,$07,$07,$07,$07,$07,$87,$C7
    .by $00,$00,$E0,$E0,$E0,$E0,$E0,$E0
    .by $E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0

    run start
