
resetspriteindex22
lda #128
sta spriteindex2


jsr sprites

rts
resetspriteindex2
lda #134
sta spriteindex2


jsr sprites

rts
resetspriteindex3
lda #134
sta spriteindex3


jsr sprites

rts

resetspriteindex4
lda #0
sta spriteindex4

rts
resetspritecount
lda #0
sta spritecount
jsr sprites
rts


sprites
 
   lda spriteindex2
 ;lda #193
 sta $7f8 
lda #192
sta $7f9
   lda #148
  sta $7fa
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
   


 
 

ldy #0
spritesloop
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

  
 
 
bne spritesloop
 
 
 
 rts
resetspriteindex
lda #0
sta spriteindex

jmp $ea7e

rts



changechar
  lda spriteindex
 cmp #16
 beq resetspriteindex

  lda spriteindex
  adc #2
  sta spriteindex

jsr spritesloop
rts


resetspriteleft
lda #135
sta spriteindex2
jsr sprites

 

rts



shootlogic



 


lda shoottrigger
cmp #1
beq shootstandby
lda $d003
cmp #1
beq shootoff 
lda $d003
cmp #0
beq shootoff 
lda $d003
cmp #2
beq shootoff 
lda $d003
cmp #3
beq shootoff 
lda $d003
cmp #4
beq shootoff 
lda $d003
cmp #255
beq shootoff 
dec $d003
dec $d003
dec $d003
dec $d003
dec $d003
dec $d003
dec $d003
 
jsr collisionmain

rts

 

 
shootoff
lda #1
sta shoottrigger
 
rts
shootstandby

lda $d000
 sta $d002
lda $d001
 sta $d003
jsr bypassshoot
rts  
 


 
shoot 

lda #0
sta shoottrigger
jsr tickingsound
rts
 

stopcarl
lda #115
;sta chrposition
ldx #0
lda #6
sta $d000,x

;dec xoffset
;jsr drawbk
 ;jsr storefromleft
rts

down
clc
 lda chrpositionh
adc #1
sta chrpositionh
 ldx #0
 

lda $d001,x
adc #3
sta $d001,x

rts
resetspriteright
lda #128
sta spriteindex2
 


left
 lda #194
sta spriteindex2
sec

 
 ;cmp #140
 ;beq resetspriteleft
 
 
 
  ; lda spriteindex2
  ;adc #1
  
  lda chrposition
 ; sta spriteindex2
 

 
 ldx #0
 
 
lda $d000,x
sbc #1
sta $d000,x
 bcc extendedleft
 

 
lda xoffset
sbc #1
sta xoffset

ldx #0
 
 lda $d000,x
cmp #5
;beq stopcarl





inc enginesound
inc enginesound
lda chrposition
cmp #115
;beq stopcarl

sec
lda chrposition
sbc #1
sta chrposition
bcc dechib


;jsr drawbk

storefromleft 
rts

movejoy 
                
             
 
               
               lda $dc00
                 cmp #$6f
                      beq shoot  
               
              and #15
                                
                                cmp #11  
				beq left
                                cmp #10  
				;beq leftup
                            

                                  cmp #9  
				;beq leftdown 
				cmp #6  
				;beq upright
             ;                      cmp #5 
				;beq downright


				cmp #7   
				beq right
				cmp #13   
				;beq down
                                cmp #14   
			;	beq up
				     
           

        
				rts

up
;lda chrpositionh
;cmp #0
;beq resetchrpositionh
;lda chrpositionh
;sbc #1
;sta chrpositionh
;lda chrposition
;adc #16
;sta chrposition
;jsr drawbk
 ldx #0
 
lda $d001,x
sbc #3
sta $d001,x
rts


rts
resetchrpositionh
lda #20
sta chrpositionh
;jsr drawbk
rts
leftup
 
jsr left
jsr up



rts
leftdown
 
jsr left
jsr down

rts

upright 
jsr up
jsr right
rts
downright 
jsr down
jsr right
rts
extendedleft
lda $d010
cmp #%00000011
beq extendleft

lda #%00000001
sta $d010
jsr left
rts

dechib

lda chrpositionh
cmp #$03
beq resethibneg
dec chrpositionh

rts
right 

 clc
 

 
 
 ;;lda spriteindex2
 ;bcs resetspriteright
 ;cmp #134
 ;beq resetspriteright

 ;lda spriteindex2
 ; adc #1
 ; sta spriteindex2
   lda #193
  sta spriteindex2
 
 ldx #0

lda $d000,x
adc #1
sta $d000,x
 bcs extendedright
 ldx #0
 
 lda $d000,x
 cmp #160
 ;beq stopcarr





inc enginesound
inc enginesound

lda chrposition
cmp #130
;beq stopcarr




clc
lda xoffset
adc #1
sta xoffset
lda chrposition
adc #1
sta chrposition
bcs inchib


;jsr drawbk

 

rts




extendedright
lda #%00000011
sta $d010
jsr right
rts

extendleft

 lda #194
sta spriteindex2

lda #%00000000
sta $d010
jsr left
rts
 

jmp sprites 
rts






stopcarr
;lda #130
;sta chrposition

;jsr drawbk
lda #159
sta $d000,x

inc xoffset
;jsr drawbk

rts
inchib

lda chrpositionh
cmp #$08
beq resethib
inc chrpositionh

rts

resethib
lda #$04
sta chrpositionh
rts

resethibneg
lda #$07
sta chrpositionh
rts



collisionmain
lda #2
adc character1xpostemp
sta arraypoints
jsr collided1
lda #7
adc character1xpostemp
sta arraypoints
jsr collided2
lda #12
adc character1xpostemp
sta arraypoints
jsr collided3
lda #17
adc character1xpostemp
sta arraypoints
jsr collided4
lda #22
adc character1xpostemp
sta arraypoints
jsr collided5
lda #3
adc character1xpostemp
sta arraypoints
jsr collided1
lda #8
adc character1xpostemp
sta arraypoints
jsr collided2
lda #13
adc character1xpostemp
sta arraypoints
jsr collided3
lda #18
adc character1xpostemp
sta arraypoints
jsr collided4
lda #23
adc character1xpostemp
sta arraypoints
jsr collided5

jsr resetcolumns

bypassshoot
rts







 



