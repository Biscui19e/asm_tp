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

    mov     r9, rax
    xor     r8, r8
    mov     r13, buf
    xor     r11, r11

Lread:
    cmp     r9, 0
    je      Lend
    mov     al, [r13]
    cmp     al, 10
    je      Lend
    cmp     al, 13
    je      Lend
    cmp     al, '0'
    jb      Xbad
    cmp     al, '9'
    ja      Xbad
    imul    r8, r8, 10
    xor     rdx, rdx
    mov     dl, al
    sub     dl, '0'
    add     r8, rdx
    inc     r11
    inc     r13
    dec     r9
    jmp     Lread

Lend:
    cmp     r11, 0
    je      Xbad
    test    r8, 1
    jnz     Xodd
    mov     eax, 60
    xor     edi, edi
    syscall

Xodd:
    mov     eax, 60
    mov     edi, 1
    syscall

Xbad:
    mov     eax, 60
    mov     edi, 2
    syscall
