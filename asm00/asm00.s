
section .text
global _start

_start:
    mov rax, 60        ; exit 
    xor rdi, rdi       ; code de retour = 0 (rdi = 0)
    syscall           