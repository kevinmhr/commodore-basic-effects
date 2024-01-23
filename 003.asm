!cpu 6510
!to "003.prg",cbm
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
increment2=$46
increment3=$47
buffer= $76
zeropagel = $fe
zeropageh =$ff
chrpages =$82

*=$0801
        !byte    $1E, $08, $0A, $00, $9E, $20, $28,$32, $30, $38, $30, $29, $3a, $8f, $20, $28, $43, $29, $20, $32, $30, $32, $31, $20, $4D, $54, $53, $56, $00, $00, $00
 
*=$820

 



lda $01    
and #251    
sta $01    
 
copyoriginalchartonewlocation
 
sei
lda $d000,x
sta $2000,x
lda $d100,x
sta $2100,x
lda $d200,x
sta $2200,x
lda $d300,x
sta $2300,x
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

lda #15
sta thingposition


lda #1
sta thingpositionh
lda #$44
sta chrpositionh
lda #20
sta chrposition	
lda #0
lda #$20
sta chrpages


sta $d020

sta $d021
lda #$44
sta listcount

lda #$18
sta $d018
copycarcharacter 
ldy #0
copycarcharacterloop
lda carchar,y
sta $2290,y

 
lda carchar2,y
sta $22a0,y
 
iny
cpy #8
 
bne copycarcharacterloop
  jsr fil60   

main
      
         ; lda #$00
 
   

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

mainloop        

 
inc increment
 
 
  
 ;jsr rollingupsidedown
 
  jsr fil60  


 jmp mainloop
 
 
irq

inc chrpages 

     lda chrpages
cmp #$28
beq resetchrpages
  

    

loop
 
 ldx #0
 
 
loop2
 clc
inc zeropagel
 
 
afterresetcount
   

lda listcount
cmp #7
beq resetlistcount
inc listcount


 
lda listcount
adc #$60

sta zeropageh
ldy #1
lda (zeropagel),y
sta buffer



lda listcount
 
sta zeropageh 
 
ldy #1
lda buffer
 adc increment3

 
sta (zeropagel),y
lda listcount

 
 lda chrpages
 
sta zeropageh

 inc increment3
 
lda (zeropagel),y
 
 
 
 
 sta (zeropagel),y

 inc zeropagel
 
 
 sta (zeropagel),y
 inc zeropagel
 
  
 sta (zeropagel),y
 inc zeropagel
 
 
 sta (zeropagel),y
 inc zeropagel

 
  
 sta (zeropagel),y
 inc zeropagel
  
  
 
  
 sta (zeropagel),y
 inc zeropagel
l
 

 sta (zeropagel),y
 inc zeropagel
 
  
 sta (zeropagel),y
 
 iny
 cpy #255
 bne loop 
 
 

 
  
  asl $d019
      asl $d016
         lda $dc0d
         sta $dd0d
        lda #$fa
        sta $d012
  
 
clearsc
; jsr clear4000
    
notclearsc   
    jmp $ea7e
     
        
rti 
resetchrpages
lda #$19
sta chrpages


 jmp main

rts

rts
resetlistcount
lda #3
sta listcount
   jmp $ea7e
     
rts 

inclistcount
inc listcount
lda listcount 
cmp #$48
 ;beq resetlistcount
   jmp $ea7e
     
rts



fil60
ldx #0
fil60l
 inc increment
 
 
lda increment
 
 
sta $6400,x 
sta $6450,x 
sta $6500,x 
sta $6550,x 
sta $6600,x
sta $6650,x
sta $6700,x
sta $6750,x
 
inx
cpx #255
bne fil60l
 


rts
move60to40
 

move60to40l


 
rts
 




incthingposih
clc

lda thingpositionh
cmp #5
beq resetthingpositionh

inc thingpositionh

jmp main
rts
resetthingpositionh
clc
 
clc
lda #1
sta thingpositionh
lda #10

sta thingposition
 
jmp main
rts











 
display
clc
 
lda chrpositionh
sta zeropageh

lda chrposition
sta zeropagel
lda #82
ldy #0
sta (zeropagel),y

lda zeropagel
adc #1
sta zeropagel
lda #84

sta (zeropagel),y

 

lda chrpositionh
cmp #$44
beq putscreen1
cmp #$45
beq putscreen2
cmp #$46
beq putscreen3
cmp #$47
beq putscreen4

rts
putscreen1
ldx chrposition
lda #11
sta $d800,x
lda #11
sta $d801,x

rts
putscreen2
ldx chrposition
lda #11
sta $d900,x
lda #11
sta $d901,x
rts
putscreen3
ldx chrposition
lda #11
sta $da00,x
lda #11
sta $da01,x
rts
putscreen4
ldx chrposition
lda #11
sta $db00,x
lda #11
sta $db01,x
rts


movejoy 
                
             
         
               
               lda $dc00
              and #15
                                
                                cmp #11  
				beq left
                                cmp #10  
				beq leftup
                            

                                  cmp #9  
				beq leftdown 
				cmp #6  
				beq upright
                                   cmp #5 
				beq downright


				cmp #7   
				beq right
				cmp #13   
				beq down
                                cmp #14   
				beq up
				cmp #$6f
                               
           

        
				rts
 
up

sec
lda chrposition

sbc #40
sta chrposition
bcc dechib




rts
leftup
sec
lda chrposition

sbc #41
sta chrposition
bcc dechib





rts
leftdown

