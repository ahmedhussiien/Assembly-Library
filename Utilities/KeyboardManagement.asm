;===========================================================================
; 							KeyboardManagement.asm
;---------------------------------------------------------------------------
; Assembly x86 library
;
;
; Author: Ahmed Hussein
; Created: 
;
;
; This file provide some Procedures that helps in dealing with keyboard events
; Included also is a Macro wrapper for each procedure
; 
; Procedures included:
;	* GetRandomNumber
;
;===========================================================================

WaitForKeyPress PROC

@@CheckKeyPress:
				MOV AH,1
				INT 16H
				JZ @@CheckKeyPress

MOV AH, 0
INT 16h

RET
WaitForKeyPress ENDP


GetKeyPress PROC

MOV AH, 01
INT 16H

RET
GetKeyPress ENDP
