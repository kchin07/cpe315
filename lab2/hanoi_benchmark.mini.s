.arch armv7-a
.file	"benchmarks/hanoi_benchmark/hanoi_benchmark.mini"
.comm	peg1,8,4
.comm	peg2,8,4
.comm	peg3,8,4
.comm	numMoves,4,4

.IONL:
	.ascii "%d\012\000"
	.text
	.align 2

.comm	globalScratch, 8, 4

.IO:
	.ascii "%d\040\000"
	.text
	.align 2

.SCAN:
	.ascii "%d\000"
	.text
	.align 2


.text
.align 2
.global _move
_move:
PUSH {fp, lr}
ADD fp, sp, #4
PUSH {r4, r5, r6, r7}
SUB sp, sp, #0

Start0:
MOV r6, r0
MOV r5, r1
MOV r4, #0
CMP r6, #1
MOVEQ r4, #1
MOV r4, r4
MOV r7, #0
CMP r4, #1
MOVEQ r7, #1
CMP r7, #1
MOV r4, r5
MOV r4, r5
MOV r5, r5
BEQ Block3
B Block4

Block4:
MOV r5, #0
CMP r6, #2
MOVEQ r5, #1
MOV r5, r5
MOV r6, #0
CMP r5, #1
MOVEQ r6, #1
CMP r6, #1
BEQ Block6
B Block7

Block7:
MOVW r5, #:lower16:peg3
MOVT r5, #:upper16:peg3
LDR r5, [r5]
MOVW r6, #:lower16:peg3
MOVT r6, #:upper16:peg3
LDR r6, [r6]
ADD r6, r6, #4
LDR r7, [r6]
MOVW r6, #:lower16:peg3
MOVT r6, #:upper16:peg3
MOV r7, r7
STR r7, [r6]
MOV r5, r5
B Join5

Block6:
MOVW r5, #:lower16:peg2
MOVT r5, #:upper16:peg2
LDR r5, [r5]
MOVW r6, #:lower16:peg2
MOVT r6, #:upper16:peg2
LDR r6, [r6]
ADD r6, r6, #4
LDR r7, [r6]
MOVW r6, #:lower16:peg2
MOVT r6, #:upper16:peg2
MOV r7, r7
STR r7, [r6]
MOV r5, r5
B Join5

Join5:
MOV r4, r4
MOV r6, r5
MOV r5, r4
MOV r4, r6
B Join2

Block3:
MOVW r4, #:lower16:peg1
MOVT r4, #:upper16:peg1
LDR r4, [r4]
MOVW r6, #:lower16:peg1
MOVT r6, #:upper16:peg1
LDR r6, [r6]
ADD r6, r6, #4
LDR r7, [r6]
MOVW r6, #:lower16:peg1
MOVT r6, #:upper16:peg1
MOV r7, r7
STR r7, [r6]
MOV r4, r4
B Join2

Join2:
MOV r5, r5
MOV r4, r4
MOV r6, #0
CMP r5, #1
MOVEQ r6, #1
MOV r6, r6
MOV r7, #0
CMP r6, #1
MOVEQ r7, #1
CMP r7, #1
BEQ Block9
B Block10

Block10:
MOV r6, #0
CMP r5, #2
MOVEQ r6, #1
MOV r6, r6
MOV r5, #0
CMP r6, #1
MOVEQ r5, #1
CMP r5, #1
BEQ Block12
B Block13

Block13:
MOVW r5, #:lower16:peg3
MOVT r5, #:upper16:peg3
LDR r6, [r5]
ADD r5, r4, #4
MOV r6, r6
STR r6, [r5]
MOVW r5, #:lower16:peg3
MOVT r5, #:upper16:peg3
MOV r4, r4
STR r4, [r5]
B Join11

Block12:
MOVW r5, #:lower16:peg2
MOVT r5, #:upper16:peg2
LDR r6, [r5]
ADD r5, r4, #4
MOV r6, r6
STR r6, [r5]
MOVW r5, #:lower16:peg2
MOVT r5, #:upper16:peg2
MOV r4, r4
STR r4, [r5]
B Join11

Join11:
B Join8

Block9:
MOVW r5, #:lower16:peg1
MOVT r5, #:upper16:peg1
LDR r6, [r5]
ADD r5, r4, #4
MOV r6, r6
STR r6, [r5]
MOVW r5, #:lower16:peg1
MOVT r5, #:upper16:peg1
MOV r4, r4
STR r4, [r5]
B Join8

