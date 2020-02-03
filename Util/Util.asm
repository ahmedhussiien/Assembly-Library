;===========================================================================
;                                 Util.asm
;---------------------------------------------------------------------------
; Assembly x86 library
;
;
; Author: Ahmed Hussein
; Created: 
;
;
; This file provide some Macros that help in decreasing code size
; 
; Procedures included:
;   * PushA
;   * PopA
;===========================================================================

;-----------------------------------------------------
; PushA
;-----------------------------------------------------
; Push all general registers
; PUSH AX, BX, DX, CX, BP, SI, DI
;-----------------------------------------------------
PushA MACRO
PUSH AX
PUSH BX
PUSH DX
PUSH CX
PUSH BP
PUSH SI
PUSH DI
ENDM PushA 


;-----------------------------------------------------
; PopA
;-----------------------------------------------------
; Pop all general registers
; POP DI, SI, BP, CX, DX, BX, AX
;-----------------------------------------------------
PopA MACRO
POP DI
POP SI
POP BP
POP CX
POP DX
POP BX
POP AX
ENDM PopA 

