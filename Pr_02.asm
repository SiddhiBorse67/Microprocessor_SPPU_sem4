section .data
msg db "Enter The String : ",10,13
len equ $-msg
msg1 db "The String is : ",10,13
len1 equ $-msg1

section .bss
        result resb 20
        str resb 20

section .text
        global _start:
        _start:
        
        mov rax,1
        mov rdi,1
        mov rsi,msg
        mov rdx,20
        syscall
        
        mov rax,0
        mov rdi,0
        mov rsi,str
        mov rdx,20
        syscall
        
        mov rax,1
        mov rdi,1
        mov rsi,msg1
        mov rdx,20
        syscall
        
        mov rax,1
        mov rdi,1
        mov rsi,str
        mov rdx,20
        syscall
        
       
        mov rax,60
        mov rdi,0
        syscall
