;===========================================================================
;                               Serial.asm
;---------------------------------------------------------------------------
; Assembly x86 library
;
;
; Author: Ahmed Hussein
; Created: 
;
;
; This file provide procedures to communicate with another device
; through serial port
; 
; Procedures included:
;   * ConfigurePort
;   * SendByte
;   * CheckForData
;   * RecieveByte
;   * WaitForRecievedData
;===========================================================================

;-------------------- Definitions --------------------
DATA_READY              EQU 00
DATA_NOT_READY          EQU 01
LINE_STATUES_REGISTER   EQU 03FDH
LINE_CONTROL_REGISTER   EQU 03FBH
TRANSMIT_DATA_REGISTER  EQU 03F8H
DIVISOR_LATCH_REGISTER  EQU 03F9H



;-----------------------------------------------------
; CheckForData
;-----------------------------------------------------
; Check if there is a data recieved 
; @return AL = DATA_READY or DATA_NOT_READY 
;-----------------------------------------------------
CheckForData proc
PUSH DX

MOV DX, LINE_STATUES_REGISTER
IN AL, DX 
TEST AL, DATA_NOT_READY
JZ @@ReturnNotReady

MOV AL, DATA_READY
JMP @@CheckForDataReturn
    
@@ReturnNotReady: 
    MOV AL, DATA_NOT_READY
                
@@CheckForDataReturn:   
    POP DX  
    RET
    
CheckForData endp



;-----------------------------------------------------
; RecieveByte
;-----------------------------------------------------
; @return AL = Character recieved
;-----------------------------------------------------
RecieveByte proc
PUSH DX

;Read the value
MOV DX, TRANSMIT_DATA_REGISTER
IN AL, DX 
PUSH AX

;Reset Line Status Register flag
MOV AL, DATA_NOT_READY
MOV DX, LINE_STATUES_REGISTER
OUT DX,AL  

POP AX
POP DX
RET
RecieveByte endp



;-----------------------------------------------------
; SendByte
;-----------------------------------------------------
; @param AL = Character to be sent
;-----------------------------------------------------
SendByte proc
PUSH DX
PUSH AX

;Check that Transimitter Holding Register is empty
MOV DX ,LINE_STATUES_REGISTER       
@@CheckTHR: 
    IN AL,DX            
    AND AL, 00100000B
    JZ @@CheckTHR

;Put the value in Transmit data register
POP AX
MOV DX, TRANSMIT_DATA_REGISTER
OUT DX, AL    

POP DX
RET
SendByte endp



;-----------------------------------------------------
; ConfigurePort
;-----------------------------------------------------
; Configures the port for serial communication
;-----------------------------------------------------
ConfigurePort PROC
PUSH AX
PUSH DX

;Set divisor latch access bit
MOV DX,LINE_CONTROL_REGISTER
MOV AL,10000000B        
OUT DX,AL               
 
;Set LSB byte of the BaudRate Divisor latch register 
MOV DX,TRANSMIT_DATA_REGISTER   
MOV AL,0CH          
OUT DX,AL

;Set MSB byte of the BaudRate Divisor latch register 
MOV DX,DIVISOR_LATCH_REGISTER
MOV AL,00H
OUT DX,AL

;Set port configuration
MOV DX,LINE_CONTROL_REGISTER
MOV AL,00011011B
OUT DX,AL

POP DX
POP AX
RET
ConfigurePort ENDP



;-----------------------------------------------------
; WaitForRecievedData
;-----------------------------------------------------
; Wait untill there's data sent then read it
; @return AL = Character recieved
;-----------------------------------------------------
WaitForRecievedData PROC
PUSH DX
PUSH AX

;Check that Data Ready
MOV DX, LINE_STATUES_REGISTER
@@CheckForData: 
    IN AL,DX
    AND AL, DATA_NOT_READY
    JZ @@CheckForData

;Read the value recieved
POP AX
MOV DX, TRANSMIT_DATA_REGISTER
IN AL, DX
PUSH AX

;Reset Line Status Register flag
MOV AL, DATA_NOT_READY
MOV DX, LINE_STATUES_REGISTER
OUT DX,AL  

POP AX
POP DX
RET
WaitForRecievedData ENDP