Join8:
MOVW r4, #:lower16:numMoves
MOVT r4, #:upper16:numMoves
LDR r4, [r4]
ADD r5, r4, #1
MOVW r4, #:lower16:numMoves
MOVT r4, #:upper16:numMoves
MOV r5, r5
STR r5, [r4]
B End1

End1:
MOV r0, #0


ADD sp, sp, #0
POP {r4, r5, r6, r7}
SUB sp, fp, #4
POP {fp, pc}

.text
.align 2
.global _hanoi
_hanoi:
PUSH {fp, lr}
ADD fp, sp, #4
PUSH {r4, r5, r6, r7, r8, r9}
SUB sp, sp, #0

Start14:
MOV r7, r0
MOV r4, r1
MOV r5, r2
MOV r6, r3
MOV r8, #0
CMP r7, #1
MOVEQ r8, #1
MOV r8, r8
MOV r9, #0
CMP r8, #1
MOVEQ r9, #1
CMP r9, #1
BEQ Block17
B Block18

Block18:
SUB r8, r7, #1
MOV r0, r8
MOV r1, r4
MOV r2, r6
MOV r3, r5
BL _hanoi
MOV r0, r4
MOV r1, r5
BL _move
SUB r7, r7, #1
MOV r0, r7
MOV r1, r6
MOV r2, r5
MOV r3, r4
BL _hanoi
B Join16

Block17:
MOV r0, r4
MOV r1, r5
BL _move
B Join16

Join16:
B End15

End15:
MOV r0, #0


ADD sp, sp, #0
POP {r4, r5, r6, r7, r8, r9}
SUB sp, fp, #4
POP {fp, pc}

.text
.align 2
.global _printPeg
_printPeg:
PUSH {fp, lr}
ADD fp, sp, #4
PUSH {r4, r5, r6}
SUB sp, sp, #0

Start19:
MOV r4, r0
MOV r5, #0
CMP r4, #0
MOVNE r5, #1
MOV r6, r5
MOV r5, #0
CMP r6, #1
MOVEQ r5, #1
CMP r5, #1
MOV r5, r4
BEQ Block22
B JoinWhile21

Block22:
MOV r4, r5
ADD r5, r4, #0
LDR r5, [r5]
MOV r1, r5
MOVW r0, #:lower16:.IONL
MOVT r0, #:upper16:.IONL
BL printf
ADD r4, r4, #4
LDR r4, [r4]
MOV r5, #0
CMP r4, #0
MOVNE r5, #1
MOV r5, r5
MOV r6, #0
CMP r5, #1
MOVEQ r6, #1
CMP r6, #1
MOV r5, r4
MOV r5, r4
BEQ Block22
B JoinWhile21

JoinWhile21:
B End20

End20:
MOV r0, #0


ADD sp, sp, #0
POP {r4, r5, r6}
SUB sp, fp, #4
POP {fp, pc}

.text
.align 2
.global main
main:
PUSH {fp, lr}
ADD fp, sp, #4
SUB sp, sp, #0

Start23:
MOVW r5, #:lower16:numMoves
MOVT r5, #:upper16:numMoves
MOV r4, #0
STR r4, [r5]
MOVW r0, #:lower16:.SCAN
MOVT r0, #:upper16:.SCAN
MOVW r1, #:lower16:globalScratch
MOVT r1, #:upper16:globalScratch
BL scanf
MOVW r1, #:lower16:globalScratch
MOVT r1, #:upper16:globalScratch
LDR r4, [r1]
MOV r5, #0
CMP r4, #1
MOVGE r5, #1
MOV r5, r5
MOV r6, #0
CMP r5, #1
MOVEQ r6, #1
CMP r6, #1
MOV r5, r4
MOV r6, r4
MOV r7, r4
BEQ Block26
B Block31

Block31:
B Join25

Block26:
MOV r8, #0
CMP r4, #0
MOVNE r8, #1
MOV r8, r8
MOV r4, #0
CMP r8, #1
MOVEQ r4, #1
CMP r4, #1
BEQ Block28
B JoinWhile27

