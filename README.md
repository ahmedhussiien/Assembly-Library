# Assembly Library
Graphics and utilities library for Assembly x86 that facilitates the process of creating GUI programs and games.
Assembled using MASM V 5.1

## Using the library
```assembly
.MODEL SMALL
.STACK 64

.DATA
INCLUDE AsmLib\Defn.inc

;...Your data members go here

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
 <br> 
### The utilities package includes:
* File management --> for Opening, Creating, Reading and Writing Files.
* Serial --> for communicating with other computers through the serial port.
* Heap management --> to access heap memory and use dynamic allocation.
* Key management --> To handle user input through the keyboard.
* Math --> Includes procedures to generate a random number and translating input to another range.
* Debug --> Create and write bytes, words, and strings to a debug file.
* Time --> For program delays.
* Util --> To use PushA and PopA macros. 
<br> 

## The graphics package
the graphics package includes tools to draw and animate objects. To do this generally to any object, objects must have a struct like form. Done that, the package can draw and animate any "Draw-able" object in this format:  
  
1st Byte = Width.  
2nd Byte = Height.  
3rd Byte = X-coordinate.  
4th Byte = Y-coordinate.  
5th Byte = Unused. Can be used for different purposes by the user.
6th Byte = Start of the pixel array.  

### The graphics package include:
* Print --> Includes procedures that print a string with custom colors on the screen in any graphics mode.
* Draw --> Includes procedures to draw different shapes on the screen, draw pixel array from memory, erase an object or shape.
* GFX --> Includes procedures to change the video mode, clear page, and scroll on the current page.
* Sound --> Includes a procedure for playing the Beep sound.
* Anim --> Includes procedures that shift objects in any direction. 
<br> 

## Definitions
Includes keys scan codes.  
Includes a VGA color palette.  
<br> 

## GUI designing tools ( Additional tools )
To ease the process of making GUI even more I made some tools -Not part of this library- that may help you in the process.
* 16 Bit color palette.
* VGA256 color palette.
* Python script to convert image to the pixel array.
* MCGA 320x200 PSD file.
   
### Steps for converting the photo to pixel array:
1. Open the photo in photoshop.
2. Choose color mode "indexed" with the "VGA color palette" for the 13h and "Text color palette" for 12h.
3. Save the image. Preferably as .BMP
4. Use the given python script to get photo data.
