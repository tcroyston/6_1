;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Thomas Royston
; Email: troys002@ucr.edu
; 
; Assignment name: Assignment 5
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
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------

OPTIONS
LD R6, MENU	
JSRR R6
ADD R1, R1, #-1
BRz ONE_SUB				
ADD R1, R1, #-1				
BRz TWO_SUB			
ADD R1, R1, #-1				
BRz THREE_SUB			
ADD R1, R1, #-1				
BRz FOUR_SUB			
ADD R1, R1, #-1				
BRz FIVE_SUB						
ADD R1, R1, #-1			
BRz SIX_SUB		
ADD R1, R1, #-1 					
BRz SEVEN_SUB

ONE_SUB 
	LD R6, ALL_MACHINES_BUSY		
	JSRR R6			
	ADD R2, R2, #-1
	BRz IS_BUSY	
	BRn NOT_BUSY	

	IS_BUSY
		LEA R0, allbusy
		PUTS
		BR END_1

	NOT_BUSY
		LEA R0, allnotbusy
		PUTS 
	END_1
	ADD R2, R2, #1
	BR OPTIONS

TWO_SUB
	LD R6, ALL_MACHINES_FREE
	JSRR R6		
	ADD R2, R2, #-1
	BRz IS_FREE
	BRn NOT_FREE

	IS_FREE
		LEA R0, allfree	 
		PUTS	
		BR END_2

	NOT_FREE
		LEA R0, allnotfree
		PUTS	
	END_2
	BR OPTIONS

THREE_SUB
	LD R6, NUM_BUSY_MACHINES
	JSRR R6

	LEA R0, busymachine1
	PUTS
	LD R6, PRINT_NUM
	JSRR R6
	LEA R0, busymachine2
	PUTS

	BR OPTIONS

FOUR_SUB
	LD R6, NUM_FREE_MACHINES
	JSRR R6

	LEA R0, freemachine1
	PUTS
	LD R6, PRINT_NUM
	JSRR R6
	LEA R0, freemachine2
	PUTS 

	BR OPTIONS

FIVE_SUB
	LD R6, GET_INPUT
	JSRR R6
	LD R6, MACHINE_STATUS
	JSRR R6

	LEA R0, status1
	PUTS
	ADD R2, R2, #0
	BRz BUSY_MACHINE
	BR FREE_MACHINE

	BUSY_MACHINE
		ADD R2, R1, #0
		LD R6, PRINT_NUM
		JSRR R6
		LEA R0, status2
		PUTS
		BR END_5

	FREE_MACHINE
		ADD R2, R1, #0
		LD R6, PRINT_NUM
		JSRR R6
		LEA R0, status3
		PUTS

	END_5
	BR OPTIONS

SIX_SUB
	LD R6, FIRST_FREE
	JSRR R6

	ADD R2, R2, #0
	BRn NONE_FREE

	LEA R0, firstfree1
	PUTS
	LD R6, PRINT_NUM
	JSRR R6
	LEA R0, firstfree2
	PUTS
	BR END_6

	NONE_FREE
		LEA R0, firstfree2
		PUTS

	END_6
	BR OPTIONS

SEVEN_SUB
	LEA R0, goodbye
	PUTS


HALT
;---------------	
;Data
;---------------
;Subroutine pointers

MENU 				.FILL 			x3200
ALL_MACHINES_BUSY 		.FILL 			x3400
ALL_MACHINES_FREE 		.FILL 			x3600
NUM_BUSY_MACHINES 		.FILL 			x3800
NUM_FREE_MACHINES 		.FILL 			x4000
MACHINE_STATUS 			.FILL 			x4200
FIRST_FREE 			.FILL 			x4400
GET_INPUT 			.FILL 			x4600
PRINT_NUM 			.FILL 			x4800

;Other data 
newline 		.fill '\n'

