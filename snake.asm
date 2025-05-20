!cpu 6510
!to "snake.prg",cbm
 
wavefm   =$36
attdec   =$31
susrel   =$32
volume   =$33
hifreq   =$34
lofreq   =$35
attdecinc =$71
voicefreq = $31
pitching =$73
pitching2 =$74
pitching3 =$77
biting =$75
incr =$72
inc2 =$78
wavebit =$79
charposition= $81
charsymb=$82
charpage =$83
pickupl=$84
pickuph=$85
pickupchar=$86
lenght = $88
direction= $87
charpositionbuf= $4000
charpagebuf= $4100
soundstart=$90

*=$0801
        !byte    $1E, $08, $0A, $00, $9E, $20, $28,$32, $30, $38, $30, $29, $3a, $8f, $20, $28, $43, $29, $20, $32, $30, $32, $31, $20, $4D, $54, $53, $56, $00, $00, $00
 
*=$820
init
lda #251
sta pickupchar
ldx #0
ldy #40
bitsfilling
inx
iny
txa
sta bits,x
cpx #255
bne bitsfilling


lda #0
sta pickupl
sta soundstart
lda #5
sta pickuph
lda #8
sta lenght
 
lda #5

sta charpage
lda #12
sta charsymb
lda #50
sta charposition
lda #0

sta $d020
sta $d021
ldx#0
clearscreen
inx
lda #32
sta $0400,x
sta $0500,x
sta $0600,x
sta $0700,x

cpx #255
bne clearscreen








zeroy

;ldy #0


incinc2 

 
resety 
  jsr soundend1
lda #0
sta incr 
lda #0
sta soundstart

timeloop2
lda #0
sta attdecinc

 lda #100

sta lofreq
 
lda soundstart
cmp #1
beq soundplay


afterplay

  inc incr
 lda incr

 cmp #5

 

 beq resety
jsr collision

jsr movejoy
jsr pickup

main
 
ldx #0

drawbkgx
lda #109
sta $0400,x
sta $0798,x
inx
cpx #40
bne drawbkgx
ldx #0
drawbkgy
clc
lda #109
sta $0400,x
sta $04f0,x
 sta $05e0,x
 sta $06d0,x
txa
adc #39
tay
lda #109
sta $0400,y
sta $04f0,y
 sta $05e0,y
 sta $06d0,y
 
txa

adc #40
tax
cpx #240
bne drawbkgy

 ldx #0

 inc attdecinc
lda attdecinc
cmp #50
beq timeloop2
 

 

jmp main
soundplay

lda #1
sta attdec
lda #24
sta volume  
lda #16
sta wavefm
 lda #200
  sta susrel
 
 jsr soundgo1
 
jmp afterplay
 
lda #0
sta soundstart

movejoy 
                
             
 
               
              
               ;cmp #$6f
              ; beq shoot  
               
              ; and #15
                                
             ; cmp #10  
				;beq leftup
                            

               ; cmp #9  
				;beq leftdown 
              ; cmp #6  
				;beq upright
             ;                      cmp #5 
				;beq downright

                        lda $dc00
                         and #15
                        
                        cmp #11  
		            beq moveleft
                        cmp #7   
				beq moveright
				cmp #13   
				beq movedown
                        cmp #14   
				beq moveup
				     
            lda direction
cmp #1
beq up
cmp #2
beq down
cmp #3
beq left
cmp #4
beq right

        
				rts
moveup
lda #1
sta direction
rts
movedown
lda #2
sta direction
rts
moveleft
lda #3
sta direction
rts
moveright
lda #4
sta direction
rts
up

 
 
sec
lda charposition
sbc #40
sta charposition

bcc decpage

jsr addtoscreen
 

rts
decpage 
lda charpage
sbc #0
sta charpage
lda charpage
cmp #3
beq gettopage7
jsr addtoscreen

rts
gettopage7
lda #7
sta charpage
 


rts


down


clc
lda charposition
adc #40
sta charposition

bcs incpage

jsr addtoscreen
 

rts
incpage

lda charpage
adc #0
sta charpage
 
lda charpage
cmp #8
beq gettopage4
jsr addtoscreen

rts


gettopage4
lda #4
sta charpage
 
rts




left
sec
lda charposition
sbc #1

sta charposition
bcc decpage 

