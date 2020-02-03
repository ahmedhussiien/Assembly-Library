;===========================================================================
;                               KeysMap.asm
;---------------------------------------------------------------------------
; Assembly x86 library
;
;
; Author: Ahmed Hussein
; Created: 
;
;
; This file provide a dictionary for keys scan codes
; See: http://stanislavs.org/helppc/scan_codes.html
;===========================================================================

;-------------------- Alphabet --------------------
SC_A    EQU   1EH
SC_B    EQU   30H
SC_C    EQU   2EH
SC_D    EQU   20H
SC_E    EQU   12H
SC_F    EQU   21H
SC_G    EQU   22H
SC_H    EQU   23H
SC_I    EQU   17H
SC_J    EQU   24H
SC_K    EQU   25H
SC_L    EQU   26H
SC_M    EQU   32H
SC_N    EQU   31H
SC_O    EQU   18H
SC_P    EQU   19H
SC_Q    EQU   10H
SC_R    EQU   13H
SC_S    EQU   1FH
SC_T    EQU   14H
SC_U    EQU   16H
SC_V    EQU   2FH
SC_W    EQU   11H
SC_X    EQU   2DH
SC_Y    EQU   15H
SC_Z    EQU   2CH

;-------------------- Numbers --------------------
SC_1    EQU   02H
SC_2    EQU   03H
SC_3    EQU   04H
SC_4    EQU   05H
SC_5    EQU   06H
SC_6    EQU   07H
SC_7    EQU   08H
SC_8    EQU   09H
SC_9    EQU   0AH
SC_0    EQU   0BH

;-------------------- Function keys --------------------
SC_F1   EQU   3BH
SC_F2   EQU   3CH
SC_F3   EQU   3DH
SC_F4   EQU   3EH
SC_F5   EQU   3FH
SC_F6   EQU   40H
SC_F7   EQU   41H
SC_F8   EQU   42H
SC_F9   EQU   43H
SC_F10  EQU   44H
SC_F11  EQU   85H
SC_F12  EQU   86H

;-------------------- Special keys --------------------
SC_BACKSPACE    EQU    0EH
SC_DEL          EQU    53H
SC_ENTER        EQU    1CH
SC_ESC          EQU    01H
SC_SPACEBAR     EQU    39H
SC_TAB          EQU    0FH

;-------------------- Arrows --------------------
SC_RIGHT_ARROW  EQU    4DH
SC_LEFT_ARROW   EQU    4BH
SC_DOWN_ARROW   EQU    50H
SC_UP_ARROW     EQU    48H