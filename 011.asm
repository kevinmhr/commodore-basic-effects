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
zeropagel2 = $fc
zeropageh2 =$fd
zeropagel = $fe
zeropageh =$ff
rows =$21
columns =$78
xoffset =$20

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
lda #0
sta xoffset
lda #0
sta rows



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
;lda oppbulletchardata,y
;sta $22b0,y
;lda sidebulletchardata,y
;sta $22b8,y
iny
cpy #8
 
bne copycarcharacterloop
clear4000
 

ldx #0
clear4000l
 inc increment
 
lda increment
sta $4400,x
sta $4500,x
sta $4600,x
sta $4700,x

 


inx
cpx #0
bne clear4000l



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
    
 
 
 jmp mainloop
 
 
irq
  

jsr background

 

 
;jsr movejoy
        

 lda rows
 cmp #21
 beq resetrows
 inc rows
 lda xoffset
 cmp #39
 beq resetxoffser
 inc xoffset
 
   ; asl $d019
    
         lda $dc0d
         sta $dd0d
       ;  lda #$fa
      ;  sta $d012
  
 
clearsc
 
    
notclearsc   
    jmp $ea7e
     
        
rti 


background
 


bkloop


clc
ldx rows 
lda bufferaddressl,x
sta zeropagel2

lda bufferaddressh,x
sta zeropageh2 


ldx rows 
lda displayaddressh,x
sta zeropageh 
lda displayaddressl,x

adc xoffset
 
;adc xoffsetindex,x
sta zeropagel
 
ldy #0
loop2



lda (zeropagel2),y
 
sta (zeropagel),y
iny
cpy #39
bne loop2
 
rts
resetxoffser
lda #0
sta xoffset
jmp $ea7e


rts
resetrows
lda #0
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
   
       
       
bufferaddressl


  !byte <$4400,<$4400+40,<$4400+80,<$4400+120
  !byte <$4400+160,<$4400+200,<$4400+240,<$4400+280,<$4400+320
   !byte <$4400+360,<$4400+400,<$4400+440,<$4400+480
    !byte <$4400+520,<$4400+560,<$4400+600,<$4400+640,<$4400+680
     !byte <$4400+720,<$4400+760,<$4400+800,<$4400+840,<$4400+880
       !byte <$4400+920,<$4400+960 
bufferaddressh


  !byte >$4400,>$4400+40,>$4400+80,>$4400+120
  !byte >$4400+160,>$4400+200,>$4400+240,>$4400+280,>$4400+320
   !byte >$4400+360,>$4400+400,>$4400+440,>$4400+480
    !byte >$4400+520,>$4400+560,>$4400+600,>$4400+640,>$4400+680
     !byte >$4400+720,>$4400+760,>$4400+800,>$4400+840,>$4400+880
       !byte >$4400+920,>$4400+960 
 
 


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