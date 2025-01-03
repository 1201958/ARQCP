.section .text
    .global format_command

format_command:
    # Ignorar espaços iniciais de `op`
    mov %rdi, %r9          # Salvar ponteiro original de `op`
skip_spaces:
    movb (%r9), %al        # Carregar o próximo caractere
    cmpb $' ', %al         # Verificar se é um espaço
    je skip_next           # Ignorar se for
    cmpb $'\t', %al        # Verificar tabulação
    je skip_next           # Ignorar se for
    jmp check_op           # Continuar se não for espaço ou tab

skip_next:
    inc %r9                # Avançar o ponteiro
    jmp skip_spaces

# Validar e capitalizar `op`
check_op:
    movb (%r9), %al        # Carregar o primeiro caractere de `op`
    and $0xDF, %al         # Converter para maiúscula
    cmpb $'O', %al         # Verificar se é 'O'
    jne invalid_op         # Se não for, erro
    movb 1(%r9), %al       # Segundo caractere de `op`
    and $0xDF, %al         # Converter para maiúscula
    cmpb $'N', %al         # Verificar se é 'N'
    je prepare_cmd         # Continua se for válido
    cmpb $'F', %al         # Verificar se é 'F'
    jne invalid_op         # Se não for, erro

    # Verificar terceiro caractere para "OFF"
    cmpb $0, 3(%r9)        # Certificar-se de que há terminador após o terceiro caractere
    jne invalid_op
    movb 2(%r9), %al       # Terceiro caractere
    and $0xDF, %al         # Converter para maiúscula
    cmpb $'F', %al         # Verificar se é 'F'
    jne invalid_op

prepare_cmd:
    # Inicializar o ponteiro de destino para `cmd` com o endereço de %rdx
    mov %rdx, %r8          # Copiar o ponteiro de `cmd` para %r8

    # Escrever "CMD,"
    movb $'C', (%r8)       # 'C'
    inc %r8                # Avançar o ponteiro
    movb $'M', (%r8)       # 'M'
    inc %r8                # Avançar o ponteiro
    movb $'D', (%r8)       # 'D'
    inc %r8                # Avançar o ponteiro
    movb $',', (%r8)       # ','
    inc %r8                # Avançar o ponteiro

    # Validar `n` (entre 0 e 31)
    cmp $0, %esi           # Verificar se n >= 0
    jl invalid_op
    cmp $31, %esi          # Verificar se n <= 31
    jg invalid_op

    # Processar os 5 bits de `n`
    mov $5, %rcx           # Contador de 5 bits
    mov %esi, %ebx         # Copiar `n` para %ebx

process_bits:
    mov %ebx, %eax         # Copiar `n` atual
    and $1, %eax           # Extrair o bit menos significativo
    add $'0', %al          # Converter para ASCII ('0' ou '1')
    movb %al, (%r8)        # Escrever no buffer
    inc %r8                # Avançar o ponteiro

    shr $1, %ebx           # Deslocar bits para a direita
    dec %rcx               # Decrementar contador
    jz finish_output       # Terminar se 5 bits forem processados

    movb $',', (%r8)       # Escrever vírgula
    inc %r8                # Avançar o ponteiro
    jmp process_bits       # Continuar processando bits

finish_output:
    # Finalizar string com terminador nulo
    movb $'\0', (%r8)
    mov $1, %eax           # Retornar sucesso (1)
    ret

invalid_op:
    # Limpar `cmd` e retornar falha
    movb $'\0', (%rdx)     # Limpar cmd
    mov $0, %eax           # Retornar falha (0)
    ret