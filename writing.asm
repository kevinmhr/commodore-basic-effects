!cpu 6502 

!to "writing.prg",cbm 
 


*=$0801
        !byte    $1E, $08, $0A, $00, $9E, $20, $28,$32, $30, $38, $30, $29, $3a, $8f, $20, $28, $43, $29, $20, $32, $30, $32, $31, $20, $4D, $54, $53, $56, $00, $00, $00
 
*=$820
begin
 
 increment=$41 
  increment2=$42 
  increment3=$43
   ZeroPageLow     = $FB
ZeroPageHigh    = $FC
	lda #0
	 sta $d020
	 sta $d021

 
jsr erasescreen
 
 
jsr erase2000
ldx #$30

stx  ZeroPageHigh 
 

loaddccimage
loop 
 
 

jsr getalphabet

   jsr colorchanging
 jsr increzeropageh
 
 
 jsr erase2000
jmp loop

rts
 

 
calculatelenght
ldx #0
calculatelenghtlp
 
lda $2000,x
inx
cmp #255
beq calculated
jmp calculatelenghtlp
rts
calculated
stx increment2
ldx #0
jmp aftercalc
rts
 
 
getalphabet

 
ldy #0
 
getalphabetlp
;jsr calculatelenght


aftercalc
 
jsr $ffcf

 
cmp #32
beq changespace
 
changedspace

sta $2000,y
cmp #13
beq setalphabet




 iny 
 cpy #255
 bne getalphabetlp
 rts
setalphabet
 
jsr erasescreen


 

ldy #0 
doagain
 
 
jsr erasescreenlp
  lda $d012
 
beq done

 
ldx #0
iny
 
 ;jsr calculatelenght
 
setalphabetlp
 

lda $2000,y
changedenter


;cmp #13
;beq changeenter


cmp #255
beq dontprintthis 



sbc #63
 

sta $0400,x
 

cmp #32
beq doagain
 

 
 iny
inx

sta $0400,x

 
jmp setalphabetlp 
done

dontprintthis



rts

 

changespace
lda #96
jmp changedspace 
rts
changeenter
lda #96
jmp changedenter
rts

increzeropageh
 
increzeropagehlp

 
 
inc ZeroPageHigh
 lda ZeroPageHigh
 cmp #$39
 beq zerozeropagehi
rts
zerozeropagehi
lda #$30
sta ZeroPageHigh
rts
erase2000


ldx #0
ldy #0
erase2000lp
 

 
 iny
lda #255
 sta $2000,x
lda (ZeroPageLow),y
 
adc #64
sta $2000,x
 
 
inx
cpx #255
bne erase2000lp
rts
wipe2000


ldx #0
 
wipe2000lp
 

 
 
lda #255
 sta $2000,x
 
 
inx
cpx #255
bne erase2000lp
rts
erasescreen
 
ldx #0
erasescreenlp
 
 
lda #32
sta $0400,x
sta $0500,x
sta $0600,x
sta $0700,x
 

inx
cpx #0
bne erasescreenlp

 

 
 
rts
colorchanging

ldx #0

colorchanginglp

lda $2000,x
cmp #67
beq compare2
rts

compare2
inx
lda $2000,x
cmp #79
beq compare3
rts
compare3
inx
lda $2000,x
cmp #76
beq changetxtcolor
rts
changetxtcolor
ldx #0
changetxtcolorlp

inc $d800,x
inx
cpx #255
bne changetxtcolorlp
rts
*=$3000
alpha 
 !scr "outside off minus besides upon above underneath among against to before after towards by over in through anti behind concerning "
   !scr "aboard following near than from below beneath but past regarding of on beyond per opposite excepting via round without like " 
   !scr "onto inside  until as for toward across save since along between up unlike into during except about versus plus around with "
   !scr "amid beside excluding considering within under despite down at faithful unbiased hallowed moan tire gabby bubble dark serve "
    !scr "cows hollow upset stingy bustling shelter rate observation shy moldy spiteful second question auspicious wilderness morning "
    !scr "giraffe cruel puzzling difficult sweater therapeutic caring foregoing bag gainful witty same funny murky elfin board boiling "
    !scr "belligerent house faulty wandering mundane search follow tender intend support thin unruly hilarious owe breezy card crate "
    !scr "defective decisive crack applaud unused determined lowly appliance greasy deadpan heat damage stream cry clover employ " 
    !scr "thankful camp shake coil offend festive lumpy discover vessel overrated library smile obeisant practice half testy silly "
    !scr "amusement legal country start wave achiever lucky slim awful cough natural pie wise overjoyed accurate industry crowded "
    !scr "pollution abundant baby fold neighborly switch spiffy machine planes devilish naughty possess advice sigh peck stupendous "
!scr "what am I about to tell you might be a little shocking but there is no need to be shocked at all "
!scr "you look around the streets what you expect? there is so many things all around and they are all yours to watch and learn about "
!scr"boiling subsequent woebegone somber pastoral dark common unsuitable abaft placid icy earsplitting juvenile odd blue silly superb "
!scr"changeable fearful beneficial literate illustrious legal ordinary outstanding ultra excited merciful bustling elite kindly five "
!scr"obsequious verdant hysterical marvelous green black-and-white hungry hard-to-find aloof nutty daily fixed relieved screeching "
!scr"functional puzzled grateful real foregoing small astonishing medical elastic super sore adventurous near bashful unknown maniacal "
!scr"cuddly adjoining aware abandoned dusty left unable flat dramatic possible husky same flowery blue-eyed obscene direful simplistic "
!scr"crabby berserk juicy slippery ossified handy gleaming colossal taboo precious broad friendly frightening unused spiffy joyous "
!scr"quizzical ragged complete splendid organic fluttering impartial one hideous stormy irate excellent amused fretful torpid "
!scr"nutritious absent oval strong uneven ceaseless jagged futuristic mountainous painful coherent like mere sticky scarce longing "
!scr"pathetic bored complex tense magenta mighty bent wealthy overrated helpless phobic uppity incompetent narrow energetic stiff "
!scr"swanky cheerful weak muddled different magnificent giddy frightened open illegal adhesive bite-sized lacking scared unbiased "
!scr"puzzling robust soft angry fluffy spectacular troubled wooden gusty harmonious adamant amusing fat well-to-do spiteful wacky "
!scr"capable habitual clammy majestic brave striped profuse shaky poor boorish enchanted thirsty cowardly ready industrious unarmed"
!scr" grotesque"
