drawlines


lda #0
sta worldy
drawxlineloop

         
lda #60
sta xstart
lda #80
sta xlength
lda #209
sta worldchar


jsr drawxline 
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
lda #218
sta worldchar
jsr drawxline 
inc worldy
lda worldy
cmp #17
bne drawxlineloop


rts
character1
ldy #0
erase24lp
ldx #24
lda displayaddressl,x
sta zeropagel

lda displayaddressh,x
sta zeropageh
lda #32
sta (zeropagel),y
iny
cpy #40
bne erase24lp
character1lp
jsr character1forward

backtoroutinecheck
clc
ldx #24

lda displayaddressl,x
sta zeropagel

lda displayaddressh,x
sta zeropageh


ldy character1xpos

lda #82
sta (zeropagel),y
 
 ldy character1xpos
 tya
 adc #1
tay
lda #84
sta (zeropagel),y

lda coloraddressl,x
sta zeropagel

lda coloraddressh,x
sta zeropageh


ldy character1xpos

lda #222
sta (zeropagel),y
 
  ldy character1xpos
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
cmp #0
beq charater1trigger 

dec character1xpos
jsr backtoroutinecheck
 
rts

character1forward
 
lda character1trigger
cmp #1
 beq character1backward
lda character1xpos
cmp #40
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
lda #170
sta xlength
 lda #210
 sta worldchar
 
 jsr drawxline
 lda #5
 sta worldy
  lda #216
 sta worldchar
 jsr drawxline
  lda #10
 sta worldy
 jsr drawxline
 
 
 
 
lda #5
sta worldwidth
lda #209
sta worldchar
ldy #80
lda #20
sta length
ldy #181

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
 
 

 

 
  
 
