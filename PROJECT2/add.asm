global REGISTER_ADDER

section .text

REGISTER_ADDER:
    mov rax, rdi
    add rax, rsi
    ret
