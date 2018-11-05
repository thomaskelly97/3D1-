	AREA	Demo, CODE, READONLY
	IMPORT	main
	EXPORT	start
start 
		LDR r0, =0x852

		MOV r1, r0 
		LDR r2, =0x0 
		LDR r3, =7
		LDR r5, =0
		LDR r7, =0
		LDR r8, =0
		LDR r11, =0 
		MOVS r3, r3
		LDR r10, =0x3fe 
		LDR r12, =0x1fe
		MOV r14,r1 
		;Clear the bits 0,1,3,7
		MOV r0, r1, LSR #2 ;Get rid of 0 and 1 
		AND r5, r0, #0x1 ;Save the last 1 bit and the first 9 
		AND r6, r0, r10 
		MOV r6,r6, LSR #1 ;Shift the first 9 over once to the right 
		AND r6, r6, r12 ;delete the last bit 
		ADD r0, r6, r5 ;add them back together 
		
		;MOV r1, r1, LSR #1 
		AND r5,r0, #0x1F
		AND r6, r0, #0x1e0 
		MOV r6,r6, LSR #1 
		AND r5, r5, #0xf 
		ADD r0, r6, r5 
		;At this point we have cleared the an restored the 8 bit code in r1 
		MOV r1,r0 
		LDR r3, =7
		LDR r5, =0
		LDR r7, =0
		LDR r8, =0
		LDR r11, =0 
		
		AND r2, r1, #0x1B ;for c0
		AND r0, r1, #0x6D ;for c1
		AND r8, r1, #0x2E ;for c2 
		AND r11, r1, #0xF0 ;for c3 
		;c0
		AND r4,r2,#0x1 
		ADD r5,r5,r4 
		
		;c1
		AND r6,r0, #0x1 
		ADD r7,r7,r6 
		
		;c2 
		AND r9,r8, #0x1 
		ADD r10,r10,r9 
		
		;c3 
		AND r12,r11, #0x1 
		ADD r13, r13, r12 
		
whileoo
		BEQ			endwh 
		
		MOV r2,r2, LSR #1
		AND r4,r2,#0x1 
		ADD r5,r5,r4 
	
		MOV r0,r0, LSR #1 
		AND r6, r0, #0x1
		ADD r7,r7,r6
		
		MOV r8,r8, LSR #1 
		AND r9, r8, #0x1
		ADD r10,r10,r9
		
		MOV r11,r11, LSR #1 
		AND r12, r11, #0x1 
		ADD r13,r13,r12 
		
		SUBS r3, r3, #0x1
		B		whileoo
endwh 
   		AND r2, r5,#0x1 ;c0 is now in r2 
   		AND r0, r7,#0x1 ;c1 is now in r0 
   		AND r8, r10,#0x1 ;c2 is now in r8
   		AND r11, r13, #0x1 ;c3 is now in r11 
   		
   		;Add the c0, c1 
   		MOV r3, r1, LSL #1 
   		ADD r3, r3, r0 
   		MOV r3, r3, LSL #1 
   		ADD r3, r3, r2
   		
   		;Insert c2 
   		AND r4, r3, #0x3F8 ;Save the front 7
   		AND r5, r3, #0x7 ;Save the back 3
   		MOV r4,r4, LSR #3
   		MOV r4,r4, LSL #1 
   		ADD r4,r4,r8 
   		MOV r6,r4, LSL #3
   		ADD r4,r6,r5 
   		
   		
   		;Insert c3 
   		AND r6, r4, #0x780 ;Save the front 4
   		AND r5, r4, #0x7F ;Save the back 7
   		MOV r6,r6, LSR #6
   		;MOV r6,r6, LSL #1 
   		ADD r6,r6,r11
   		MOV r7,r6, LSL #7
   		ADD r4,r7,r5 
   		MOV r0,r4
   		
   		EOR r1,r14,r0 
   		;Save bits 0 and 1 
   		AND r2,r1, #0x3
   		;Save bit 5 
   		AND r3,r1, #0x20 
   		MOV r3,r3, LSR #3 
   		;Save bit 7 
   		AND r4,r1, #0x80
   		MOV r4,r4, LSR #4
   		;Add the whole lot up 
   		ADD r5,r2,r3 
		ADD r5,r5,r4 
   		SUB r5,r5,#0x1 
   		;Bit 'r5' is incorrect and must be inverted 
		MOVS r5,r5
   		MOVS r8,r5
   		LDR r7, =0xffe 
   		LDR r9, =0x20
whileo
   		BEQ 	endwho 
   		MOV r0,r0, ROR #1 
   		
   		SUBS r5,r5,#0x1 
   		B 		whileo
endwho
   		EOR r0, r0,#0x1
   		SUBS r8, r9, r8
whilet
   		BEQ 	endwht 
		MOV r0,r0, ROR #1 
   		
   		SUBS r8,r8,#0x1 
   		B 		whilet 
endwht
   		LDR r12, = 0x1fe 
   		LDR r10, = 0x3fe 
   		MOV r0,r0, LSR #2 
   		
   		AND r5, r0, #0x1 ;Save the last 1 bit and the first 9 
   		AND r6, r0, r10 
		MOV r6,r6, LSR #1 ;Shift the first 9 over once to the right 
   		AND r6, r6, r12 ;delete the last bit 
   		ADD r0, r6, r5 ;add them back together 
   		
   	;MOV r1, r1, LSR #1 
   		AND r5,r0, #0x1F
   		AND r6, r0, #0x1e0 
   		MOV r6,r6, LSR #1 
   		AND r5, r5, #0xf 
   		ADD r0, r6, r5 
		
		LDR r3, =0x852 
		CMP r14, r3 
		BEQ 	a
		B		bb 
a 
		MOV r0, #0xA
bb 
 
		
stop	B	stop

	END	

