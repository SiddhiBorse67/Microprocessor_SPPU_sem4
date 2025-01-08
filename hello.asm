section .data
msg db "HelloWorld"
section .bss

section .txt
        global_start
        _start:
        mov rax,01
        mov rdi,01
        mov rsi,msg
        mov rdx,10
        syscall
        
        mov rax,60
        mov rdi,0
        syscall
