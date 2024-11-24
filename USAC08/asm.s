.text
.globl move_n_to_array

move_n_to_array:
    pushq %rbp
    movq %rsp, %rbp
    
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    
    movq %rdi, %r12     # buffer
    movl %esi, %r13d    # length
    movq %r9, %r14      # array
    
    movl (%rdx), %eax   # tail
    movl (%rcx), %ebx   # head
    
    movl %ebx, %r10d    # head
    subl %eax, %r10d    # head - tail
    jns no_wrap
    addl %r13d, %r10d   # add length if wrapped
no_wrap:
    
    cmpl %r8d, %r10d    # compare with n
    jl not_enough
    
    xorl %r11d, %r11d   # counter = 0
    
copy_loop:
    cmpl %r8d, %r11d
    je success
    
    movl (%r12,%rax,4), %r9d
    movl %r9d, (%r14,%r11,4)
    
    incl %eax
    cmpl %r13d, %eax
    jl no_tail_wrap
    xorl %eax, %eax
no_tail_wrap:
    
    incl %r11d
    jmp copy_loop
    
success:
    movl %eax, (%rdx)
    movl $1, %eax
    jmp exit
    
not_enough:
    xorl %eax, %eax
    
exit:
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    
    leave
    ret