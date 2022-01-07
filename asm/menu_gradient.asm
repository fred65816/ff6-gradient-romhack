; Gradient Menu Option
; version 0.1
; released on 05/13/2017

hirom
;header

!ram = $1E1D			; Sram used for Gradient Purpose, change if needed
!ramAbs = $7E1E1D		; Same as above but in absolute addresssing

; BANK $C0 (Dialogue and Map Name Windows)

org $C0BE98				; !ram initialization
JSL initSram

org $C02F98
SEP #$20
lda !ram
bne noGrdC0A
REP #$20
jsl subGrdC0A
jsr subC0B
jsl subGrdC0C
bra ctnC0A
noGrdC0A:
REP #$20
jsl subNoGrdC0A
jsr subC0B
jsl subNoGrdC0C
bra ctnC0A

subC0B:
lda #$81B3
sta $7B9F
sta $7BA2
sta $7BA5
sta $7BA8
rts

fill $07, $EA
ctnC0A:

org $C03119				; Dialogue Window 
jsl subC0D
bra ctnC0D
nop
ctnC0D:

; BANK $C1 (Battle Menu and Top Window)

org $C11282
jsl subGrdC1A
bra ctnC1A
fill $24, $EA
ctnC1A:

org $C19631
jsl subGrdC1B
jsr $9673
rts

; BANK $D4 (Main Menu, Shop, Colloseum, Load Menu, Save Menu)

org $D4CA21
jsl subGrdD4A
bra ctnD4A
fill $09, $EA
ctnD4A:

org $D4CA3A
jsl subGrdD4B
nop

; BANK $C3 (Menu Code)

org $C32347				; Handle clicked option
jmp (clicks,x)  		; Handle option

org $C33887				; Handle D-Pad for Config page 2
ldy #cursors   

org $C33891
db $07   

org $C3392F
jsr initGrd     		; Draw "Gradient"

org $C33D3D
jmp (cfgUpd,X)  		; Handle page 2

org $C3413D
LDY #palArrow     		; Text pointer

org $C34154
LDA palPtrs,X  			; Text pointer

org $C34ABA
dw $4437

org $C34AC9
dw $44B7

org $C3F091
initSram:				; Initialize Gradient value to True (00)
STZ !ram
LDA #$CA
STA $E7
rtl

gradient:				; "Gradient"
dw $44A5				; Position
db $86, $AB, $9A, $9D	; "Gradient"
db $A2, $9E, $A7, $AD	
db $00					; End String

draw: 					; Draw "Gradient"
sta $29        			; Set palette
ldy #gradient			; Text pointer
jsr $02F9      			; Draw "Gradient"
rts

grdCheck:				; Draw "Gradient" with the right color (enabled or disabled)
lda !ram      			; Gradient (00 = yes, 01 = no)
beq grdOn				; Branch if Gradient enabled
lda #$28      			; Color: Gray
jsr draw     			; Draw "Gradient"
bra exitChk				; Exit
grdOn:					; Gradient is enabled
lda #$20      			; Color: User's
jsr draw     			; Draw "Gradient"
exitChk:
rts

updateGrd:				; Placeholder to align the new option in the menu
rts

grdClick:				; Toggle the Gradient value and call the draw function (00 -> 01, 01 -> 00)
lda !ram      			; Gradient (00 = yes, 01 = no)
beq setNoGrd			; Branch if Gradient
lda #$00				; Gradient enabled
bra drawGrd				; Make the Gradient change
setNoGrd:				; We switch to no Gradient
lda #$01				; Gradient Disabled
drawGrd:
sta !ram				; Save Option
jsr grdCheck			; Change Option Color
jsl $D4CA1D				; Redraw New Gradient
rts

initGrd:				; Init the new menu option
jsr $69BA      			; Draw A/B/C, R/G/B
jsr grdCheck			; Draw "Gradient"
rts
	
cursors:				; Cursor positions for Config page 2
dw $2960    			; Mag.Order
dw $6960    			; Window
dw $7960    			; Color 
dw $8960 				; Gradient  	
dw $9960				; R
dw $A960   				; G
dw $B960   				; B


clicks:					; Jump table for clicks in Config menu
dw $2341   				; Mag.Order  (NOP)
dw $2341    			; Window     (NOP)
dw $2388    			; Color
dw grdClick				; Gradient
dw $2388    			; R
dw $2388    			; G
dw $2388   				; B

cfgUpd:
dw $3E9F    			; Mag.Order
dw $3ECD   				; Window
dw $3F01    			; Viewed color
dw updateGrd			; Gradient (RTS)
dw $3F3C     			; R
dw $3F5B    			; G
dw $3F7A   				; B

palPtrs:				; Pointers..
dw palArrow    			; Font...
dw win1					; Window 1
dw win2					; Window 2
dw win3					; Window 3
dw win4					; Window 4
dw win5					; Window 5
dw win6					; Window 6
dw win7					; Window 7

palArrow:				; Arrow location and symbol on palette
dw $44F7, $FFFF, $FFFF  ; String to erase the previous arrow
dw $FFFF, $00FF

win1:					; Main menu background palette colors
dw $44F7, $00D4			; Color 1
win2:
dw $44F9, $00D4			; Color 2
win3:
dw $44FB, $00D4			; Color 3
win4:
dw $44FD, $00D4			; Color 4
win5:
dw $44FF, $00D4			; Color 5
win6:
dw $4501, $00D4			; Color 6
win7:
dw $4503, $00D4			; Color 7

