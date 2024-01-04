
!cpu 6510
!to "anewg.prg",cbm
;--------------------------------------------------------------------

;This routine sets or erases a point on the hires screen based
;on coordinates and drawmode determined before-hand.  you can change
;"screen" to wherever your hires screen is located.
;plotPoint works by first determining which 8x8 cell the point is
;located in and uses tables to figure that out.
;The in-cell offset is determined by just isolating the lowest 3 bits
;of each point (0-7).  The pixel masking uses tables, too.

;--------------------------------------------------------------------


screen = $2000              ;for example
dest = $fb
pointX =$21
incre =$41
incre2 =$42
pointY =$20
spritecount= $71
spriteindex= $72
spriteindex2= $74
spriteindex3= $77
spriteindex4= $76
lastkey = $73
 
*=$0801
        !byte    $1E, $08, $0A, $00, $9E, $20, $28,  $32, $30, $38, $30, $29, $3a, $8f, $20, $28, $43, $29, $20, $32, $30, $32, $31, $20, $4D, $54, $53, $56, $00, $00, $00
 
*=$0820

lda #$18
	 sta $d011
	 lda #$04
	 sta $d016
	lda #255
	sta $d01c
	lda #2
	sta $d025
	lda #11
	sta $d026
	
	;lda #$18
	;sta $d018
	lda #0
	sta $d021
sta spritecount
lda #0
sta spriteindex
sta spriteindex3
lda #130
sta spriteindex2


    lda #100
    sta $d000
     lda #110
    sta $d001
      lda #120
     sta $d002
       lda #130
       
      sta $d003
         lda #140
        sta $d004
         lda #150
        sta $d005
         lda #160
        sta $d006
           lda #170
          sta $d007
            lda #180
           sta $d008
            lda #190
           sta $d009
             lda #200
            sta $d00a
              lda #210
             sta $d00b
               lda #220
              sta $d00c
               lda #230
              sta $d00d
                
            
    
 lda #%01100001
 sta $d015


ldy #0
clearcolor

 lda #32
 sta $0400,y
 
 sta $0500,y
 
 sta $0600,y
 
 sta $06ef,y
iny
cpy #0
bne clearcolor





main 
  inc $d02d
   inc $d02c
   lda spriteindex2
 
 sta $7f8 

  
;sta $7fa
 ;sta $7fb
 ;sta $7fc
 ; sta $7fd
   ;sta $7fe
   
    lda #148
 sta $7fd
 sta $7fe
 


lda spriteindex3
 cmp #148
 beq resetspriteindex3
 
lda spriteindex4
 cmp #64
 beq resetspriteindex4
  lda spriteindex4
  adc #4
  sta spriteindex4
   



    jsr movejoy 

inc incre2

ldy #0
mainloop
   lda spriteindex2
  cmp #141
  beq resetspriteindex2
  lda spriteindex2
  cmp #142
  beq resetspriteindex2
    lda spriteindex2
  cmp #143
  beq resetspriteindex2
inc spritecount
 
 ldx spritecount
 cpx #255
 beq resetspritecount

  
 

 lda incre2
 

lda pointX
adc incre2
 ror
sta pointX


 
 
 lda #0

 

 
 
ldy $d012
 cpy incre2
bne mainloop 
;jsr plotPoint
 
 jsr main

 
 rts
resetspriteindex
lda #0
sta spriteindex

jsr main

rts

resetspriteindex22
lda #128
sta spriteindex2


jsr main

rts
resetspriteindex2
lda #134
sta spriteindex2


jsr main

rts
resetspriteindex3
lda #134
sta spriteindex3


jsr main

rts

resetspriteindex4
lda #0
sta spriteindex4

jsr main
 

rts
resetspritecount
lda #0
sta spritecount
jsr main
rts
movejoy 
                
dojoy
lda $dc00
sta lastkey
 
      clc
             
               lda lastkey
              
                cmp #$7b   
				beq left 
				
				cmp #$7e   
				 beq up
				cmp #$77    
				beq right
				cmp #$7d   
				beq down
				cmp #$6f
                beq changechar
           

        
				rts
				
changechar
  lda spriteindex
 cmp #16
 beq resetspriteindex

  lda spriteindex
  adc #2
  sta spriteindex

jsr mainloop
rts
resetspriteright
lda #128
sta spriteindex2
jsr main

 

rts

resetspriteleft
lda #134
sta spriteindex2
jsr main 

 

rts
down



ldx #0
 

lda $d001,x
adc #1
sta $d001,x
 

rts

up

 ldx #0
 
lda $d001,x
sbc #1
sta $d001,x
rts

left

sec

lda spriteindex2
 
 cmp #140
 beq resetspriteleft
 
 
 
   lda spriteindex2
  adc #1
  sta spriteindex2
 
 


 
 ldx #0
 
lda $d000,x
sbc #1
sta $d000,x
bcc extendedleft

rts
right
 
 clc
 

 
 
 lda spriteindex2
 bcs resetspriteright
 cmp #134
 beq resetspriteright

 lda spriteindex2
  adc #1
  sta spriteindex2
 
 ldx #0
 
