section .bss
buf:    resb 32

section .text
global _start

_start:
    mov     eax, 0
    mov     edi, 0
    mov     rsi, buf
    mov     edx, 32
    syscall
    cmp     rax, 0
    jle     Xbad

    mov     r14, rax
    mov     r12, buf
    xor     r10, r10
    xor     r15, r15
P:
    cmp     r14, 0
    je      D
    mov     al, [r12]
    cmp     al, 10
    je      D
    cmp     al, 13
    je      D
    cmp     al, '0'
    jb      Xbad
    cmp     al, '9'
    ja      Xbad
    imul    r10, r10, 10
    xor     edx, edx
    mov     dl, al
    sub     dl, '0'
    add     r10, rdx
    inc     r15
    inc     r12
    dec     r14
    jmp     P
D:
    cmp     r15, 0
    je      Xbad
    cmp     r10, 2
    jb      Xc
    je      Xp
    test    r10, 1
    jz      Xc
    mov     r13, 3
L:
    mov     rax, r10
    xor     edx, edx
    div     r13
    test    rdx, rdx
    jz      Xc
    cmp     r13, rax
    ja      Xp
    add     r13, 2
    jmp     L
Xp:
    mov     eax, 60
    xor     edi, edi
    syscall
Xc:
    mov     eax, 60
    mov     edi, 1
    syscall
Xbad:
    mov     eax, 60
    mov     edi, 2
    syscall
