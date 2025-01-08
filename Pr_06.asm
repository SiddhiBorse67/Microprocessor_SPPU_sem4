
section .data

	count1 db 16
	mystr db 10,13, "********** MENU ********** ",10,13,"1.Hex to BCD",10,13,"2.BCD to Hex",10,13,"3.Exit",10,13
	len equ $-mystr
	msg db "Enter Choice",10,13
	len1 equ $-msg
        
        m1 db "Enter Hex Number  :",10,13
        l1 equ $-m1

        m2 db "Enter BCD Number  :",10,13
        l2 equ $-m2
        
	m3 db "Hex to BCD is  :",10,13
	l3 equ $-m3
	
	m4 db "BCD to Hex is :",10,13
	l4 equ $-m4

	;num1 db 0000000000000004h
	;num2 db 0000000000000004h
	
section .bss
       choice resb 1
        num resb 16
        answer resb 16
        factor resb 16
        cnt resb 1
        dcnt resb 1
        
        %macro rw 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
        %endmacro rw
        
section .text
global _start
_start:
          
      up: rw 1,1,mystr,len
          rw 1,1,msg,len1
          rw 0,0,choice,1
          
          cmp byte[choice],'1'
          je hextobcd
        
          
          cmp byte[choice],'2'
          je bcdtohex
          
          
          cmp byte[choice],'3'
          je exitprog
         
  ;******************Hex to bcd***************
hextobcd:
        rw 1,1,m1,l1
      
        call accept
        
        mov rax,rbx
        mov rbx,10
        mov rdi,num
        
  loop2:
        mov rdx,0
        div rbx
        push dx
        inc byte[dcnt]
        
     
        cmp rax,0
        jne loop2
        
        rw 1,1,m3,l3
   b1:  pop dl
        add dl,30
        mov [num],dl
          rw 1,1,num,1
          dec byte[dcnt]
          jnz b1
       
        
        
        
 
 jmp up
 ;***************BCD to HEX*****************       
bcdtohex:
        rw 1,1,m2,l2
        rw 0,0,num,17  
        mov rcx,16
	mov rsi,num+15
	mov rbx,0
	mov qword[factor],1
	
loop4:
	mov rax,0	
	mov al,[rsi]
        sub al,30h
	mul qword[factor]
	add rbx,rax
	mov rax,10
	mul qword[factor]
	mov qword[factor],rax
	dec rsi
	loop loop4

	rw 1,1,m4,l4
	mov rax,rbx
	call Display1   
          
 jmp up
        
        
exitprog:
        mov rax,60
        mov rdi,0;
        syscall                   
        
 ;******************Accept **************
 accept:
                rw 0,0,num,5
		mov rsi, num		
		mov byte[cnt], 5
		mov rbx, 0
		mov rax, 0
			
	loop1:	shl rbx, 04
		mov al, [rsi]		
		cmp al, 39h
		jbe skip1
		sub al, 07h
	skip1:	sub al, 30h
		
		add rbx, rax
		;add bl,al
		
		inc rsi
		dec byte[cnt]
		jnz loop1	
	ret      
        
        
        
 ;*********************Display***************************
Display1:
        mov rbx,rax
        mov rsi,answer
        xor rcx,rcx
        mov cx,16
        
        
     back1:
           rol rbx,04h
           mov al,bl
           and al,0fh
           cmp al,09h
           jg add_37
           add al,30h
           jmp skip
           
     add_37:
           add al,37h
           
     skip:
           mov byte[rsi],al
           inc rsi
           dec cx
           jnz back1
           
           rw 1,1,answer,20
                                  
        
        ret
        
        
        
        
        
        
        
        
        
        	
	
