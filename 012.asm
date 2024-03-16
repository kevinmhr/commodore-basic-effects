




drawlinespg2


lda #0
sta worldy
drawxlinepg2loop



lda #105
sta xstart
lda #220
sta xlength

lda #166
sta worldchar

jsr drawxlinepg2

inc worldy
lda worldy
cmp #17
bne drawxlinepg2loop


rts








drawlines


lda #0
sta worldy
drawxlineloop

         
lda #60
sta xstart
lda #80
sta xlength

lda #166
sta worldchar

jsr drawxline

 
lda #166
sta worldchar


lda #80
sta xstart
lda #140
sta xlength
lda #210
sta worldchar
jsr drawxline 
lda #140
sta xstart
lda #200
sta xlength
lda #217
sta worldchar
jsr drawxline 
lda #200
sta xstart
lda #250
sta xlength
lda #223
sta worldchar
jsr drawxline 
inc worldy
lda worldy
cmp #17
bne drawxlineloop


rts

erasure

ldx #0

erasurel

lda displayaddressl,x
sta zeropagel

lda displayaddressh,x
sta zeropageh
ldy #0

erasurel2
lda #32
sta (zeropagel),y
 
  iny
 cpy #39
 bne erasurel2
inx
cpx #16
bne erasurel

rts
 
 
column1rout
ldx #0
lda #0
sta columncount
checky2


clc




ldy columncount
ldx alienarrayy,y
lda #2
adc character1xpos
sta arraypoints
jsr character1lp
inc columncount
lda columncount
cmp #6
bne checky2


rts

column2rout

ldx #0
lda #0
sta columncount

checky3

clc
ldy columncount

lda #7
ldx alienarrayy,y
adc character1xpos
sta arraypoints
jsr character1lp
inc columncount
lda columncount
cmp #6
bne checky3
rts


column3rout
ldx #0

lda #0
sta columncount
checky4

clc
ldy columncount

lda #12
ldx alienarrayy,y
adc character1xpos
sta arraypoints
jsr character1lp
inc columncount
lda columncount
cmp #6
bne checky4
rts



column4rout
ldx #0
lda #0
sta columncount

checky5

clc
ldy columncount

lda #17
ldx alienarrayy,y
adc character1xpos
sta arraypoints
jsr character1lp
inc columncount
lda columncount
cmp #6
bne checky5

rts
column5rout
ldx #0

lda #0
sta columncount
checky6
ldy columncount

ldx alienarrayy,y
clc
lda #22

adc character1xpos
sta arraypoints
jsr character1lp
inc columncount
lda columncount
cmp #6
bne checky6
 
 

rts
character1lp





 

 
;lda alienarrayy,x
;tax

  

clc


ldy arraypoints
lda displayaddressl,x
sta zeropagel

lda displayaddressh,x
sta zeropageh
 

lda #82
sta (zeropagel),y
 

 tya
  adc #1
 tay
lda #84
sta (zeropagel),y

lda coloraddressl,x
sta zeropagel

lda coloraddressh,x
sta zeropageh


 

lda #222
sta (zeropagel),y
 tya
  adc #1
 tay
 
 

lda #223
sta (zeropagel),y
 
 
rts
charater1trigger 
lda #0
sta character1trigger

rts
charater1triggerback 
lda #1
sta character1trigger

rts

 

character1backward

lda character1xpos
cmp #1
beq charater1trigger 

dec character1xpos
jsr backtoroutinecheck
 
rts

character1forward
 
lda character1trigger
cmp #1
 beq character1backward
lda character1xpos
cmp #15
beq charater1triggerback
inc character1xpos
jsr backtoroutinecheck

rts
drawxline
ldx worldy
ldy xstart
drawxlinelp
lda bufferaddressl,x
sta zeropagel

lda bufferaddressh,x
sta zeropageh

lda worldchar
sta (zeropagel),y
 
 
iny
cpy xlength
bne drawxlinelp

rts
drawxlinepg2
ldx worldy
ldy xstart
drawxlinepg2lp
lda bufferaddressl,x
sta zeropagel
clc
lda bufferaddressh,x
adc #$17
sta zeropageh

lda worldchar
sta (zeropagel),y
 
 
iny
cpy xlength
bne drawxlinepg2lp

rts
 
drawpattern
ldx worldy
 
drawpatternlp



lda bufferaddressl,x
sta zeropagel

lda bufferaddressh,x
sta zeropageh

 
lda worldchar
sta (zeropagel),y
lda zeropagel
adc worldwidth
sta zeropagel

inx
cpx length
bne drawpatternlp
 

rts

drawpatternlist 

lda #0
sta worldy
lda #60
sta xstart
lda #250
sta xlength
 lda #212
 sta worldchar
 
 jsr drawxline
 lda #5
 sta worldy
  lda #223
 sta worldchar
 jsr drawxline
  lda #10
 sta worldy
 jsr drawxline
 
 
 
   lda #1
 sta worldy
lda #5
sta worldwidth
lda #199
sta worldchar
ldy #60
lda #10
sta length
ldy #181

jsr drawpattern
ldy #170

jsr drawpattern

lda #10
sta worldy
lda #211
sta worldchar

lda #15
sta length
ldy #110

jsr drawpattern
ldy #111

jsr drawpattern
ldy #112

jsr drawpattern
ldy #113

jsr drawpattern

lda #206
sta worldchar

lda #15
sta length
ldy #120

jsr drawpattern
ldy #121

jsr drawpattern
ldy #122

jsr drawpattern
ldy #123

jsr drawpattern
lda #207
sta worldchar

lda #15
sta length
ldy #130

jsr drawpattern
ldy #131

jsr drawpattern
ldy #132

jsr drawpattern
ldy #133

jsr drawpattern
lda #209
sta worldchar

lda #15
sta length
ldy #140

jsr drawpattern
ldy #141

jsr drawpattern
ldy #142

jsr drawpattern
ldy #143

jsr drawpattern

lda #210
sta worldchar

lda #15
sta length
ldy #150

jsr drawpattern
ldy #151

jsr drawpattern
ldy #152

jsr drawpattern
ldy #153

jsr drawpattern
 jsr drawbk 
 

 rts
 
 

 

 













  
 
