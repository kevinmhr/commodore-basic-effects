




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
 
 lda coloraddressl,x

 sta zeropagel3

 lda coloraddressh,x
 
 sta zeropageh3
 lda buffer2addressl,x

 sta zeropagel2

 lda buffer2addressh,x
 
 sta zeropageh2 
;lda zeropagel2
;adc #100 
;sta zeropagel2


lda displayaddressl,x
sta zeropagel

lda displayaddressh,x
sta zeropageh
ldy #0

erasurel2
lda (zeropagel2),y
;lda #32
sta (zeropagel),y
  lda #2
sta (zeropagel3),y
  iny
 cpy #39
 bne erasurel2
inx
cpx #24
bne erasurel




rts

 
column1rout
ldx #0
lda #0
 

sta columncount
checky2
 
jsr resetcharacters

clc



ldy columncount
ldx alienarrayy,y
 
 
 

lda #2
adc character1xpos

sta arraypoints
 
 
jsr character1lp
inc columncount
lda columncount
cmp column1
bne checky2


rts
collided1
ldy column1

lda $d003

lsr
lsr
lsr
 
 

cmp alienarrayy,y


beq collided11
rts
collided11
lda $d002
lsr
lsr
lsr
 
 
cmp arraypoints
beq collided111
rts
collided111
jsr collisionburst

lda $d000
 sta $d002
lda $d001
 sta $d003
lda #1
sta shoottrigger

dec column1
jsr pickupsnd
 
rts

column2rout

ldx #0
lda #0
sta columncount

checky3
 jsr resetcharacters
clc
ldy columncount

lda #7
ldx alienarrayy,y
adc character1xpos
sta arraypoints
 
 
jsr character2lp
inc columncount
lda columncount
cmp column2
bne checky3
rts
collided2

ldy column2
lda $d003

lsr
lsr
lsr
 

cmp alienarrayy,y


beq collided12
rts
collided12


lda $d002
lsr
lsr
lsr
 
cmp arraypoints
beq collided122
rts
collided122
jsr collisionburst
lda $d000
 sta $d002
lda $d001
 sta $d003

lda #1
sta shoottrigger
dec column2
jsr pickupsnd
 
rts



 

column3rout
ldx #0

lda #0
sta columncount
checky4
 jsr resetcharacters
clc
ldy columncount

lda #12
ldx alienarrayy,y
adc character1xpos
sta arraypoints
 
jsr character3lp
inc columncount
lda columncount
cmp column3
bne checky4
rts
collided3

ldy column3
lda $d003

lsr
lsr
lsr
 
cmp alienarrayy,y


beq collided13
rts
collided13
lda $d002
lsr
lsr
lsr
 
cmp arraypoints
beq collided133
rts
collided133
jsr collisionburst
lda $d000
 sta $d002
lda $d001
 sta $d003
lda #1
sta shoottrigger
dec column3
jsr pickupsnd
 
rts


column4rout
ldx #0
lda #0
sta columncount
 
checky5
jsr resetcharacters
clc
ldy columncount

lda #17
ldx alienarrayy,y
adc character1xpos
sta arraypoints
 
jsr character4lp
inc columncount
lda columncount
cmp column4
bne checky5

rts
collided4
ldy column4

lda $d003

lsr
lsr
lsr
 

cmp alienarrayy,y


beq collided14
rts
collided14
lda $d002
lsr
lsr
lsr
 
cmp arraypoints
beq collided144
rts
collided144
jsr collisionburst
lda $d000
 sta $d002
lda $d001
 sta $d003

dec column4
lda #1
sta shoottrigger
jsr pickupsnd
 

rts

column5rout
ldx #0

lda #0
sta columncount
checky6
 jsr resetcharacters

ldy columncount

ldx alienarrayy,y
clc
lda #22

adc character1xpos
sta arraypoints
 
jsr character5lp
inc columncount
lda columncount
cmp column5
bne checky6
 
 

rts
collided5
ldy column5

lda $d003

lsr
lsr
lsr


cmp alienarrayy,y


beq collided15
rts
collided15
lda $d002
lsr
lsr
lsr
 
cmp arraypoints
beq collided155

rts
collided155
jsr collisionburst
lda $d000
 sta $d002
lda $d001
 sta $d003
lda #1
sta shoottrigger
dec column5
jsr pickupsnd
 
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
lda charactersno
sta (zeropagel),y
 

iny
lda #83
lda charactersno
adc #1
sta (zeropagel),y
ldy arraypoints
lda coloraddressl,x
sta zeropagel

lda coloraddressh,x
sta zeropageh


 

lda characterscol
sta (zeropagel),y
clc
iny
 
 

 
sta (zeropagel),y
 
 
rts
character2lp





 

 
;lda alienarrayy,x
;tax

  

clc


ldy arraypoints
lda displayaddressl,x
sta zeropagel

lda displayaddressh,x
sta zeropageh
 