; BANK $EF

org $EFFBC8				; Free Space
subGrdC0A:				; Gradient Map Window Part A
lda #$8BD3
sta $7E1C
lda #$8BE3
sta $7E1F
lda #$8BF3
sta $7E22
lda #$8C03
sta $7E25
rtl

subNoGrdC0A:			; No Gradient Map Window Part A
lda #$8BE3
sta $7E1C
lda #$8BE3
sta $7E1F
lda #$8BE3
sta $7E22
lda #$8BE3
sta $7E25
rtl

subGrdC0C:				; Gradient Map Window Part B
lda #$8A43
sta $7D0B
lda #$8A53
sta $7D0E
lda #$8A63
sta $7D11
lda #$8A73
rtl

subNoGrdC0C:			; No Gradient Map Window Part B
lda #$8BE3
sta $7D0B
lda #$8BE3
sta $7D0E
lda #$8BE3
sta $7D11
lda #$8BE3
rtl

subC0D:					; Dialogue Window Code
SEP #$20
lda !ramAbs      		; Gradient (00 = yes, 01 = no)
bne exitGrdEF1			; Branch if no Gradient
REP #$20
lda $34F0,y				; Load From Default Table
sta $7E7D08,x			; Transfer to !ram
exitGrdEF1:
REP #$20
rtl

subGrdC1A:				; Battle Menu Code
lda #$02
sta $8BF0,x
lda #$82
sta $8BF1,x
lda !ram      			; Gradient (00 = yes, 01 = no)
beq setGrdEF2
lda #$E7
bra brnGrdEF2
setGrdEF2:
lda $10
brnGrdEF2:
sta $8BF2,x
inc $1A
lda $1A
cmp #$03
bne brnGrdEF3
stz $1A
lda $10
cmp #$FF
beq brnGrdEF3
inc $10
brnGrdEF3:
inx 
inx 
inx 
inx 
cpx #$0120
bne subGrdC1A
rtl

subGrdC1B:				; Top Battle Window
lda #$02
sta $89B4,x
lda #$81
sta $89B5,x
lda !ram      			; Gradient (00 = yes, 01 = no)
beq setGrdEF4
lda #$E7
bra brnGrdEF4
setGrdEF4:
lda $10
brnGrdEF4:
sta $89B6,x
inc $1A
lda $1A
cmp #$02
bne brnGrdEF5
stz $1A
lda $10
cmp #$FF
beq brnGrdEF5
inc $10
brnGrdEF5:
inx 
inx 
inx 
inx 
cpx #$0080
bne subGrdC1B
rtl

subGrdD4A:				; Main Menu Gradient Code
asl 
tax
lda !ram      			; Gradient (00 = yes, 01 = no)
beq setGrdEF6
rep #$20 
lda tblD4E,x
sta $4332      
lda tblD4A,x
bra brnGrdEF6
setGrdEF6:   
rep #$20 
lda $D4CA7C,x
sta $4332      
lda $D4CA71,x
brnGrdEF6:
rtl

subGrdD4B:			; Main Menu Gradient Code
sta $4331   
lda !ram      		; Gradient (00 = yes, 01 = no)
beq setGrdEF7
lda #$EF
bra brnGrdEF7
setGrdEF7:     
lda #$D4
brnGrdEF7:
rtl

;Jump Table
tblD4A:			
dw tblD4B, tblD4C, tblD4D    	

;HDMA Table (no Gradient)
tblD4B:
dw $0270, $8270
db $00

;Jump Table
tblD4E:
dw tblD4F, tblD4G, tblD4H

;Gradient Table (no Gradient)
tblD4F:
dw $E00A, $E00A, $E00A, $E00A, $E00A, $E00A, $E00A, $E00A
dw $E00A, $E00A, $E00A, $E00A, $E00A, $E00A, $E00A, $E00A
dw $E00A, $E00A, $E00A, $E00A, $E00A, $E00A, $E00A, $EC0A
db $00

; Color Table (no Gradient)
tblD4C:				
dw $021F, $8210, $021C, $821C, $021C, $821C, $021C, $821C
db $00

; Color Table (no Gradient)
tblD4D:
dw $0217, $8278, $0224, $8224
db $00

;Gradient Table (no Gradient)
tblD4G:
dw $E00F, $E002, $E002, $E002, $E002, $E002, $E002, $E002
dw $E002, $E002, $E002, $E002, $E002, $E002, $E002, $E002
dw $E004, $E004, $E004, $E004, $E004, $E004, $E004, $E004
dw $E004, $E004, $E004, $E004, $E004, $E004, $E004, $E004
dw $E004, $E004, $E004, $E004, $E004, $E004, $E004, $E004
dw $E004, $E004, $E004, $E004, $E004, $E004, $E004, $E004
dw $E004, $E004, $E004, $E004, $E004, $E004, $E004, $E004
dw $E004, $E004
db $00

;HDAM Table (no Gradient)
tblD4H:
dw $E007, $E702, $E602, $E502, $E402, $E302, $E202, $E102
dw $E002, $E102, $E202, $E302, $E402, $E502, $E602, $E703
dw $E067, $EA02, $E904, $E804, $E704, $E604, $E504, $E404
dw $E304, $E204, $E104, $E004, $E104, $E204, $E304, $E404
dw $E504, $E604, $E704, $E804, $E904, $EA02
db $00