section .data
eol:    db 10

section .text
global _start

_start:
    mov     rcx, [rsp]
    cmp     rcx, 2
    jb      _done

    mov     r12, [rsp+16]
    xor     rdx, rdx
    mov     r8, r12
Llen:
    mov     al, [r8]
    test    al, al
    je      Lgot
    inc     r8
    inc     rdx
    jmp     Llen

Lgot:
    mov     eax, 1
    mov     edi, 1
    mov     rsi, r12
    syscall

    mov     eax, 1
    mov     edi, 1
    mov     rsi, eol
    mov     edx, 1
    syscall

_done:
    mov     eax, 60
    xor     edi, edi
    syscall
