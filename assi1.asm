;Assignment No. 1
;Title : Accept 5 numbers and display those 5 numbers.

section .data
   msg1 db "Enter five numbers"
   msg2 db "The Numbers are"
section .bss
   array resq 6
   counter resb 1
section .text
global _start
_start:
         mov rax,1
         mov rdi,1
         mov rsi,msg1
         mov rdx,17

         mov byte[counter],5
         mov rbx,00
         syscall
         
loop1:
        
         mov rax,0
         mov rdi,0
         mov rsi,array
         add rsi,rbx
         mov rdx,17
         syscall
         add rbx,17
         dec byte[counter]
         JNZ loop1
         
         mov rax,1
         mov rdi,1
         mov rsi,msg2
         mov rdx,17
         mov byte[counter],5
         mov rbx,00
         syscall
loop2:         
         mov rax, 1
         mov rdi,1
         mov rsi,array
         add rsi,rbx
         mov rdx,17
         syscall
         add rbx,17
         dec byte[counter]
         JNZ loop2
         
         mov rax,60
         mov rdi,0
         syscall
         
