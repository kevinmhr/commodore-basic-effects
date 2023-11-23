
!cpu 6510
!to "spritesandplots.prg",cbm
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
 
*=$0801
        !byte    $1E, $08, $0A, $00, $9E, $20, $28,  $32, $30, $38, $30, $29, $3a, $8f, $20, $28, $43, $29, $20, $32, $30, $32, $31, $20, $4D, $54, $53, $56, $00, $00, $00
 
*=$0820

lda #$3b
	 sta $d011
	 lda #$08
	 sta $d016
	lda #$18
	sta $d018
lda #0
sta spritecount
sta spriteindex





main 

ldy #0
clearcolor

 lda #6
 sta $0400,y
 
 sta $0500,y
 
 sta $0600,y
 
 sta $0700,y
iny
cpy #0
bne clearcolor




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
 
 
 lda #%11111111
 sta $d015
 
 
 inc incre2
 
 
ldy #0
lda spriteindex
 cmp #15
 beq resetspriteindex
  inc spriteindex


mainloop
lda spritecount
cmp #7
beq resetspritecount
inc spritecount
 
 ldx spritecount
 lda pointX
 sta $7f8,x
inc incre2
lda pointX
adc incre2
 ror
sta pointX

 
 ldx spriteindex
 lda spriteposition,x
 tax
 lda pointX
 ror
 ror
sta $d000,x
 lda #0

 
 
 adc sinetab,y
 
 
; sta pointX
 
  inc pointY

lda pointY
cmp #200
 beq zeropointy

 jsr plotPoint
 
 
 iny
 cpy #255
 bne mainloop
;jsr plotPoint
 
 jsr main 
 rts
 
 

 
jsr main

rts
resetspriteindex
lda #0
sta spriteindex
jsr main

rts
resetspritecount
lda #0
sta spritecount
jsr main
rts
zeropointy
lda #0
sta pointY
 

jmp main 
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
sinetab2
!byte 1,1,2,2,2,3,3,3,3,4,4,4,4,4,5,5,5,5,5,5,5,6,6,6,6,6,6,6,6,7,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8
!byte 9,9,9,9,9,9,9,9,9,9,9,9,10,10,10,10,10,10,10,10,10,10,10,11,11,11,11,11,11,11,11,11,11,12,12,12,12
!byte 12,12,12,12,12,12,12,12,13,13,13,13,13,13,13,13,13,13,13,13,13,14,14,14,14,14,14,14,14,14,14,14,14,14
!byte 15,15,15,15,15,15,15,15,15,15,15,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,17,17,17,17,17,17,17,17
!byte 17,17,17,17,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,19,19,19,19,19,19,19,19,19,19,19,19,19,19
!byte 19,19,19,19,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20
sinetab
!byte 10,10,10,10,10,20,20,20,20,20,20,20,30,30,30,30,30,30,30,30,30,50,51,52,53,54,55,56,56,57,57,57,58,58,58,58,59,59
!byte 59,59,60,60,60,60,60,100,100,100,100,100,110,110,110,110,110,110,110,110,115,115,115,115,115,115,115,115,115
!byte 120,120,120,120,120,120,120,120,125,125,125,125,125,125,125,125,130,130,130,130,130,130,130,150,150
!byte 150,150,150,150,150,190,190,190,190,190,190,190,200,200,200,200,200,200,200,200 
!byte 200,200,200,200,200,200,190,190,190,190,190,190,150,150,150,150,150,130,130,130,130,125,125,125,125
!byte 120,120,120,120,120,120,100,100,100,100,100,100,100,60,60,60,60,59,58,57
!byte 10,10,10,10,10,20,20,20,20,20,20,20,30,30,30,30,30,30,30,30,30,50,51,52,53,54,55,56,56,57,57,57,58,58,58,58,59,59
!byte 59,59,60,60,60,60,60,100,100,100,100,100,110,110,110,110,110,110,110,110,115,115,115,115,115,115,115,115,115
!byte 120,120,120,120,120,120,120,120,125,125,125,125,125,125,125,125,130,130,130,130,130,130,130,150,150
!byte 150,150,150,150,150,190,190,190,190,190,190,190,200,200,200,200,200,200,200,200 
!byte 200,200,200,200,200,200,190,190,190,190,190,190,150,150,150,150,150,130,130,130,130,125,125,125,125
!byte 120,120,120,120,120,120,100,100,100,100,100,100,100,60,60,60,60,59,58,57
spriteposition
!byte 0,2,4,6,8,10,12,14,16,1,3,5,7,9,11,13,15
