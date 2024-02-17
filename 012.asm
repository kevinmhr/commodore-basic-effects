 

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
lda #80
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
