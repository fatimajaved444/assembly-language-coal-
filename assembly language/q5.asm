[org 0x0100]
 jmp start
 message: db 'Enter a number between 0-9: ',0
 messagee: db 'Enter a number between 0-9: ',0
 sum: db 'Sum ',0
 diff: db 'Difference ',0
 prod: db 'Product ',0
 divide: db 'Division ',0
;---------------------clear the screen----------------

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
;------------------------print the string---------------

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
 nextchar:	
	 lodsb
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
;--------------------print the number----------------------
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
  	mov dh, 0x0f
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

 	mov ax, 0
 	push ax
 	mov ax, 0
 	push ax
 	mov ax, 0x07
 	push ax
 	mov ax, message
 	push ax
	call printstr

 	mov ax,0xb800
 	mov es,ax
 	mov di,54
 	;--------------take num as input--------------
	mov ah,0
 	int 0x16
 
 	mov ah,0x07
	mov [es:di],ax  
 	sub al,0x30
 	mov dl, al  
 	mov cl,dl

 	mov ax, 0
 	push ax
 	mov ax, 1
 	push ax
 	mov ax, 0x07
 	push ax
 	mov ax, messagee
 	push ax
 	call printstr
 	mov di,134
;-----------------take num 2 as input----------------
 	mov ah,0
 	int 0x16
 
 	mov ah,0x07
 	mov [es:di],ax
 	sub al,0x30
 	mov bl , al 
 	add dl,al
 	add di,320
 	push di
 	mov dh , 0
 	push dx
 	call printnum

 	mov ax, 0
 	push ax
 	mov ax, 4
 	push ax
 	mov ax, 0x07
 	push ax
 	mov ax, diff
 	push ax
 	call printstr

 	mov dx , 0
 	mov dl,cl
 	mov al,bl
 	sub dl,al
 	add di,160
 	push di
 	push dx
 	call printnum

	mov ax, 0
 	push ax
 	mov ax, 5
 	push ax
 	mov ax, 0x07
 	push ax
 	mov ax, prod
 	push ax
 	call printstr

 	mov al,cl
 	mul byte bl
 	add di,160
 	push di
 	push ax
 	call printnum


 	mov ax, 0
 	push ax
 	mov ax, 6
 	push ax
 	mov ax, 0x07
 	push ax
 	mov ax, divide
 	push ax
 	call printstr

 	mov ah , 0
 	mov al,cl
 	div byte bl
 	add di,160
 	push di
 	push ax
 	call printnum

 mov ax, 0x4c00
 int 0x21