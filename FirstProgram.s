	AREA	Demo, CODE, READONLY
	IMPORT	main
	EXPORT	start
start 
	LDR r0, =TestStr  
	LDR r3, =0x10000000 
	LDR r6, =0 
	LDR r5, =0
	LDR r8, =8 
	LDR r9, =0
	
	;Loop through to see if we have any 0's  
loop0 LDRB r7, [r0], #1 ;e bit at a time 
	CMP r7, #0 ;is this digit a 0? 
	BNE branch 
	ADD r9,r9,#1 ;Increment a counter for the amount of 0's 
branch
	
	SUB r8,r8,#1 ;Decrement counter 
	CMP r8, #0 ;If r8 != 0 keep looping 
	BNE loop0
	;Should have the amount of 0's in the string stored in r9 now 
	
	
	
	LDRB r1, [r0],#-8
loop LDRB r1, [r0], #1 ;Take one bit at a time 
	MOV r5,r1 ;Copy the bit to r5 
	;Need to check if each bit is a number/lower/uppercase 
	MOV r2, r5, LSR #4 ;Move over so we  get the first digit 
	
	;Case for numbers 
	CMP r2, #3 
	BNE endif1 
	SUB r1, r1, #0x30 ;Take away 30 to get value, MSB now in r1 
	B skip
endif1 ;Otherwise for letters  
	CMP r2, #6 
	BNE endif2 
	SUB r1,r1, #0x60 
	ADD r1,r1,#0x9 
	B skip
endif2 
	CMP r2, #4 
	BNE endif3 
	SUB r1,r1, #0x40
	ADD r1,r1,#0x9
	B skip
endif3 	
skip 
	MUL r4, r1,r3 ;Multiply by scaling factor 
	MOV r3, r3, LSR #4 ;Shift scaling factor over 
	ADD r6,r6,r4 
	
	CMP r1, #0 ;If it's not a zero, loop again 
	BNE loop 
	
	CMP r9, #0 
	BEQ branch2 ;if
	
	MOVS r9,r9 
while 
	BEQ endwh 
	MOV r6,r6, LSR #4
	SUB r9,r9,#1 
	CMP r9,#0 ;while 
	B	while 
endwh
branch2
	
	MOV r0,r6
stop	B	stop
	AREA	HexToVal, DATA, READWRITE
TestStr	DCB	"1f3"
	END	

