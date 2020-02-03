;===========================================================================
;                                 Math.asm
;---------------------------------------------------------------------------
; Assembly x86 library
;
;
; Author: Ahmed Hussein
; Created: 
;
;
; This file provide procedures that facilitate mathematicla operations
; 
; Procedures included:
;   * GetRandomNumber
;   * TranslateNumber
;
;===========================================================================

;-----------------------------------------------------
; GetRandomNumber
;-----------------------------------------------------
; Computer and return random number from zero to the upper limit 
; @param BX = upper limit
; @return DX = random number
;-----------------------------------------------------
GetRandomNumber PROC
PushA

MOV AH, 00h     ; Interrupt to get system timer in CX:DX 
INT 1AH

MOV CX , BX
mov AX, DX
XOR DX, DX
DIV CX          ; Here DX contains the remainder - from 0 to the upper limit

PopA
RET
GetRandomNumber ENDP



;-----------------------------------------------------
; TranslateNumber
;-----------------------------------------------------
; Translate a coordinate from one range to another
; by default lower limit is zero
;
; @param AX = Old number
; @param BX = Old upper limit
; @param CX = New upper limit
; @return AX = New number
;         
;-----------------------------------------------------
TranslateNumber PROC

PUSH DX
MOV DX, 00
MUL CX
DIV BX
POP DX
RET

TranslateNumber ENDP

;===========================================================================
;                               Macro wrappers
;===========================================================================
GetRandomNumber_M MACRO UpperLimit
    MOV BX UpperLimit
    CALL GetRandomNumber
ENDM GetRandomNumber_M 



TranslateNumber_M MACRO Number, OldUpperLimit, NewUpperLimit
PUSH BX
PUSH CX

MOV AX, Number
MOV BX, OldUpperLimit
MOV CX, NewUpperLimit

CALL TranslateNumber

POP CX
POP BX
ENDM TranslateNumber_M