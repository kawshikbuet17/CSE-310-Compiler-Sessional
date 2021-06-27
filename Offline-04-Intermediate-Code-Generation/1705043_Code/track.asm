;line 1:
a DW '?'

;line 4:
MOV AX, 10

;line 4:
MOV AX, 10
MOV a, AX

;line 5:
MOV AX, 5

;line 8:
MOV AX, 5
CMP AX, 0
JE L1
MOV AX, a
CALL OUTDEC
L1:

;line 11:
MOV AX, 10

;line 11:
MOV AX, 10
MOV a, AX

;line 15:
MOV AX, a
CMP AX, 0
JE L2
MOV AX, a
CALL OUTDEC
L2:

;line 18:
MOV AX, 10

;line 18:
MOV AX, 10
MOV a, AX

;line 19:
MOV AX, 0

;line 22:
MOV AX, 0
CMP AX, 0
JE L3
MOV AX, a
CALL OUTDEC
L3:

;line 25:
MOV AX, 0

;line 25:
MOV AX, 0
MOV a, AX

;line 29:
MOV AX, a
CMP AX, 0
JE L4
MOV AX, a
CALL OUTDEC
L4:

