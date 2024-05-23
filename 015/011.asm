!cpu 6510
!to "011.prg",cbm
;designed by keyvan mehrbakhsh 2024
;keyvanmehrbakhsh@gmail.com
;its free to alter 

lastkey = $72
chrposition= $74
 
chrpositionh= $75

listcount =$77
thingposition=$22
thingposition2=$80
thingposition3=$81
thingpositionh=$79
increment=$41
increment2=$42
buffer= $76
zeropagel2 = $fb
zeropageh2 =$fc
zeropagel = $fd
zeropageh =$fe
zeropagel3 = $f9
zeropageh3 =$fa
rows =$25
;columns =$78
xoffset =$26
lines = $24
world = $42
worldh= $41
wavefm   =$36
attdec   =$31
susrel   =$32
volume   =$33
hifreq   =$34
lofreq   =$35
voicefreq = $31
enginesound =$37
length= $40
lengthh =$44
xlength =$47
worldchar =$39
worldwidth =$45
worldy= $46
xstart =$48
yrepetition =$49
character1xpos =$50
character1y =$51
character1trigger =$52
screen = $2000              ;for example
dest = $fb
 bufferhbadd = $87
incre =$31
incre2 =$32
character1xpostemp =$62
spritecount= $91
spriteindex= $92
spriteindex2= $38
spriteindex3= $97
spriteindex4= $96
shoottrigger =$88
arraypoints =$55
column1 =$56
column2 =$57
column3 =$58
column4 =$59
column5 =$60
columncount = $61
charactersno =$64
characterscol =$65
backfiretrigger = $67
xpos=$68
xmemchr = $120
*=$0801
        !byte    $1E, $08, $0A, $00, $9E, $20, $28,$32, $30, $38, $30, $29, $3a, $8f, $20, $28, $43, $29, $20, $32, $30, $32, $31, $20, $4D, $54, $53, $56, $00, $00, $00
 
*=$820
start
lda #0
sta bufferhbadd
lda #1
sta shoottrigger

    lda #170
   sta $d000
     lda #205
    sta $d001
         lda #100
    sta $d002
     lda #205
    sta $d003     
            lda #190
    sta $d004
     lda #180
    sta $d005 
 lda #%00001111
 sta $d015

lda #1
sta characterscol
lda #1
sta backfiretrigger
lda $01    
and #251    
sta $01    
 
copyoriginalchartonewlocation
 
sei
lda $d000,x
sta $2000,x
lda $d100,x
sta $2100,x
;lda $d200,x
;sta $2200,x
;lda $d300,x
;sta $2300,x
lda $d400,x
sta $2400,x
lda $d500,x
sta $2500,x
lda $d600,x
sta $2600,x
lda $d700,x
sta $2700,x
         
 

 
inx
 
 
beq stopcpy



jmp copyoriginalchartonewlocation


stopcpy 

      lda $01
         ora #4
         sta $01 
         
         
         
          lda #$3b
	 sta $d011
	 lda #$08
	 sta $d016
	lda #255
	;sta $d01c
	;lda #2
	;sta $d025
	;lda #11
	;sta $d026
	
	 lda #$18
	 sta $d018
	lda #0
	sta $d021
sta spritecount
lda #0
sta spriteindex
sta spriteindex3
lda #193
sta spriteindex2
         lda #20
         sta character1y
lda #5
sta character1xpos

lda #15
sta thingposition
lda #1
sta character1trigger
lda #1
sta thingpositionh
lda #$07
sta chrpositionh
lda #120
sta chrposition	
lda #0
lda #60
sta xoffset
lda #0
sta rows
lda #$45
sta worldh
lda #3
lda #10
sta world
lda #82
sta charactersno

lda #0
sta $d020
lda #0
sta $d021
lda #$44
sta listcount
lda #1
sta lines
lda #$18
sta $d018

lda #6
sta column1
sta column2
sta column3
sta column4
sta column5
 

clear4000
lda #20
sta chrpositionh

ldx #0
 
lda #20
sta chrpositionh
 
ldx #0

 ;jsr drawlines
;jsr drawlinespg2
main
; jsr drawpatternlist      
         ; lda #$00
 jsr erasure
    jsr bitmaperase
aftererase

          ldx #<irq      
          ldy #>irq
          
          lda #$36
          sta $d012
       stx $0314
        sty $0315
          lda #$7f
          sta $dc0d
          lda #$1b
         sta $d011
         lda #$01
         sta $d01a
        lda #0


  
