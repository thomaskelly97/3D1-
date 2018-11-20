	AREA	Demo, CODE, READONLY
	IMPORT	main
	EXPORT	start
start 
	LDR	r1, =0xFEED1234 ;INPUT 
	MOV r9, r1 ;COPY 
	LDR r0, =0xA1000400 ;TARGET ADDRESS 
	LDR r8, =0x8 
	LDR r2, =0 
	LDR r7, =2_1111 ;BINARY 
	LDR r3, =0
	LDR r5, =0 
	
	MOVS r1,r1
while
	MOV r9, r9, ROR #28
	AND r2, r9,r7
	
	MOVS r2,r2
	CMP r2, #9 
	BHI endif1 ;IF r2 is more than 9 skip this
	ADD r6,r2, #0x30 ;NUMBER 1-9 
endif1 
	MOVS r2,r2 
	CMP r2, #9 
	BLS endif2 ;IF r2 is less than or = 9 skip this part 
	SUB r6, r2, #0x9
	ADD r6, r6, #0x40
endif2 
	STR r6, [r0],#1 ;STORE BYTE IN ADDRESS 
	ADD r3,r3,#1
	SUB r8,r8,#1 
	MOVS r8,r8
	CMP r8, #0 ;IF r8 = 0 DONT LOOP
	BEQ skiploop
	B	while 
skiploop
stop	B	stop
	END	

