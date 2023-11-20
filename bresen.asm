
!cpu 6510
!to "bresen.prg",cbm


;zp
plot_lo = $fe
plot_hi = $ff
 
;coords
x_1 = $15
x_2 = $14
y_1 = $13
y_2 = $12
 
incre = $41
 
incre2 = $42
*=$0801
        !byte    $1E, $08, $0A, $00, $9E, $20, $28,  $32, $30, $38, $30, $29, $3a, $8f, $20, $28, $43, $29, $20, $32, $30, $32, $31, $20, $4D, $54, $53, $56, $00, $00, $00
 
*=$0820
;init screen
 
       
 
        lda #$00
        sta $d020
        lda #$18
        sta $d018
        and #$08
        sta $d016
        lda #2
        sta $dd00
        lda #$3b
        sta $d011

  lda #100
 sta x_1
 sta y_1
 
 
 
 
        ldx #0
        lda #1
loop1   sta $4400,x
        sta $4500,x
        sta $4600,x
        sta $4700,x
        inx
        bne loop1
 
 
        sei
loop2    
erase6000 
 ldy #0
 ldx #0
 
 
erase6000lp
 
	lda #0
	sta $6000,y
 
sta $6100,y
 
sta $6200,y
 
sta $6300,y
 
sta $6400,y
 
sta $6500,y
	 
sta $6600,y
 
sta $6700,y
 
sta $6800,y
 
sta $6900,y
 

       
       sta $6a00,y
 
sta $6b00,y
 
sta $6c00,y
 
sta $6d00,y
 
	sta $6e00,y
 
	sta $6f00,y

 
sta $7000,y
	 
sta $7100,y
	 
sta $7200,y
	 
sta $7300,y
	 
sta $7400,y
	 
sta $7500,y
	 
sta $7600,y
	 
sta $7700,y
	 
sta $7800,y
	 
sta $7900,y
	 
sta $7a00,y
 
sta $7b00,y
 
sta $7c00,y
	 
sta $7d00,y
 sta $7e00,y
 sta $7f00,y

iny
cpy #0
bne erase6000lp
 
 
 
ldy #0
ldy #0
sty incre
 
 
  lda incre2
 
 sta x_2
 
 
 jsr draw_line  
 
loopcycle
 
 
 inc incre


  inc incre2

 
ror x_1
 
ror y_1
ror x_2
 
 ror y_2
 
 
 
jsr draw_line     
  
 
 inc x_1
 
 
 
jsr draw_line   
ror x_2
 
 ror y_2
 ror x_1
 
ror y_1
jsr draw_line        
     
      
ldy incre
cpy #3
bne loopcycle
        
        jmp loop2
 
draw_line
 
;init
 
        ldx #$e8        ;inx
       
      
        lda  y_2
        sta to_y+1
        sec
     
       sbc  y_1
        bcs skip1
        eor #$ff
        adc #1
        ldx #$ca        ;dex - change direction
skip1
        sta d_y+1
        sta t_y_1+1
        sta t_y_2+1
        stx incx1
        stx incx2
 
        ldx #$c8        ;iny
        
        lda  x_2
        sta to_x+1
        sec
        sbc x_1
        bcs skip2
        eor #$ff
        adc #1
        ldx #$88        ;dey - change direction
skip2
        stx incy1
        stx incy2
       
        ldy x_1

        ldx y_1
 
;loop
 
;start y in x-register
;start x in y-register
;delta x in a-register
 
d_y     cmp #0
        bcc steep
 
        sta t_x_1+1
        ror
    
        sta errx+1
loopx
        clc                 ;needed, as previous cmp could set carry. could be saved if we always count up and branch with bcc;
        lda x_char,y
        adc y_char_lo,x
        
        sta plot_lo
        lda y_char_hi,x
        sta plot_hi
 
        lda x_pixel_char,y
        ora (plot_lo),y
        sta (plot_lo),y     ;Remember that the y_char_lo table in this example starts at $20 (which center hires mode plotting). If you lower the start of table to below $08 (say for multicolor purposes where x steps are in doubles), you will get high-byte issues when you $FE in the adc x_char with the sta (),y  
 
errx    lda #$00
        sec
t_y_1   sbc #0
      
     
        bcs skip3
 
        ;one might also swap cases (bcc here) and duplicate the loopend. saves more or less cycles as the subtract-case occurs more often than the add-case. Copying the whole loop to zeropage also save cycles as sta errx+1 is only 3 cycles then. (Bitbreaker)
 
t_x_1   adc #0
incx1   inx
skip3   sta errx+1
 
incy1   iny
to_x   
        
        
        cpy #0
        bne loopx
        rts
 
steep
        sta t_x_2+1
       ror
     
      adc #1
        sta erry+1
