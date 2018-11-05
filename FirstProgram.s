	AREA	Demo, CODE, READONLY
	IMPORT	main
	EXPORT	start
start 
	LDR R1, =2_01110001000111101100111000111111 ;Original input 
	LDR R2, = 0x20 ;Loop counter 
	LDR r0, = 0x0 ;Sequence counter variable 
	LDR r5, = 0x0 ;PREVIOUS  
	
	;Examine the first bit: 
	
	;Loop through and examine each bit 
	;Prev is initially set to 0 in r5 
	MOVS r2,r2 
	
while 
	BEQ 	endwh ;Loop 32 times 
	AND r3, r1, #0x1 ;Get the first bit of r1 on it's own in r3 
	MOVS r3,r3 
	CMP r3, #0x1 ;See if it's a 1 
	BEQ endif  ;if it's a one take this branch 
	B 	bb 
endif 
	MOVS r5,r5
	CMP r5,#0x0 ;See if the previous value was a 0
	BEQ endif2 
	B	bb2
endif2 
			;If the previous value is a zero, count 
	ADD r0,r0, #0x1 
bb2
bb
	MOV r5,r3 ;Put the previous value in r5
	MOV r1, r1, LSR #1 ;Shift right 
	SUBS r2, r2, #1 ;Decrement the loop counter 
	B		while 
endwh 

stop	B	stop

	END	;