cli
   lda #$3b
	 sta $d011
	 lda #$08
	 sta $d016
	 	 lda #$18
	 sta $d018

	
mainloop        

 ; jsr bitmaperase
 

aftermove
; jsr erasure
;jsr columns

 


 jsr bitmaptile 

 
   
  ;jsr sprites
 ;jsr drawpickups
 

   jmp mainloop
 
irq
;jsr backfireprocess
; jsr shootlogic

 ; jsr character1forward

  
 ; jsr right
 ; jsr display

   ; jsr movejoy
    
    
 
 
  



 ; jsr columns
;jsr engine

 
 
 
 
 
afterlines
 
lsr  $d019
  
         ; lda $dc0d
        ; sta $dd0d
       ;lda #$ff
      ; sta $d012

 lda enginesound
 cmp #0
 beq keepenginesound
 lda enginesound
 cmp #255
 beq keepenginesound2
  ; dec enginesound
 
socollided
lda $d01e
cmp  #%00000111
beq shipcollided 
   
 
; jmp $ea7e
     
        
rti 

rts
shipcollided

jsr expnoz

ldx #0
shipcollidedl
inc $d012
lda $d012
cmp #255
beq jsrstart
inc $d020
 
lda $d020
cmp #100
bne shipcollidedl 

jsr shipcollided
jsrstart
jsr start
rts
 
 
resetxoffsetinc
lda #60
sta xoffset
 
 jmp $ea7e
rts


keepenginesound
lda #0
sta enginesound
 jmp $ea7e
rts
keepenginesound2
lda #255
sta enginesound
 jmp $ea7e
rts
backgroundcol
clc

ldx rows



lda bufferaddressl,x

sta zeropagel2

lda bufferaddressh,x
adc bufferhbadd
sta zeropageh2 

 
 


lda zeropagel2
adc  xoffset

sta zeropagel2 

ldx rows
lda coloraddressl,x


 
; adc xoffsetindex,x
sta zeropagel
 
lda coloraddressh,x
sta zeropageh 
ldy #0
colorloop



lda (zeropagel2),y

sta (zeropagel),y



iny
cpy #40
bne colorloop
rts



background





afterresetxoffset  

 
bkloop
clc

ldx rows
 



lda bufferaddressl,x

sta zeropagel2

lda bufferaddressh,x

adc bufferhbadd
sta zeropageh2 


 
 


lda zeropagel2
adc  xoffset

sta zeropagel2 

 ldx rows
lda displayaddressl,x


 
; adc xoffsetindex,x
sta zeropagel
 
lda displayaddressh,x
sta zeropageh 

ldy #0
loop2



lda (zeropagel2),y

sta (zeropagel),y



iny
cpy #40
bne loop2

rts

 
resetrows
lda #1
sta rows
 jmp irq

 
 
 rts
 

 


resetlistcount
lda #$43
sta listcount

lda #17

sta thingposition


jmp main
rts 







display
clc
 

 
ldx chrpositionh
 
 lda displayaddressh,x
sta zeropageh

lda chrposition
sta zeropagel
lda #82
ldy #0
sta (zeropagel),y

 ldy #1
lda #84

sta (zeropagel),y
 ldx chrpositionh
 
 lda coloraddressh,x
sta zeropageh
lda #11
ldy #0
sta (zeropagel),y

 ldy #1
lda #11
 
sta (zeropagel),y

 

rts
 


 
addbufferhbadd
lda #60
sta xoffset
lda bufferhbadd
cmp #$17
beq resetbufferadd




lda bufferhbadd
adc #$17
sta bufferhbadd
 
 
rts
 
resetbufferadd
lda #$0
sta bufferhbadd
rts


drawbk
  lda xoffset
cmp #250
beq addbufferhbadd
lda #1
sta rows
 
jsr background
jsr backgroundcol
lda #2
sta rows
 
jsr background
jsr backgroundcol
lda #3
sta rows
 
jsr background
jsr backgroundcol
lda #4
sta rows
 
jsr background
jsr backgroundcol
lda #5
sta rows
  jsr drawpattern
jsr background
jsr backgroundcol
lda #6
sta rows
 
jsr background
jsr backgroundcol
lda #7
sta rows
 
jsr background
jsr backgroundcol
lda #8
sta rows
 
jsr background
jsr backgroundcol
lda #9
sta rows
 
jsr background
jsr backgroundcol
lda #10
sta rows
 
jsr background
jsr backgroundcol
lda #11
sta rows
 
