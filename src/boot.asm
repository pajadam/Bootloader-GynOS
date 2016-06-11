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
		
		mov bx, 0 ; position
		mov ax, 0x0020 ; data
		mov [fs:bx], ax ; set
		
		loopClearW:
			
			mov bx, cx ; position
			mov ax, 0xE020 ; data
			mov [fs:bx], ax ; set
			dec ecx
			
		loop loopClearW
		
		mov ecx, 3518
		
		loopClearB:
			
			mov bx, cx ; position
			mov ax, 0x0020 ; data
			mov [fs:bx], ax ; set
			dec ecx
			
		loop loopClearB
		
		; P
			mov bx, 3812 ; position
			mov ax, 0xEF50 ; data
			mov [fs:bx], ax ; set
		; R
			mov bx, 3814 ; position
			mov ax, 0xEF52 ; data
			mov [fs:bx], ax ; set
		; E
			mov bx, 3816 ; position
			mov ax, 0xEF45 ; data
			mov [fs:bx], ax ; set
		; S
			mov bx, 3818 ; position
			mov ax, 0xEF53 ; data
			mov [fs:bx], ax ; set
		; S
			mov bx, 3820 ; position
			mov ax, 0xEF53 ; data
			mov [fs:bx], ax ; set
		; [space]
			mov bx, 3822 ; position
			mov ax, 0xEF20 ; data
			mov [fs:bx], ax ; set
		; A
			mov bx, 3824 ; position
			mov ax, 0xEF41 ; data
			mov [fs:bx], ax ; set
		; N
			mov bx, 3826 ; position
			mov ax, 0xEF4E ; data
			mov [fs:bx], ax ; set
		; Y
			mov bx, 3828 ; position
			mov ax, 0xEF59 ; data
			mov [fs:bx], ax ; set
		; [space]
			mov bx, 3830 ; position
			mov ax, 0xEF20 ; data
			mov [fs:bx], ax ; set
		; K
			mov bx, 3832 ; position
			mov ax, 0xEF4B ; data
			mov [fs:bx], ax ; set
		; E
			mov bx, 3834 ; position
			mov ax, 0xEF45 ; data
			mov [fs:bx], ax ; set
		; Y
			mov bx, 3836 ; position
			mov ax, 0xEF59 ; data
			mov [fs:bx], ax ; set
	
	jmp loop
 
loop:
	; WAIT FOR ANY KEY
	mov ah, 00h
	int 16h
	
	; CLEAR SCREEN
	mov ecx, 3998
	loopClearA:
			
		mov bx, cx ; position
		mov ax, 0x0020 ; data
		mov [fs:bx], ax ; set
		dec ecx
			
	loop loopClearA
	
	; THEN START BOOTING

	jmp loop
 
   times 510-($-$$) db 0
   db 0x55
   db 0xAA