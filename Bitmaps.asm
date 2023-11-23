!cpu 6502 

!to "me.prg",cbm 
 
	*=  $2000  -2
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
begin




 
 
 
 

 

 


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



 
jmp loop
rts
 

