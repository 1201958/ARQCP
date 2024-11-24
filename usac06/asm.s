.section .text
	.global dequeue_value

dequeue_value:

    # Prologue
    pushq %rbp
    movq %rsp, %rbp
    
    # Save registers
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    pushq %r15
    
    # Load parameters
    movq %rdi, %r12      # *buffer
    movl %esi, %r13d     # length
    movq %rdx, %r14      # *head 
    movq %rcx, %r15      # *tail
    movq %r8, %rbx       # *value
    
    # Load current head and tail
    movl (%r14), %eax    # head 
    movl (%r15), %ecx    # tail 
    
    cmpl %r13d, %ecx           # Compara tail com length
    jne check_empty            # Se tail != length, verifica se está vazio
    movl $0, %ecx              # Caso contrário, tail = 0
    movl %ecx, (%r15)          # Atualiza o índice tail 

check_empty:

    # Verificar se o buffer está vazio
    cmpl %ecx, %eax            # Compara head com tail
    je buffer_empty            # Se forem iguais, o buffer está vazio
    
    # O buffer não está vazio - remove um valor
    movl (%r12,%rax,4), %edx   # %edx = buffer[head] (carrega o valor na posição head)
    movl %edx, (%rbx)          # *value = %edx (guarda o valor retirado no ponteiro de saída)
    
    # Atualizar o índice head
    incl %eax                  # Incrementa o índice head
    cmpl %r13d, %eax           # Compara head com length
    jl store_head              # Se head < length, salta para guardar o índice atualizado
    movl $0, %eax              # Caso contrário, head = 0 (volta ao início do buffer)

store_head:
    movl %eax, (%r14)          # Atualiza o índice head 
    movl $1, %eax              # Retorna 1 
    jmp epilogue               

buffer_empty:
    movl $0, %eax              # Retorna 0 

epilogue:
    # Restore registers and return
    popq %r15
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    movq %rbp, %rsp
    popq %rbp
    ret