loopy
        clc                 ;needed, as previous cmp could set carry. could be saved if we always count up and branch with bcc;
        lda x_char,y
        adc y_char_lo,x
        sta plot_lo
        lda y_char_hi,x
        sta plot_hi
 
        lda x_pixel_char,y
        eor (plot_lo),y
        sta (plot_lo),y
 
erry    lda #$00
        sec
t_x_2   sbc #0
        bcs skip4
 
t_y_2   adc #0
incy2   iny
skip4   sta erry+1
  
 
  

incx2   inx
to_y   
cpx incre2
       
       bne loopy
        rts
 
change
inc y_1
 
rts


;.align 256
y_char_lo
        !byte $20,$21,$22,$23,$24,$25,$26,$27,$60,$61,$62,$63,$64,$65,$66,$67
        !byte $a0,$a1,$a2,$a3,$a4,$a5,$a6,$a7,$e0,$e1,$e2,$e3,$e4,$e5,$e6,$e7
        !byte $20,$21,$22,$23,$24,$25,$26,$27,$60,$61,$62,$63,$64,$65,$66,$67
        !byte $a0,$a1,$a2,$a3,$a4,$a5,$a6,$a7,$e0,$e1,$e2,$e3,$e4,$e5,$e6,$e7
        !byte $20,$21,$22,$23,$24,$25,$26,$27,$60,$61,$62,$63,$64,$65,$66,$67
        !byte $a0,$a1,$a2,$a3,$a4,$a5,$a6,$a7,$e0,$e1,$e2,$e3,$e4,$e5,$e6,$e7
        !byte $20,$21,$22,$23,$24,$25,$26,$27,$60,$61,$62,$63,$64,$65,$66,$67
        !byte $a0,$a1,$a2,$a3,$a4,$a5,$a6,$a7,$e0,$e1,$e2,$e3,$e4,$e5,$e6,$e7
        !byte $20,$21,$22,$23,$24,$25,$26,$27,$60,$61,$62,$63,$64,$65,$66,$67
        !byte $a0,$a1,$a2,$a3,$a4,$a5,$a6,$a7,$e0,$e1,$e2,$e3,$e4,$e5,$e6,$e7
        !byte $20,$21,$22,$23,$24,$25,$26,$27,$60,$61,$62,$63,$64,$65,$66,$67
        !byte $a0,$a1,$a2,$a3,$a4,$a5,$a6,$a7,$e0,$e1,$e2,$e3,$e4,$e5,$e6,$e7
        !byte $20,$21,$22,$23,$24,$25,$26,$27,$60,$61,$62,$63,$64,$65,$66,$67
        !byte $60,$61,$62,$63,$64,$65,$66,$67,$60,$61,$62,$63,$64,$65,$66,$67
        !byte $60,$61,$62,$63,$64,$65,$66,$67,$60,$61,$62,$63,$64,$65,$66,$67
        !byte $60,$61,$62,$63,$64,$65,$66,$67,$60,$61,$62,$63,$64,$65,$66,$67
 
y_char_hi
        !byte $60,$60,$60,$60,$60,$60,$60,$60,$61,$61,$61,$61,$61,$61,$61,$61
        !byte $62,$62,$62,$62,$62,$62,$62,$62,$63,$63,$63,$63,$63,$63,$63,$63
        !byte $65,$65,$65,$65,$65,$65,$65,$65,$66,$66,$66,$66,$66,$66,$66,$66
        !byte $67,$67,$67,$67,$67,$67,$67,$67,$68,$68,$68,$68,$68,$68,$68,$68
        !byte $6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6b,$6b,$6b,$6b,$6b,$6b,$6b,$6b
        !byte $6c,$6c,$6c,$6c,$6c,$6c,$6c,$6c,$6d,$6d,$6d,$6d,$6d,$6d,$6d,$6d
        !byte $6f,$6f,$6f,$6f,$6f,$6f,$6f,$6f,$70,$70,$70,$70,$70,$70,$70,$70
        !byte $71,$71,$71,$71,$71,$71,$71,$71,$72,$72,$72,$72,$72,$72,$72,$72
        !byte $74,$74,$74,$74,$74,$74,$74,$74,$75,$75,$75,$75,$75,$75,$75,$75
        !byte $76,$76,$76,$76,$76,$76,$76,$76,$77,$77,$77,$77,$77,$77,$77,$77
        !byte $79,$79,$79,$79,$79,$79,$79,$79,$7a,$7a,$7a,$7a,$7a,$7a,$7a,$7a
        !byte $7b,$7b,$7b,$7b,$7b,$7b,$7b,$7b,$7c,$7c,$7c,$7c,$7c,$7c,$7c,$7c
        !byte $7e,$7e,$7e,$7e,$7e,$7e,$7e,$7e,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f
        !byte $7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f
        !byte $7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f
        !byte $7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f
