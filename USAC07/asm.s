.text
.globl get_n_element

# int get_n_element(int* buffer, int length, int* tail, int* head)
# Parameters:
#   %rdi = buffer pointer (unused)
#   %esi = length
#   %rdx = tail pointer
#   %rcx = head pointer
get_n_element:
    pushq %rbp
    movq %rsp, %rbp
    
    # Save registers we'll use
    pushq %rbx           # Save %rbx as we'll use it
    
    # Load tail and head values
    movl (%rdx), %r8d   # Load *tail into %r8d
    movl (%rcx), %r9d   # Load *head into %r9d
    
    # Check if head == tail (buffer is empty)
    cmpl %r8d, %r9d    # Compare head with tail
    je buffer_empty
    
    # Calculate number of elements
    movl %r9d, %eax    # head value in eax
    subl %r8d, %eax    # subtract tail from head
    jns no_wrap        # if result >= 0, no wrap occurred
    
    # Handle wrap-around case
    addl %esi, %eax    # Add buffer length
    
no_wrap:
    # If the result is negative after wrap handling or greater than length,
    # something is wrong - return -1
    cmpl $0, %eax
    jl error
    cmpl %esi, %eax
    jge error
    jmp done

buffer_empty:
    xorl %eax, %eax    # Return 0 for empty buffer
    jmp done

error:
    movl $-1, %eax     # Return -1 for error cases

done:
    # Restore registers and return
    popq %rbx
    leave
    ret