; Strings for reports from menu subroutines:
goodbye         .stringz "Goodbye!\n"
allbusy         .stringz "All machines are busy\n"
allnotbusy      .stringz "Not all machines are busy\n"
allfree         .stringz "All machines are free\n"
allnotfree		.stringz "Not all machines are free\n"
busymachine1    .stringz "There are "
busymachine2    .stringz " busy machines\n"
freemachine1    .stringz "There are "
freemachine2    .stringz " free machines\n"
status1         .stringz "Machine "
status2		    .stringz " is busy\n"
status3		    .stringz " is free\n"
firstfree1      .stringz "The first available machine is number "
firstfree2      .stringz "No machines are free\n"


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, invited the
;                user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7 (as a number, not a character)
;                    no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
;HINT back up 

.ORIG x3200

ST R0, BACKUP_R0_3200
ST R2, BACKUP_R2_3200
ST R7, BACKUP_R7_3200

USER_INPUT
	LD R0, Menu_string_addr 
	PUTS
	GETC
	OUT
	LD R2, DEC_48_M
	ADD R0, R0, R2
	BRnz ERROR_INPUT
	LD R2, DEC_48_P
	ADD R0, R0, R2

	LD R2, DEC_56_M
	ADD R0, R0, R2 
	BRzp ERROR_INPUT
	LD R2, DEC_56_P
	ADD R0, R0, R2 
	BR FINISH_INPUT

	ERROR_INPUT
		LD R0, NEWLINE
		OUT
		LEA R0, Error_message_1
		PUTS
		BR USER_INPUT

FINISH_INPUT
LD R2, DEC_48_M
ADD R0, R0, R2 
ADD R1, R0, #0
LD R0, NEWLINE
OUT
				; RESTORE REGISTERS AS NEEDED
LD R0, BACKUP_R2_3200
LD R2, BACKUP_R2_3200
LD R7, BACKUP_R7_3200

ret

;HINT Restore

;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_msg_1	      .STRINGZ "INVALID INPUT\n"
Menu_string_addr  .FILL x6A00

Error_message_1			.STRINGZ 		"INVALID INPUT\n"
DEC_48_M			.FILL 			#-48
DEC_48_P 			.FILL 			#48
DEC_56_M 			.FILL 			#-56
DEC_56_P			.FILL 			#56
NEWLINE 			.STRINGZ 		"\n"

BACKUP_R0_3200 			.BLKW 			#1
BACKUP_R2_3200 			.BLKW 			#1
BACKUP_R7_3200			.BLKW			#1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY (#1)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
;HINT back up 


.ORIG x3400

ST R0, BACKUP_R0_3400
ST R1, BACKUP_R1_3400
ST R7, BACKUP_R7_3400

LD R0, BUSYNESS_ADDR_ALL_MACHINES_BUSY
LDR R1, R0, #0
BRz BUSY_IM_ALL
BR BUSY_NOT_ALL

BUSY_IM_ALL
	AND R2, R2, #0
	ADD R2, R2, #1
	BR BUSY_DONE	

BUSY_NOT_ALL
	AND R2, R2, #0
	BR BUSY_DONE
BUSY_DONE
				; RESTORE REGISTERS AS NEEDED
LD R0, BACKUP_R0_3400
LD R1, BACKUP_R1_3400
LD R7, BACKUP_R7_3400

ret

;HINT Restore

;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xBA00

BACKUP_R0_3400 			.BLKW 			#1
BACKUP_R1_3400 			.BLKW 			#1
BACKUP_R7_3400 			.BLKW 			#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE (#2)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
;HINT back up 

.ORIG x3600

ST R0, BACKUP_R0_3600
ST R1, BACKUP_R1_3600
ST R7, BACKUP_R7_3600

LD R0, BUSYNESS_ADDR_ALL_MACHINES_FREE		
LDR R1, R0, #0 						

ADD R1, R1, #1 						
BRz FREE_IM_ALL						
BR FREE_NOT_ALL 					

FREE_IM_ALL
	AND R2, R2, #0 					
	ADD R2, R2, #1 					
	BR FREE_DONE 					

FREE_NOT_ALL
	AND R2, R2, #0 					
	BR FREE_DONE

FREE_DONE

;HINT Restore

LD R0, BACKUP_R0_3600
LD R1, BACKUP_R1_3600
LD R7, BACKUP_R7_3600
				
