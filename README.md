# AssemblyLibrary
A graphics and utilities library for Assembly x86 that ease the process of creating GUI programs and games

## Includeing the library
```assembly
.MODEL SMALL
.STACK 64

.DATA
INCLUDE AsmLib\Defn.inc

;...Your data members goes here

.CODE
INCLUDE AsmLib\Util.inc
INCLUDE AsmLib\Graphics.inc

;...Your code goes here

MAIN PROC FAR
MOV AX, @DATA
MOV DS, AX

MOV AH, 4CH
INT 21H
            
MAIN ENDP
END MAIN
```

## The utilities package
The utilities package abstracts the complexity behind doing frequent operations and facilitate the process of creating programs.

### The utilities package includes:
* File management --> for Opening, Creating, Reading and Writing Files.
* Serial --> for communicating with other computers through the serial port.
* Heap management --> to access heap memory and use dynamic allocation.
* Key management --> To handle user input through the keyboard.
* Math --> Includes procedures to generate a random number and translating input to another range.
* Debug --> Create and write bytes, word, and strings to a debug file.
* Time --> For program delays.
* Util --> To use PushA and PopA macros.

## The graphics package
the graphics package includes tools to draw and animate objects. To do this generally to any object, objects must have a struct like form. Done that, the package can draw and animate any "Draw-able" object in this format:
1st Byte = Width
2nd Byte = Height
3rd Byte = X-coordinate
4th Byte = Y-coordinate
5th Byte = Neglected. Used by the user and can be different fro mone object to another.
6th Byte = Start of the pixel array.

### The graphics package include:
* Print --> Includes procedures that print a string with custom colors on the screen in any graphics mode.
* Draw --> Includes procedures to draw different shapes on the screen, draw pixel array from memory, erase an object or shape.
* GFX --> Includes procedures to change the video mode, clear page, and scroll on the current page.
* Sound --> Includes a procedure for playing the Beep sound.
* Anim --> Includes procedures that shift objects in any direction
