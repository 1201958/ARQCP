.section .text
    .global median

median:
    # Verifica se o comprimento do vetor é válido
    cmpl $0, %esi         # length <= 0?
    jle end_error         # Se sim, retorna erro

    # Calcula o índice central
    movq %rsi, %rax       # rax = length
    shrq $1, %rax         # rax = length / 2 (índice central)

    # Verifica se o número de elementos é par ou ímpar
    testq $1, %rsi        # Testa o bit menos significativo de length
    jnz odd_case          # Se ímpar, vai para o caso ímpar

even_case:
    # Caso par: média dos dois elementos centrais
    leaq (%rdi, %rax, 4), %rcx # Ponteiro para o elemento central (4 bytes por int)
    movl (%rcx), %eax     # Carrega o elemento central em eax
    subq $4, %rcx         # Move para o elemento anterior
    movl (%rcx), %ebx     # Carrega o elemento anterior em ebx
    addl %ebx, %eax       # Soma os dois elementos
    shrl $1, %eax         # Divide por 2 (média)
    movq %rdx, %rcx       # rcx aponta para `me`
    movl %eax, (%rcx)     # Armazena a mediana no endereço `me`
    movl $1, %eax         # Retorna sucesso
    ret

odd_case:
    # Caso ímpar: elemento central
    leaq (%rdi, %rax, 4), %rcx # Ponteiro para o elemento central (4 bytes por int)
    movl (%rcx), %eax     # Carrega o elemento central em eax
    movq %rdx, %rcx       # rcx aponta para `me`
    movl %eax, (%rcx)     # Armazena a mediana no endereço `me`
    movl $1, %eax         # Retorna sucesso
    ret

end_error:
    movl $0, %eax         # Retorna erro
    ret
