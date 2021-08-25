;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Thomas Royston
; Email: troys002@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 021
; TA:Nikhil Gowda
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
LD R6, Value_addr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------

AND R5, R5, #0
ADD R5, R5, #15

AND R4, R4, #0
ADD R4, R4, #4

LOOP
ADD R4, R4, #0

BRp NEXTN
LEA R0, free
TRAP x22

AND R4, R4, #0
ADD R4, R4, #4
ADD R5, R5, #0
BR ENDNEXTN

NEXTN
	ADD R1, R1, #0
BRn IFSTAMT
LEA R0, stringzero

TRAP x22
BR ENDIFSTAMT
IFSTAMT
LEA R0, stringone

TRAP x22
ENDIFSTAMT
ADD R1, R1, R1
ADD R5, R5, #-1
ADD R4, R4, #-1
ENDNEXTN

ADD R5, R5, #0
BRzp LOOP
LEA R0, newLINE
PUTS

HALT
;---------------	
;Data
;---------------
Value_addr	.FILL xB800	; The address where value to be displayed is stored

count .FILL #16
count2 .FILL #4
stringone .STRINGZ "1"
stringzero .STRINGZ "0"
free .STRINGZ " "
newLINE.STRINGZ "\n"


.ORIG xB800					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
