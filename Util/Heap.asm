;===========================================================================
;                                 Heap.asm
;---------------------------------------------------------------------------
; Assembly x86 library
;
;
; Author: Ahmed Hussein
; Created: 
;
;
; This file provides procedures to dynamically manipulate memory
; 
; Proceduress included:
;	* 
;
;===========================================================================



;-------------------- Definitions --------------------
_MAX_NUM_SEGMENTS   EQU 40
_NumOfSegments      DB  0
_SegmentsOffsetArr  DW  _MAX_NUM_SEGMENTS DUP(?)



;-----------------------------------------------------
; AllocateMemory
;-----------------------------------------------------
; Allocate a new segment in memory with the passed size
; @param BX = number of memory paragraphs requested. Where each paragraph = 16 bytes
; @return AX = segment address of allocated memory block
;            = Null if any error occurred
;-----------------------------------------------------
AllocateMemory PROC

MOV AL, _NumOfSegments
CMP AL, _MAX_NUM_SEGMENTS
JE @@AllocateError

MOV AH, 48H
INT 21H
JC @@AllocateError

PUSH SI
PUSH CX

MOV SI, OFFSET _SegmentsOffsetArr
MOV CL, _NumOfSegments
CMP CL, 0
JE @@AddOffsetToArr

@@GetLastSegmentPos: ADD SI, 02
                     DEC CL
                     JNZ @@GetLastSegmentPos

@@AddOffsetToArr:    MOV [SI], AX 
                     INC _NumOfSegments

POP CX
POP SI 
JMP @@AllocateMemoryRet

@@AllocateError:      MOV AX, NULL
@@AllocateMemoryRet:  RET

AllocateMemory ENDP



;-----------------------------------------------------
; FreeMemory
;-----------------------------------------------------
; releases passed memory segment back to DOS
; @param ES = segment of the block to be returned
; @return AX = error code if any error occurred
;-----------------------------------------------------
FreeMemory PROC

MOV AH, 49H
INT 21H

RET
FreeMemory ENDP



;-----------------------------------------------------
; FreeAll
;-----------------------------------------------------
; releases all allocated memory segments
;-----------------------------------------------------
FreeAll PROC

PUSH CX
PUSH DI
PUSH AX
PUSH BP
PUSH ES

MOV CL, _NumOfSegments
MOV DI, OFFSET _SegmentsOffsetArr 
MOV BP, 00
CMP CL, 00
JE @@FreeMemoryRet

@@FreeNextMem:
                MOV ES, [DI + BP]
                MOV AH, 49H
                INT 21H
                INC BP
                INC BP
                DEC CL
                JNZ @@FreeNextMem


@@FreeMemoryRet:
                POP ES
                POP BP
                POP AX
                POP DI
                POP CX
                RET
FreeAll ENDP