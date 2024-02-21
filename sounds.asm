
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
        ; sta $d404     ; wf1
         rts

soundend2
         lda #0
         sta $d40b     ; wf2
         rts

soundend3
         lda #0
         sta $d412     ;wf3
         rts
         
         
tickingsound
         jsr soundend3
         lda #%00001111 ; 0 9
         sta attdec
         lda #%00000111 ; 0 0
         sta susrel
         lda #15        ; 15
         sta volume
      
         lda #130; 12
         sta hifreq
         lda #130      ; 8
         sta lofreq
         lda 15      ; 32 saw
         sta wavefm

         jsr soundgo3
         rts
         
engine
         jsr soundend1
         lda #%00100000 ; 0 9
         sta attdec
         lda #%01100000 ; 0 0
         sta susrel
         lda #15        ; 15
         sta volume
         
           
          lda enginesound
         
         sta hifreq
          lda #5
         sta lofreq
         lda #%00110000       ; 32 saw
         sta wavefm

         jsr soundgo1
          
       
        
         rts

pickupsnd
         jsr soundend2
         lda #%00001001 ; 0 9
         sta attdec
         lda #%00001000 ; 0 0
         sta susrel
         lda #15        ; 15
         sta volume
         lda #100        ; 13
         sta hifreq
         lda #100         ; 9 bit higher
         sta lofreq
         lda #%00110000        ; 32 saw
         sta wavefm

         jsr soundgo2
         rts
lazbeep3
         jsr soundend2
         lda #%00000111 ; 0 9
         sta attdec
         lda #%00000111 ; 0 0
         sta susrel
         lda #15        ; 15
         sta volume
         
        
        lda #30; 13
         sta hifreq
         lda #20   ; 9 bit higher
        
        
         sta lofreq
         lda #32  ; 32 saw
         sta wavefm

         jsr soundgo2
         rts

expnoz
         jsr soundend3
         
         lda #%00000100 ; 1 9
         sta attdec
         lda #%00000011 ; 0 0
         sta susrel
         lda #15        ; 15
         sta volume
         lda increment 
         sta hifreq
         lda  voicefreq   ; 16
         sta lofreq
         lda #128 ; 128 noise
         sta wavefm

         jsr soundgo3
         rts
expnoz2
         jsr soundend3
         
         lda #%00000111 ; 1 9
         sta attdec
         lda #%00000011 ; 0 0
         sta susrel
         lda #15        ; 15
         sta volume
         lda #$15  
         sta hifreq
         lda #$25 ; 16
         sta lofreq
         lda #15 ; 128 noise
         sta wavefm

         jsr soundgo3
         rts
     ;      lda #0
        ; sta $d404     ; wf1
         ;     lda #0
       ;  sta $d40b     ; wf2
       

 
        ; lda #0
      ;   sta $d412     
         

