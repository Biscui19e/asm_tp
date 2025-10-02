section .data
txt:    db "1337", 10
tlen:   equ $ - txt

section .text
global _start

_start:
    mov     rcx, [rsp]
    cmp     rcx, 2
    jb      _bad

    mov     r10, [rsp+16]

    cmp     byte [r10], '4'
    jne     _bad
    cmp     byte [r10+1], '2'
    jne     _bad
    mov     bl, [r10+2]
    test    bl, bl
    jne     _bad

    mov     eax, 1
    mov     edi, 1
    mov     rsi, txt
    mov     edx, tlen
    syscall

    mov     eax, 60
    xor     edi, edi
    syscall

_bad:
    mov     eax, 60
    mov     edi, 1
    syscall
