;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name:Thomas Royston 
; Email: troys002@ucr.edu
; 
; Assignment name: Assignment 2
; Lab section: 021
; TA: Nikhil Gowda
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------
GETC
OUT
AND R1, R1, #0
ADD R1, R1, R0
LEA R0, newline

PUTS
GETC
OUT
AND R2, R2, #0
ADD R2, R2, R0
LEA R0, newline

PUTS
AND R3, R3, #0
ADD R3, R3, #15
ADD R3, R3, #15
ADD R4, R4, #0
ADD R4, R3, #2   ;R4 is a space
ADD R3, R3, #15
ADD R3, R3, #3

AND R5, R5, #0
ADD R5, R5, R3   ;R5 is a zero
NOT R3, R3
ADD R3, R3, #1   ;R3 is converter

ADD R1, R1, R3
ADD R2, R2, R3   ;both ready to be worked with

AND R6, R6, #0
ADD R0, R1, R6
ADD R0, R0, R5
OUT		 ;print first number

AND R6, R6, #0
ADD R0, R4, R6
OUT		 ;print space

ADD R3, R4, #13
ADD R6, R6, #0
ADD R0, R3, R6
OUT		 ;print minus sign

AND R6, R6, #0
ADD R0, R4, R6
OUT		 ;print second space

AND R6, R6, #0
ADD R0, R2, R6
ADD R0, R0, R5
OUT		 ;print second number

AND R6, R6, #0
ADD R0, R4, R6
OUT		 ;print thrid space

ADD R3, R3, #15
ADD R3, R3, #1   ;R3 is an equals sign

AND R6, R6, #0
ADD R0, R3, R6
OUT		 ;print equals sign

AND R6, R6, #0
ADD R0, R4, R6
OUT		 ;print fourth space

NOT R2, R2
ADD R2, R2, #1
ADD R6, R1, R2   ;subtraction with 2's complement conversion on R2

BRn neg
BR pos

neg NOT R6, R6
    ADD R6, R6, #1
    AND R3, R3, #0
    ADD R3, R4, #13
    AND R4, R4, #0
    ADD R0, R3, R4
    OUT

pos ADD R6, R6, R5
    AND R4, R4, #0
    ADD R0, R6, R4
    OUT

LEA R0, newline
PUTS
HALT				; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline .FILL '\n'	; newline character - use with LD followed by OUT




;---------------	
;END of PROGRAM
;---------------	
.END

