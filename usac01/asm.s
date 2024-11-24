.section .data
	empty_string:
    .asciz ""         # String vazia 

.section .text
	.global extract_data

extract_data:
    pushq %rbp
    movq %rsp, %rbp
    
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    pushq %r15
    
    movl $0, (%rcx)    # Inicializa *value com 0
    movb $0, (%rdx)    # Inicializa *unit com 0
    
    # Guarda parâmetros
    movq %rdi, %r12         # str
    movq %rsi, %r13         # token
    movq %rdx, %r14         # unit
    movq %rcx, %r15         # value
    
    # Procurar token 
    movq %r12, %rdi         # str
    movq %r13, %rsi         # token
    call .find_exact_token
    testq %rax, %rax		# valida se o retorno é NULL
    jz .fail				# se for null, salta para fail
    
    movq %rax, %r12         # Atualizar posição na string
    
    # Procurar "unit:"
    movq %r12, %rdi
    
.find_unit:
    movb (%rdi), %al
    testb %al, %al			# Verifica se é o final da string '\0'
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
    addq $5, %rdi				# Avança %rdi para o primeiro caractere após "unit:"
    movq %r14, %rdx				# Move  (%r14) para %rdx

.copy_unit:
    movb (%rdi), %al			# Move o caractere atual de str para %al
    testb %al, %al				# Verifica se é o final da string
    jz .fail					# Se sim, falha
    cmpb $'&', %al				# Valida se encontra '&'
    je .unit_done
    
    movb %al, (%rdx)			
    incq %rdi					# Avança para o próximo caractere após '&'
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
    movb (%rdi), %bl			# Carrega o caractere atual em %bl
    subb $'0', %bl				# Converte o caractere de ASCII para número
    cmpb $9, %bl				# Verifica se é um dígito válido (0–9)
    ja .num_done				# Se não for, termina a conversão
    
    imull $10, %eax          # Multiplica o valor atual em %eax por 10
    movzbl %bl, %ebx         # Move o número convertido para %ebx
    addl %ebx, %eax          # Adiciona o dígito ao número
    incq %rdi                # Avança para o próximo caractere
    jmp .convert_num		  # Repete para o próximo dígito

.num_done:
    movl %eax, (%r15)		# Armazena o número convertido em value
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

# função para encontrar token 
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
