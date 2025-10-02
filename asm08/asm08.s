section .bss
wk:     resb 64

section .data
nl:     db 10

section .text
global _start

atoi_u:
    xor     rax, rax
    mov     r8, rsi
.A:
    mov     dl, [r8]
    test    dl, dl
    je      .Q
    cmp     dl, 10
    je      .Q
    cmp     dl, '0'
    jb      .Q
    cmp     dl, '9'
    ja      .Q
    imul    rax, rax, 10
    xor     rdx, rdx
    mov     dl, [r8]
    sub     dl, '0'
    add     rax, rdx
    inc     r8
    jmp     .A
.Q:
    ret

u_to_s:
    mov     rbx, 10
    mov     r11, wk
    add     r11, 63
    mov     byte [r11], 0
    xor     r9, r9
    test    rax, rax
    jnz     .L
    dec     r11
    mov     byte [r11], '0'
    mov     rsi, r11
    mov     rdx, 1
    ret
.L:
    xor     rdx, rdx
    div     rbx
    add     dl, '0'
    dec     r11
    mov     [r11], dl
    inc     r9
    test    rax, rax
    jnz     .L
    mov     rsi, r11
    mov     rdx, r9
    ret

_start:
    mov     rcx, [rsp]
    cmp     rcx, 2
    jb      _e1

    mov     rsi, [rsp+16]
    call    atoi_u
    cmp     rax, 1
    jbe     .Z

    mov     rdx, rax
    dec     rdx
    imul    rax, rdx
    mov     rbx, 2
    xor     rdx, rdx
    div     rbx
    jmp     .P

.Z:
    xor     rax, rax
.P:
    call    u_to_s
    mov     eax, 1
    mov     edi, 1
    syscall
    mov     eax, 1
    mov     edi, 1
    mov     rsi, nl
    mov     edx, 1
    syscall
    mov     eax, 60
    xor     edi, edi
    syscall

_e1:
    mov     eax, 60
    mov     edi, 1
    syscall
