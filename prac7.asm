section .data
rm db "processor is in real mode"
rm_1 equ $-rm  

pm db "Processor is in protected mode"
pm_1 equ $-pm

g db "Gdt contents are "
g_1 equ $-g

l db "Ldt contents are "
l_1 equ $-l

i db "IDT contets are "
i_1 equ $-i

t db "Task register contets are "
t_1 equ $-t

m db "Macine status word "
m_1 equ $-m

cpu_msg db "Cpu id is "
cup_msg_1 equ $-cpu_msg

col db ":"
newline db 10







section .bss

gdt resd 1 

ldt resw 1
idt resd 1

cpu_data resw 1

tr resw 1
cr0_data resd 1
dnum_buff resb 04











%macro disp 2

mov rax, 01
mov rdi, 01
mov rsi, %1
mov rdx, %2
syscall

%endmacro








section .text

global _start

_start:

    ;store machine status code in eax
    smsw eax
    mov [cr0_data], eax

    bt eax, 0
    jc prmode
        disp rm, rm_1
    
prmode: 
    disp pm, pm_1
    disp newline, 1


next1:
    sgdt [gdt]
    sldt [ldt]
    sidt [idt]
    str [tr]

    disp g, g_1
    mov bx, [gdt+4]
    call disp_num


    ;not understood
    mov bx, [gdt+2]
    call disp_num

    


    disp col, 1
    mov bx, [gdt]
    call disp_num
    disp newline, 1





    disp l, l_1
    mov bx, [ldt]
    call disp_num
    disp newline, 1





    disp i, i_1
    mov bx, [idt+4]
    call disp_num




    mov bx, [idt+2]
    call disp_num




    mov bx, [idt+2]
    call disp_num



    disp col, 1
    mov bx, [idt]
    call disp_num
    disp newline, 1



    disp t, t_1
    mov bx, [tr]
    call disp_num
    disp newline, 1



    disp m, m_1
    mov bx, [cr0_data+2]
    call disp_num



    mov bx, [cr0_data]
    call disp_num
    disp newline, 1


    mov eax, 0
  cpuid  
    disp cpu_msg, cup_msg_1
    mov ebx, eax
    call disp_num
    disp newline, 1

exit: 
    mov rax, 60
    mov rdi, 0
    syscall


disp_num:
    mov esi, dnum_buff
    mov ecx, 4

up1:
    rol bx, 4
    mov dl, bl
    and dl, 0fh
    add dl, 30h
    cmp dl, 39h
    jbe skip1
    add dl, 07h

skip1:
    mov [esi], dl
    inc esi
    loop up1

    


    disp dnum_buff, 4
    ret



