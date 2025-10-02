section .data
expect: db "42", 10
elen:   equ $ - expect

msg:    db "1337", 10
mlen:   equ $ - msg

section .bss
buf:    resb 8

section .text
global _start

_start:
    mov     eax, 0
    mov     edi, 0
    mov     rsi, buf
    mov     edx, 8
    syscall

    mov     ecx, elen
    mov     rsi, buf
    mov     rdi, expect
cmp_loop:
    mov     al, [rsi]
    mov     bl, [rdi]
    cmp     al, bl
    jne     not_equal
    inc     rsi
    inc     rdi
    loop    cmp_loop

    mov     eax, 1
    mov     edi, 1
    mov     rsi, msg
    mov     edx, mlen
    syscall

    mov     eax, 60
    xor     edi, edi
    syscall

not_equal:
    mov     eax, 60
    mov     edi, 1
    syscall
