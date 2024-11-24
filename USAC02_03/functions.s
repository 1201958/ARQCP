.section .data
.section .text
	.global get_number_binary
	.global get_number

#USAC02

get_number_binary:
	#Parametro value armazenado em %edi
    #Parametro bits armazenado em %rsi
    
    #Verifica se o valor se encontra entre 0 e 31
    cmp $0, %edi    
    jl exit
    cmp $31, %edi
    jg exit
    
    movq $0, %rcx   		# Contar bits
    movq %rsi, %rdx
    
    # Inicializar todas as posições do array a '0'
    movb $'0', (%rsi)
    movb $'0', 1(%rsi)
    movb $'0', 2(%rsi)
    movb $'0', 3(%rsi)
    movb $'0', 4(%rsi)
    
loop_get_binary:
    movl %edi, %eax			# Armazenar o valor em eax para preservar o valor original
    and $1, %eax			# Verificar se ultimo bit é 0 ou 1
    movb %al, (%rsi,%rcx)  	# Armazena o bit no seu lugar do array
    shr %edi              	# Ir buscar um novo bit menos significativo
    incq %rcx				# Incrementar o contador de bits
    cmp $5, %rcx         	# Verificar se já atingimos os 5 bits
    jl loop_get_binary  	# Se não, continuar no loop
    
    movl $1, %eax
    ret
    
exit:
    #Retorna zero (0) em caso de não se encontrar entre [0-31]
    movl $0, %eax
    ret
	

#USAC03

get_number:
	#Parametro str armazenado em %rdi
	#Parametro n armazenado em %rsi
	
	#Limpar registos
	xor %rax, %rax
	xor %rcx, %rcx
	xor %r8, %r8
	xor %r9, %r9
	
	
skip:
	movb (%rdi, %rcx, 1), %r8b
    test %r8b, %r8b
    jz invalid_string
    
    cmp $'0', %r8b
    jl skip_char
    cmp $'9', %r8b
    jle start_conversion
    
skip_char:
    incq %rcx
    jmp skip

start_conversion:
	movb $1, %r9b
	
loop_conversion:
    movb (%rdi, %rcx, 1), %r8b
    test %r8b, %r8b				# Verifica fim da string
    jz end_loop
    
    # Verifica se valor está entre 0 e 9
    cmp $'0', %r8b
    jl check_remaining_chars
    cmp $'9', %r8b
    jg check_remaining_chars
    
    # Se valor for válido multiplica o resultado por 10 para adicionar o próximo numero
    imulq $10, %rax
    
    subb $'0', %r8b				# Converter de ASCII para numero
    addq %r8, %rax  			# Adicionar numero ao resultado
    
    incq %rcx					# Incrementar contador
    jmp loop_conversion

check_remaining_chars:
    movb (%rdi, %rcx, 1), %r8b
    test %r8b, %r8b
    jz end_conversion
    
    cmp $'0', %r8b
    jl next_char
    cmp $'9', %r8b
    jle invalid_string
    
end_conversion:
    test %r9b, %r9b
    jz invalid_string
    
    movq %rax, (%rsi)
    movq $1, %rax
    ret
    
next_char:
    incq %rcx
    jmp check_remaining_chars
       
invalid_string:
    xor %rax, %rax
    movq $0, %rax
    movq $0, (%rsi)
    ret
    
end_loop:   
    movq %rax, (%rsi)
    movq $1, %rax
    ret
