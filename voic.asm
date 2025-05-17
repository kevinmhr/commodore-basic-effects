!cpu 6510
!to "voic.prg",cbm
 
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

*=$0801
        !byte    $1E, $08, $0A, $00, $9E, $20, $28,$32, $30, $38, $30, $29, $3a, $8f, $20, $28, $43, $29, $20, $32, $30, $32, $31, $20, $4D, $54, $53, $56, $00, $00, $00
 
*=$820
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
ldx #0
zeroy

ldy #0

jsr soundend1


 
jsr soundend2
incinc2




 
 
 
lda lofreq
 
and #%00001111
sta lofreq

jsr soundgo2
jsr soundend2
 
 

lda #1
sta susrel
lda #1
sta attdec

jsr soundgo2

;sbc #150
 

lda #1
sta susrel
lda #1
sta attdec
 


lda #0
sta inc2
inc biting
iny
resetpitch

 
resety 
 

lda #200
 sta susrel
jsr soundgo1



inc inc2
lda inc2
cmp #5
beq incinc2
lda #0
sta incr


  inc pitching
 
 


timeloop2
  lda #16
sta wavefm
inc pitching3
  

inc incr
lda incr

 
cmp #30
beq resety
attack
lda #100
sta attdec
inc pitching2
lda #0
sta attdecinc 

main

inc attdecinc
 


lda attdecinc
cmp #50
beq timeloop2



 


lda #255

sta volume

 
cpy #30
beq zeroy 

 lda bits,y
 
 
 

eor pitching

 
ora bits,y
 eor pitching3
 bit biting

 
 eor wavebit
 
 and #%00011111

sta lofreq
 inc wavebit
  
 sta $060a,y
  sta $da0a,y
 
 
 
 
lda pitching2
;lda #10
 

 

 


 
 






  






jmp main
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
 
bits !byte 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30