lda #84
lda charactersno
adc #2
sta (zeropagel),y
 

iny
lda #85
lda charactersno
adc #3
sta (zeropagel),y
ldy arraypoints
lda coloraddressl,x
sta zeropagel

lda coloraddressh,x
sta zeropageh


 

lda characterscol
adc #1
sta (zeropagel),y
clc
iny
 
 

 
sta (zeropagel),y
 
 
rts
character3lp




 

 
;lda alienarrayy,x
;tax

  

clc


ldy arraypoints
lda displayaddressl,x
sta zeropagel

lda displayaddressh,x
sta zeropageh
 

lda #86
lda charactersno
adc #4

sta (zeropagel),y
 

iny
lda #87
lda charactersno
adc #5

sta (zeropagel),y
ldy arraypoints
lda coloraddressl,x
sta zeropagel

lda coloraddressh,x
sta zeropageh


 

lda characterscol
adc #3
sta (zeropagel),y
clc
iny
 
 

 
sta (zeropagel),y
 
 
rts
character4lp





 

 
;lda alienarrayy,x
;tax

  

clc


ldy arraypoints
lda displayaddressl,x
sta zeropagel

lda displayaddressh,x
sta zeropageh
 

lda #88
lda charactersno
adc #6
sta (zeropagel),y
 

iny
lda #89
lda charactersno
adc #7

sta (zeropagel),y
ldy arraypoints
lda coloraddressl,x
sta zeropagel

lda coloraddressh,x
sta zeropageh


 

lda characterscol
adc #4
sta (zeropagel),y
clc
iny
 
 

 
sta (zeropagel),y
 
 
rts

charater1trigger 

ldx #0
character1triggerlp
lda #0
sta character1trigger
;inc alienarrayy,x
;inx
;cpx #6
;bne character1triggerlp

rts
charater1triggerback 
lda #1
sta character1trigger

rts

character5lp





 

 
;lda alienarrayy,x
;tax

  

clc


ldy arraypoints
lda displayaddressl,x
sta zeropagel

lda displayaddressh,x
sta zeropageh
 

lda #90
lda charactersno
adc #8

sta (zeropagel),y
 

iny
lda #91
lda charactersno
adc #9
sta (zeropagel),y
ldy arraypoints
lda coloraddressl,x
sta zeropagel

lda coloraddressh,x
sta zeropageh


 

lda characterscol
adc #5
sta (zeropagel),y
clc
iny
 
 

 
sta (zeropagel),y
 
 
rts 

character1backward
clc
ldx #0
character1backward1
lda character1xpos
cmp #1
beq charater1trigger 

dec character1xpos
 lda character1xpos
 sta character1xpostemp
lda character1xpostemp
adc #2
sta character1xpostemp
inx
cpx #1
bne character1backward1 
 
rts

character1forward
clc
ldx #0
character1forward1

lda character1trigger
cmp #1
 beq character1backward
lda character1xpos
cmp #15
beq charater1triggerback
inc character1xpos
  lda character1xpos
 sta character1xpostemp
inx
cpx #1
bne character1forward1
 
 
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
 
 

 
resetcolumns

 lda column1
 cmp #0
 beq resetcolumn1
  lda column1
 cmp #255
 beq resetcolumn1
 lda column2
 cmp #0
 beq resetcolumn2
  lda column2
 cmp #255
 beq resetcolumn2
 lda column3
 cmp #0
 beq resetcolumn3
  lda column3
 cmp #255
 beq resetcolumn3
 lda column4
 cmp #0
 beq resetcolumn4
  lda column4
 cmp #255
 beq resetcolumn4
 lda column5
 cmp #0
 beq resetcolumn5
  lda column5
 cmp #255
 beq resetcolumn5


rts

resetcolumn1
lda #6
sta column1

rts

resetcolumn2
lda #6
sta column2

rts
resetcolumn3
lda #6
sta column3

rts
resetcolumn4
lda #6
sta column4

rts
resetcolumn5
lda #6
sta column5

rts




erasurecolor

ldx #0

erasurecolorl
 

lda bufferaddressl,x

sta zeropagel2

lda bufferaddressh,x
 
sta zeropageh2 
lda zeropagel2
adc xoffset
sta zeropagel2



lda coloraddressl,x
sta zeropagel

lda coloraddressh,x
sta zeropageh
erasurecolorl2
lda (zeropagel2),y
sta (zeropagel),y
 
  iny
 cpy #39
 bne erasurecolorl2
inx
cpx #23
bne erasurecolorl


rts
columns
  jsr column1rout
   jsr column2rout
  jsr column3rout
   jsr column4rout
  jsr column5rout
rts

resetcharacters
 

 lda charactersno
cmp #86
beq resetcharactersno

  inc charactersno
inc charactersno
inc characterscol

rts
resetcharactersno
jsr backfire
lda #1
sta characterscol
lda #82
sta charactersno

 
rts

  
 
