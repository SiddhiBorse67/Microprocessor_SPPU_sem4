
;Assignment No. 2
;Title : Accept string and display its length.
section .data
        msg1 db 10,13,"Enter String ",0xA,0xD
	len1 equ $-msg1
	msg2 db 10,13,"String length",0xA,0xD
	len2 equ $-msg2
	

section .bss
  str: resb 200
  result resb 200 
  
section .text
     global _start
    
     _start:
     
	;display
	mov rax, 1
	mov rdi, 1
	mov rsi, msg1
	mov rdx, len1
	syscall
	
	;input
	mov rax,0
	mov rdi,0
	mov rsi, str
	mov rdx, 16
	syscall
	
	
	;store length in rbx
	dec rax
	mov rbx,rax
	mov rdi,result
	mov rcx,16    
	
	loop1 :
	rol rbx,04
	mov al,bl
	and al,0fh
	cmp al,09h
	
	jg loop2
	add al,30h
	jmp l1
	
	loop2: add al,37h
	l1 : mov[rdi],al
	inc rdi
	dec cx
	jnz loop1
	
	;display
	mov rax, 1
	mov rdi, 1
	mov rsi, msg2
	mov rdx, len2
	syscall
	
	;display
	mov rax, 1
	mov rdi, 1
	mov rsi, result
	mov rdx, 16
	syscall
	
	;exit
	mov rax,60
	mov rdi,0
	syscall
     
