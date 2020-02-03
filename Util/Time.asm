;===========================================================================
;                               Time.asm
;---------------------------------------------------------------------------
; Assembly x86 library
;
;
; Author: Ahmed Hussein
; Created: 
;
;
; This file provide some Procedures that are used for time operations and delays
; 
; Procedures included:
;   * Delay
;
;===========================================================================



;-----------------------------------------------------
; Delay
;-----------------------------------------------------
; Delay the execution of the program for the given milliseconds
; @param CX:DX = Delay in Milliseconds
;-----------------------------------------------------
Delay   PROC
        PushA

        MOV     AH, 86H
        INT     15H 
        
        PopA
        ret  
Delay   ENDP