ret

;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xBA00

BACKUP_R0_3600 			.BLKW 			#1
BACKUP_R1_3600 			.BLKW 			#1
BACKUP_R7_3600 			.BLKW 			#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES (#3)
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R1): The number of machines that are busy (0)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
;HINT back up 

.ORIG x3800

ST R0, BACKUP_R0_3800
ST R1, BACKUP_R1_3800
ST R3, BACKUP_R3_3800
ST R4, BACKUP_R4_3800
ST R7, BACKUP_R7_3800

LD R0, BUSYNESS_ADDR_NUM_BUSY_MACHINES
LDR R1, R0, #0
LD R3, DEC_16_BUSY

COUNT_NUM_BUSY
	ADD R1, R1, #0
	BRn IS_NEGATIVE_BUSY
	ADD R1, R1, R1
	ADD R3, R3, #-1
	BRz END_COUNT_BUSY
	BR COUNT_NUM_BUSY 

	IS_NEGATIVE_BUSY
		ADD R4, R4, #1 
		ADD R1, R1, R1
		ADD R3, R3, #-1
		BRz END_COUNT_BUSY
		BR COUNT_NUM_BUSY 
END_COUNT_BUSY

LD R2, DEC_16_BUSY
NOT R4, R4
ADD R4, R4, #1
ADD R2, R2, R4

;HINT Restore
LD R0, BACKUP_R0_3800
LD R1, BACKUP_R1_3800
LD R3, BACKUP_R3_3800
LD R4, BACKUP_R4_3800
LD R7, BACKUP_R7_3800
				
ret
;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xBA00

DEC_16_BUSY 			.FILL 			#16
BACKUP_R0_3800 			.BLKW 			#1
BACKUP_R1_3800 			.BLKW 			#1
BACKUP_R3_3800 			.BLKW 			#1
BACKUP_R4_3800 			.BLKW 			#1
BACKUP_R7_3800 			.BLKW 			#1


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES (#4)
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R1): The number of machines that are free (1)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
;HINT back up 

.ORIG x4000

ST R0, BACKUP_R0_4000
ST R1, BACKUP_R1_4000
ST R3, BACKUP_R3_4000
ST R4, BACKUP_R4_4000
ST R7, BACKUP_R7_4000

LD R0, BUSYNESS_ADDR_NUM_FREE_MACHINES	
LDR R1, R0, #0
LD R3, DEC_16_FREE

FREE_COUNT_NUM
	ADD R1, R1, #0
	BRn FREE_IS_NEGATIVE
	ADD R1, R1, R1
	ADD R3, R3, #-1
	BRz FREE_END_COUNT
	BR FREE_COUNT_NUM 

	FREE_IS_NEGATIVE
		ADD R4, R4, #1 
		ADD R1, R1, R1 
		ADD R3, R3, #-1
		BRz FREE_END_COUNT
		BR FREE_COUNT_NUM
FREE_END_COUNT

ADD R2, R4, #0

;HINT Restore

LD R0, BACKUP_R0_4000
LD R1, BACKUP_R1_4000
LD R3, BACKUP_R3_4000
LD R4, BACKUP_R4_4000
LD R7, BACKUP_R7_4000
				
ret

;--------------------------------
;Data for subroutine NUM_FREE_MACHINES 
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xBA00

