;===========================================================================
; 								Draw.asm
;---------------------------------------------------------------------------
; Assembly x86 library
;
;
; Author: Ahmed Hussein
; Created: 
;
;
; This file provide some Procedures for drawing on VGA screen
; 
; Procedures included:
;	* GetRandomNumber
;
;===========================================================================


;-----------------------------------------------------
; DrawData
;-----------------------------------------------------
; Draws an pixel array at given coordinates
; @param DI = Width
; @param BP = Height
; @param CX = X-coordinate
; @param DX = Y-coordinate
; @param SI = offset of the pixel array
;-----------------------------------------------------
DrawData proc

PUSHA

MOV DI, [SI] 		;Width
MOV BP, [SI + 02H]	;Height
MOV CX, [SI + 04H]	;X-coordinate
MOV DX, [SI + 06H]	;Y-coordinate

PUSH DI
ADD SI, 0AH 		; Start of pixels array

@@DrawDataLength:
@@DrawDataWidth:
               
MOV AL, [SI] 	;Pixel color
MOV AH, 0CH 	;Draw Pixel Command
INT 10H

INC SI
INC CX
DEC DI
JNZ @@DrawDataWidth 

POP DI		; Reset Width
PUSH DI
SUB CX, DI 	; Reset X-coordinate

INC DX
DEC BP  
JNZ @@DrawDataLength
 
POP DI 
POPA
RET
DrawData endp



DrawObject PROC




DrawObject ENDP