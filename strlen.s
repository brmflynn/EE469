		;hw1-pt1
		;strlen()	- take a string and return its length
		;little-endian,	each char in ascii
		;string	fills from R4->R9, null terminated
init
		;string	register "input"
		LDR		R4, =0x6c6c6568 ;hell
		LDR		R5, =0x6f77206f ;o wo
		LDR		R6, =0x00646c72 ;rld
		LDR		R7, =0x00000000
		LDR		R8, =0x00000000
		
		;variable	init
		LDR		R9, =0 ;counter
		LDR		R10, =0 ;register address var
		
		;stack	initialization
		SUB		R13, R13, #16 ;R13 is stack pointer
		STMFD	R13!, {R4-R8} ;push stack (multiple)
main
		LDR		R11, [R13, R10] ;pop stack into R11
		CMP		R11, #0
		BLNE		charCount
		
		LSL		R10, R10, #2 ;after return - align next stack (i*4)
		CMP		R10, R9 ;if R10 (max possible) > R9 (actual) that is end of string
		BEQ		main
		B		exit
		
		
charCount
		ADD		R9, R9, #1 ;++count
		LSR		R11, R11, #8 ;remove each counted char
		CMP		R11, #0
		BNE		charCount
		
		LSR		R10, R10, #2 ;i/4 to properly iterate
		ADD		R10, R10, #1 ;++i
		MOV		PC, LR
		
exit
