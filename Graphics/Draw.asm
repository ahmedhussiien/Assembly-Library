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
; the file includes also Macro wrapper for some procedures
; 
; Procedures included:
;   * DrawData
;   * DrawObject
;   * DrawRectangle
;   * Erase
;   * EraseObject
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
               
MOV AL, [SI]    ;Pixel color
MOV AH, 0CH     ;Draw Pixel Command
INT 10H

INC SI
INC CX
DEC DI
JNZ @@DrawDataWidth 

POP DI      ; Reset Width
PUSH DI
SUB CX, DI  ; Reset X-coordinate

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
MOV DI, [SI]        ;Width
MOV BP, [SI + 02H]  ;Height
MOV CX, [SI + 04H]  ;X-coordinate
MOV DX, [SI + 06H]  ;Y-coordinate
ADD SI, 0AH         ;Start of pixels array

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

POP DI          ; Reset the width value
PUSH DI

SUB CX, DI      ; Reset X-coordinate
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
; Erase by drawing GX_BACKGROUND_COLOR
; @param DI = Width
; @param BP = Height
; @param CX = X-coordinate
; @param DX = Y-coordinate
;-----------------------------------------------------
Erase PROC
MOV AL, GX_BACKGROUND_COLOR
CALL DrawRectangle
RET
Erase ENDP


;-----------------------------------------------------
; EraseObject
;-----------------------------------------------------
; Erase an object by drawing GX_BACKGROUND_COLOR
; @param SI = Offset of the object
;-----------------------------------------------------
EraseObject PROC
MOV AL, GX_BACKGROUND_COLOR
MOV DI, [SI]
MOV BP, [SI + 02H]
MOV CX, [SI + 04H]
MOV DX, [SI + 06H]

CALL DrawRectangle
RET
EraseObject ENDP

;===========================================================================
;                               Macro wrappers
;===========================================================================
DrawData_M MACRO Width, Height, Xcoordinate, Ycoordinate, PixelArrayOffset

MOV DI, Width
MOV BP, Height
MOV CX, Xcoordinate
MOV DX, Ycoordinate
MOV SI, PixelArrayOffset
CALL DrawData

ENDM DrawData_M

;-----------------------------------------------------

DrawRectangle_M MACRO Width, Height, Xcoordinate, Ycoordinate, Color

MOV DI, Width
MOV BP, Height
MOV CX, Xcoordinate
MOV DX, Ycoordinate
MOV AL, Color
CALL DrawRectangle

ENDM DrawRectangle_M 

;-----------------------------------------------------

Erase_M MACRO Width, Height, Xcoordinate, Ycoordinate

MOV DI, Width
MOV BP, Height
MOV CX, Xcoordinate
MOV DX, Ycoordinate
CALL Erase

ENDM Erase_M 