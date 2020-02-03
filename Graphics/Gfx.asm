;===========================================================================
;                                 Gfx.asm
;---------------------------------------------------------------------------
; Assembly x86 library
;
;
; Author: Ahmed Hussein
; Created: 
;
;
; This file provide procedures manipulate what is being drawn
; on the screen
; 
; Procedures included:
;   * ClearPage
;   * SetTextMode
;   * SetVideoModeMCGA
;   * SetVideoModeVGA
;   * Scroll
;
;===========================================================================



;-----------------------------------------------------
; ClearPage
;-----------------------------------------------------
ClearPage PROC

PUSH AX
PUSH BX
PUSH CX
PUSH DX

MOV AX, 00H
MOV BH, GX_BACKGROUND_COLOR
MOV CX, 00H
MOV DX, 184FH ;End of screen coordinates
INT 10H

POP DX
POP CX
POP BX
POP AX
RET

ClearPage ENDP

;-----------------------------------------------------
; SetVideoModeVGA
;-----------------------------------------------------
; Set video mode to 640x480 16 color graphics (VGA)
;-----------------------------------------------------
SetVideoModeVGA PROC
PUSH AX

MOV AH, 00H
MOV AL, 12H
INT 10H

MOV GX_ScreenWidth, GX_VGA_MODE_W
MOV GX_ScreenHeight, GX_VGA_MODE_H 

POP AX
RET
SetVideoModeVGA ENDP


;-----------------------------------------------------
; SetVideoModeMCGA
;-----------------------------------------------------
; Set video mode to 320x200 256 color graphics (MCGA, VGA)
;-----------------------------------------------------
SetVideoModeMCGA PROC
PUSH AX

MOV AH, 00H
MOV AL, 13H
INT 10H

MOV GX_ScreenWidth, GX_MCGA_MODE_W
MOV GX_ScreenHeight, GX_MCGA_MODE_H          

POP AX
RET
SetVideoModeMCGA ENDP


;-----------------------------------------------------
; SetTextMode
;-----------------------------------------------------
; Set video mode to 80x25 16 color text (CGA,EGA,MCGA,VGA)
;-----------------------------------------------------
SetTextMode PROC
PUSH AX

MOV AH, 00H
MOV AL, 03H
INT 10H

MOV GX_ScreenWidth, GX_TEXT_MODE_COL
MOV GX_ScreenHeight, GX_TEXT_MODE_ROW

POP AX
RET
SetTextMode ENDP


;-----------------------------------------------------
; Scroll
;-----------------------------------------------------
; Scroll page up or down
;-----------------------------------------------------
Scroll MACRO FromX, FromY, ToX, ToY, Color, NumberOfLines
PUSHA

MOV CL, FromX
MOV CH, FromY
MOV DL, ToX
MOV DH, ToY
MOV BH, Color
MOV AL, NumberOfLines
MOV AH, 06H
INT 10H

POPA
ENDM Scroll