lda $d000,x
adc #1
sta $d000,x
bcs extendedright

rts
extendedright
lda #%00000001
sta $d010
jsr right
rts
extendedleft
lda $d010
cmp #%00000001
beq extendleft

lda #%00000001
sta $d010
jsr left
rts
extendleft



lda #%00000000
sta $d010
jsr left
rts
zeropointy
lda #0
sta pointY
 

jmp main 
rts
goingright


rts
goingleft


rts

plotPoint 

;-------------------------
;calc Y-cell, divide by 8
;y/8 is y-cell table index
;-------------------------

lda pointY
lsr                         ;/ 2
lsr                         ;/ 4
lsr                         ;/ 8
tay                         ;tbl_8,y index

;------------------------
;calc X-cell, divide by 8
;divide 2-byte pointX / 8
;------------------------
              ;rotate the high byte into carry flag
lda pointX
lsr                       ;lo byte / 2 (rotate C into low byte)
lsr                         ;lo byte / 4
lsr                         ;lo byte / 8
tax                         ;tbl_8,x index

;----------------------------------
;add x & y to calc cell point is in
;----------------------------------
clc

lda tblvbaseLo,y           ;table of screen row base addresses
adc tbl8Lo,x               ;+ (8 * Xcell)
sta dest                    ;= cell address

lda tblvbaseHi,y           ;do the high byte
adc tbl8Hi,x
sta dest+1

;---------------------------------
;get in-cell offset to point (0-7)
;---------------------------------
lda pointX                  ;get pointX offset from cell topleft
and #%00000111              ;3 lowest bits = (0-7)
tax                         ;put into index register

lda pointY                  ;get pointY offset from cell topleft
and #%00000111              ;3 lowest bits = (0-7)
tay                         ;put into index register

;----------------------------------------------
;depending on drawmode, routine draws or erases
;----------------------------------------------

lda drawmode                ;(0 = erase, 1 = set)
beq erase                   ;if = 0 then branch to clear the point

;---------
;set point
;---------
lda (dest),y                ;get row with point in it
ora tblorbit,x             ;isolate and set the point
sta (dest),y                ;write back to screen
jmp past                    ;skip the erase-point section

;-----------
;erase point
;-----------
erase                   ;handled same way as setting a point
lda (dest),y                ;just with opposite bit-mask
and tblandbit,x            ;isolate and erase the point
sta (dest),y                ;write back to screen

past 
rts

;----------------------------------------------------------------
copyfrom5to2
 ldy #0
 ldx #0
 
 
copyfrom5to2lp
 
	lda #0
	sta $2000,y
 
sta $2100,y
 
sta $2200,y
 
sta $2300,y
 
sta $2400,y
 
sta $2500,y
	 
sta $2600,y
 
sta $2700,y
 
sta $2800,y
 
sta $2900,y
 

       
       sta $2a00,y
 
sta $2b00,y
 
sta $2c00,y
 
sta $2d00,y
 
	sta $2e00,y
 
	sta $2f00,y

 
sta $3000,y
	 
sta $3100,y
	 
sta $3200,y
	 
sta $3300,y
	 
sta $3400,y
	 
sta $3500,y
	 
sta $3600,y
	 
sta $3700,y
	 
sta $3800,y
	 
sta $3900,y
	 
sta $3a00,y
 
sta $3b00,y
 
sta $3c00,y
	 
sta $3d00,y
 sta $3e00,y
 sta $3f00,y

iny
cpy #0
bne copyfrom5to2lp

rts
drawmode !byte 1

tblvbaseLo 
!byte <screen,<screen+320,<screen+640,<screen+960
!byte <screen+1280,<screen+1600,<screen+1920,<screen+2240
!byte <screen+2560,<screen+2880,<screen+3200,<screen+3520
!byte <screen+3840,<screen+4160,<screen+4480,<screen+4800
!byte <screen+5120,<screen+5440,<screen+5760,<screen+6080
!byte <screen+6400,<screen+6720,<screen+7040,<screen+7360
!byte <screen+7680

tblvbaseHi 
!byte >screen,>screen+320,>screen+640,>screen+960
!byte >screen+1280,>screen+1600,>screen+1920,>screen+2240
!byte >screen+2560,>screen+2880,>screen+3200,>screen+3520
!byte >screen+3840,>screen+4160,>screen+4480,>screen+4800
!byte >screen+5120,>screen+5440,>screen+5760,>screen+6080
!byte >screen+6400,>screen+6720,>screen+7040,>screen+7360
!byte >screen+7680

tbl8Lo 
!byte <0,<8,<16,<24,<32,<40,<48,<56,<64,<72
!byte <80,<88,<96,<104,<112,<120,<128,<136,<144,<152
!byte <160,<168,<176,<184,<192,<200,<208,<216,<224,<232
!byte <240,<248,<256,<264,<272,<280,<288,<296,<204,<212

