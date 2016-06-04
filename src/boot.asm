[ORG 0x7c00]
	; Clear interrupts flag
	cli 
	
	; code here
	
	jmp loop
 
loop:
   jmp loop
 
   times 510-($-$$) db 0
   db 0x55
   db 0xAA