;===========================================================================
;                                 Print.asm
;---------------------------------------------------------------------------
; Assembly x86 library
;
;
; Author: Ahmed Hussein
; Created: 
;
;
; This file provide some Procedures for printing text on the screen
; All procedures provided works on top of Interrupt 10H
; 
; Procedures included:
;   * PrintString
;   * PrintStringVGA
;
;===========================================================================


;-----------------------------------------------------
; PrintString
;-----------------------------------------------------
; Prints a string with a certain color in text mode
; Prints new line whenever it reaches screen limit, where the 
;   new line starts from the same X-coordinate.
;
; @param BH = Display page
; @param DH = Row position where string is to be written
; @param DL = Column position where string is to be written
; @param SI = Offset of the string
; @param CX = Length of the string
; @param BL = Pixel Color 
;
;        BL =  |7|6|5|4|3|2|1|0| 
;              | | | | | | | |___ B           Foreground
;              | | | | | | |_____ G           Foreground
;              | | | | | |_______ R           Foreground 
;              | | | | |_________ Intensity   Foreground 
;              | | | |___________ B           Background
;              | | |_____________ G           Background
;              | |_______________ R           Background
;              |_________________ Blinking    Background
;        
;        Examples: 00FH --> White on black background
;                  0FAH --> Green on white blinking
;        
;         
;-----------------------------------------------------
PrintString PROC
PUSHA

MOV DI, DX
CMP CX, 00
JE @@PrintStringRet
           
@@PrintChar:    PUSH CX
                MOV AH,2
                INT 10H      ;Setting cursor
           
                MOV AL, [SI] 
                INC SI         

                MOV CX, 1    ;Print character once
                MOV AH, 9
                INT 10H      ;Printing character
                
                INC DL       ;Increment cursor position
                CMP DL, GX_TEXT_MODE_COL
                JB @@SameLine
                MOV DX, DI
                INC DH
                MOV DI, DX
                
    @@SameLine: POP CX
                DEC CX
                JNZ @@PrintChar   

@@PrintStringRet:POPA
                 RET

PrintString ENDP



;-----------------------------------------------------
; PrintStringVGA
;-----------------------------------------------------
; Prints a string with a certain color on graphics mode.
; This procedure translate coordinates from graphics mode to text mode
;   to print string in the intented position. 
; The resulted coordinates may not be as accurate as needed.
;
; @param BH = Display page
; @param SI = Offset of the string
; @param AX = Length of the string
; @param CX = X-coordinate
; @param DX = Y-coordinate
; @param BL = Pixel Color 
;         
;-----------------------------------------------------
PrintStringVGA PROC

PUSH AX

; Translating coordinates from graphics mode to text mode
TranslateNumber_M DX, GX_ScreenHeight, GX_TEXT_MODE_ROW
MOV DH, AL

TranslateNumber_M CX, GX_ScreenWidth, GX_TEXT_MODE_COL
MOV DL, AL

POP CX ;Pop string length in CX
CALL PrintString

RET
PrintStringVGA ENDP



;===========================================================================
;                               Macro wrappers
;===========================================================================
PrintString_M MACRO DispPage, StringLength, RowPos, ColumnPos, Color, PointerToString
PUSHA

MOV BH, DispPage
MOV CX, StringLength
MOV DL, ColumnPos
MOV DH, RowPos
MOV BL, Color
MOV SI, PointerToString
CALL PrintString

POPA
ENDM PrintString_M

PrintStringVGA_M MACRO DispPage, StringLength, Xcoordinate, Ycoordinate, Color, PointerToString
PUSHA
 
MOV BH, DispPage
MOV CX, Xcoordinate
MOV DX, Ycoordinate
MOV AX, StringLength
MOV BL, Color
MOV SI, PointerToString
CALL PrintStringVGA

POPA
ENDM PrintStringVGA_M