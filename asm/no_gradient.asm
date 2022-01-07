// Gradient Removal Patch
// version 0.1
// released on 05/06/2017

arch snes.cpu

macro seek(offset) {
	origin {offset}
	base $00
}

// Main Menu

seek($14CA82);
dw $E00A, $E00A, $E00A, $E00A, $E00A, $E00A, $E00A, $E00A
dw $E00A, $E00A, $E00A, $E00A, $E00A, $E00A, $E00A, $E00A
dw $E00A, $E00A, $E00A, $E00A, $E00A, $E00A, $E00A, $EC0A
db $00

// Load Menu

seek($14CACD);
dw $E00F, $E002, $E002, $E002, $E002, $E002, $E002, $E002
dw $E002, $E002, $E002, $E002, $E002, $E002, $E002, $E002
dw $E004, $E004, $E004, $E004, $E004, $E004, $E004, $E004
dw $E004, $E004, $E004, $E004, $E004, $E004, $E004, $E004
dw $E004, $E004, $E004, $E004, $E004, $E004, $E004, $E004
dw $E004, $E004, $E004, $E004, $E004, $E004, $E004, $E004
dw $E004, $E004, $E004, $E004, $E004, $E004, $E004, $E004
dw $E004, $E004
db $00

// Map Name Window

seek($002F98);
lda.w #$8BE3
sta.w $7E1C
lda.w #$8BE3
sta.w $7E1F
lda.w #$8BE3
sta.w $7E22
lda.w #$8BE3
sta.w $7E25

seek($002FBF);
lda.w #$8BE3
sta.w $7D0B
lda.w #$8BE3
sta.w $7D0E
lda.w #$8BE3
sta.w $7D11
lda.w #$8BE3

// Dialogue Window

seek($003119);
bra +
nop
nop
nop
nop
nop
+;

seek($0034F0);
dw $89C3, $89C3, $89C3, $89C3, $89C3, $89C3, $89C3, $89C3, $89C3
dw $89C3, $89C3, $89C3, $89C3, $89C3, $89C3, $89C3, $89C3, $89C3
dw $89C3, $89C3, $89C3, $89C3, $89C3, $89C3, $89C3, $89C3, $89C3
dw $89C3, $89C3, $89C3, $89C3, $89C3, $89C3, $89C3, $89C3, $89C3
dw $89C3, $89C3, $89C3, $89C3, $89C3, $89C3, $89C3, $89C3, $89C3

// Battle Menu

seek($01127A);
tdc 
tax 
loop_a:
lda.b #$02
sta.w $8BF0,x
lda.b #$82
sta.w $8BF1,x
lda.b #$E7
sta.w $8BF2,x
inx 
inx 
inx 
inx 
cpx #$0120
bne loop_a
bra branch_a
fill $16, $EA
branch_a:

// Battle Top Window

seek($019629);
tdc 
tax 
loop_b:
lda.b #$02
sta.w $89B4,x
lda.b #$81
sta.w $89B5,x
lda.b #$E7
sta.w $89B6,x
inx 
inx 
inx 
inx 
cpx #$0080
bne loop_b
jsr $9673
rts