%macro disp 2
mov rax,01
mov rdi,01
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro exit 0
mov rax,60
mov rdi,00
syscall
%endmacro

section .data
msg db "The Number is : "
msg_len equ $ -msg
fact_msg db "Factorial is : "
fact_len equ $-fact_msg
newline db 10

section .bss
fact resb 8
num resb 2

section .text
global _start:
_start:
pop rbx ;total no. of args
pop rbx ;program name
pop rbx ;actual val

mov [num],rbx

; print accpeted number from the user
disp msg,msg_len
mov rax,1
mov rdi,1
mov rsi,[num]
mov rdx,2
syscall

mov rsi,[num]
mov rcx,02
xor rbx,rbx
call AsciiToHex

mov rax,rbx
call factNum

mov rcx,08
mov rdi,fact
xor bx,bx
mov ebx,eax
call HexToAscii

disp newline,01

disp fact_msg,fact_len
mov rax,1
mov rdi,1
mov rsi,fact
mov rdx,8
syscall

mov rax,60
mov rdi,0
syscall

factNum:
dec rbx
cmp rbx,01
je comeOut
cmp rbx,00
je comeOut
mul rbx
call factNum
comeOut:ret

AsciiToHex:
up1: rol bx,04
     mov al,[rsi]
     cmp al,39H
     jbe A2
     sub al,07H
A2: sub al,30H
  add bl,al
  inc rsi
  loop up1
ret

HexToAscii:
d: rol ebx,04H
mov ax,bx
and ax,0fH
cmp ax,09H
jbe l1
add ax,07H
l1: add ax,30H
mov [rdi],ax
inc rdi
loop d
ret
