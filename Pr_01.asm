section .data
msg1 db "***********The Elements are : ***********",10,13
len1 equ $-msg1
msg2 db " *****Enter the elements : ********",10,13
len2 equ $-msg2

section .bss
      array resb 200
      count resb 5
      
section .text
         global _start
  _start:mov rbp,array
        mov byte[count],05
        
        mov rax,1
        mov rdi,1
        mov rsi,msg2
        mov rdx,len2
        syscall
        
   loop1:mov rax,0
         mov rdi,0
         mov rsi,rbp
         mov rdx,17
         syscall     
   
         add rbp,17
         dec byte[count] 
         jnz loop1
         
         ;displaying the elements
         mov rbp,array
         mov byte[count],05
         
        mov rax,1
        mov rdi,1
        mov rsi,msg1
        mov rdx,len2
        syscall
        
         
    loop2:mov rax,1
          mov rdi,1
          mov rsi,rbp
          mov rdx,17
          syscall
          
          add rbp,17
          dec byte[count] 
          jnz loop2  
          
          
          mov rax,60
          mov rdi,0
          syscall       
