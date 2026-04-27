; ============================================================ 
; Title: Parameter Passing Example (x86_64 - 68000 Style Match) 
; Converted from Easy68k 68000 version 
; ============================================================ 

global main 
extern printf 
extern scanf 

section .data 
    PROMPT       db "Enter number: ", 0 
    RESULT       db "The sum is: %ld", 10, 0 
    FINAL_RESULT db "Final sum is: %ld", 10, 0 
    INPUT_FMT    db "%ld", 0 
    ERROR_MSG    db "Invalid input. Try again.", 10, 0 

section .bss 
    ; D-register equivalents (conceptual mapping) 
    D1 resq 1 
    D2 resq 1 
    D3 resq 1 

section .text 

; ============================================================ 
; START (main equivalent) 
; ============================================================ 

main: 
    push rbp 
    mov rbp, rsp 
    sub rsp, 8 
    
    xor rax, rax 
    mov [D3], rax   ; running sum = 0 
    mov rcx, 3       ; D4 loop counter equivalent 

; ============================================================ 
; GAME_LOOP (matches 68000 structure) 
; ============================================================ 

GAME_LOOP: 
    ; ---- INPUT 1 ---- 
    push rcx         ; Preserve loop counter across library calls
    mov rdi, PROMPT 
    xor rax, rax 
    call printf 

    mov rdi, INPUT_FMT 
    lea rsi, [D1] 
    xor rax, rax 
    call scanf 
    cmp rax, 1 
    jne INPUT_ERROR 

    ; ---- INPUT 2 ---- 
    mov rdi, PROMPT 
    xor rax, rax 
    call printf 

    mov rdi, INPUT_FMT 
    lea rsi, [D2] 
    xor rax, rax 
    call scanf 
    cmp rax, 1 
    jne INPUT_ERROR 

    ; ---- REGISTER_ADDER (BSR equivalent) ---- 
    mov rdi, [D1] 
    mov rsi, [D2] 
    call REGISTER_ADDER 

    ; D3 = D3 + result 
    add [D3], rax 

    ; ---- PRINT RESULT ---- 
    mov rdi, RESULT 
    mov rsi, rax 
    xor rax, rax 
    call printf 

    ; ---- LOOP CONTROL (SUBQ.W #1, D4) ---- 
    pop rcx          ; Restore loop counter
    dec rcx 
    jnz GAME_LOOP 

; ============================================================ 
; FINAL OUTPUT 
; ============================================================ 

    mov rdi, FINAL_RESULT 
    mov rsi, [D3] 
    xor rax, rax 
    call printf 

    mov rsp, rbp 
    pop rbp 
    xor rax, rax 
    ret 

; ============================================================ 
; REGISTER_ADDER (exact conceptual match to 68000 subroutine) 
; D1 + D2 → result in RAX 
; ============================================================ 

REGISTER_ADDER: 
    mov rax, rdi 
    add rax, rsi 
    ret 

; ============================================================ 
; INPUT ERROR HANDLER 
; ============================================================ 

INPUT_ERROR: 
    mov rdi, ERROR_MSG 
    xor rax, rax 
    call printf 
    pop rcx          ; Fix stack before jumping back
    jmp GAME_LOOP