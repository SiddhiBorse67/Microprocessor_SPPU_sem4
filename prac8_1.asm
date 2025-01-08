section .data


global msg6,len6,scount,ncount,occcount,new,new_len
fname: db 'abc.txt',0


msg: db "File open successfully",10,13
len:equ $-msg
msg1: db"File closed Successfully",10,13
len1:equ $-msg1
msg2: db "Error occured",10,13
len2:equ $-msg2
msg3:db "Spaces are : ",10,13
len3:equ $-msg3
new : db "",10,13
new_len:equ $-new
;**********counters***********

scount :db 0
ncount : db 0
ccount:db 0
chacount: db 0

section .bss
global cnt,cnt2,cnt3,buffer
fd:resb 17
buffer :resb 200
buf_len:resb 17
cnt : resb 2
cnt2: resb 2
cnt3: resb 2
occr :resb 2

%macro disp 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro




section .text
global _start
_start:

extern spaces,enters,occ
;*************opening file*************
mov rax,2
mov rdi,fname
mov rsi,2
mov rdx,0777
syscall
;********checking file has opened or not****************
mov qword[fd],rax
BT rax,63
jc next
disp 1,1,msg,len
jmp next2

next:disp 1,1,msg2,len2
jmp exit

next2:disp 0,[fd],buffer,200
mov qword[buf_len],200
mov qword[cnt],rax
mov qword[cnt2],rax
mov qword[cnt3],rax
disp 1,1,msg3,len3
call spaces

;**************close file*************
disp 1,1,msg1,len1
mov rax ,3
mov rdi,fname
syscall

;********exit program******
exit : mov rax,60
mov rdi,00
syscall

        

























