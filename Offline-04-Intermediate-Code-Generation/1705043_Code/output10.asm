.MODEL SMALL
.STACK 100H

.DATA
a DW '?'
b DW '?'


.CODE
POP AX
MOV b, AX
POP AX
MOV a, AX
func_1 PROC
PUSH AX
PUSH BX
PUSH CX
PUSH DX
MOV AX, a
CALL OUTDEC
MOV AX, b
CALL OUTDEC
POP DX
POP CX
POP BX
POP AX
RET 4
func_1 ENDP
main PROC
MOV AX, @DATA 
MOV DS, AX
MOV AX, 1
MOV AX, 1
MOV a, AX
MOV AX, 2
MOV AX, 2
MOV b, AX
MOV AX, a
PUSH AX
MOV AX, b
PUSH AX
CALL func_1

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