jsr background
jsr backgroundcol
lda #12
sta rows
 
jsr background
jsr backgroundcol
lda #13
sta rows
 
jsr background
jsr backgroundcol
lda #14
sta rows
 
jsr background
jsr backgroundcol
lda #15
sta rows
 
jsr background
jsr backgroundcol
lda #16
sta rows
 
jsr background
jsr backgroundcol
lda #17
sta rows
 
jsr background
jsr backgroundcol
lda #18
sta rows
 
jsr background
jsr backgroundcol
lda #19
sta rows
 
jsr background
jsr backgroundcol
lda #20
sta rows
 
jsr background
jsr backgroundcol
lda #21
sta rows
 
jsr background
jsr backgroundcol
lda #22
sta rows
 
jsr background
jsr backgroundcol
lda #23
sta rows
 
jsr background
jsr backgroundcol
 
 
rts
drawpickups

ldy #0
drawpickupslp
lda pickups,y
cmp #32
beq out
sta $58f0,y
out
iny

cpy #255 
bne drawpickupslp
  
rts

 
xoffsetindex
  !byte 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40

displayaddressl


  !byte <$0400,<$0400+40,<$0400+80,<$0400+120,<$0400+160
  !byte <$0400+200,<$0400+240,<$0400+280,<$0400+320,<$0400+360
   !byte <$0400+400,<$0400+440,<$0400+480,<$0400+520,<$0400+560
    !byte <$0400+600,<$0400+640,<$0400+680,<$0400+720,<$0400+760
     !byte <$0400+800,<$0400+840,<$0400+880,<$0400+920,<$0400+960
  
       
       
displayaddressh


  !byte >$0400,>$0400+40,>$0400+80,>$0400+120,>$0400+160
  !byte >$0400+200,>$0400+240,>$0400+280,>$0400+320,>$0400+360
   !byte >$0400+400,>$0400+440,>$0400+480,>$0400+520,>$0400+560
    !byte >$0400+600,>$0400+640,>$0400+680,>$0400+720,>$0400+760
     !byte >$0400+800,>$0400+840,>$0400+880,>$0400+920,>$0400+960
   
coloraddressl


  !byte <$d800,<$d800+40,<$d800+80,<$d800+120,<$d800+160
  !byte <$d800+200,<$d800+240,<$d800+280,<$d800+320,<$d800+360
   !byte <$d800+400,<$d800+440,<$d800+480,<$d800+520,<$d800+560
    !byte <$d800+600,<$d800+640,<$d800+680,<$d800+720,<$d800+760
     !byte <$d800+800,<$d800+840,<$d800+880,<$d800+920,<$d800+960
  
       
       
coloraddressh


  !byte >$d800,>$d800+40,>$d800+80,>$d800+120,>$d800+160
  !byte >$d800+200,>$d800+240,>$d800+280,>$d800+320,>$d800+360
   !byte >$d800+400,>$d800+440,>$d800+480,>$d800+520,>$d800+560
    !byte >$d800+600,>$d800+640,>$d800+680,>$d800+720,>$d800+760
     !byte >$d800+800,>$d800+840,>$d800+880,>$d800+920,>$d800+960
         
       
bufferaddressl


  !byte <$4400,<$4400+255,<$4400+510,<$4400+765
  !byte <$4400+1020,<$4400+1275,<$4400+1530,<$4400+1785,<$4400+2040
    !byte <$4400+2295,<$4400+2550,<$4400+2805,<$4400+3060,<$4400+3315,<$4400+3570 
    !byte <$4400+3825,<$4400+4080,<$4400+4335,<$4400+4590,<$4400+4845,<$4400+5100
    !byte <$4400+5355,<$4400+5610,<$4400+5865,<$4400+6120
bufferaddressh


  !byte >$4400,>$4400+255,>$4400+510,>$4400+765
  !byte >$4400+1020,>$4400+1275,>$4400+1530,>$4400+1785,>$4400+2040
    !byte >$4400+2295,>$4400+2550,>$4400+2805,>$4400+3060,>$4400+3315,>$4400+3570 
    !byte >$4400+3825,>$4400+4080,>$4400+4335,>$4400+4590,>$4400+4845,>$4400+5100
    !byte >$4400+5355,>$4400+5610,>$4400+5865,>$4400+6120
    
    
           
