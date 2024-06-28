[org 0x100]
Jmp start

array1: db 'Enter a 2-digit number: '
l1: dw 24
array2: db 'Enter another 2-digit number: '
l2: dw 30
array3: db 'Sum: '
l3: dw 5

arr4: dw 0
arr5: dw 0


;------------------clearsrceen--------------------
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
;------------------printing the string-------
	
printstring:
	 	push bp 
		mov bp,sp
                Push ax
                Push cx
                Push es
                Push si
               
                mov ax,0xb800
                mov es,ax

                mov si,[bp+6]          ;point si to string
                mov cx,[bp+4]          ;load length of string in cx
                mov ah,0x07

nextchar:	mov al,  [si]
                inc si
                mov [es:di], ax
                add di,2
                loop nextchar

                pop si
                pop es
                pop cx
                pop ax
                pop bp
                ret 4

printnum:	push bp 
		mov bp,sp
                push ax
                push bx
                push cx
                push dx
                push es
                
		 mov ax,0xb800
                 mov es,ax

                 mov ax,[bp+4]
                 mov cx,0
                 mov bx,10
    

nextdigit:		mov dx,0
                div bx
                add dl,0x30
                push dx
                inc cx
                cmp ax,0
                jnz nextdigit

             

nextpos:	pop dx
                mov dh,0x07
                mov [es:di],dx
                add di,2
                loop nextpos

                pop es
                pop dx
                pop cx
                pop bx
                pop ax
                pop bp
                ret 2

start:		call clrscr

;---------------print the string-----------------
          	mov ax,0xb800
         	mov es,ax
         	mov ax,array1 
	 	push ax
          	mov ax,[l1]
          	push ax
          	mov di,0
          	call printstring

;------------------input num1----------------
		mov ah,0
           	int 16h
           	mov ah,0x07
           	mov [es:di],ax
           	add di,2
           	mov ah,0
           	sub ax,0x30
           	mov bl,10
           	mul bl
           	mov bx,ax
          
           	mov ah,0
           	int 16h
           	mov ah,0x07
           	mov [es:di],ax
           	add di,2
           	mov ah,0
           	sub ax,0x30
           	add bx,ax
		mov [arr4],bx

;----------------print string---------------
		mov ax,array2
              	push ax
           	mov ax,[l2]
           	push ax
           	mov di,160
           	call printstring

;---------------------input number-------------
		 mov ah,0
           	int 16h
           	mov ah,0x07
           	mov [es:di],ax
           	add di,2
           	mov ah,0
           	sub ax,0x30
           	mov bl,10
           	mul bl
           	mov bx,ax

		mov ah,0
           	int 16h
           	mov ah,0x07
           	mov [es:di],ax
           	add di,2
           	mov ah,0
           	sub ax,0x30
           	add bx,ax
		mov [arr5],bx

;---------------------print sum--------------------
		mov ax,array3
           	push ax
           	mov ax,[l3]
           	push ax
           	mov di,320
           	call printstring
           	add di,2

;--------------------add both numbers-------------

           	mov ax,[arr4]
           	add ax,[arr5]
           	push ax
           	call printnum   

		mov ax,0x4c00
          	int 0x21