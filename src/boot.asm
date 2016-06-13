[bits 16]
[ORG 0x7c00]
	; Clear interrupts flag
	cli 
	
		; Video Memory
		mov ax, 0xb800 
		mov fs, ax
		
		; COLOR  CHARACTER ASCII
		; 0x42   20
		; SCREEN SIZE 80 * 25 | 2 BYTES
		
		; HIDE CURSOR
		mov ah, 01h
		mov cx, 2607h
		int 10h
		
		; CLEAR SCREEN
		
		mov ecx, 3998
		loopClearW:
			
			mov bx, cx ; position
			mov ax, 0xE020 ; data
			mov [fs:bx], ax ; set
			dec ecx
			
		loop loopClearW
		
		mov bx, 0 ; position
		mov ax, 0xB020 ; data
		mov [fs:bx], ax ; set
		
		
		; DRAW TARGET IMAGE
		mov ecx, 3518
		loopDraw:
		
			mov bx, cx ; position
			mov [fs:bx], ax ; set
			
			; SET COLOR
				; MONITOR STAND
				cmp ecx, 3478
					je gray
				cmp ecx, 3398
					je cyan
				; MONITOR STAND UPPER
				cmp ecx, 3288
					je gray			
				cmp ecx, 3268
					je cyan				
				cmp ecx, 3128
					je gray				
				cmp ecx, 3108
					je cyan
				; DISPLAY
				cmp ecx, 3040
					je gray
				cmp ecx, 2880
					je cyan
				cmp ecx, 320
					je gray
				cmp ecx, 160
					je cyan
			
			; AFTER COLORS
			afterColors:
			dec ecx
		
		loop loopDraw
			
			; DRAW MONITOR BLACK BACKGROUND
			mov ecx, 317
			loopBackground:
				add ecx, 3
				mov bx, cx
				mov ax, 0x0020 ; data
				
				cmp cx, 2880
				je afterBG
				
				mov [fs:bx], ax ; set
			
			loop loopBackground
			afterBG:
			
			; DRAW INFO
			mov bx, 2720 ; position
			mov ax, 0x873A ; data
			mov [fs:bx], ax ; set
			
			mov bx, 2722 ; position
			mov ax, 0x0750 ; data
			mov [fs:bx], ax ; set
			
			mov bx, 2724 ; position
			mov ax, 0x0752 ; data
			mov [fs:bx], ax ; set
			
			mov bx, 2726 ; position
			mov ax, 0x0745 ; data
			mov [fs:bx], ax ; set
			
			mov bx, 2728 ; position
			mov ax, 0x0753 ; data
			mov [fs:bx], ax ; set
			
			mov bx, 2730 ; position
			mov ax, 0x0753 ; data
			mov [fs:bx], ax ; set
			
			mov bx, 2732 ; position
			mov ax, 0x0720 ; data
			mov [fs:bx], ax ; set
			
			mov bx, 2734 ; position
			mov ax, 0x0741 ; data
			mov [fs:bx], ax ; set
			
			mov bx, 2736 ; position
			mov ax, 0x074E ; data
			mov [fs:bx], ax ; set
			
			mov bx, 2738 ; position
			mov ax, 0x0759 ; data
			mov [fs:bx], ax ; set
			
			mov bx, 2740 ; position
			mov ax, 0x0720 ; data
			mov [fs:bx], ax ; set

			mov bx, 2742 ; position
			mov ax, 0x074B ; data
			mov [fs:bx], ax ; set
			
			mov bx, 2744 ; position
			mov ax, 0x0745 ; data
			mov [fs:bx], ax ; set
			
			mov bx, 2746 ; position
			mov ax, 0x0759 ; data
			mov [fs:bx], ax ; set
		
			; DRAW TERMINAL CHARS
			mov bx, 320 ; position
			mov ax, 0x073E ; data
			mov [fs:bx], ax ; set
			
			mov bx, 322 ; position
			mov ax, 0x0772 ; data
			mov [fs:bx], ax ; set
			
			mov bx, 324 ; position
			mov ax, 0x0775 ; data
			mov [fs:bx], ax ; set
			
			mov bx, 326 ; position
			mov ax, 0x076E ; data
			mov [fs:bx], ax ; set
			
			mov bx, 328 ; position
			mov ax, 0x875F ; data
			mov [fs:bx], ax ; set
		
		jmp continue
		
			cyan:
				mov ax, 0xB020
			jmp afterColors
			
			gray:
				mov ax, 0xF020
			jmp afterColors
			
			black:
				mov ax, 0x0720
			jmp afterColors
		
		continue:
			; "GynOS"	
			
			mov bx, 2870 ; position
			mov ax, 0x0947 ; data
			mov [fs:bx], ax ; set
			
			mov bx, 2872 ; position
			mov ax, 0x0979 ; data
			mov [fs:bx], ax ; set
			
			mov bx, 2874 ; position
			mov ax, 0x096E ; data
			mov [fs:bx], ax ; set
			
			mov bx, 2876 ; position
			mov ax, 0x034F ; data
			mov [fs:bx], ax ; set
			
			mov bx, 2878 ; position
			mov ax, 0x0353 ; data
			mov [fs:bx], ax ; set
	
	; WAIT FOR ANY KEY
	mov ah, 00h
	int 16h
	
	; CLEAR SCREEN
	mov ecx, 3998
	loopClearA:
			
		mov bx, cx ; position
		mov ax, 0x0700 ; data
		mov [fs:bx], ax ; set
		dec ecx
			
	loop loopClearA
	
	mov bx, 0 ; position
	mov ax, 0x0700 ; data
	mov [fs:bx], ax ; set
	
	; THEN START BOOTING
	
		; Load from floppy stage 2.
		; DL == already set by BIOS
		; AX -- 16 bits, AH AL -- 8 bits
		; EAX -- AX
		mov ecx, ecx
		mov edx, edx
		mov ax, 0x2000 ; 0x2000:0x0000
		mov es, ax
		xor bx, bx ; bx == 0

		mov ah, 2  ; read sectors into memory
		mov al, 0xcc  ; 1337 stage2  3 * 512 
		nop
		nop
		mov ch, 0
		mov cl, 2  ; sectors start from 1, or so they say ;)
		mov dh, 0

		int 13h
		  
		; Jump to stage 2
		jmp word 0x2000:0x0000

epilogue:
	%if ($ - $$) > 510
	  %fatal "Bootloader code exceed 512 bytes."
	%endif
	
	times 510 - ($ - $$) db 0
	db 0x55
	db 0xAA