buffer2addressl


  !byte <$4400,<$4400+40,<$4400+80,<$4400+120
  !byte <$4400+160,<$4400+200,<$4400+240,<$4400+280,<$4400+320,<$4400+360
  
   !byte <$4400+400,<$4400+440,<$4400+480,<$4400+520,<$4400+560
    !byte <$4400+600,<$4400+640,<$4400+680,<$4400+720,<$4400+760,<$4400+800
    !byte <$4400+840,<$4400+880,<$4400+920,<$4400+960 
buffer2addressh

  !byte >$4400,>$4400+40,>$4400+80,>$4400+120
  !byte >$4400+160,>$4400+200,>$4400+240,>$4400+280,>$4400+320,>$4400+360
  
   !byte >$4400+400,>$4400+440,>$4400+480,>$4400+520,>$4400+560
    !byte >$4400+600,>$4400+640,>$4400+680,>$4400+720,>$4400+760,>$4400+800
    !byte >$4400+840,>$4400+880,>$4400+920,>$4400+960 
    
tblvbaseLo 
!byte <screen,<screen+320,<screen+640,<screen+960
!byte <screen+1280,<screen+1600,<screen+1920,<screen+2240
!byte <screen+2560,<screen+2880,<screen+3200,<screen+3520
!byte <screen+3840,<screen+4160,<screen+4480,<screen+4800
!byte <screen+5120,<screen+5440,<screen+5760,<screen+6080
!byte <screen+6400,<screen+6720,<screen+7040,<screen+7360
!byte <screen+7680,<screen+8000,<screen+8320,<screen+8640
!byte <screen+8960,<screen+9280,<screen+10600,<screen+10920
tblvbaseHi 
!byte >screen,>screen+320,>screen+640,>screen+960
!byte >screen+1280,>screen+1600,>screen+1920,>screen+2240
!byte >screen+2560,>screen+2880,>screen+3200,>screen+3520
!byte >screen+3840,>screen+4160,>screen+4480,>screen+4800
!byte >screen+5120,>screen+5440,>screen+5760,>screen+6080
!byte >screen+6400,>screen+6720,>screen+7040,>screen+7360
!byte >screen+8960,>screen+9280,>screen+10600,>screen+10920
    
 
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
rowstable


  !byte 0,<40,<80,<120
  !byte <160,<200,<240,<280,<320,<360,<400,<440,<480,<520,<560,<600,<640,<680,<720,<760,<800,<840,<880,<920,<960,<1000,<1040
  !byte <1080,<1120,<1160,<1200,<1240,<1280,<1320,<1360,<1400,<1440,<1480,<1520,<1560,<1600,<1640,<1680,<1720,<1760,<1800
  
  
   !byte <$4400+400,<$4400+440,<$4400+480,<$4400+520,<$4400+560
    !byte <$4400+600,<$4400+640,<$4400+680,<$4400+720,<$4400+760,<$4400+800
    !byte <$4400+840,<$4400+880,<$4400+920,<$4400+960 
 !source "sounds.asm"
  !source "012.asm"
    !source "013.asm"

    
    
 *=$4400
screen1 
 
  
 
 !byte  100,100,100,99,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,98,100,100,100 
 !byte  100,100,100,100,100,100,99,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,98,100,100,100,100,100
 !byte  100,100,100,100,100,100,99,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,98,100,100,100,100,100,100 
 !byte 100,100,100,100,100,100,100,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,100,100,100,100,100,100,100,100
 !byte 100,100,100,100,100,100,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,100,100,100,100,100,100,100,100
 !byte 100,100,100,100,100,100,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,100,100,100,100,100,100,100
 !byte 100,100,100,100,100,100,100,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,100,100,100,100,100,100,100
 !byte 100,100,100,100,100,100,100,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,100,100,100,100,100,100
 !byte 100,100,100,100,100,100,100,100,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,100,100,100,100,100,100
 !byte 100,100,100,100,100,100,100,100,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,100,100,100,100,100,100
 !byte 100,100,100,100,100,100,100,100,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,100,100,100,100,100,100
 !byte 100,100,100,100,100,100,100,100,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,100,100,100,100,100,100
 !byte 100,100,100,100,100,100,100,100,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,100,100,100,100,100,100
 !byte 100,100,100,100,100,100,100,100,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,100,100,100,100,100,100 
 !byte 100,100,100,100,100,100,100,100,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,100,100,100,100,100,100
 !byte 100,100,100,100,100,100,100,100,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,100,100,100,100,100,100
 !byte 100,100,100,100,100,100,100,100,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,100,100,100,100,100,100
  !byte 100,100,100,100,100,100,100,100,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,100,100,100,100,100,100,100
 !byte 100,100,100,100,100,100,100,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,100,100,100,100,100,100,100
 !byte  100,100,100,100,100,100,97,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,96,100,100,100,100,100,100 
 !byte   100,100,100,100,100,97,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,96,100,100,100,100,100
 !byte  100,100,100,100,97,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,96,100,100,100,100
 !byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
 !byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
 