x_char
        !byte $00,$ff,$fe,$fd,$fc,$fb,$fa,$f9,$00,$ff,$fe,$fd,$fc,$fb,$fa,$f9
        !byte $00,$ff,$fe,$fd,$fc,$fb,$fa,$f9,$00,$ff,$fe,$fd,$fc,$fb,$fa,$f9
        !byte $00,$ff,$fe,$fd,$fc,$fb,$fa,$f9,$00,$ff,$fe,$fd,$fc,$fb,$fa,$f9
        !byte $00,$ff,$fe,$fd,$fc,$fb,$fa,$f9,$00,$ff,$fe,$fd,$fc,$fb,$fa,$f9
        !byte $00,$ff,$fe,$fd,$fc,$fb,$fa,$f9,$00,$ff,$fe,$fd,$fc,$fb,$fa,$f9
        !byte $00,$ff,$fe,$fd,$fc,$fb,$fa,$f9,$00,$ff,$fe,$fd,$fc,$fb,$fa,$f9
        !byte $00,$ff,$fe,$fd,$fc,$fb,$fa,$f9,$00,$ff,$fe,$fd,$fc,$fb,$fa,$f9
        !byte $00,$ff,$fe,$fd,$fc,$fb,$fa,$f9,$00,$ff,$fe,$fd,$fc,$fb,$fa,$f9
        !byte $00,$ff,$fe,$fd,$fc,$fb,$fa,$f9,$00,$ff,$fe,$fd,$fc,$fb,$fa,$f9
        !byte $00,$ff,$fe,$fd,$fc,$fb,$fa,$f9,$00,$ff,$fe,$fd,$fc,$fb,$fa,$f9
        !byte $00,$ff,$fe,$fd,$fc,$fb,$fa,$f9,$00,$ff,$fe,$fd,$fc,$fb,$fa,$f9
        !byte $00,$ff,$fe,$fd,$fc,$fb,$fa,$f9,$00,$ff,$fe,$fd,$fc,$fb,$fa,$f9
        !byte $00,$ff,$fe,$fd,$fc,$fb,$fa,$f9,$00,$ff,$fe,$fd,$fc,$fb,$fa,$f9
        !byte $00,$ff,$fe,$fd,$fc,$fb,$fa,$f9,$00,$ff,$fe,$fd,$fc,$fb,$fa,$f9
        !byte $00,$ff,$fe,$fd,$fc,$fb,$fa,$f9,$00,$ff,$fe,$fd,$fc,$fb,$fa,$f9
        !byte $00,$ff,$fe,$fd,$fc,$fb,$fa,$f9,$00,$ff,$fe,$fd,$fc,$fb,$fa,$f9
 
x_pixel_char
        !byte $80,$40,$20,$10,$08,$04,$02,$01,$80,$40,$20,$10,$08,$04,$02,$01
        !byte $80,$40,$20,$10,$08,$04,$02,$01,$80,$40,$20,$10,$08,$04,$02,$01
        !byte $80,$40,$20,$10,$08,$04,$02,$01,$80,$40,$20,$10,$08,$04,$02,$01
        !byte $80,$40,$20,$10,$08,$04,$02,$01,$80,$40,$20,$10,$08,$04,$02,$01
        !byte $80,$40,$20,$10,$08,$04,$02,$01,$80,$40,$20,$10,$08,$04,$02,$01
        !byte $80,$40,$20,$10,$08,$04,$02,$01,$80,$40,$20,$10,$08,$04,$02,$01
        !byte $80,$40,$20,$10,$08,$04,$02,$01,$80,$40,$20,$10,$08,$04,$02,$01
        !byte $80,$40,$20,$10,$08,$04,$02,$01,$80,$40,$20,$10,$08,$04,$02,$01
        !byte $80,$40,$20,$10,$08,$04,$02,$01,$80,$40,$20,$10,$08,$04,$02,$01
        !byte $80,$40,$20,$10,$08,$04,$02,$01,$80,$40,$20,$10,$08,$04,$02,$01
        !byte $80,$40,$20,$10,$08,$04,$02,$01,$80,$40,$20,$10,$08,$04,$02,$01
        !byte $80,$40,$20,$10,$08,$04,$02,$01,$80,$40,$20,$10,$08,$04,$02,$01
        !byte $80,$40,$20,$10,$08,$04,$02,$01,$80,$40,$20,$10,$08,$04,$02,$01
        !byte $80,$40,$20,$10,$08,$04,$02,$01,$80,$40,$20,$10,$08,$04,$02,$01
        !byte $80,$40,$20,$10,$08,$04,$02,$01,$80,$40,$20,$10,$08,$04,$02,$01
        !byte $80,$40,$20,$10,$08,$04,$02,$01,$80,$40,$20,$10,$08,$04,$02,$01

    
 
