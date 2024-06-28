[org 0x0100]
	jmp start

alpha:     	dw 36 
message:	db 'ALPHA is: '
length:		dw 10
;------------------clearsrceen---------------
clrscr: 	push es 
 		push ax 
 		push cx 
 		push di 
 		mov ax, 0xb800 
 		mov es, ax 
 		xor di, di 
 		mov ax, 0x0720 
 		mov cx, 2000 
 		cld 
 		rep stosw 
 		pop di
		pop cx 
 		pop ax 
 		pop es 
 		ret
;-----------------print the string------------


p1:		push bp
		mov bp, sp
		push es
		push ax
		push cx
		push si
		push di

		mov ax, 0xb800
		mov es, ax
		mov di, 0
		mov ah, 0x07
		mov si, [bp+8]
		mov cx, [bp+6]
		
;----------------nextcharacter-----------------
n1:		mov al, [si]
		mov [es:di], ax
		add di, 2
		add si, 1
		loop n1
		mov ax, [bp+4]
		mov cx, 0 
		mov bx, 10
 ;----------------------print the digit----------------

nextdigit: 	mov dx, 0 
 		div bx 
 		add dl, 0x30  
 		push dx 
 		inc cx  
 		cmp ax, 0
 		jnz nextdigit 

;-------------------next position------------
nextpos: 	pop dx 
 		mov dh, 0x07 
 		mov [es:di], dx 
 		add di, 2 
 		loop nextpos 
 		pop di
		pop si
      		pop cx
        	pop ax
        	pop es
        	pop bp
        	ret 4


start:		call clrscr
		mov ax, message
		push ax
		push word [length]
		mov ax, [alpha]
		push ax
		
		call p1

	
		mov ax, 0x4c00
		int 0x21