;line 2:
MOV AX, 2

;line 2:
MOV AX, 2
MOV AX, 2
MOV BX, a
MUL BX
MOV t1, AX

;line 3:
MOV AX, 9

;line 3:
MOV AX, 9
MOV AX, 9
MOV a, AX

;line 8:
MOV AX, f ( a )
MOV BX, a
ADD AX, BX
MOV t2, AX

;line 8:
MOV AX, t2
MOV BX, b
ADD AX, BX
MOV t3, AX

;line 8:
MOV AX, t2
MOV BX, b
ADD AX, BX
MOV t3, AX
MOV AX, t3
MOV x, AX

;line 14:
MOV AX, 1

;line 14:
MOV AX, 1
MOV AX, 1
MOV a, AX

;line 15:
MOV AX, 2

;line 15:
MOV AX, 2
MOV AX, 2
MOV b, AX

;line 16:
MOV AX, a
PUSH AX
MOV AX, b
PUSH AX
CALL g
POP AX
MOV AX, g ( a , b )
MOV a, AX

;line 18:
MOV AX, 0