tbl8Hi 
!byte >0,>8,>16,>24,>32,>40,>48,>56,>64,>72
!byte >80,>88,>96,>104,>112,>120,>128,>136,>144,>152
!byte >160,>168,>176,>184,>192,>200,>208,>216,>224,>232
!byte >240,>248,>256,>264,>272,>280,>288,>296,>204,>212

tblorbit 
!byte %10000000
!byte %01000000
!byte %00100000
!byte %00010000
!byte %00001000
!byte %00000100
!byte %00000010
!byte %00000001

tblandbit 
!byte %01111111
!byte %10111111
!byte %11011111
!byte %11101111
!byte %11110111
!byte %11111011
!byte %11111101
!byte %11111110
 
spriteposition
!byte 0,2,4,6,8,10,12,14,16,1,3,5,7,9,11,13,15
*=$2000
!fill $2000,0

*=$2000


!bin "spritesk.spr"




spritedata !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%01111110,%00000000
           !byte  %00000011,%00011000,%11000000
           !byte  %00001100,%00100100,%00110000
           !byte  %00110000,%01000010,%00001100
           !byte  %01100000,%10011001,%00000110
           !byte  %11000001,%00100100,%10000011
           !byte  %11000010,%01000010,%01000011
           !byte  %11000010,%01000010,%01000011
           !byte  %11000001,%00100100,%10000011
           !byte  %01100000,%10011001,%00000110
           !byte  %00110000,%01000010,%00001100
           !byte  %00001100,%00100100,%00110000
           !byte  %00000011,%00011000,%11000000
           !byte  %00000000,%01111110,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
             !byte  %00000000 
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%01111110,%00000000
           !byte  %00000011,%00011000,%11000000
           !byte  %00001100,%00100100,%00110000
           !byte  %00110000,%01000010,%00001100
           !byte  %01100000,%10011001,%00000110
           !byte  %11000001,%00111100,%10000011
           !byte  %11000010,%01111110,%01000011
           !byte  %11000010,%01111110,%01000011
           !byte  %11000001,%00111100,%10000011
           !byte  %01100000,%10011001,%00000110
           !byte  %00110000,%01000010,%00001100
           !byte  %00001100,%00100100,%00110000
           !byte  %00000011,%00011000,%11000000
           !byte  %00000000,%01111110,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
            !byte  %00000000 
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%01111110,%00000000
           !byte  %00000011,%00011000,%11000000
           !byte  %00001100,%00100100,%00110000
           !byte  %00110000,%01000010,%00001100
           !byte  %01100001,%10011001,%10000110
           !byte  %11000011,%00111100,%11000011
           !byte  %11000110,%01100110,%01100011
           !byte  %11000110,%01100110,%01100011
           !byte  %11000011,%00111100,%11000011
           !byte  %01100001,%10011001,%10000110
           !byte  %00110000,%01000010,%00001100
           !byte  %00001100,%00100100,%00110000
           !byte  %00000011,%00011000,%11000000
           !byte  %00000000,%01111110,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           
   !byte  %00000000 
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%01111110,%00000000
           !byte  %00000011,%00011000,%11000000
           !byte  %00001100,%00100100,%00110000
           !byte  %00110000,%01000010,%00001100
           !byte  %01100001,%10011001,%10000110
           !byte  %11000011,%00111100,%11000011
           !byte  %11000110,%01100110,%01100011
           !byte  %11000110,%01100110,%01100011
           !byte  %11000011,%00111100,%11000011
           !byte  %01100001,%10011001,%10000110
           !byte  %00110000,%01000010,%00001100
           !byte  %00001100,%00100100,%00110000
           !byte  %00000011,%00011000,%11000000
           !byte  %00000000,%01111110,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
   !byte  %00000000 
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%01111110,%00000000
           !byte  %00000011,%00011000,%11000000
           !byte  %00001100,%00100100,%00110000
           !byte  %00110000,%01000010,%00001100
           !byte  %01100000,%10011001,%00000110
           !byte  %11000001,%00111100,%10000011
           !byte  %11000010,%01111110,%01000011
           !byte  %11000010,%01111110,%01000011
           !byte  %11000001,%00111100,%10000011
           !byte  %01100000,%10011001,%00000110
           !byte  %00110000,%01000010,%00001100
           !byte  %00001100,%00100100,%00110000
           !byte  %00000011,%00011000,%11000000
           !byte  %00000000,%01111110,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
   !byte  %00000000 
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%01111110,%00000000
           !byte  %00000011,%00011000,%11000000
           !byte  %00001100,%00100100,%00110000
           !byte  %00110000,%01000010,%00001100
           !byte  %01100000,%10011001,%00000110
           !byte  %11000001,%00100100,%10000011
           !byte  %11000010,%01000010,%01000011
           !byte  %11000010,%01000010,%01000011
           !byte  %11000001,%00100100,%10000011
           !byte  %01100000,%10011001,%00000110
           !byte  %00110000,%01000010,%00001100
           !byte  %00001100,%00100100,%00110000
           !byte  %00000011,%00011000,%11000000
           !byte  %00000000,%01111110,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
