;===========================================================================
;                               Graphics.inc
;---------------------------------------------------------------------------
; Assembly x86 library
;
;
; Author: Ahmed Hussein
; Created: 
;
; This files includes some deinitions and constants used in both graphics
; and utility procedures 
; This file must be included in the data segment
;===========================================================================

;-------------------- Includes --------------------
include AsmLib\Graphics\VGAColor.asm
include AsmLib\Util\KeysMap.asm



;-------------------- Definitions --------------------
TRUE                    EQU     1
FALSE                   EQU     0
NULL                    EQU     0
NewLineASCII            EQU     0AH
GX_BACKGROUND_COLOR     EQU     COLOR_BLACK
GX_TEXT_MODE_COL        EQU     80
GX_TEXT_MODE_ROW        EQU     25
GX_VGA_MODE_W           EQU     640
GX_VGA_MODE_H           EQU     480
GX_MCGA_MODE_W          EQU     320
GX_MCGA_MODE_H          EQU     200
GX_ScreenHeight         DW      ?
GX_ScreenWidth          DW      ?


