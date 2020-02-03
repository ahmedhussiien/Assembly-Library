;===========================================================================
;                                 Anima.asm
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
;   * ShiftUp
;   * ShiftDown
;   * ShiftRight
;   * ShiftLeft
;
; Note: 
;   1.  Animation works only on "Draw-able" objects you can see more on how to
;       construct those in the main document.
;   2.  Shifting animation will stop whenever it hit screen borders
;   3.  Shifting procedures are intended for small shifting animations
;       if a big shift is used it may result in erasing a big portion of the screen
;       unintentially.
;       If you want to CHANGE the position of an object you can easily erase it and
;       draw it again.
;===========================================================================


;-------------------- Definitions --------------------
GX_ShiftStep        EQU     05H



;-----------------------------------------------------
; ShiftDown
;-----------------------------------------------------
; Shifts down an object by GX_ShiftStep
; @param SI = offset of the object
;-----------------------------------------------------
ShiftDown PROC
PUSHA

MOV BP, [SI + 02H]      ;Height
MOV DX, [SI + 06H]      ;Y-coordinate

;Check borders
ADD DX, GX_ShiftStep
ADD DX, BP
CMP DX, GX_ScreenHeight 
JG @@NoShiftDown 
SUB DX, BP

;Drawing
MOV [SI + 06H], DX
CALL DrawObject

;Erasing
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
MOV DI, [SI]        ;Width
MOV BP, [SI + 02H]  ;Height
MOV CX, [SI + 04H]  ;X-coordinate
MOV DX, [SI + 06H]  ;Y-coordinate
ADD DX, BP          
MOV BP, GX_ShiftStep
CALL Erase  

@@NoShiftUp:POPA
            RET
ShiftUp ENDP


;-----------------------------------------------------
; ShiftLeft
;-----------------------------------------------------
; Shifts left an object by GX_ShiftStep
; @param SI = offset of the object
;-----------------------------------------------------
ShiftLeft PROC
PUSHA
MOV CX, [SI + 04H]

;Check borders
CMP CX, GX_ShiftStep 
JB @@NoShiftLeft 
SUB CX, GX_ShiftStep

;Drawing
MOV [SI + 04h], CX
CALL DrawObject

;Erasing
MOV DI, [SI]
MOV BP, [SI + 02H]  
MOV CX, [SI + 04H]
MOV DX, [SI + 06H]  
ADD CX, DI
MOV DI, GX_ShiftStep
CALL Erase  

@@NoShiftLeft:  POPA
                RET
ShiftLeft ENDP


;-----------------------------------------------------
; ShiftRight
;-----------------------------------------------------
; Shifts Right an object by GX_ShiftStep
; @param SI = offset of the object
;-----------------------------------------------------
ShiftRight PROC
PUSHA

MOV DI, [SI]            ;Width
MOV CX, [SI + 04h]      ;X-coordinate

;Check borders
ADD CX, GX_ShiftStep
ADD CX, DI
CMP CX, GX_ScreenWidth
JG @@NoShiftRight 
SUB CX, DI

;Drawing
MOV [SI + 04H], CX
CALL DrawObject

;Erasing
MOV BP, [SI + 02H]  
MOV CX, [SI + 04H]
MOV DX, [SI + 06H]  
SUB CX, GX_ShiftStep
MOV DI, GX_ShiftStep
CALL Erase  

@@NoShiftRight: POPA
                RET
ShiftRight ENDP