Block28:
MOV r4, r5
MOV r5, r6
MOV r0, #8
BL malloc
MOV r6, r0
MOV r6, r6
ADD r7, r6, #0
MOV r8, r5
STR r8, [r7]
MOVW r7, #:lower16:peg1
MOVT r7, #:upper16:peg1
LDR r8, [r7]
ADD r7, r6, #4
MOV r8, r8
STR r8, [r7]
MOVW r7, #:lower16:peg1
MOVT r7, #:upper16:peg1
MOV r6, r6
STR r6, [r7]
SUB r7, r5, #1
MOV r5, #0
CMP r7, #0
MOVNE r5, #1
MOV r5, r5
MOV r6, #0
CMP r5, #1
MOVEQ r6, #1
CMP r6, #1
MOV r5, r4
MOV r6, r7
MOV r5, r4
MOV r6, r7
MOV r7, r4
BEQ Block28
B JoinWhile27

JoinWhile27:
MOV r4, r7
MOV r1, #1
MOVW r0, #:lower16:.IONL
MOVT r0, #:upper16:.IONL
BL printf
MOVW r5, #:lower16:peg1
MOVT r5, #:upper16:peg1
LDR r5, [r5]
MOV r0, r5
BL _printPeg
MOV r1, #2
MOVW r0, #:lower16:.IONL
MOVT r0, #:upper16:.IONL
BL printf
MOVW r5, #:lower16:peg2
MOVT r5, #:upper16:peg2
LDR r5, [r5]
MOV r0, r5
BL _printPeg
MOV r1, #3
MOVW r0, #:lower16:.IONL
MOVT r0, #:upper16:.IONL
BL printf
MOVW r5, #:lower16:peg3
MOVT r5, #:upper16:peg3
LDR r5, [r5]
MOV r0, r5
BL _printPeg
MOV r0, r4
MOV r1, #1
MOV r2, #3
MOV r3, #2
BL _hanoi
MOV r1, #1
MOVW r0, #:lower16:.IONL
MOVT r0, #:upper16:.IONL
BL printf
MOVW r4, #:lower16:peg1
MOVT r4, #:upper16:peg1
LDR r4, [r4]
MOV r0, r4
BL _printPeg
MOV r1, #2
MOVW r0, #:lower16:.IONL
MOVT r0, #:upper16:.IONL
BL printf
MOVW r4, #:lower16:peg2
MOVT r4, #:upper16:peg2
LDR r4, [r4]
MOV r0, r4
BL _printPeg
MOV r1, #3
MOVW r0, #:lower16:.IONL
MOVT r0, #:upper16:.IONL
BL printf
MOVW r4, #:lower16:peg3
MOVT r4, #:upper16:peg3
LDR r4, [r4]
MOV r0, r4
BL _printPeg
MOVW r4, #:lower16:numMoves
MOVT r4, #:upper16:numMoves
LDR r4, [r4]
MOV r1, r4
MOVW r0, #:lower16:.IONL
MOVT r0, #:upper16:.IONL
BL printf
MOVW r4, #:lower16:peg3
MOVT r4, #:upper16:peg3
LDR r5, [r4]
MOV r4, #0
CMP r5, #0
MOVNE r4, #1
MOV r4, r4
MOV r5, #0
CMP r4, #1
MOVEQ r5, #1
CMP r5, #1
BEQ Block30
B JoinWhile29

Block30:
MOVW r4, #:lower16:peg3
MOVT r4, #:upper16:peg3
LDR r4, [r4]
MOVW r5, #:lower16:peg3
MOVT r5, #:upper16:peg3
LDR r5, [r5]
ADD r5, r5, #4
LDR r6, [r5]
MOVW r5, #:lower16:peg3
MOVT r5, #:upper16:peg3
MOV r6, r6
STR r6, [r5]
MOV r4, r4
MOV r0, r4
BL free
MOVW r4, #:lower16:peg3
MOVT r4, #:upper16:peg3
LDR r5, [r4]
MOV r4, #0
CMP r5, #0
MOVNE r4, #1
MOV r4, r4
MOV r5, #0
CMP r4, #1
MOVEQ r5, #1
CMP r5, #1
BEQ Block30
B JoinWhile29

JoinWhile29:
B Join25

Join25:
B End24

End24:
MOV r0, #0


ADD sp, sp, #0
SUB sp, fp, #4
POP {fp, pc}