clc
lda chrposition

adc #39
sta chrposition
bcs inchib



rts

upright 
sec
lda chrposition

sbc #39
sta chrposition
bcc dechib
rts
downright 
clc
lda chrposition

adc #41
sta chrposition
bcs inchib
rts



down
clc
lda chrposition

adc #40
sta chrposition
bcs inchib


rts

right 
clc
lda chrposition
adc #1
sta chrposition
bcs inchib
rts
left
sec
lda chrposition
sbc #1
sta chrposition
bcc dechib
rts
inchib

lda chrpositionh
cmp #$48
beq resethib
inc chrpositionh

rts
dechib

lda chrpositionh
cmp #$43
beq resethibneg
dec chrpositionh

rts
resethib
lda #$44
sta chrpositionh
rts

resethibneg
lda #$47
sta chrpositionh
rts
clearscr

ldx #0


clearscrloop

 
lda #32
sta $0400,x
sta $0500,x
sta $0600,x
sta $0700,x

inx
cpx #0
bne clearscrloop

rts



 
 
rolling

 

 
 


lda $d012
cmp increment2
 ;bne rolling

 
rts

displaythingcolor

 
 
restforlater
ldx thingposition

lda listcount

cmp #$44
beq putscreenthing1
cmp #$45
beq putscreenthing2
cmp #$46
beq putscreenthing3
cmp #$47
beq putscreenthing4

rts
putscreenthing1
txa
 
lda listcount
sta $d800,x
 
 
rts
putscreenthing2
 
 
 
lda listcount
sta $d900,x
 
 
rts
putscreenthing3
 
 
lda listcount
sta $da00,x
 
 
rts
putscreenthing4
 
 
lda listcount
sta $db00,x

 
rts
rollingupsidedown
 
ldy #0 
rollingupsidedownl
lda increment2
adc #39
sta increment2
 
lda increment2
tax

lda #189
sta $4400,x
sta $4500,x
sta $4600,x
sta $4700,x
 
iny
cpy #0
bne rollingupsidedownl

rts
drawuntoscreen
ldx #0
 ldy #0
 
drawuntoscreenl
 inx



 
lda $4400,y
sta $0400,x
lda $4500,y
sta $0500,x
lda $4600,y
sta $0600,x
lda $4700,y
sta $0700,x
 
iny

 
cpx #0
bne drawuntoscreenl
rts

clear4000

ldy#0

ldx #0
clear4000l

lda #32
sta $4400,x
sta $4500,x
sta $4600,x
sta $4700,x

;lda #8
;sta $d800,x
;sta $d900,x
;sta $da00,x
;sta $db00,x
 
txa
;adc increment2
 adc increment
 
tax


iny
cpy #0
bne clear4000l
rts


rowslist !byte 5,30,55,70,83,116,140,180,200,250,255

numbers !byte 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
numbers2 !byte 40,80,120,160,200,240
sin !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
    !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
    !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
    !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
    !byte 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
    !byte 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
    !byte 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
    !byte 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
    !byte 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
    !byte 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
    !byte 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
    !byte 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
    !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
    !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
    !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
    !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
sin2  
 
!byte 39,39,39,39,39,39,39,39
 !byte 39,39,39,39,39,39,39,39 
!byte 39,39,39,39,39,39,39,39
 !byte 39,39,39,39,39,39,39,39 
 !byte 39,39,39,39,39,39,39,39
 !byte 39,39,39,39,39,39,39,39 
!byte 39,39,39,39,39,39,39,39
 !byte 39,39,39,39,39,39,39,39 
 
 
!byte 40,40,40,40,40,40,40,40
!byte 40,40,40,40,40,40,40,40
!byte 40,40,40,40,40,40,40,40
!byte 40,40,40,40,40,40,40,40
 !byte 40,40,40,40,40,40,40,40
!byte 40,40,40,40,40,40,40,40
!byte 40,40,40,40,40,40,40,40
!byte 40,40,40,40,40,40,40,40

 
 !byte 41,41,41,41,41,41,41,41
  
 !byte 41,41,41,41,41,41,41,41
 !byte 41,41,41,41,41,41,41,41 
 !byte 41,41,41,41,41,41,41,41
 !byte 41,41,41,41,41,41,41,41
  
 !byte 41,41,41,41,41,41,41,41
 !byte 41,41,41,41,41,41,41,41 
 !byte 41,41,41,41,41,41,41,41
 !byte 40,40,40,40,40,40,40,40
!byte 40,40,40,40,40,40,40,40
!byte 40,40,40,40,40,40,40,40
!byte 40,40,40,40,40,40,40,40
!byte 40,40,40,40,40,40,40,40
!byte 40,40,40,40,40,40,40,40
!byte 40,40,40,40,40,40,40,40
!byte 40,40,40,40,40,40,40,40
widening
!byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
!byte 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
!byte 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
!byte 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
!byte 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
!byte 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
!byte 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
!byte 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
!byte 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
!byte 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
!byte 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
!byte 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
!byte 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
!byte 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
!byte 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
!byte 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8


carchar
!byte %00011111
!byte %00100100
!byte %01000100
!byte %11001111
!byte %10000000
!byte %11111111
!byte %00111100
!byte %00011000

carchar2
!byte %11111000
!byte %00100100
!byte %00100110
!byte %11110001
!byte %10000001
!byte %11111111
!byte %00111100
!byte %00011000
