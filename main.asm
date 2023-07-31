BITS 16 
mov ax, 07C0h
add ax, 288
mov ss, ax
mov sp, 4096
mov ax, 07C0h
mov ds, ax

mov si, msg
call print_string

mov si, msg
call print_string
call read_command
jmp $

msg db 'Bienvenido a Bootloader', 13, 10, 0
msgb db 'Buen Dia Emma', 13 ,10 , 0

command db 20 dup(0)

print_string:
mov ah, 0x0E
mov bh, 0x00

.repeat:
lodsb
cmp al, 0
je .done
int 0x10
jmp .repeat
.done:
ret 

read_command:
mov ah, 0x0A
mov dx, command
int 0x21
cmp byte ptr [command], 'h'
je .print_hour
cmp byte ptr [command], 'm'
je .print_memory
jmp .invalid_command

.print_hour:
mov ah, 0x02
int 0x1A
mov bh, 0x00
mov dl, ch
call print_hex
mov dl, cl
call print_hex
jmp .command_done

.print_memory:
mov ah, 0x48
xor bx, bx
int 0x21
mov ah, 0x02
mov dl, bl
call print_hex
jmp .command_done

.print_hex:
push ax
push bx
push cx
push dx
mov bl, dl
shr dl, 4
add dl, '0'
add dl, '9'
jle .skip_adjust
add dl, 7

.skip_adjust:
int 0x10
mov dl, bl 
and dl, 0x0F
add dl, '0'
cmp dl, '9'
jle .skip_adjust2
add dl, 7

.skip_adjust2:
int 0x10
pop dx
pop cx
pop bx
pop ax
ret

.command_done:
mov si, command
call print_string
ret

.invalid_command:
mov si, invalid
call print_string
ret

invalid db 'Comando Invalido',13,10,0
times 510-($-$$) db 0
dw 0xAA55
