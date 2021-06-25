;line 1:
a DB '?'

;line 1:
b DB '?'

;line 1:
c DB '?'

;line 4:
MOV AX, 10

;line 4:
MOV a, AX

;line 5:
MOV AX, 20

;line 5:
MOV b, AX

;line 6:
MOV AX, 30

;line 6:
MOV c, AX

;line 8:
MOV AX, 10

;line 8:
MOV AX, 10
MOV AX, a
MOV BX, 10
MUL BX
MOV t1, AX

;line 8:
MOV c, AX

;line 9:
MOV AX, 10

;line 9:
MOV AX, 10
MOV BX, a
MUL BX
MOV t2, AX

;line 9:
MOV c, AX

;line 10:
MOV AX, a
MOV BX, b
MUL BX
MOV t3, AX

;line 10:
MOV c, AX

;line 11:
MOV AX, c
MOV BX, a
MUL BX
MOV t4, AX

;line 11:
MOV c, AX

;line 13:
MOV AX, 10

;line 13:
MOV AX, 10
MOV AX, a
MOV BX, 10
XOR DX, DX
CWD
IDIV AX
MOV t5, AX

;line 13:
MOV c, AX

;line 14:
MOV AX, 10

;line 14:
MOV AX, 10
MOV BX, a
XOR DX, DX
CWD
IDIV AX
MOV t6, AX

;line 14:
MOV c, AX

;line 15:
MOV AX, a
MOV BX, b
XOR DX, DX
CWD
IDIV AX
MOV t7, AX

;line 15:
MOV c, AX

;line 16:
MOV AX, c
MOV BX, a
XOR DX, DX
CWD
IDIV AX
MOV t8, AX

;line 16:
MOV c, AX

;line 18:
MOV AX, 10

;line 18:
MOV AX, a
MOV BX, 10
ADD AX, BX

;line 18:
MOV c, AX

;line 19:
MOV AX, 10

;line 19:
MOV AX, 10
MOV BX, a
ADD AX, BX

;line 19:
MOV c, AX

;line 20:
MOV AX, a
MOV BX, b
ADD AX, BX

;line 20:
MOV c, AX

;line 21:
MOV AX, c
MOV BX, a
ADD AX, BX

;line 21:
MOV c, AX

;line 23:
MOV AX, 10

;line 23:
MOV AX, a
MOV BX, 10
SUB AX, BX

;line 23:
MOV c, AX

;line 24:
MOV AX, 10

;line 24:
MOV AX, 10
MOV BX, a
SUB AX, BX

;line 24:
MOV c, AX

;line 25:
MOV AX, a
MOV BX, b
SUB AX, BX

;line 25:
MOV c, AX

;line 26:
MOV AX, c
MOV BX, a
SUB AX, BX

;line 26:
MOV c, AX

;line 28:
MOV AX, c
INC AX
MOV c, AX