flowercan


!byte %00101000
!byte %00010100
!byte %00001000
!byte %00000100
!byte %00000010
!byte %00000111
!byte %00000111
!byte %00000011
flowercan2
 
!byte %01010000
!byte %00101000
!byte %01010000
!byte %01100000
!byte %10000000
!byte %11000000
!byte %11000000
!byte %10000000

flowercan3

!byte %01000100
!byte %00101000
!byte %00010001
!byte %00001010
!byte %00010100
!byte %10001000
!byte %10101000
!byte %01010000

flowercan4

!byte %00100010
!byte %00010100
!byte %00001000
!byte %00001100
!byte %10010010
!byte %01010100
!byte %00111000
!byte %01010000



 
pickups
    !byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32    
 !byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32 
  !byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32 
   !byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32 
    !byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,207,32,32,32,32,32,32,32,32,32,32,32 
     !byte 32,32,32,32,32,32,32,32,32,32,32,32,207,32,32,32,32,32,32,32,32,32,32,32,32,32,32,207,32,32,32,32,32 
      !byte 32,32,32,207,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32 
       !byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32 
        !byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32 
         !byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32 
 

 


  
!byte %00000000
!byte %00111100
!byte %01000010
!byte %10100101
!byte %10000001
!byte %11111111
!byte %00100100
!byte %00011000
     
  !byte %01111100
  !byte %10000010
  !byte %01000100
  !byte %00101000
  !byte %00010000
  !byte %00101000
  !byte %01000100
  !byte %10000010
     
         
  !byte %10011001 
  !byte %01011010 
  !byte %00111100 
  !byte %00011000 
  !byte %00100100 
  !byte %00100100 
  !byte %00011000 
  !byte %00011000 
    
   !byte %10000000
   !byte %01000000
   !byte %00100000
   !byte %00010000
   !byte %00001000
   !byte %00000100
   !byte %00001110
   !byte %00000000
   
   !byte %00100100
   !byte %00100100
   !byte %00100100
   !byte %00100100
   !byte %00100100
   !byte %00100100
   !byte %01011010
   !byte %01011010
   
   *=$5290
   
carchar
!byte %00100000
!byte %00011111
!byte %11101111
!byte %11111001
!byte %11111001
!byte %11110111
!byte %10101010
!byte %00010000

carchar2
!byte %00000100
!byte %11111000
!byte %11110111
!byte %10011111 
!byte %10011111 
!byte %11101111
!byte %01010101
!byte %00001000

carchar3
!byte %00000111
!byte %00000111
!byte %00001111
!byte %00011101
!byte %00011111
!byte %00011111
!byte %00001111
!byte %00000111

carchar4
!byte %11100000
!byte %11100000
!byte %11110000
!byte %01110000
!byte %11111000
!byte %11111000
!byte %11110000
!byte %11100000
   
   
carchar5
!byte %00000000
!byte %00000111
!byte %00001111
!byte %01111101
!byte %11111111
!byte %01111111
!byte %00001111
!byte %00000111

carchar6
!byte %00000000
!byte %11100000
!byte %11110000
!byte %01111110
!byte %11111111
!byte %11111110
!byte %11110000
!byte %11100000
   
carchar7
!byte %00000000
!byte %00000111
!byte %00001000
!byte %01110010
!byte %10010000
!byte %01110000
!byte %00001000
!byte %00000111

carchar8
!byte %00000000
!byte %11100000
!byte %00010000
!byte %01001110
!byte %00001001
!byte %00001110
!byte %00010000
!byte %11100000
   
carchar9
!byte %00000000
!byte %00000111
!byte %00001000
!byte %00010010
!byte %00010010
!byte %00010000
!byte %00001000
!byte %00000111

carchar10
!byte %00000000
!byte %11100000
!byte %00010000
!byte %01001000
!byte %01001000
!byte %00001000
!byte %00010000
!byte %11100000

carchar11
!byte %00000000
!byte %00000111
!byte %00001000
!byte %00010110
!byte %00010011
!byte %00010000
!byte %00001000
!byte %00000111

