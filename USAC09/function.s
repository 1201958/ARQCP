.section .text
	.global sort_array

sort_array:
	#vec in %rdi
	#length in %esi
	#order in %edx
	
	#Verificar inputs inválidos
	cmp esi, 0
    jle return_error
    test rdi, rdi
    jz return_error
    
	#Inicializa o contador do loop exterior
	movl $0, %ecx			# i = 0
	dec %esi

outer_loop:
    cmp ecx, esi
    jge success				# se i >= length-1, sort está completo

    #Inicializa o contador do loop interno
    movl $0, %r8d			# j = 0
    movl %esi, %r9d
    subl %ecx, %esi
    
inner_loop:
    cmp %esi, %r8d
    jge outer_increment		#se j >= length-i-1, salta para próximo i


outer_increment:
    inc %ecx
    jmp outer_loop
    
return_error:
    xor eax, eax
    ret
