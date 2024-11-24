#include <stdio.h>
#include "asm.h"

int main() {
    // Initialize circular buffer
    int buffer[5] = {1, 2, 3, 4, 5};
    int length = 5;
    int tail = 0;
    int head = 3;
    
    // Initialize array to receive elements
    int array[3] = {0};
    int n = 3;  // number of elements to move
    
    // Call the assembly function
    int result = move_n_to_array(buffer, length, &tail, &head, n, array);
    
    // Print results
    printf("Result: %d\n", result);
    printf("Moved elements: ");
    for(int i = 0; i < n; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");
    
    return 0;
}