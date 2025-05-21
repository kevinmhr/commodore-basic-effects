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
charposition=$81
charsymb=$82
charhsymb=$92
 
charpage =$83
pickupl=$5201
pickuph=$5200
pickupltemp =$89
pickupchar=$86
lenght = $88
lenght2= $95
direction= $87
charpositionbuf= $5000
charpagebuf= $5100
wallchar=$94
wallcolor=$102
 charcolor=$103
soundstart=$90
pickupcolor=$93
*=$0801
        !byte    $1E, $08, $0A, $00, $9E, $20, $28,$32, $30, $38, $30, $29, $3a, $8f, $20, $28, $43, $29, $20, $32, $30, $32, $31, $20, $4D, $54, $53, $56, $00, $00, $00
 
*=$820
init
init2
lda #251
sta pickupchar
 
lda #241
sta wallchar
lda #8
sta wallcolor
lda #3
sta pickupcolor
lda #0
sta pickupl
lda #30
sta pickupltemp
lda #0
sta soundstart
lda #2
sta pickuph
 
lda #8
sta lenght
 
lda #5

sta charpage
;lda #5

;sta charpagebuf
lda #253
sta charsymb
lda #230
sta charcolor
lda #50
sta charposition

;lda #50
;sta charpositionbuf
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
 
 
cpx #0
bne clearscreen
 
 



zeroy

;ldy #0


incinc2 

 
resety 
 lda lenght
cmp #250
beq clearagain
 
 
 jsr soundend1



lda #0
sta incr 

jsr movejoy

jsr pickup



inc pitching3
jsr drawframe

timeloop2



lda #0
sta attdecinc
  inc incr
 lda incr

 cmp #50
beq resety



 

 



main


 

 inc attdecinc
lda attdecinc
cmp #50
beq timeloop2



 inc biting

jmp main
rts
clearagain
jsr init2
rts

drawframe
ldx #0

drawbkgx
lda wallchar
sta $0400,x
sta $07c0,x
lda wallcolor
sta $d800,x
sta $dbc0,x



inx
cpx #40
bne drawbkgx
ldx #0
drawbkgy
clc
lda wallchar
sta $0400,x
sta $04f0,x
 sta $05e0,x
 sta $06d0,x
lda wallcolor
sta $d800,x
sta $d8f0,x
 sta $d9e0,x
 sta $dad0,x


txa
adc #39
tay
lda wallchar
sta $0400,y
sta $04f0,y
 sta $05e0,y
 sta $06d0,y
 lda wallcolor
sta $d800,y
sta $d8f0,y
 sta $d9e0,y
 sta $dad0,y
txa

adc #40
tax
cpx #240
bne drawbkgy
 
rts


soundplay


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
aftermove
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
jsr aftermove
rts
movedown
lda #2
sta direction
jsr aftermove
rts
moveleft
lda #3
sta direction
jsr aftermove
rts
moveright
lda #4
sta direction
jsr aftermove
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


page4n
ldy charpositionbuf,x
 
lda #32
sta $0400,y
rts
page5n
ldy charpositionbuf,x
 
lda #32
sta $0500,y
rts
page6n
ldy charpositionbuf,x
 
lda #32
sta $0600,y
rts
page7n
ldy charpositionbuf,x
 
lda #32
sta $0700,y
rts

addtoscreen
jsr collision

 jsr charclear


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
 
 jsr putchar
rts
charclear
ldx lenght
 
dex
dex
lda #32
ldy charpagebuf,x 
cpy #4
beq page4n
cpy #5
beq page5n
cpy #6
beq page6n
cpy #7
beq page7n
rts
putchar

ldx charposition
 
ldy charpage 
cpy #4
beq page4p
cpy #5
beq page5p
cpy #6
beq page6p
cpy #7
beq page7p
lda #0
 
rts
page4p
lda charsymb
sta $0400,x
lda charcolor
 sta $d800,x
rts
page5p
lda charsymb
sta $0500,x
lda charcolor
sta $d900,x
 
rts
page6p
lda charsymb
sta $0600,x
lda charcolor
sta $da00,x
 
rts
page7p
lda charsymb
sta $0700,x
lda charcolor
sta $db00,x
 
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
cmp wallchar
beq gotoinit
cmp charsymb
beq gotoinit
rts




colpg5
ldx charposition
lda $0500,x
cmp pickupchar
beq increaselenght
cmp wallchar
beq gotoinit
 cmp charsymb
beq gotoinit
 
rts
colpg6
ldx charposition
lda $0600,x
cmp pickupchar
beq increaselenght
cmp wallchar
beq gotoinit
  cmp charsymb
beq gotoinit
 
 
rts
colpg7
ldx charposition
lda $0700,x
cmp pickupchar
beq increaselenght
cmp wallchar
beq gotoinit
  cmp charsymb
beq gotoinit
 
rts
gotoinit
jsr init
rts
increaselenght

inc lenght
inc lenght
 

regenpickup
 
jsr addpickuph
 
lda pickupl
adc biting

and #%01111110
sta pickupl

jsr pickupcollisioncheck
inc pickupchar

lda #100
sta lofreq
 lda #10
sta attdec
lda #24
sta volume  
lda #16
sta wavefm
 lda #100
  sta susrel

 jsr soundgo1 
rts
pickupcollisioncheck
lda pickupl
cmp #255
;beq regenpickup 
lda pickupl
cmp #0
 
;beq regenpickup
lda pickuph
cmp #1
beq pickupwallcolli4
cmp #2
beq pickupwallcolli5
cmp #3
beq pickupwallcolli6
cmp #4
beq pickupwallcolli7

rts
pickupwallcolli4
ldx pickupl
lda $0400,x
cmp wallchar
beq regenpickup
 
rts
pickupwallcolli5
ldx pickupl
lda $0500,x
cmp wallchar
beq regenpickup
 
rts
pickupwallcolli6
ldx pickupl
lda $0600,x
cmp wallchar
beq regenpickup
 
rts
pickupwallcolli7
ldx pickupl
lda $0700,x
cmp wallchar
beq regenpickup

rts






addpickuph
inc pickuph
lda pickuph
cmp #5
beq resetpickuph

rts
resetpickuph
lda #1
sta pickuph
 
rts


pickup
ldx pickupl
ldy pickuph
 
cpy #1
beq pickuppg4
cpy #2
beq pickuppg5
cpy #3
beq pickuppg6
cpy #4
beq pickuppg7

rts
pickuppg4
lda pickupchar
sta $0400,x
lda pickupcolor
sta $d800,x
rts
pickuppg5
lda pickupchar
sta $0500,x
lda pickupcolor
sta $d900,x
rts
pickuppg6
lda pickupchar
sta $0600,x
lda pickupcolor
sta $da00,x
rts
pickuppg7
lda pickupchar
sta $0700,x
lda pickupcolor
sta $db00,x
rts
 
 
 

gotoinit2
jsr init
rts
 

 
bits !byte 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,33,34,35,36
