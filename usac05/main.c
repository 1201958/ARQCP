#include <stdio.h>
#include "asm.h"
#define ARRAY_LENGTH 5

int main() {
    int array[ARRAY_LENGTH] = {0}; // Initialize buffer
    int head = 0, tail = 0;        // Head and tail pointers
    
    printf("Inserting values:\n");
    
    int values[] = {10, 20, 30, 40, 50, 60};
    for (int i = 0; i < 6; i++) {
        int full = enqueue_value(array, ARRAY_LENGTH, &head, &tail, values[i]);
        
        printf("Inserted %d (Full: %d) - ", values[i], full);
        printf("Buffer: ");
        for (int j = 0; j < ARRAY_LENGTH; j++) {
            printf("%d ", array[j]);
        }
        printf("| Head: %d, Tail: %d\n", head, tail);
    }
    
    printf("\nFinal circular buffer contents: ");
    for (int i = 0; i < ARRAY_LENGTH; i++) {
        printf("%d ", array[i]);
    }
    printf("\nFinal Head: %d, Tail: %d\n", head, tail);
    
    return 0;
}
