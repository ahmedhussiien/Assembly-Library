;===========================================================================
; 								Math.asm
;---------------------------------------------------------------------------
; Assembly x86 library
;
;
; Author: Ahmed Hussein
; Created: 
;
;
; This file provide some Procedures that generates random numbers
; 
; Procedures included:
;	* GetRandomNumber
;
;===========================================================================

;-----------------------------------------------------
; GetRandomNumber
;-----------------------------------------------------
; Computer and return random number from zero to the upper limit 
; @param BX = upper limit
;-----------------------------------------------------
GetRandomNumber PROC
PushA

MOV AH, 00h   	; Interrupt to get system timer in CX:DX 
INT 1AH

MOV CX , BX
mov AX, DX
XOR DX, DX
DIV CX			; Here DX contains the remainder - from 0 to 

PopA
RET
GetRandomNumber ENDP


;===========================================================================
;								Macro wrappers
;===========================================================================
GetRandomNumber_M MACRO UpperLimit
	MOV BX UpperLimit
	CALL GetRandomNumber
GetRandomNumber_M ENDM