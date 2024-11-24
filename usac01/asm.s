.section .data
empty_string:
    .asciz ""         # String vazia para inicialização

.section .text
.global extract_data

# Função extract_data(char* str, char* token, char* unit, int* value)
extract_data:
    pushq %rbp
    movq %rsp, %rbp
    
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    pushq %r15
    
    movl $0, (%rcx)    # Inicializa *value com 0
    movb $0, (%rdx)    # Inicializa *unit com '\0'
    
    # Guardar parâmetros
    movq %rdi, %r12         # str
    movq %rsi, %r13         # token
    movq %rdx, %r14         # unit
    movq %rcx, %r15         # value
    
    # Procurar token exato
    movq %r12, %rdi         # str
    movq %r13, %rsi         # token
    call .find_exact_token
    testq %rax, %rax
    jz .fail
    
    movq %rax, %r12         # Atualizar posição na string
    
    # Procurar "unit:"
    movq %r12, %rdi
    
.find_unit:
    movb (%rdi), %al
    testb %al, %al
    jz .fail
    
    cmpb $'u', %al
    jne .next_unit_char
    cmpb $'n', 1(%rdi)
    jne .next_unit_char
    cmpb $'i', 2(%rdi)
    jne .next_unit_char
    cmpb $'t', 3(%rdi)
    jne .next_unit_char
    cmpb $':', 4(%rdi)
    jne .next_unit_char
    
    # Encontrou "unit:", copiar valor
    addq $5, %rdi
    movq %r14, %rdx
.copy_unit:
    movb (%rdi), %al
    testb %al, %al
    jz .fail
    cmpb $'&', %al
    je .unit_done
    
    movb %al, (%rdx)
    incq %rdi
    incq %rdx
    jmp .copy_unit

.unit_done:
    movb $0, (%rdx)
    incq %rdi
    
    # Procurar "value:"
    movq %rdi, %r12
.find_value:
    movb (%rdi), %al
    testb %al, %al
    jz .fail
    
    cmpb $'v', %al
    jne .next_value_char
    cmpb $'a', 1(%rdi)
    jne .next_value_char
    cmpb $'l', 2(%rdi)
    jne .next_value_char
    cmpb $'u', 3(%rdi)
    jne .next_value_char
    cmpb $'e', 4(%rdi)
    jne .next_value_char
    cmpb $':', 5(%rdi)
    jne .next_value_char
    
    # Encontrou "value:", converter número
    addq $6, %rdi
    xorl %eax, %eax
.convert_num:
    movb (%rdi), %bl
    subb $'0', %bl
    cmpb $9, %bl
    ja .num_done
    
    imull $10, %eax
    movzbl %bl, %ebx
    addl %ebx, %eax
    incq %rdi
    jmp .convert_num

.num_done:
    movl %eax, (%r15)
    movl $1, %eax
    jmp .done

.next_unit_char:
    incq %rdi
    jmp .find_unit

.next_value_char:
    incq %rdi
    jmp .find_value

.fail:
    movq %r14, %rdx
    movb $0, (%rdx)
    movq %r15, %rcx
    movl $0, (%rcx)
    xorl %eax, %eax

.done:
    popq %r15
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    movq %rbp, %rsp
    popq %rbp
    ret

# Nova função auxiliar para encontrar token exato
.find_exact_token:
    pushq %rbp
    movq %rsp, %rbp
    
    xorq %rcx, %rcx         # índice na string principal
.token_loop:
    movb (%rdi, %rcx), %al
    testb %al, %al
    jz .token_not_found    # Fim da string

    # Verificar se é o início do token
    xorq %rdx, %rdx         # índice no token
.compare_loop:
    movb (%rsi, %rdx), %bl  # Caractere do token
    testb %bl, %bl
    jz .check_boundary     # Token encontrado, verificar fronteira
    
    movb (%rdi, %rcx), %al  # Caractere da string
    cmpb %al, %bl
    jne .token_next        # Não corresponde, próxima posição
    
    incq %rcx
    incq %rdx
    jmp .compare_loop

.check_boundary:
    # Verificar se o próximo caractere é '&' ou '#' ou fim da string
    movb (%rdi, %rcx), %al
    testb %al, %al          # Fim da string
    jz .token_found
    cmpb $'&', %al          # Delimitador &
    je .token_found
    cmpb $'#', %al          # Delimitador #
    je .token_found
    jmp .token_next        # Não é um token completo

.token_found:
    leaq (%rdi, %rcx), %rax
    jmp .token_done

.token_next:
    incq %rcx
    jmp .token_loop

.token_not_found:
    xorq %rax, %rax

.token_done:
    movq %rbp, %rsp
    popq %rbp
    ret