DEC_16_FREE 			.FILL 			#16
BACKUP_R0_4000 			.BLKW 			#1
BACKUP_R1_4000 			.BLKW 			#1
BACKUP_R3_4000 			.BLKW 			#1
BACKUP_R4_4000 			.BLKW 			#1
BACKUP_R7_4000 			.BLKW 			#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS (#5)
; Input (R1): Which machine to check, guaranteed in range {0,15}
; Postcondition: The subroutine has returned a value indicating whether
;                the selected machine (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;              (R1) unchanged
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
;HINT back up 

.ORIG x4200

ST R1, BACKUP_R1_4200
ST R3, BACKUP_R3_4200
ST R7, BACKUP_R7_4200

LD R3, BUSYNESS_ADDR_MACHINE_STATUS
LDR R3, R3, #0
AND R2, R2, #0
AND R4, R4, #0
ADD R4, R4, #15
NOT R1, R1
ADD R1, R1, #1
ADD R4, R4, R1

CHECK_MACHINE_STATUS
	ADD R4, R4, #0
	BRz B_F
	ADD R4, R4, #-1
	ADD R3, R3, R3
	BR CHECK_MACHINE_STATUS

B_F
	ADD R3, R3, #0 
	BRn FREEMACHINE
	BR DONE_MACHINE_STATUS

	FREEMACHINE 
		ADD R2, R2, #1

DONE_MACHINE_STATUS

;HINT Restore

LD R1, BACKUP_R1_4200
LD R3, BACKUP_R3_4200
LD R7, BACKUP_R7_4200
				
ret

;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS.Fill xBA00

BACKUP_R1_4200 			.BLKW 			#1
BACKUP_R3_4200 			.BLKW 			#1
BACKUP_R7_4200 			.BLKW 			#1


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE (#6)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R1): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
;HINT back up 

.ORIG x4400

ST R0, BACKUP_R0_4400
ST R1, BACKUP_R1_4400
ST R3, BACKUP_R3_4400
ST R4, BACKUP_R4_4400
ST R5, BACKUP_R5_4400 
ST R6, BACKUP_R6_4400
ST R7, BACKUP_R7_4400

LD R0, BUSYNESS_ADDR_FIRST_FREE
LDR R1, R0, #0 
AND R5, R5, #0 
AND R3, R3, #0 
AND R2, R2, #0
AND R6, R6, #0
ADD R3, R3, #1
LD R4, DEC_16_FIRST_FREE 

FIND_FIRST_FREE
	AND R5, R1, R3 	
	BRnp FREE_BIT 	
	BR NOT_FREE_BIT 

	NOT_FREE_BIT
		ADD R3, R3, R3
		ADD R6, R6, #1
		ADD R4, R4, #-1
		BRz NOTHING_FREE
		BR FIND_FIRST_FREE 
	FREE_BIT
		ADD R2, R6, #0 
		BR DONE_FIRST_FREE

	NOTHING_FREE
		ADD R2, R2, #-1 	
		BR DONE_FIRST_FREE

DONE_FIRST_FREE

;HINT Restore

LD R0, BACKUP_R0_4400
LD R1, BACKUP_R1_4400
LD R3, BACKUP_R3_4400
LD R4, BACKUP_R4_4400
LD R5, BACKUP_R5_4400
LD R6, BACKUP_R6_4400
LD R7, BACKUP_R7_4400

				
ret
;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill xBA00

DEC_16_FIRST_FREE 		.FILL 			#16
BACKUP_R0_4400 			.BLKW 			#1
BACKUP_R1_4400 			.BLKW 			#1
BACKUP_R3_4400 			.BLKW 			#1
BACKUP_R4_4400 			.BLKW 			#1
BACKUP_R5_4400 			.BLKW 			#1
BACKUP_R6_4400 			.BLKW 			#1
BACKUP_R7_4400 			.BLKW 			#1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: GET_MACHINE_NUM
; Inputs: None
; Postcondition: The number entered by the user at the keyboard has been converted into binary,
;                and stored in R1. The number has been validated to be in the range {0,15}
; Return Value (R1): The binary equivalent of the numeric keyboard entry
; NOTE: You can use your code from assignment 4 for this subroutine, changing the prompt, 
;       and with the addition of validation to restrict acceptable values to the range {0,15}
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.ORIG x4600

ST R0, BACKUP_R0_4600
ST R2, BACKUP_R2_4600
ST R3, BACKUP_R3_4600
ST R4, BACKUP_R4_4600
ST R5, BACKUP_R5_4600
ST R7, BACKUP_R7_4600

LD R3, INPUT_COUNTER 		
LD R4, MULTIPLY_COUNTER
LD R2, ENTER_SHIFT 
AND R1, R1, #0 
AND R5, R5, #0 

START
	LEA R0, prompt
	PUTS
	GETC
	OUT 
	ADD R0, R0, R2	
	BRz INVALID_INPUT 
	ADD R0, R0, #10	

CHECK_SIGN
	ADD R5, R0, #0 

	LD R2, ASCII_PLUS_SHIFT	
	ADD R5, R5, R2	
	BRz PRE_CONVERT_2 
	ADD R5, R5, #15	
	ADD R5, R5, #15
	ADD R5, R5, #13

	LD R2, ASCII_MINUS_SHIFT
	ADD R5, R5, R2	
	BRz NEGATIVE_PREP
	BR PRE_CONVERT_1
NEGATIVE_PREP
	ADD R5, R5, #-1	
	BR PRE_CONVERT_2
PRE_CONVERT_1
	LD R2, NAN	
	ADD R0, R0, R2	
	BRp INVALID_INPUT 
	ADD R0, R0, #15	
	ADD R0, R0, #15
	ADD R0, R0, #15
	ADD R0, R0, #12

	LD R2, DEC_SHIFT
	ADD R0, R0, R2
	BRn INVALID_INPUT
	ADD R1, R0, #0
	ADD R3, R3, #-1	

CONVERT_1
	GETC
	OUT 

	LD R2, ENTER_SHIFT
	ADD R0, R0, R2
	BRz LAST_CHECK
	ADD R0, R0, #10

	LD R2, NAN
	ADD R0, R0, R2
	BRp INVALID_INPUT
	ADD R0, R0, #15
	ADD R0, R0, #15
	ADD R0, R0, #15
	ADD R0, R0, #12

	LD R2, DEC_SHIFT
	ADD R0, R0, R2
	BRn INVALID_INPUT
	ADD R2, R1, #0
	MULTIPLY_1
		ADD R1, R1, R2
		ADD R4, R4, #-1
		BRp MULTIPLY_1
	LD R4, MULTIPLY_COUNTER
	ADD R1, R1, R0
	ADD R3, R3, #-1
	BRp CONVERT_1

	LD R0, NEWLINE_2
	OUT
	ADD R5, R5, #0
	BRn NEGATIVE
	BR DONE_INPUT

PRE_CONVERT_2
	GETC
	OUT

	LD R2, ENTER_SHIFT
	ADD R0, R0, R2
	BRz INVALID_INPUT
	ADD R0, R0, #10

	LD R2, NAN
	ADD R0, R0, R2		
	BRp INVALID_INPUT
	ADD R0, R0, #15	
	ADD R0, R0, #15
	ADD R0, R0, #15
	ADD R0, R0, #12

	LD R2, DEC_SHIFT
	ADD R0, R0, R2
	BRn INVALID_INPUT
	ADD R1, R0, #0
	ADD R3, R3, #-1	
CONVERT_2
	GETC
	OUT 

	LD R2, ENTER_SHIFT
	ADD R0, R0, R2
	BRz LAST_CHECK
	ADD R0, R0, #10

	LD R2, NAN
	ADD R0, R0, R2
	BRp INVALID_INPUT
	ADD R0, R0, #15
	ADD R0, R0, #15
	ADD R0, R0, #15
	ADD R0, R0, #12

	LD R2, DEC_SHIFT
	ADD R0, R0, R2
	BRn INVALID_INPUT
	ADD R2, R1, #0
	MULTIPLY_2
		ADD R1, R1, R2
		ADD R4, R4, #-1
		BRp MULTIPLY_2 
	LD R4, MULTIPLY_COUNTER
	ADD R1, R1, R0
	ADD R3, R3, #-1
	BRp CONVERT_2

	LD R0, NEWLINE_2
	OUT
	ADD R5, R5, #0
	BRn NEGATIVE
	BR DONE_INPUT

INVALID_INPUT
	LD R0, NEWLINE_2
	OUT
	LEA R0, Error_msg_2
	PUTS
	AND R1, R1, #0
	LD R3, INPUT_COUNTER
	LD R2, ENTER_SHIFT
	BR START

INVALID_INPUT_POST_ENTER
	LEA R0, Error_msg_2
	PUTS
	AND R1, R1, #0
	LD R3, INPUT_COUNTER
	LD R2, ENTER_SHIFT
	BR START

LAST_CHECK
	ADD R5, R5, #0
	BRn NEGATIVE
	BR DONE_INPUT

NEGATIVE
	NOT R1, R1				
	ADD R1, R1, #1				

DONE_INPUT

OVER_15
	LD R2, DEC_MINUS_15
	ADD R1, R1, R2  
	BRp INVALID_INPUT_POST_ENTER
	ADD R1, R1, #15 

NEGATIVE_INPUT
	ADD R1, R1, #0
	BRn INVALID_INPUT_POST_ENTER


				; RESTORE REGISTERS AS NEEDED
LD R0, BACKUP_R0_4600
LD R2, BACKUP_R2_4600
LD R3, BACKUP_R3_4600
LD R4, BACKUP_R4_4600
LD R5, BACKUP_R5_4600
LD R7, BACKUP_R7_4600
				
ret
;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_msg_2 .STRINGZ "ERROR INVALID INPUT\n"

ENTER_SHIFT 			.FILL 			#-10
ASCII_PLUS_SHIFT 		.FILL 			#-43
ASCII_MINUS_SHIFT 		.FILL 			#-45
DEC_SHIFT 			.FILL 			#-48 
NAN 				.FILL 			#-57
NEWLINE_2 			.STRINGZ 		"\n"
INPUT_COUNTER 			.FILL 			#5
MULTIPLY_COUNTER 		.FILL 			#9
DEC_MINUS_15 			.FILL 			#-15
BACKUP_R0_4600 			.BLKW 			#1
BACKUP_R2_4600 			.BLKW 			#1
BACKUP_R3_4600 			.BLKW 			#1
BACKUP_R4_4600 			.BLKW 			#1
BACKUP_R5_4600 			.BLKW 			#1
BACKUP_R7_4600 			.BLKW 			#1
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: PRINT_NUM
; Inputs: R1, which is guaranteed to be in range {0,16}
; Postcondition: The subroutine has output the number in R1 as a decimal ascii string, 
;                WITHOUT leading 0's, a leading sign, or a trailing newline.
; Return Value: None; the value in R1 is unchanged
;-----------------------------------------------------------------------------------------------------------------


;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------

.ORIG x4800

ST R1, BACKUP_R1_4800
ST R2, BACKUP_R2_4800
ST R3, BACKUP_R3_4800
ST R4, BACKUP_R4_4800
ST R5, BACKUP_R5_4800
ST R6, BACKUP_R6_4800
ST R7, BACKUP_R7_4800

ADD R1, R2, #0
ADD R6, R2, #0
AND R3, R3, #0
ADD R2, R2, #0
BRn NEGATIVE_PRINT 
BR PRECHECK

NEGATIVE_PRINT
	LD R0, ASCII_MINUS
	OUT
	NOT R2, R2
	ADD R2, R2, #1
	ADD R1, R2, #0
	ADD R6, R2, #0

PRECHECK
	LD R5, DEC_10K
	ADD R1, R1, R5 
	BRzp PRE_10K
	ADD R1, R6, #0

	LD R5, DEC_1K
	ADD R1, R1, R5
	BRzp PRE_1K 
	ADD R1, R6, #0

	LD R5, DEC_100
	ADD R1, R1, R5 
	BRzp PRE_100
	ADD R1, R6, #0

	LD R5, DEC_10
	ADD R1, R1, R5
	BRzp PRE_10
	ADD R1, R6, #0

	BR PRE_1

	PRE_10K
		ADD R1, R6, #0
		LD R5, DEC_10K
		BR CHECK_10K_LOOP

	PRE_1K
		ADD R1, R6, #0
		LD R5, DEC_1K
		BR CHECK_1K_LOOP

	PRE_100
		ADD R1, R6, #0
		LD R5, DEC_100
		BR CHECK_100_LOOP

	PRE_10
		ADD R1, R6, #0
		LD R5, DEC_10
		BR CHECK_10_LOOP

	PRE_1
		ADD R1, R6, #0
		LD R5, DEC_1
		BR CHECK_1_LOOP


CHECK_10K_LOOP
	ADD R4, R1, #0
	ADD R1, R1, R5
	BRp INCREMENT_1
	BRn END_CHECK_10K_LOOP 

	INCREMENT_1
		ADD R3, R3, #1	
		BR CHECK_10K_LOOP
END_CHECK_10K_LOOP

ADD R0, R3, #0 	
ADD R0, R0, #12	
ADD R0, R0, #12
ADD R0, R0, #12
ADD R0, R0, #12
OUT

ADD R1, R4, #0	
AND R3, R3, #0

CHECK_1K_LOOP 
	LD R5, DEC_1K
	ADD R4, R1, #0
	ADD R1, R1, R5
	BRp INCREMENT_2
	BRn END_CHECK_1K_LOOP

	INCREMENT_2
		ADD R3, R3, #1	
		BR CHECK_1K_LOOP
END_CHECK_1K_LOOP

ADD R0, R3, #0 
ADD R0, R0, #12	
ADD R0, R0, #12
ADD R0, R0, #12
ADD R0, R0, #12
OUT

ADD R1, R4, #0
AND R3, R3, #0

CHECK_100_LOOP 
	LD R5, DEC_100
	ADD R4, R1, #0
	ADD R1, R1, R5
	BRp INCREMENT_3
	BRn END_CHECK_100_LOOP

	INCREMENT_3
		ADD R3, R3, #1
		BR CHECK_100_LOOP
END_CHECK_100_LOOP

ADD R0, R3, #0
ADD R0, R0, #12
ADD R0, R0, #12
ADD R0, R0, #12
ADD R0, R0, #12
OUT

ADD R1, R4, #0
AND R3, R3, #0

CHECK_10_LOOP 
	LD R5, DEC_10
	ADD R4, R1, #0
	ADD R1, R1, R5 
	BRp INCREMENT_4
	BRn END_CHECK_10_LOOP

	INCREMENT_4
		ADD R3, R3, #1
		BR CHECK_10_LOOP
END_CHECK_10_LOOP

ADD R0, R3, #0 
ADD R0, R0, #12
ADD R0, R0, #12
ADD R0, R0, #12
ADD R0, R0, #12
OUT

ADD R1, R4, #0
AND R3, R3, #0

CHECK_1_LOOP
	LD R5, DEC_1
	ADD R4, R1, #0
	ADD R1, R1, R5
	BRp INCREMENT_5 
	BRn END_CHECK_1_LOOP

	INCREMENT_5
		ADD R3, R3, #1
		BR CHECK_1_LOOP
END_CHECK_1_LOOP

ADD R0, R3, #0
ADD R0, R0, #12
ADD R0, R0, #12
ADD R0, R0, #12
ADD R0, R0, #12
OUT

LD R1, BACKUP_R1_4800
LD R2, BACKUP_R2_4800
LD R3, BACKUP_R3_4800
LD R4, BACKUP_R4_4800
LD R5, BACKUP_R5_4800
LD R6, BACKUP_R6_4800
LD R7, BACKUP_R7_4800

ret
;--------------------------------
;Data for subroutine print number
;--------------------------------

DEC_10K			.FILL			#-10000
DEC_1K 			.FILL			#-1000
DEC_100			.FILL 			#-100
DEC_10 			.FILL 			#-10
DEC_1 			.FILL			#-1
ASCII_MINUS 		.FILL 			#45

BACKUP_R1_4800		.BLKW			#1
BACKUP_R2_4800		.BLKW			#1
BACKUP_R3_4800		.BLKW			#1
BACKUP_R4_4800		.BLKW			#1
BACKUP_R5_4800		.BLKW			#1
BACKUP_R6_4800		.BLKW			#1
BACKUP_R7_4800		.BLKW			#1

.ORIG x6A00
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xBA00			; Remote data
BUSYNESS .FILL xABCD		; <----!!!BUSYNESS VECTOR!!! Change this value to test your program.

;---------------	
;END of PROGRAM
;---------------	
.END
