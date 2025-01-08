section .data


extern msg6,len6,scount,ncount,occcount,new,new_len

section .bss
extern cnt,cnt2,cnt3,buffer

%macro disp 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall

%endmacro

section .text
global main
main:

global spaces,enters,occ


;****************spaces***************
spaces:
        mov rsi,buffer
        up:
            mov al,byte[rsi]
            cmp al,20H
            je next3
            inc rsi
            dec byte[cnt]
            jnc up
            jmp next4
            next3:inc rsi
            inc byte[scount]
            dec byte[cnt]
            jnz up
            
            next4:
            add byte[scount],30h
            disp 1,1,scount,2
            disp 1,1,new,new_len
            
       ret     
