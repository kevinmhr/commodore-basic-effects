!cpu 6502 

!to "line.prg",cbm 


	* = $0801

!byte $0c,$08,$d0,$07,$9e
!scr " 2064"
!byte $00,$00,$00,$00

	
	
	*=	$0810

screenl=$5000 
  ZeroPageLow     = $FB
ZeroPageHigh    = $FC
ZeroPageLow2    = $FD
ZeroPageHigh2   = $FE
  offsetblockl=$43
    offsetblockh=$44
 increment=$41 
  increment2=$42 
	lda $4327
	 sta $d020
	 sta $d021
	
 lda #$3b
	 sta $d011
	 lda #$08
	 sta $d016
	lda #$18
	sta $d018

	

 
clearscreen

ldx #0
clearscreenlp

lda #0
sta $2000,x
sta $2100,x
sta $2200,x
sta $2300,x
sta $2400,x
sta $2500,x
sta $2600,x
sta $2700,x
sta $2800,x
sta $2900,x
sta $2a00,x
sta $2b00,x
sta $2c00,x
sta $2d00,x
sta $2e00,x
sta $2f00,x
sta $3000,x
sta $3100,x
sta $3200,x
sta $3300,x
sta $3400,x
sta $3500,x
sta $3600,x
sta $3700,x
sta $3800,x
sta $3900,x
sta $3a00,x
sta $3b00,x
sta $3c00,x
sta $3d00,x
sta $3e00,x
sta $3f00,x



inx

cpx #255
bne clearscreenlp
lda #0
sta increment

begin
lda #$20
 
sta ZeroPageHigh

lda #$1
sta ZeroPageLow
addzeropageHigh

clc

 
clearcolors
ldy #0
clearcolorslp

lda #1
sta $0400,y
sta $0500,y
sta $0600,y
sta $0700,y
 iny
cpy #0
bne clearcolorslp
 
loop
 
loop2
  


 
 


 
 
 
;  
  

 
 
 
 ldy increment
  
 lda ZeroPageLow
 adc #1
 sta ZeroPageLow
 tya
 
 ldx increment2
  ldy #1
 
 lda bits,x
ora bits,x
 inx
 
ora bits3,x


 
sta (ZeroPageLow),y
 

 


    jsr increzeropageh

backtoloop

  

 
 



 

 
 
jmp loop
rts
zeroincrement
lda #0
sta increment
 
rts
zeroincrement2
lda #0
sta increment2

jmp loop
rts
increzeropagel
clc
;lda ZeroPageLow
;adc #4
;sta ZeroPageLow 
   lda #0
sta increment
 




 lda #0
sta increment

 jmp loop

rts
increzeropageh
 
 
inc ZeroPageHigh
 ldy ZeroPageHigh
cpy #$3f
beq resetzeropageh
 lda increment
 cmp #128
 beq zeroincrement
inc increment
  inc increment2
 
rts
resetzeropagel


lda #0
sta ZeroPageLow
jmp loop
rts
incZeroPageHigh
clc
inc ZeroPageHigh

 
rts
resetzeropageh
lda #$20
sta ZeroPageHigh
 
rts
 
copyfrom5to2
 ldy #0
 ldx #0
 
 
copyfrom5to2lp
 
	lda $5000,y
	sta $2000,y
	lda $5100,y
sta $2100,y
	lda $5200,y
sta $2200,y
	lda $5300,y
sta $2300,y
	lda $5400,y
sta $2400,y
	lda $5500,y
sta $2500,y
	lda $5600,y
sta $2600,y
	lda $5700,y
sta $2700,y
	lda $5800,y
sta $2800,y
	lda $5900,y
sta $2900,y
	lda $5a00,y

       
       sta $2a00,y
	lda $5b00,y
sta $2b00,y
	lda $5c00,y
sta $2c00,y
	lda $5d00,y
sta $2d00,y
	lda $5e00,y
	sta $2e00,y

	lda $5f00,y
	sta $2f00,y
iny
cpy #255
bne copyfrom5to2lp
ldy #0
copyfrom5to2lp2
	lda $6000,y
sta $3000,y
	lda $6100,y
sta $3100,y
	lda $6200,y
sta $3200,y
	lda $6300,y
sta $3300,y
	lda $6400,y
sta $3400,y
	lda $6500,y
sta $3500,y
	lda $6600,y
sta $3600,y
	lda $6700,y
sta $3700,y
	lda $6800,y
sta $3800,y
	lda $6900,y
sta $3900,y
	lda $6a00,y
sta $3a00,y
	lda $6b00,y
sta $3b00,y
	lda $6c00,y
sta $3c00,y
	lda $6d00,y
 sta $3d00,y
	lda $6e00,y
	sta $3e00,y
	lda $6f00,y
	sta $3f00,y

	iny
cpy #255
bne copyfrom5to2lp2
rts
jsrbegin
jsr begin
rts
jmpcopyfrom5to2lp
jsr copyfrom5to2lp 
rts
jmpcopyfrom5to2 
jsr copyfrom5to2  
rts

bits !byte 1,2,4,8,16,32,64,128,255,2,3,5,9,17,33,65,129,0,1,2,4,8,16,32,64,128,255,2,3,5,9,17,33,65,129,0,1,2,4,8,16,32,64,128,255,2,3,5,9,17,33,65,129,0,1,2,4,8,16,32,64,128,255,2,3,5,9,17,33,65,129,0,1,2,4,8,16,32,64,128,255,2,3,5,9,17,33,65,129,0,1,2,4,8,16,32,64,128,255,2,3,5,9,17,33,65,129,0,1,2,4,8,16,32,64,128,255,2,3,5,9,17,33,65,129,0,1,2,4,8,16,32,64,128,255,2,3,5,9,17,33,65,129,0,1,2,4,8,16,32,64,128,255,2,3,5,9,17,33,65,129,0,1,2,4,8,16,32,64,128,255,2,3,5,9,17,33,65,129,0,1,2,4,8,16,32,64,128,255,2,3,5,9,17,33,65,129,0,1,2,4,8,16,32,64,128,255,2,3,5,9,17,33,65,129,0,1,2,4,8,16,32,64,128,255,2,3,5,9,17,33,65,129,0,1,2,4,8,16,32,64,128,255,2,3,5,9,17,33,65,129,0,1,2,4,8,16,32,64,128,255,2,3,5,9,17,33,65,129,0
bits2 !byte 1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8
bits3 !byte 255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1,255,128,64,32,16,8,4,2,1
