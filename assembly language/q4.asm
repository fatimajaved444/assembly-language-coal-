[org 0x0100]
 jmp start
array1: db 'Enter a number between 0-9: ',0
array3: db 'Enter a number between 0- :',0
array2: db 'The sum is: ',0
temp : db '0', 0

;--------------------clear the screen--------------------
clrscr:
		push es
		push ax
		push cx
		push di
		mov ax, 0xb800
		mov es, ax
		xor di,di
		mov ax,0x0720
		mov cx,2000
		cld
		rep stosw
		pop di
		pop cx
		pop ax
		pop es
		ret
;-----------------print the string-------------------

printstr:
 		push bp
 		mov bp, sp
 		push es
 		push ax
 		push cx
 		push si
 		push di
 		push ds
 		pop es
 		mov di, [bp+4]
 		mov cx, 0xffff
 		xor al, al
 		repne scasb
 		mov ax, 0xffff
 		sub ax, cx
 		dec ax
 		jz exit
 		mov cx, ax
 		mov ax, 0xb800
 		mov es, ax
 		mov al, 80
 		mul byte [bp+8]
 		add ax, [bp+10]
 		shl ax, 1
 		mov di,ax
 		mov si, [bp+4]
 		mov ah, [bp+6]
 		cld
nextchar: 	lodsb
 		stosw
 		loop nextchar
exit:
		pop di
 		pop si
 		pop cx
 		pop ax
 		pop es
 		pop bp
 		ret 8
;-------------------print the num----------------------

printnum:
 		push bp
 		mov bp, sp
 		push es
 		push ax
 		push bx
 		push cx
 		push dx
 		push di
 
 		mov ax, 0xb800
 		mov es, ax
 		mov ax, [bp+4]
 		mov bx, 10
 		mov cx, 0
 
nextdigit:
 		mov dx, 0
 		div bx
 		add dl, 0x30
 		push dx
 		inc cx
 		cmp ax, 0
 		jnz nextdigit
 		mov di, [bp+6]
 
 nextpos:
 		pop dx
 		mov dh, 0x07
 		mov [es:di], dx
 		add di,2
 		loop nextpos
 		pop di
 		pop dx
 		pop cx
 		pop bx
 		pop ax
 		pop es
 		pop bp
 		ret 4


start:

		call clrscr

 ;------------------print the string-----------------
		mov ax, 0
		push ax
		mov ax, 0
		push ax
		mov ax, 0x07
		push ax
		mov ax, array1
		push ax
		call printstr
 
		mov ax,0xb800
		mov es,ax
		mov di,60
;-----------------take input----------------------
 		mov ah,0
		int 0x16

		mov [es:di],ax
		sub al,0x30
		mov dl, al
		mov bl,dl
		mov cx , 0
		mov ax,9
		sub ax,bx
		add al,0x30
		mov ch , 0
		mov cl , al
		mov [temp],al

 
		mov ax, 0
		push ax
		mov ax, 1
		push ax
		mov ax, 0x07
		push ax
		mov ax, array3
		push ax
		call printstr
		mov ax, 25
		push ax
		mov ax, 1
		push ax
		mov ax, 0x0f
		push ax
		mov ax, temp
		push ax
		call printstr
;--------------take inputs-------------------
		mov ax,0xb800
		mov es,ax
		add di,160
 		mov ah,0
		int 0x16

		mov ah,0x07
		mov [es:di],ax
		sub al,0x30
		mov dl, al

		mov ax, 0
		push ax
		mov ax, 2
		push ax
		mov ax, 0x07
		push ax
		mov ax, array2
		push ax
		call printstr

;-------------------add both nums--------------------
		add dl,bl
		mov dh,0
		add di,160
		push di
		push dx
		call printnum
 
 mov ax, 0x4c00
 int 0x21