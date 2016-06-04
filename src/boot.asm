[ORG 0x7c00]
	; Clear interrupts flag
	cli 
	
		; Video Memory
		mov ax, 0xb800 
		mov fs, ax
		
		; COLOR  CHARACTER ASCII
		; 0x42   20
		; SCREEN SIZE 80 * 25 | 2 BYTES
		
		mov bx, 0 ; position
		mov ax, 0xF054 ; data
		mov [fs:bx], ax ; set
		
		mov bx, 2 ; position
		mov ax, 0xF045 ; data
		mov [fs:bx], ax ; set
		
		mov bx, 4 ; position
		mov ax, 0xF053 ; data
		mov [fs:bx], ax ; set
		
		mov bx, 6 ; position
		mov ax, 0xF054 ; data
		mov [fs:bx], ax ; set
	
	jmp loop
 
loop:
   jmp loop
 
   times 510-($-$$) db 0
   db 0x55
   db 0xAA