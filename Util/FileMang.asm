;===========================================================================
;                               FileMang.asm
;---------------------------------------------------------------------------
; Assembly x86 library
;
;
; Author: Ahmed Hussein
; Created: 
;
;
; This file provide some Macros that ease the process of dealing with files 
; 
; Macros included:
;   * OpenFile
;   * ReadFile
;   * CloseFile
;   * CreateFile
;   * WriteToFile
;
;===========================================================================



;-----------------------------------------------------
; OpenFile
;-----------------------------------------------------
; Opens a file 
;
; @param FileNamePtr = Pointer to ASCII File name in memory. For example: 'test.txt', 0
; @param OpenAccessMode = 00  read only
;                         01  write only
;                         02  read/write
;
; @return AX = File handle
; @exception CF = 1, AX = Error code
;-----------------------------------------------------
OpenFile MACRO FileNamePtr, OpenAccessMode
PUSH DX

MOV DX, FileNamePtr
MOV AL, OpenAccessMode
MOV AH, 3DH  ;Open the file
INT 21H 

POP DX
ENDM OpenFile



;-----------------------------------------------------
; ReadFile
;-----------------------------------------------------
; Reads file binary data and save it to memory
;
; @param DataPtr = Offset to save data into.
; @param NumOfBytes = Number of bytes to read. For example for an image you read Width*Height bytes
; @return DataPtr = data read from the file
;-----------------------------------------------------
ReadFile MACRO FileHandle, DataPtr, NumOfBytes
PUSHA

MOV BX, FileHandle
MOV DX, DataPtr
MOV CX, NumOfBytes
MOV AH, 3Fh
INT 21h

POPA
ENDM ReadFile



;-----------------------------------------------------
; CloseFile
;-----------------------------------------------------
; Closes the passed file handle
;-----------------------------------------------------
CloseFile MACRO FileHandle
PUSH AX
PUSH BX

MOV BX, FileHandle
MOV AH, 3Eh
INT 21h

POP BX
POP AX
ENDM CloseFile



;-----------------------------------------------------
; CreateFile
;-----------------------------------------------------
; Creates a new file
; 
; @param FileNamePtr = Pointer to ASCII File name in memory
; @return AX = File handle
; @exception CF = 1, AX = Error code
;-----------------------------------------------------
CreateFile MACRO FileNamePtr
PUSH CX
PUSH DX

MOV DX, FileNamePtr
MOV CX, 00
MOV AH, 3CH
INT 21H

POP DX
POP CX
ENDM CreateFile



;-----------------------------------------------------
; WriteToFile
;-----------------------------------------------------
; Write data to the passed file handle
; 
; @param DataPtr = Pointer to data buffer
; @param NumOfBytes = Number of bytes to write. Maximum = 2^16
;-----------------------------------------------------
WriteToFile MACRO FileHandle, NumOfBytes, DataPtr
PUSH AX
PUSH BX
PUSH CX

MOV BX, FileHandle
MOV CX, NumOfBytes
MOV AH, 40H
INT 21H

POP CX
POP BX
POP AX
ENDM WriteToFile