carchar12
!byte %00000000
!byte %11100000
!byte %00010000
!byte %01101000
!byte %11001000
!byte %00001000
!byte %00010000
!byte %11100000

carchar13
!byte %00100000
!byte %00001111
!byte %01111100
!byte %11111001
!byte %11111001
!byte %01110100
!byte %00111111 
!byte %00000111

carchar14
!byte %00000100
!byte %11110000
!byte %00111110
!byte %10011111 
!byte %10011111 
!byte %00101110
!byte %11111100
!byte %11100000

bgchar1

!byte %11111111
!byte %01111111
!byte %00111111
!byte %00011111
!byte %00001111
!byte %00000111
!byte %00000011
!byte %00000001




bgchar2

!byte %11111111
!byte %11111110
!byte %11111100
!byte %11111000
!byte %11110000
!byte %11100000
!byte %11000000
!byte %10000000


bgchar3

!byte %00000001
!byte %00000011
!byte %00000111
!byte %00001111
!byte %00011111
!byte %00111111
!byte %01111111
!byte %11111111

bgchar4

!byte %10000000
!byte %11000000
!byte %11100000
!byte %11110000
!byte %11111000
!byte %11111100
!byte %11111110
!byte %11111111

bgchar5

!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111


   
*=$3000


spritedata !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00010000,%00000000
           !byte  %00000000,%00001000,%00000000
           !byte  %00000000,%00010000,%00000000
           !byte  %00000000,%00100000,%00000000
           !byte  %00000000,%00010000,%00000000
           !byte  %00000000,%00001000,%00000000
           !byte  %00000000,%00010000,%00000000
           !byte  %00000000,%00100000,%00000000
           !byte  %00000000,%00010000,%00000000
           !byte  %00000000,%00001000,%00000000
           !byte  %00000000,%00010000,%00000000
           !byte  %00000000,%00100000,%00000000
           !byte  %00000000,%00010000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00000000,%00000000
             !byte  %00000000 
         !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00011000,%00000000
           !byte  %00000000,%00011000,%00000000
           !byte  %00000000,%00011000,%00000000
           !byte  %00000000,%01111110,%00000000
           !byte  %00000000,%00100100,%00000000
           !byte  %00000011,%01100110,%11000000
           !byte  %00000111,%10011001,%11100000
           !byte  %00011001,%01100110,%10011000
           !byte  %11111110,%00011000,%01111111
           !byte  %01000000,%00011000,%00000010
           !byte  %00000011,%01111110,%11000000
           !byte  %00000000,%11011011,%00000000
           !byte  %00000000,%10111101,%00000000
           !byte  %00000000,%00111100,%00000000
           !byte  %00000000,%11111111,%00000000
           !byte  %00000000,%11011011,%00000000
           !byte  %00000000,%11100111,%00000000
           !byte  %00000000,%11011011,%00000000
           !byte  %00000000,%10000001,%00000000
           !byte  %00000000,%11000011,%00000000
            !byte  %00000000 
           !byte  %00000000,%00000000,%00000000
           !byte  %00000000,%00011000,%00000000
           !byte  %00000000,%00011000,%00000000
           !byte  %00000000,%00011000,%00000000
           !byte  %00000000,%01111110,%00000000
           !byte  %00000000,%00100100,%00000000
           !byte  %00000011,%01100110,%11000000
           !byte  %00000111,%10011001,%11100000
           !byte  %00011001,%01100110,%10011000
           !byte  %11111110,%00011000,%01111111
           !byte  %01000000,%00011000,%00000010
           !byte  %00000011,%01111110,%11000000
           !byte  %00000000,%11011011,%00000000
           !byte  %00000000,%10111101,%00000000
           !byte  %00000000,%00111100,%00000000
           !byte  %00000000,%11111111,%00000000
           !byte  %00000000,%11011011,%00000000
           !byte  %00000000,%11100111,%00000000
           !byte  %00000000,%11011011,%00000000
           !byte  %00000000,%10000001,%00000000
           !byte  %00000000,%11000011,%00000000
           
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
alienarrayx 
           !byte 2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22,2,7,12,17,22  ,2,7,12,17,22  ,2,7,12,17,22  ,2,7,12,17,22  ,2,7,12,17,22  ,2,7,12,17,22  ,2,7,12,17,22  ,2,7,12,17,22  ,2,7,12,17,22  ,2,7,12,17,22    
alienarrayy
           !byte 1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45     
 
