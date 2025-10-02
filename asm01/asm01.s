section .data
msg:    db "1337", 10
len:    equ $ - msg

section .text
global _start

_start:
    mov     eax, 1
    mov     edi, 1
    mov     rsi, msg
    mov     rdx, len
    syscall

    mov     eax, 60
    xor     edi, edi
    syscall
