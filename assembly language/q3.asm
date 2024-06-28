[org 0x0100]
jmp start


message:	db'Enter three lower case alphabets: '
length:	        dw 34


message1:	db'The output is: '
length1:	dw 15


char:	        db'000'
;------------------------clear screen-----------------------
clrscr:		push ax
       		push di
       		push es
      		mov ax,0xb800
      		mov es,ax
      		mov di,0
 nextloc:
                mov word[es:di],0x0720
                add di,2
                cmp di,4000
                jne nextloc
      		pop es
        	pop di
        	pop ax
        	ret

;------------------------printstring-------------------------
p1:		push bp
		mov bp, sp
		push es
		push ax
		push cx
		push si
		push di

		mov ax, 0xb800
		mov es, ax
		mov al, 80
		mul byte [bp+10]
		add ax, [bp+12]
		shl ax, 1
		mov di, ax
		mov si, [bp+6]
		mov cx, [bp+4]
		mov ah, [bp+8]

n1:		mov al, [si]
		mov [es:di], ax
		add di, 2
		add si, 1
		loop n1

		pop di
		pop si
		pop cx
		pop ax
		pop es
		pop bp
		ret 4		


start:		call clrscr
		mov ax,0xb800
		mov es,ax
		
		mov ax, 0
		push ax
		mov ax, 0
		push ax
		mov ax, 0x07
		push ax
		mov ax, message
		push ax
		push word [length]
		call p1
		
;----------------taking inputs-----------------	

		mov ah,0
		int 16h
		mov [char],al
		mov di,68
		mov ah, 0x07
		mov [es:di],al

		mov ah,0
		int 16h
		mov [char+2],al
		mov di,70
		mov ah, 0x07
		mov [es:di],al

		mov ah,0
		int 16h
		mov [char+4],al
		mov di,72
		mov ah, 0x07
		mov [es:di],al

;--------------displaying uppercase-----------------
		
		mov ax, 0
		push ax
		mov ax, 1
		push ax
		mov ax, 0x07
		push ax
		mov ax, message1
		push ax
		push word [length1]
		call p1

		sub word [char],32
		mov di,190
		mov byte al,[char]
		mov ah, 0x07
		mov [es:di],ax

		sub word[char+2],32
		mov di,192
		mov byte al,[char+2]
		mov ah, 0x07
		mov [es:di],ax

		sub word[char+4],32
		mov di,194
		mov byte al,[char+4]
		mov ah, 0x07
		mov [es:di],ax

		mov ax, 0x4c00
		int 0x21