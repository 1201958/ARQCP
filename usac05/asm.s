.section .text
	.global enqueue_value

enqueue_value:
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
    movl %r8d, %ebx      # value 

    # Load current head and tail
    movl (%r14), %eax    # head
    movl (%r15), %ecx    # tail

    # Calcula próximo índice de tail
    movl %ecx, %edx      # Copia tail atual 
    incl %edx            # Incrementa tail
    cmpl %r13d, %edx     # Compara com length
    jl no_wrap_tail      # Se menor que length, sem wrap
    movl $0, %edx        # Senão, volta para 0

no_wrap_tail:

    cmpl %eax, %edx      # Compara próximo tail com head
    je buffer_full       # Se igual, buffer está cheio

    # Não está cheio - insere valor normalmente
    movl %ebx, (%r12,%rcx,4)  # Insere valor na posição atual de tail

    # Atualiza tail
    movl %edx, (%r15)    # Armazena novo valor de tail

    movl $0, %eax        # Retorna 0 (não está cheio)
    jmp epilogue

buffer_full:
    # Buffer cheio - atualiza head primeiro
    incl %eax            # Incrementa head
    cmpl %r13d, %eax     # Compara com length
    jl store_head        # Se menor que length, guarda
    movl $0, %eax        # Senão, volta para 0

store_head:
    movl %eax, (%r14)    # Armazena novo valor de head

    # Substitui o valor mais antigo
    movl %ebx, (%r12,%rcx,4)  # Insere valor na posição de tail

    # Atualiza tail
    movl %edx, (%r15)    # Armazena próximo valor de tail

    movl $1, %eax        # Retorna 1 (cheio)

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
