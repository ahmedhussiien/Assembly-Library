;===========================================================================
;                               Animations.asm
;---------------------------------------------------------------------------
; Assembly x86 library
;
;
; Author: Ahmed Hussein
; Created: 
;
;
; This file provide some Procedures for animating objects like shifting
; 
; Procedures included:
;	* ShiftUp
;	* ShiftDown
;	* ShiftRight
;	* ShiftLeft
;
; Note: 
;	1.	Animation works only on "Draw-able" objects you can see more on how to
;		construct those in the main document.
;	2.	Shifting procedures are intended for small shifting animations
;		if a big shift is used it may result in erasing a big portion of the screen
;		unintentially.
;		If you want to CHANGE the position of an object you can easily erase it and
;		draw it again.
;===========================================================================


;-------------------- Definitions --------------------
GX_ShiftStep			DB 05H
GX_BackgroundHeight		DB 320
GX_BackgroundWidth		DB 480

;-----------------------------------------------------
; ShiftDown
;-----------------------------------------------------
; Shifts down an object by GX_ShiftStep
; @param SI = offset of the object
;-----------------------------------------------------
ShiftDown PROC
PUSHA

MOV BP, [SI + 02H]		;Height
MOV DX, [SI + 06H]		;Y-coordinate
ADD DX, GX_ShiftStep
ADD DX, BP

;Check borders
CMP DX, GX_BackgroundHeight 
JG @@NoShiftDown 
SUB DX, BP

;Drawing
MOV [SI + 06H], DX
CALL DrawObject

;Erasing
MOV DI, [SI]
MOV BP, [SI + 02H] 	
MOV CX, [SI + 04H]
MOV DX, [SI + 06H]	
SUB DX, GX_ShiftStep
MOV BP, GX_ShiftStep
CALL Erase	

@@NoShiftDown:	
			POPA
			RET
ShiftDown ENDP



;-----------------------------------------------------
; ShiftUp
;-----------------------------------------------------
; Shifts up an object by GX_ShiftStep
; @param SI = offset of the object
;-----------------------------------------------------
ShiftUp PROC
PUSHA

MOV DX, [SI + 06H]

;Check borders
CMP DX, GX_ShiftStep 
JB @@NoShiftUp 
SUB DX, GX_ShiftStep

;Drawing
MOV [SI + 06H], DX
CALL DrawObject

;Erasing
MOV DI, [SI]		;Width
MOV BX, [SI + 02H]	;Height
MOV CX, [SI + 04H]	;X-coordinate
MOV DX, [SI + 06H]	;Y-coordinate
ADD DX, BX			
MOV BX, GX_ShiftStep
CALL Erase	

@@NoShiftUp:POPA
			RET
ShiftUp ENDP