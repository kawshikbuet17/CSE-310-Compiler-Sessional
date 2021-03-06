.MODEL SMALL
.STACK 100H

.DATA
a DW '?'
i DW '?'
sum DW '?'
t1 DW '?'
t2 DW '?'
t3 DW '?'
t4 DW '?'
t5 DW '?'
t6 DW '?'
t7 DW '?'
t8 DW '?'
t9 DW '?'


.CODE
loop_1 PROC
PUSH AX
PUSH BX
PUSH CX
PUSH DX
MOV AX, 0
MOV AX, 0
MOV sum, AX
;for i=0 start
MOV AX, 0
MOV AX, 0
MOV i, AX
;for i=0 end
L2:
;i<10 start
MOV AX, 5
MOV AX, 0
MOV t2, AX
MOV t1, AX
MOV AX, i
MOV BX, 5
CMP AX, BX
JNL L1
MOV AX, 1
MOV t2, AX
MOV t1, AX
L1:
MOV AX, t2
;i<10 end
MOV BX, 0
CMP AX, BX
JE L3
MOV AX, sum
MOV BX, i
ADD AX, BX
MOV t3, AX
MOV AX, t3
MOV sum, AX
;i++ start
MOV AX, i
INC AX
MOV i, AX
;i++ end
JMP L2
L3:
MOV AX, sum
CALL OUTDEC
POP DX
POP CX
POP BX
POP AX
RET
loop_1 ENDP
loop_2 PROC
PUSH AX
PUSH BX
PUSH CX
PUSH DX
MOV AX, 5
MOV AX, 5
MOV a, AX
MOV AX, 0
MOV AX, 0
MOV sum, AX
;for i=0 start
MOV AX, 0
MOV AX, 0
MOV i, AX
;for i=0 end
L5:
;i<10 start
MOV AX, 0
MOV t5, AX
MOV t4, AX
MOV AX, i
MOV BX, a
CMP AX, BX
JNL L4
MOV AX, 1
MOV t5, AX
MOV t4, AX
L4:
MOV AX, t5
;i<10 end
MOV BX, 0
CMP AX, BX
JE L6
MOV AX, sum
MOV BX, i
ADD AX, BX
MOV t6, AX
MOV AX, t6
MOV sum, AX
;i++ start
MOV AX, i
INC AX
MOV i, AX
;i++ end
JMP L5
L6:
MOV AX, sum
CALL OUTDEC
POP DX
POP CX
POP BX
POP AX
RET
loop_2 ENDP
loop_3 PROC
PUSH AX
PUSH BX
PUSH CX
PUSH DX
MOV AX, 5
MOV AX, 5
MOV a, AX
MOV AX, 0
MOV AX, 0
MOV sum, AX
;for i=0 start
MOV AX, 0
MOV AX, 0
MOV i, AX
;for i=0 end
L8:
;i<10 start
MOV AX, 0
MOV t8, AX
MOV t7, AX
MOV AX, i
MOV BX, a
CMP AX, BX
JNL L7
MOV AX, 1
MOV t8, AX
MOV t7, AX
L7:
MOV AX, t8
;i<10 end
MOV BX, 0
CMP AX, BX
JE L9
MOV AX, sum
MOV BX, i
ADD AX, BX
MOV t9, AX
MOV AX, t9
MOV sum, AX
MOV AX, sum
CALL OUTDEC
;i++ start
MOV AX, i
INC AX
MOV i, AX
;i++ end
JMP L8
L9:
POP DX
POP CX
POP BX
POP AX
RET
loop_3 ENDP
main PROC
MOV AX, @DATA 
MOV DS, AX
CALL loop_1
CALL loop_2
CALL loop_3

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