jsr addtoscreen

 
rts

right 
clc
lda charposition
adc #1

sta charposition
bcs incpage
jsr addtoscreen
 
rts
page4p
ldy charpositionbuf,x
 
lda #32
sta $0400,y
rts
page5p
ldy charpositionbuf,x
 
lda #32
sta $0500,y
rts
page6p
ldy charpositionbuf,x
 
lda #32
sta $0600,y
rts
page7p
ldy charpositionbuf,x
 
lda #32
sta $0700,y
rts

addtoscreen
 jsr putchar


lda charpage
sta charpagebuf
lda charposition
sta charpositionbuf
ldy lenght 
 
addtoscl
dey
dey
lda charpositionbuf,y
iny
iny
sta charpositionbuf,y
dey
dey
cpy #0
bne addtoscl

ldy lenght 

addtosch
dey
dey
lda charpagebuf,y
iny
iny
sta charpagebuf,y
dey
dey
cpy #0
bne addtosch
 
 jsr charclean
rts
putchar
ldx lenght
dex
dex
lda #32
ldy charpagebuf,x 
cpy #4
beq page4p
cpy #5
beq page5p
cpy #6
beq page6p
cpy #7
beq page7p
rts
charclean

ldx charposition
lda #250
sta charsymb
ldy charpage 
cpy #4
beq page4n
cpy #5
beq page5n
cpy #6
beq page6n
cpy #7
beq page7n
lda #0
 
rts
page4n
lda charsymb
sta $0400,x
 
rts
page5n
lda charsymb
sta $0500,x
 
rts
page6n
lda charsymb
sta $0600,x
 
rts
page7n
lda charsymb
sta $0700,x
 
rts



soundgo1
         lda attdec
         sta $d405
         lda susrel
         sta $d406
         lda volume
         sta $d418
         lda hifreq
         sta $d400
         lda lofreq
         sta $d401
         ldx wavefm
         inx
         txa
         sta $d404
       
         rts

soundgo2
         lda attdec
         sta $d40c
         lda susrel
         sta $d40d
         lda volume
         sta $d418
         lda hifreq
         sta $d407
         lda lofreq
         sta $d408
         ldx wavefm
         inx
         txa
         sta $d40b
       
        
        rts

soundgo3
         lda attdec
         sta $d413
         lda susrel
         sta $d414
         lda volume
         sta $d418
         lda hifreq
         sta $d40e
         lda lofreq
         sta $d40f
         ldy wavefm
         iny
         tya
         sta $d412
         rts

soundend1
         lda #0 
 sta $d404     ; wf1
         rts

soundend2
         lda #0
         sta $d40b     ; wf2
         rts

soundend3
         lda #0
         sta $d412     ;wf3
         rts


collision
ldy charpage
cpy #4
beq colpg4
cpy #5
beq colpg5
cpy #6
beq colpg6
cpy #7
beq colpg7
rts
colpg4
ldx charposition
lda $0400,x
cmp pickupchar
beq increaselenght
cmp #109
beq gotoinit
rts
colpg5
ldx charposition
lda $0500,x
cmp pickupchar
beq increaselenght
cmp #109
beq gotoinit
rts
colpg6
ldx charposition
lda $0600,x
cmp pickupchar
beq increaselenght
cmp #109
beq gotoinit
rts
colpg7
ldx charposition
lda $0700,x
cmp pickupchar
beq increaselenght
 
cmp #109
beq gotoinit
rts
gotoinit
jsr init
rts
increaselenght
inc lenght
inc lenght
 
clc 
 
lda pickupl
bcs addpickuph 
lda #1
sta soundstart
 
rts
addpickuph
inc pickuph
lda pickuph
cmp #8
beq resetpickuph
rts
resetpickuph
lda #4
sta pickuph

rts


pickup
ldx pickupl
ldy pickuph
 
cpy #4
beq pickuppg4
cpy #5
beq pickuppg5
cpy #6
beq pickuppg6
cpy #7
beq pickuppg7

rts
pickuppg4
lda pickupchar
sta $0400,x
rts
pickuppg5
lda pickupchar
sta $0500,x
rts
pickuppg6
lda pickupchar
sta $0600,x
rts
pickuppg7
lda pickupchar
sta $0700,x
rts
 
bits !byte 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,33,34,35,36
