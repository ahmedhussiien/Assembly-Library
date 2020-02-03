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
;   * InitializeHeap
;   * AllocateMemory
;   * FreeMemory
;   * FreeAll
;
;===========================================================================



;-------------------- Definitions --------------------
_MAX_NUM_SEGMENTS   EQU 40
_STACK_SIZE         EQU 64
_NumOfSegments      DB  0
_SegmentsOffsetArr  DW  _MAX_NUM_SEGMENTS DUP(?)


;-----------------------------------------------------
; InitializeHeap
;-----------------------------------------------------
; Frees program memory 
; it must be called before allocating memory
;   or a insufficient memory error will be thrown
;-----------------------------------------------------
InitializeHeap PROC
PUSH DX
PUSH BX
PUSH AX

MOV DX, SS                  ; Stack segment
MOV BX, _STACK_SIZE/16 +1   ; Stack size in paragraphs
ADD BX, DX                  ; BX = end
MOV AX, ES          
SUB BX, AX                  ; BX = new size in paragraphs
MOV AH, 4AH
INT 21H

POP AX
POP BX
POP DX
RET
InitializeHeap ENDP

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

MOV CH, _NumOfSegments
MOV CL, 02
SHL CH, CL
MOV SI, OFFSET _SegmentsOffsetArr
XCHG CH, CL
MOV CH, 00
ADD SI, CX

MOV [SI], AX 
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
;            = TRUE is succesful
; Note: The segment must be allocated by AllocateMemory procedure !
;-----------------------------------------------------
FreeMemory PROC
PUSH DI
PUSH SI
PUSH CX

MOV CL, _NumOfSegments
CMP _NumOfSegments, 00
JE @@FreeMemoryRet

MOV AX, ES
MOV DI, OFFSET _SegmentsOffsetArr
MOV SI, OFFSET _SegmentsOffsetArr

;Loop to the given segment offset
@@GivenSegOffset:   CMP [SI], AX
                    JE @@LastSegOffset
                    INC SI
                    INC SI
                    JMP @@GivenSegOffset

;Loop to the last segment offset
@@LastSegOffset:    INC DI
                    INC DI
                    DEC CL
                    JNZ @@LastSegOffset

DEC DI
DEC DI

;Free Memory segment
MOV AH, 49H
INT 21H
JC @@FreeMemoryError
DEC _NumOfSegments

;Copy data from last segment to the deleted segment
CMP SI, DI
JE @@FreeMemoryRet
MOV AX, [DI]
MOV [SI], AX

@@FreeMemoryRet:    MOV AX, TRUE

@@FreeMemoryError:  POP CX
                    POP SI
                    POP DI
                    RET
                    
FreeMemory ENDP



;-----------------------------------------------------
; ModifyBlock
;-----------------------------------------------------
; Modifies memory blocks allocated 
;
; @param ES = Segment of the block 
; @param BX = New requested block size in paragraphs
; @return AX = error code if any error occurred 
;            = TRUE is succesful
;-----------------------------------------------------
ModifyBlock PROC

MOV AH, 04AH
INT 21H
JC @@ModifyMemoryError
MOV AX, TRUE

@@ModifyMemoryError: RET

ModifyBlock ENDP



;-----------------------------------------------------
; FreeAll
;-----------------------------------------------------
; releases all allocated memory segments
; @return AX = error code if any error occurred 
;            = TRUE is succesful
;-----------------------------------------------------
FreeAll PROC

PUSH CX
PUSH DI
PUSH BP
PUSH ES

MOV CL, _NumOfSegments
MOV DI, OFFSET _SegmentsOffsetArr 
MOV BP, 00
CMP CL, 00
JE @@FreeAllRet

@@FreeNextMem:  MOV ES, [DI + BP]
                MOV AH, 49H
                INT 21H
                JC @@FreeAllRet
                INC BP
                INC BP
                DEC CL
                JNZ @@FreeNextMem

MOV AX, TRUE
@@FreeAllRet:   POP ES
                POP BP
                POP DI
                POP CX
                RET
FreeAll ENDP