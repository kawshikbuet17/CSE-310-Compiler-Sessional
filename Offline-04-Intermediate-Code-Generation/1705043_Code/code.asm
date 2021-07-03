.MODEL SMALL
.STACK 100H

.DATA
a DW '?'
b DW '?'
c DW '?'
t1 DW '?'
t10 DW '?'
t11 DW '?'
t12 DW '?'
t13 DW '?'
t14 DW '?'
t15 DW '?'
t16 DW '?'
t17 DW '?'
t18 DW '?'
t19 DW '?'
t2 DW '?'
t20 DW '?'
t21 DW '?'
t22 DW '?'
t23 DW '?'
t24 DW '?'
t25 DW '?'
t26 DW '?'
t27 DW '?'
t28 DW '?'
t29 DW '?'
t3 DW '?'
t30 DW '?'
t4 DW '?'
t5 DW '?'
t6 DW '?'
t7 DW '?'
t8 DW '?'
t9 DW '?'


.CODE
relop_1 PROC
PUSH AX
PUSH BX
PUSH CX
PUSH DX
MOV AX, 1
MOV AX, 1
MOV a, AX
MOV AX, 2
MOV AX, 2
MOV b, AX
MOV AX, 3
MOV AX, 3
MOV c, AX
MOV AX, 0
MOV t1, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNL L1
MOV AX, 1
MOV t1, AX
L1:
MOV AX, t1
MOV c, AX
MOV AX, c
CALL OUTDEC
MOV AX, 0
MOV t2, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNLE L2
MOV AX, 1
MOV t2, AX
L2:
MOV AX, t2
MOV c, AX
MOV AX, c
CALL OUTDEC
MOV AX, 0
MOV t3, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNG L3
MOV AX, 1
MOV t3, AX
L3:
MOV AX, t3
MOV c, AX
MOV AX, c
CALL OUTDEC
MOV AX, 0
MOV t4, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNGE L4
MOV AX, 1
MOV t4, AX
L4:
MOV AX, t4
MOV c, AX
MOV AX, c
CALL OUTDEC
MOV AX, 0
MOV t5, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNE L5
MOV AX, 1
MOV t5, AX
L5:
MOV AX, t5
MOV c, AX
MOV AX, c
CALL OUTDEC
MOV AX, 0
MOV t6, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JE L6
MOV AX, 1
MOV t6, AX
L6:
MOV AX, t6
MOV c, AX
MOV AX, c
CALL OUTDEC
POP DX
POP CX
POP BX
POP AX
RET
relop_1 ENDP
relop_2 PROC
PUSH AX
PUSH BX
PUSH CX
PUSH DX
MOV AX, 2
MOV AX, 2
MOV a, AX
MOV AX, 1
MOV AX, 1
MOV b, AX
MOV AX, 3
MOV AX, 3
MOV c, AX
MOV AX, 0
MOV t7, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNL L7
MOV AX, 1
MOV t7, AX
L7:
MOV AX, t7
MOV c, AX
MOV AX, c
CALL OUTDEC
MOV AX, 0
MOV t8, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNLE L8
MOV AX, 1
MOV t8, AX
L8:
MOV AX, t8
MOV c, AX
MOV AX, c
CALL OUTDEC
MOV AX, 0
MOV t9, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNG L9
MOV AX, 1
MOV t9, AX
L9:
MOV AX, t9
MOV c, AX
MOV AX, c
CALL OUTDEC
MOV AX, 0
MOV t10, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNGE L10
MOV AX, 1
MOV t10, AX
L10:
MOV AX, t10
MOV c, AX
MOV AX, c
CALL OUTDEC
MOV AX, 0
MOV t11, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNE L11
MOV AX, 1
MOV t11, AX
L11:
MOV AX, t11
MOV c, AX
MOV AX, c
CALL OUTDEC
MOV AX, 0
MOV t12, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JE L12
MOV AX, 1
MOV t12, AX
L12:
MOV AX, t12
MOV c, AX
MOV AX, c
CALL OUTDEC
POP DX
POP CX
POP BX
POP AX
RET
relop_2 ENDP
relop_3 PROC
PUSH AX
PUSH BX
PUSH CX
PUSH DX
MOV AX, 2
MOV AX, 2
MOV a, AX
MOV AX, 2
MOV AX, 2
MOV b, AX
MOV AX, 3
MOV AX, 3
MOV c, AX
MOV AX, 0
MOV t13, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNL L13
MOV AX, 1
MOV t13, AX
L13:
MOV AX, t13
MOV c, AX
MOV AX, c
CALL OUTDEC
MOV AX, 0
MOV t14, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNLE L14
MOV AX, 1
MOV t14, AX
L14:
MOV AX, t14
MOV c, AX
MOV AX, c
CALL OUTDEC
MOV AX, 0
MOV t15, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNG L15
MOV AX, 1
MOV t15, AX
L15:
MOV AX, t15
MOV c, AX
MOV AX, c
CALL OUTDEC
MOV AX, 0
MOV t16, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNGE L16
MOV AX, 1
MOV t16, AX
L16:
MOV AX, t16
MOV c, AX
MOV AX, c
CALL OUTDEC
MOV AX, 0
MOV t17, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNE L17
MOV AX, 1
MOV t17, AX
L17:
MOV AX, t17
MOV c, AX
MOV AX, c
CALL OUTDEC
MOV AX, 0
MOV t18, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JE L18
MOV AX, 1
MOV t18, AX
L18:
MOV AX, t18
MOV c, AX
MOV AX, c
CALL OUTDEC
POP DX
POP CX
POP BX
POP AX
RET
relop_3 ENDP
relop_4 PROC
PUSH AX
PUSH BX
PUSH CX
PUSH DX
MOV AX, 2
MOV AX, 2
MOV a, AX
MOV AX, 2
MOV AX, 2
MOV b, AX
MOV AX, 3
MOV AX, 3
MOV c, AX
MOV AX, 0
MOV t19, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNL L19
MOV AX, 1
MOV t19, AX
L19:
MOV AX, t19
CMP AX, 0
JE L21
MOV AX, 0
MOV t20, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNL L20
MOV AX, 1
MOV t20, AX
L20:
MOV AX, t20
MOV c, AX
MOV AX, c
CALL OUTDEC
L21:
MOV AX, 0
MOV t21, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNLE L22
MOV AX, 1
MOV t21, AX
L22:
MOV AX, t21
CMP AX, 0
JE L24
MOV AX, 0
MOV t22, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNLE L23
MOV AX, 1
MOV t22, AX
L23:
MOV AX, t22
MOV c, AX
MOV AX, c
CALL OUTDEC
L24:
MOV AX, 0
MOV t23, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNG L25
MOV AX, 1
MOV t23, AX
L25:
MOV AX, t23
CMP AX, 0
JE L27
MOV AX, 0
MOV t24, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNG L26
MOV AX, 1
MOV t24, AX
L26:
MOV AX, t24
MOV c, AX
MOV AX, c
CALL OUTDEC
L27:
MOV AX, 0
MOV t25, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNGE L28
MOV AX, 1
MOV t25, AX
L28:
MOV AX, t25
CMP AX, 0
JE L30
MOV AX, 0
MOV t26, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNGE L29
MOV AX, 1
MOV t26, AX
L29:
MOV AX, t26
MOV c, AX
MOV AX, c
CALL OUTDEC
L30:
MOV AX, 0
MOV t27, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNE L31
MOV AX, 1
MOV t27, AX
L31:
MOV AX, t27
CMP AX, 0
JE L33
MOV AX, 0
MOV t28, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JNE L32
MOV AX, 1
MOV t28, AX
L32:
MOV AX, t28
MOV c, AX
MOV AX, c
CALL OUTDEC
L33:
MOV AX, 0
MOV t29, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JE L34
MOV AX, 1
MOV t29, AX
L34:
MOV AX, t29
CMP AX, 0
JE L36
MOV AX, 0
MOV t30, AX
MOV AX, a
MOV BX, b
CMP AX, BX
JE L35
MOV AX, 1
MOV t30, AX
L35:
MOV AX, t30
MOV c, AX
MOV AX, c
CALL OUTDEC
L36:
POP DX
POP CX
POP BX
POP AX
RET
relop_4 ENDP
main PROC
MOV AX, @DATA 
MOV DS, AX
CALL relop_1
CALL relop_2
CALL relop_3
CALL relop_4

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
