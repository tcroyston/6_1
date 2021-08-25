;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Thomas Royston
; Email: troys002@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 021
; TA: Nikhil Gowda
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R2
;=================================================================================

	.ORIG x3000	
	
;-------------
;Instructions
;-------------
 
; output intro prompt
RESET_IF_ERROR
		LD R0, introMessagePtr
		PUTS
						
; Set up flags, counters, accumulators as needed
 
LD R6, COUNT
	AND R2, R2, #0			
	AND R4, R4, #0			
	AND R5, R5, #0		;CHECKS FOR SIGNS 
 
; Get first character, test for '\n', '+', '-', digit/non-digit 
 
LOOP
		GETC
		ADD R1, R0, #0		;is very first character = '\n'? if so, just quit 						;(no message)! 
		LD R7, ENTER_CHAR	
		ADD R1, R1, R7
		BRnp OUTPUT_CHAR

; is it = '+'? if so, ignore it, go get digits

; is it = '-'? if so, set neg flag, go get digits

 
	CHECK_INPUT
		ADD R1, R0, #0		; is it < '0'? if so, it is not a digit	- o/p
		LD R7, DEC_NEG_48
		ADD R1, R1, R7
		BRn BELOW_ZERO
		ADD R1, R0, #0		; is it > '9'? if so, it is not a digit	- o/p
		LD R7, DEC_NEG_57
		ADD R1, R1, R7
		BRp ABOVE_NINE	
					
		ADD R1, R6, #0		;counter is R1
		ADD R1, R1, #-6		;checks to see if first character is a digit
		BRz FIRST_NOT_SIGN	
		
		ADD R2, R2, R2		
		ADD R7, R2, R2
		ADD R7, R7, R7
		ADD R2, R7, R2
		
		LD R7, DEC_NEG_48
		ADD R0, R0, R7
		ADD R2, R2, R0		;Add input to previous input * 10
		ADD R6, R6, #-1
		BRp LOOP
		BRz END
 


	FIRST_NOT_SIGN
		LD R7, DEC_NEG_48
		ADD R0, R0, R7		;convert the char to dec
		ADD R2, R0, R2
		ADD R6, R6, #-2		;skip 2 because we not using sign
		BRnzp LOOP
		
 
	BELOW_ZERO				;either +,-, ENTER produces error otheriwse
		LD R7, POS
		ADD R1, R0, #0
		ADD R1, R1, R7
		BRz POS_CHAR
		
		LD R7, NEG
		ADD R1, R0, #0
		ADD R1, R1, R7
		BRz NEG_CHAR
		
		LD R7, ENTER_CHAR
		ADD R1, R0, #0
		ADD R1, R1, R7
		BRz ENTER
		BRnzp OUTPUT_ERROR
 
	ABOVE_NINE				;AN ERROR IF ABOVE 9
		ADD R1, R0, #0
		BRnzp OUTPUT_ERROR

					; if none of the above, first character is first numeric digit - convert it to number & store in target register!

; Now get remaining digits (max 5) from user, testing each to see if it is a digit, and build up number in accumulator

					; remember to end with a newline!
 
	OUTPUT_CHAR
		OUT
		BRnzp CHECK_INPUT
 
		
	OUTPUT_ERROR
		LD R0, NEWLINE
		OUT
		LD R0, errorMessagePtr
		PUTS
		BRnzp RESET_IF_ERROR
 
	POS_CHAR
		ADD R1, R6, #0		;check for first char "+"
		ADD R1, R1, #-6
		BRnp OUTPUT_ERROR
		
		ADD R5, R5, #1
		ADD R6, R6, #-1
		BRnzp LOOP
	
	NEG_CHAR
		ADD R1, R6, #0		;check for first char "-"
		ADD R1, R1, #-6
		BRnp OUTPUT_ERROR
		
		ADD R4, R4, #1		;sets signed binary to 1 if neg
		ADD R5, R5, #1
		ADD R6, R6, #-1
		BRnzp LOOP
	
	ENTER
		ADD R1, R6, #0		;check to see if enter key is the first character
		ADD R1, R1, #-6
		BRz END
		
		ADD R1, R6, #0
		ADD R1, R1, #-5
		BRnp END
		
		ADD R1, R5, #0
		ADD R1, R1, #-1
		BRz END
		
		BRn OUTPUT_ERROR
 



	TWOS_COMPL
		NOT R2, R2
		ADD R2, R2, #1
		BRnzp END_NEWLINE
	END
		ADD R1, R4, #0
		ADD R1, R1, #-1
		BRz TWOS_COMPL
	
	END_NEWLINE
		LD R0, NEWLINE
		OUT			
					
HALT
 
;---------------	
; Program Data
;---------------
 
introMessagePtr	.FILL xA100
errorMessagePtr	.FILL xA200

COUNT    	.FILL #6
NEWLINE		.FILL #10
DEC_NEG_48	.FILL #-48
DEC_NEG_57	.FILL #-57
POS 		.FILL #-43
NEG		.FILL #-45
ENTER_CHAR	.FILL #-10
 
;------------
; Remote data
;------------
.ORIG xA100			; intro prompt
.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
					
					
.ORIG xA200			; error message
.STRINGZ	"ERROR: invalid input\n"
 
 
;---------------
; END of PROGRAM
;---------------
.END
 


;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
