;===========================================================================
;                               Draw.asm
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
;	* DrawData
;	* DrawObject
;	* DrawRectangle
;	* Erase
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
DrawData PROC
PUSHA
PUSH DI

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
DrawData ENDP



;-----------------------------------------------------
; DrawObject
;-----------------------------------------------------
; Draws an object
; Return to the main document to see how to construct a "Draw-able" object
; @param SI = Offset of the object
;-----------------------------------------------------
DrawObject PROC
PUSHA
MOV DI, [SI] 		;Width
MOV BP, [SI + 02H]	;Height
MOV CX, [SI + 04H]	;X-coordinate
MOV DX, [SI + 06H]	;Y-coordinate
ADD SI, 0AH 		;Start of pixels array

CALL DrawData

POPA
RET
DrawObject ENDP


;-----------------------------------------------------
; DrawRectangle
;-----------------------------------------------------
; Draws a rectangle with a certain color
; @param DI = Width
; @param BP = Height
; @param CX = X-coordinate
; @param DX = Y-coordinate
; @param AL = Color
;-----------------------------------------------------
DrawRectangle PROC
PUSHA

MOV AH, 0CH
PUSH DI

@@DrawLength:
@@DrawWidth:    
INT 10H
INC CX
DEC DI
JNZ @@DrawWidth 

POP DI			; Reset the width value
PUSH DI

SUB CX, DI		; Reset X-coordinate
INC DX
DEC BP
JNZ @@DrawLength

POP DI
POPA
RET
DrawRectangle ENDP


;-----------------------------------------------------
; Erase
;-----------------------------------------------------
; Erase by drawing BACKGROUND_COLOR
; @param DI = Width
; @param BP = Height
; @param CX = X-coordinate
; @param DX = Y-coordinate
;-----------------------------------------------------
Erase PROC
MOV AL, BACKGROUND_COLOR
CALL DrawRectangle
RET
Erase ENDP

;===========================================================================
;								Macro wrappers
;===========================================================================
DrawData_M MACRO Width, Height, X-coordinate, Y-coordinate, PixelArrayOffset

MOV DI, Width
MOV BP, Height
MOV CX, X-coordinate
MOV DX, Y-coordinate
MOV SI, PixelArrayOffset
CALL DrawData

DrawData_M ENDM

;-----------------------------------------------------

DrawRectangle_M MACRO Width, Height, X-coordinate, Y-coordinate, Color

MOV DI, Width
MOV BP, Height
MOV CX, X-coordinate
MOV DX, Y-coordinate
MOV SI, PixelArrayOffset
CALL DrawRectangle

DrawRectangle_M ENDM

;-----------------------------------------------------

Erase_M MACRO Width, Height, X-coordinate, Y-coordinate

MOV DI, Width
MOV BP, Height
MOV CX, X-coordinate
MOV DX, Y-coordinate
CALL Erase

Erase_M ENDM