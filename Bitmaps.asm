!cpu 6502 

!to "me.prg",cbm 
 
 
		*=  $5000  -2
	!BIN "me.art"
	* = $0801

!byte $0c,$08,$d0,$07,$9e
!scr " 2064"
!byte $00,$00,$00,$00

	
	
	*=	$0810
screen1=$3f40 
 	 
screen2=$4040 
screen3=$4140 
screen4=$4240 
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
	lda #0
	sta increment
begin

copyfrom5to2
 
ldy increment
 ldx #0
 
 
copyfrom5to2lp
 
	lda $5000,x
	sta $2000,y
	lda $5100,x
sta $2100,y
	lda $5200,x
sta $2200,y
	lda $5300,x
sta $2300,y
	lda $5400,x
sta $2400,y
	lda $5500,x
sta $2500,y
	lda $5600,x
sta $2600,y
	lda $5700,x
sta $2700,y
	lda $5800,x
sta $2800,y
	lda $5900,x
sta $2900,y
	lda $5a00,x

       
       sta $2a00,y
	lda $5b00,x
sta $2b00,y
	lda $5c00,x
sta $2c00,y
	lda $5d00,x
sta $2d00,y
	lda $5e00,x
	sta $2e00,y

	lda $5f00,x
	sta $2f00,y

	
	
	iny

	inx
cpx #255
bne copyfrom5to2lp

ldy increment
ldx #0
copyfrom5to2lp2
	lda $6000,x
sta $3000,y
	lda $6100,x
sta $3100,y
	lda $6200,x
sta $3200,y
	lda $6300,x
sta $3300,y
	lda $6400,x
sta $3400,y
	lda $6500,x
sta $3500,y
	lda $6600,x
sta $3600,y
	lda $6700,x
sta $3700,y
	lda $6800,x
sta $3800,y
	lda $6900,x
sta $3900,y
	lda $6a00,x
sta $3a00,y
	lda $6b00,x
sta $3b00,y
	lda $6c00,x
sta $3c00,y
	lda $6d00,x
 sta $3d00,y
 	lda $6e00,x
 sta $3e00,y
 	lda $6f00,x
 sta $3f00,y
  	lda $7000,x
 sta $4000,y
   	lda $7100,x
 sta $4100,y
    	lda $7200,x
 sta $4200,y
    	lda $7300,x
 sta $4300,y

	
	iny
	inx
cpx #255
bne copyfrom5to2lp2
 


 
 
 
 

 

 


loop

loadcolors
ldy #0
loadcolorslp
iny
lda screen1,y
 sta $0400,y
 lda screen2,y
 sta $0500,y
  lda screen3,y
 sta $0600,y
  lda screen4,y
 sta $0700,y
 inc $0523
 
cpy #255
bne loadcolorslp

inc increment
lda increment
cmp #2
beq incincincrement
 
 
jmp copyfrom5to2
rts
incincincrement
lda #0
sta increment
jmp copyfrom5to2
jmpcopyfrom5to2
jsr copyfrom5to2lp
rts

