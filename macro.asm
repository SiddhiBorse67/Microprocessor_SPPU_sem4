section .data
msg db "Enter The String:",10
msg_len equ $ - msg
    
msg1 db "The String is: ",10
    msg_len1 equ $ - msg1
    
    
section .bss
        result resb 20
        string resb 20
        
        %macro get 2
        mov rax,0
        mov rdi,0
        mov rsi,%1
        mov rdx,%2
        syscall
        %endmacro
        
        %macro print 2
        mov rax,1
        mov rdi,1
        mov rsi,%1
        mov rdx,%2
        syscall
        %endmacro

section .text
        global _start:
        _start:
        
        print msg,msg_len
        get string,msg_len
        
        
        mov rbx,rax
        mov rbp,result
        mov cx,16H
        
    back:Rol rbx,04H
        mov al,bl
        AND al,0FH
        CMP al,09H
        Jg add_37
        add al,30H
        JMP skip
    add_37:add al,37H
    skip: mov byte[rbp],al
        Inc rbp
        DEC cx
        JNZ back
        
        mov rax,1
        mov rdi,1
        mov rsi,result
        mov rdx,16
        syscall        
       
       
       
     
        mov rax,60
        mov rdi,0
        syscall
