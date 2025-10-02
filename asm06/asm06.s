section .bss
tmp:    resb 64

section .data
lf:     db 10

section .text
global _start

parse_i:
    xor     rax, rax
    mov     r8d, 1
    mov     dl, [rsi]
    cmp     dl, '-'
    jne     .p1
    mov     r8d, -1
    inc     rsi
    jmp     .lp
.p1:
    cmp     dl, '+'
    jne     .lp
    inc     rsi
.lp:
    mov     dl, [rsi]
    test    dl, dl
    je      .dn
    cmp     dl, '0'
    jb      .dn
    cmp     dl, '9'
    ja      .dn
    imul    rax, rax, 10
    xor     rcx, rcx
    mov     cl, dl
    sub     cl, '0'
    add     rax, rcx
    inc     rsi
    jmp     .lp
.dn:
    cmp     r8d, -1
    jne     .rt
    neg     rax
.rt:
    ret

to_s:
    mov     rbx, 10
    mov     rdi, tmp
    add     rdi, 63
    mov     byte [rdi], 0
    xor     rcx, rcx
    test    rax, rax
    jnz     .sg
    dec     rdi
    mov     byte [rdi], '0'
    mov     rsi, rdi
    mov     rdx, 1
    ret
.sg:
    xor     r10d, r10d
    test    rax, rax
    jge     .cv
    neg     rax
    mov     r10b, 1
.cv:
    xor     rdx, rdx
    div     rbx
    add     dl, '0'
    dec     rdi
    mov     [rdi], dl
    inc     rcx
    test    rax, rax
    jnz     .cv
    cmp     r10b, 1
    jne     .out
    dec     rdi
    mov     byte [rdi], '-'
    inc     rcx
.out:
    mov     rsi, rdi
    mov     rdx, rcx
    ret

_start:
    mov     rax, [rsp]
    cmp     rax, 3
    jb      _e1

    mov     rsi, [rsp+16]
    call    parse_i
    mov     r12, rax

    mov     rsi, [rsp+24]
    call    parse_i

    add     rax, r12
    call    to_s

    mov     eax, 1
    mov     edi, 1
    syscall

    mov     eax, 1
    mov     edi, 1
    mov     rsi, lf
    mov     edx, 1
    syscall

    mov     eax, 60
    xor     edi, edi
    syscall

_e1:
    mov     eax, 60
    mov     edi, 1
    syscall
