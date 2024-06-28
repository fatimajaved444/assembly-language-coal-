[org 0x0100]
jmp start

message1:	db 'I won $25000 in lottery but I lost $5000.'
length1:	dw 41

;------------------clearscreen---------------------
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
;----------------print string-----------------------

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

;------------------print the string----------------
		mov ax, 10
		push ax
		mov ax, 10
		push ax
		mov ax, 0x09
		push ax
		mov ax, message1
		push ax
		push word [length1]
		call p1
		jmp end

end:		mov ah,0x1
		int 0x21

		mov ax, 0x4c00
		int 0x21