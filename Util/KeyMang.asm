;===========================================================================
;                             KeyMang.asm
;---------------------------------------------------------------------------
; Assembly x86 library
;
;
; Author: Ahmed Hussein
; Created: 
;
;
; This file provide some Macros that helps in dealing with keyboard events
; 
; Macros:
;   * WaitForKeyPress
;   * GetKeyPress
;   * GetUserInput
;
;===========================================================================



;-----------------------------------------------------
; WaitForKeyPress
;-----------------------------------------------------
; Wait untill the user press on a key 
; @return AH = Scan code
; @return AL = ASCII COde

;-----------------------------------------------------
WaitForKeyPress MACRO
LOCAL @@CheckKeyPress

@@CheckKeyPress:
                MOV AH,1
                INT 16H
                JZ @@CheckKeyPress

MOV AH, 0
INT 16h

ENDM WaitForKeyPress 



;-----------------------------------------------------
; GetKeyPress
;-----------------------------------------------------
; Get key press ( Non-blocking )
;
; @return ZF = 0 if a key pressed
; @return AH = Scan code
; @return AL = ASCII COde
;
;-----------------------------------------------------
GetKeyPress MACRO

MOV AH, 01
INT 16H

MOV AH, 01
INT 16H
ENDM GetKeyPress



;-----------------------------------------------------
; GetKeyPress
;-----------------------------------------------------
; Get user input given a buffer
; Buffer DB BufferSize, StringLength, ActualString
;
; @return AH Fill Buffer data
;
;-----------------------------------------------------
GetUserInput MACRO BufferOffset
PUSH AX
PUSH DX

MOV DX, BufferOffset
MOV AH, 0AH
INT 21H

POP DX
POP AX
ENDM GetUserInput