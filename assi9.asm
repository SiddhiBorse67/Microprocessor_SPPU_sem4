%macro io 4
mov rax, %1
mov rdi, %2
mov rsi, %3
mov rdx, %4
syscall
%endmacro

section .data
global scount, ecount, charcount, new, new_len

fname: db 'Assignment9.txt', 0

msg: db "File opened successfully", 0x0A
len: equ $ - msg

msg1: db "File closed successfully", 0x0A
len1: equ $ - msg1

msg2: db "Error in opening file", 0x0A
len2: equ $ - msg2

msg3: db "Spaces: ", 0x0A
len3: equ $ - msg3

msg4: db "No of Lines: ", 0x0A
len4: equ $ - msg4

msg5: db "Enter character ", 0x0A
len5: equ $ - msg5

msg6: db "No of occurances: ", 0x0A
len6: equ $ - msg6

new: db "", 0x0A
new_len: equ $ - new

scount: db 0
ecount: db 0
charcount: db 0

section .bss
global cnt, cnt2, cnt3, buffer

fd: resb 17
buffer: resb 200
buf_len: resb 17
cnt: resb 2
cnt2: resb 2
cnt3: resb 2
character: resb 2

section .text

global _start
_start:
extern spaces, enters, occurances

io 2, fname, 2, 0777
mov qword[fd], rax

bt rax, 63
jc next
io 1,1,msg, len
jmp next2
next:
io 1, 1, msg2, len2

next2:
io 0, [fd], buffer, 200
mov qword[buf_len], rax
mov qword[cnt], rax
mov qword[cnt2], rax
mov qword[cnt3], rax

io 1, 1, msg3, len3
call spaces

io 1, 1, msg4, len4
call enters

io 1, 1, msg5, len5
io 0, 1, character, 2
mov bl, byte[character]
call occurances
jmp exit

exit:
mov rax, 60
mov rdi, 0
syscall
