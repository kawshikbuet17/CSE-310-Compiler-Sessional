.MODEL SMALL
.STACK 100H

.DATA
a DW '?'
b DW '?'
t1 DW '?'
t2 DW '?'
t3 DW '?'
t4 DW '?'
t5 DW '?'
t6 DW '?'
c DW DUP 3 (?)


.CODE
main PROC
MOV AX, @DATA 
MOV DS, AX
MOV AX, 1
MOV AX, 2
MOV BX, 3
ADD AX, BX
MOV t1, AX
MOV AX, 1
MOV BX, t1
MUL BX
MOV t2, AX
MOV AX, 3
MOV AX, t2
MOV BX, 3
XOR DX, DX
CWD
IDIV BX
MOV t3, DX
MOV AX, t3
MOV a, AX
MOV AX, 1
MOV AX, 5
MOV AX, 0
MOV t5, AX
MOV t4, AX
MOV AX, 1
MOV BX, 5
CMP AX, BX
JNL L1
MOV AX, 1
MOV t5, AX
MOV t4, AX
L1:
MOV AX, t5
MOV AX, t4
MOV b, AX
MOV AX, 0
MOV BX, 0
INC BX
ADD BX, BX
SUB BX, 2
MOV AX, 2
MOV AX, 2
MOV c[BX], AX
MOV AX, a
MOV BX, b
CMP AX, 0
JE L2
CMP BX, 0
JE L2
MOV AX, 1
MOV t6, AX
JMP L3
L2:
MOV AX, 0
MOV t6, AX
L3:
MOV AX, t6
CMP AX, 0
JE L4
MOV AX, c[BX]
INC AX
MOV c[BX], AX
JMP L5
L4:
MOV AX, 1
MOV BX, 1
INC BX
ADD BX, BX
SUB BX, 2
MOV AX, 0
MOV BX, 0
INC BX
ADD BX, BX
SUB BX, 2
MOV AX, c[BX]
MOV c[BX], AX
L5:
MOV AX, a
CALL OUTDEC
MOV AX, b
CALL OUTDEC

MOV AH, 4CH
INT 21H
main ENDP
OUTDEC PROC

PUSH AX
PUSH BX
PUSH CX
PUSH DX
OR AX, AX
JGE @END_IF1

PUSH AX
MOV DL, '-'
MOV AH, 2
INT 21H
POP AX
NEG AX
@END_IF1:
XOR CX, CX
MOV BX, 10D
@REPEAT1:
XOR DX, DX
DIV BX
PUSH DX
INC CX
OR AX, AX
JNE @REPEAT1

MOV AH, 2
@PRINT_LOOP:
POP DX
OR DL, 30H
INT 21H
LOOP @PRINT_LOOP
POP DX
POP CX
POP BX
POP AX
RET
OUTDEC ENDP
END MAIN
