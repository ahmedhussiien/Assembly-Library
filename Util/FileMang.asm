;===========================================================================
; 							    FileMang.asm
;---------------------------------------------------------------------------
; Assembly x86 library
;
;
; Author: Ahmed Hussein
; Created: 
;
;
; This file provide some Procedures that helps in dealing with files 
; 
; Procedures included:
;	* OpenFile
;   * ReadFile
;   * CloseFile
;
;===========================================================================


;-------------------- Definitions --------------------
FileHandle  DW ?
FileName    DB ?


;-----------------------------------------------------
; OpenFile
;-----------------------------------------------------
; Opens a file in Read-Only mode
; @param DX = Offset of the File Name in memory
; @return FileHandle
; @exception if it fails to open the file the program will exit with code 1
;-----------------------------------------------------
OpenFile PROC
PUSH AX
PUSH DX

MOV AH, 3DH  ;Open the file
MOV AL, 0    ;Read-Only
LEA DX, FileName 
INT 21H 
JC @@FileError
MOV [FileHandle], AX
   
POP DX
POP AX
RET

@@FileError: MOV AX, 4C01H ;Exit with code 1 ( Error happened )
             INT 21H

OpenFile ENDP



;-----------------------------------------------------
; ReadFile
;-----------------------------------------------------
; Opens a file in Read-Only mode
; @param FileHandle = file handle of the currently opened file
; @param DX = offset to save data into.
; @param CX = number of bytes to read. For example for an image you read Width*Height bytes
; @return [DX] = data read from the file
;-----------------------------------------------------
ReadFile PROC
PUSH AX
PUSH BX

MOV AH, 3Fh
MOV BX, [FileHandle]
INT 21h

POP BX
POP AX
RET
ReadFile ENDP



;-----------------------------------------------------
; CloseFile
;-----------------------------------------------------
; Close the currently opened file handle
;-----------------------------------------------------
CloseFile PROC
PUSH AX
PUSH BX

MOV AH, 3Eh
MOV BX, [FileHandle]
INT 21h

POP BX
POP AX
RET
CloseFile ENDP