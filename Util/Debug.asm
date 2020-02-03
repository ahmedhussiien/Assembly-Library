;===========================================================================
;                               Debug.asm
;---------------------------------------------------------------------------
; Assembly x86 library
;
;
; Author: Ahmed Hussein
; Created: 
;
;
; This file provide some Procedures & Macros that helps in the debugging process
; 
; Procedures included:
;   * CreateDebugFile
;   * CloseDebugFile
;
; Macros includes:
;   * PrintDebugByte
;   * PrintDebugWord
;   * PrintDebugString
;   * PrintDebugNEWL
;
;===========================================================================


;-------------------- Definitions --------------------
_MAX_BYTES_DEBUG_STRING     EQU 33
_DebugFileHandle            DW ?
_DebugFileName              DB 'Debug.txt', 0
_DebugString                DB _MAX_BYTES_DEBUG_STRING DUP(?)



;-----------------------------------------------------
; CreateDebugFile
;-----------------------------------------------------
; Creates _DebugFileName file
;
; Note: This procedure should be called once in your code, preferably
;       at the beginning of your program. Calling it multiple times will
;       cause the loss of written data in the debug file.
;-----------------------------------------------------
CreateDebugFile PROC
PUSH AX
PUSH DX

LEA DX, _DebugFileName
CreateFile DX
MOV _DebugFileHandle, AX

POP DX
POP BX
RET

CreateDebugFile ENDP



;-----------------------------------------------------
; CloseDebugFile
;-----------------------------------------------------
; Closes _DebugFileName file
;-----------------------------------------------------
CloseDebugFile PROC

CloseFile _DebugFileHandle 
RET

CloseDebugFile ENDP



;-----------------------------------------------------
; PrintDebugByte
;-----------------------------------------------------
; Writes a byte to the debugging file
;-----------------------------------------------------
PrintDebugByte MACRO Byte

PUSH DX
MOV _DebugString, Byte
LEA DX, _DebugString
WriteToFile _DebugFileHandle, 01, DX
POP DX

ENDM PrintDebugByte



;-----------------------------------------------------
; PrintDebugWord
;-----------------------------------------------------
; Writes a word to the debugging file
;-----------------------------------------------------
PrintDebugWord MACRO Word
PUSH DX
MOV DX, Word
MOV _DebugString, DL
MOV _DebugString + 1, DH
LEA DX, _DebugString
WriteToFile _DebugFileHandle, 02, DX

POP DX
ENDM PrintDebugByte



;-----------------------------------------------------
; PrintDebugWord
;-----------------------------------------------------
; Writes a string to the debugging file
;-----------------------------------------------------
PrintDebugString MACRO String, StringLength
PUSH DX
MOV _DebugString, String
LEA DX, _DebugString
WriteToFile _DebugFileHandle, StringLength, DX

POP DX
ENDM PrintDebugByte



;-----------------------------------------------------
; PrintDebugWord
;-----------------------------------------------------
; Writes a word to the debugging file
;-----------------------------------------------------
PrintDebugNEWL MACRO 
PUSH DX
MOV _DebugString, NewLineASCII
LEA DX, _DebugString
WriteToFile _DebugFileHandle, 01, DX

POP DX
ENDM PrintDebugByte