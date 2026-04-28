; ============================================================ 
; Title: Example (x86_64 - 68000 Style Match) 
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
    D1 resq 1
    D2 resq 1
    D3 resq 1

section .text

main:
    push rbp              ; save base pointer
    mov rbp, rsp          ; set stack frame
    sub rsp, 8            ; stack alignment

    xor rax, rax         ; clear rax
    mov [D3], rax        ; sum = 0
    mov rcx, 3           ; loop counter

GAME_LOOP:
    push rcx             ; save counter

    mov rdi, PROMPT      ; print prompt
    xor rax, rax
    call printf

    mov rdi, INPUT_FMT   ; read first number
    lea rsi, [D1]
    xor rax, rax
    call scanf
    cmp rax, 1
    jne INPUT_ERROR     ; check input

    mov rdi, PROMPT      ; print prompt again
    xor rax, rax
    call printf

    mov rdi, INPUT_FMT   ; read second number
    lea rsi, [D2]
    xor rax, rax
    call scanf
    cmp rax, 1
    jne INPUT_ERROR     ; check input

    mov rdi, [D1]        ; load first value
    mov rsi, [D2]        ; load second value
    call REGISTER_ADDER  ; add numbers

    add [D3], rax        ; add to total

    mov rdi, RESULT      ; print result
    mov rsi, rax
    xor rax, rax
    call printf

    pop rcx              ; restore counter
    dec rcx              ; decrease loop
    jnz GAME_LOOP       ; repeat if not zero

    mov rdi, FINAL_RESULT ; print final sum
    mov rsi, [D3]
    xor rax, rax
    call printf

    mov rsp, rbp         ; restore stack
    pop rbp
    xor rax, rax
    ret

REGISTER_ADDER:
    mov rax, rdi         ; move first number
    add rax, rsi         ; add second number
    ret

INPUT_ERROR:
    mov rdi, ERROR_MSG   ; print error message
    xor rax, rax
    call printf

    pop rcx              ; restore loop counter
    jmp GAME_LOOP        ; restart loop
