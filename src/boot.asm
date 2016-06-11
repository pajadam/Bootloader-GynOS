[ORG 0x7c00]
	; Clear interrupts flag
	cli 
	
		; Video Memory
		mov ax, 0xb800 
		mov fs, ax
		
		; COLOR  CHARACTER ASCII
		; 0x42   20
		; SCREEN SIZE 80 * 25 | 2 BYTES
		
		; BIOS WAIT AS MICROSECONDS
		; mov ah, 86h
		; mov bx, bx
		; mov ax, ax
		; mov cx, 0x00001
		; mov dx, 0xFFFFF
		; int 15h
		
		; HIDE CURSOR
		mov ah, 01h
		mov cx, 2607h
		int 10h
		
		; CLEAR SCREEN
		mov ecx, 3998
		loopClear:
		
			mov bx, cx ; position
			mov ax, 0x0020 ; data
			mov [fs:bx], ax ; set
			dec ecx
			
		loop loopClear
		
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
	; WAIT FOR ANY KEY
	mov ah, 00h
	int 16h
	
	; THEN START BOOTING

	jmp loop
 
   times 510-($-$$) db 0
   db 0x55
   db 0xAA