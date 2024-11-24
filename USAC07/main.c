#include <stdio.h>
#include <assert.h>
#include "asm.h"

void test_get_n_element() {
    int buffer[10];
    int length = 10;
    int tail, head;
    int result;
    
    printf("Running tests for get_n_element...\n");
    
    // Test 1: Empty buffer (head == tail)
    printf("\nTest 1: Empty buffer\n");
    head = tail = 0;
    result = get_n_element(buffer, length, &tail, &head);
    printf("Expected: 0, Got: %d\n", result);
    assert(result == 0);
    
    // Test 2: Regular case (no wrap-around)
    printf("\nTest 2: Regular case\n");
    tail = 1;
    head = 9;
    result = get_n_element(buffer, length, &tail, &head);
    printf("Expected: 8, Got: %d\n", result);
    assert(result == 8);
    
    // Test 3: Wrap-around case
    printf("\nTest 3: Wrap-around case\n");
    tail = 7;
    head = 3;
    result = get_n_element(buffer, length, &tail, &head);
    printf("Expected: 6, Got: %d\n", result);
    assert(result == 6);
    
    // Test 4: Full buffer
    printf("\nTest 4: Full buffer minus one\n");
    tail = 0;
    head = 9;
    result = get_n_element(buffer, length, &tail, &head);
    printf("Expected: 9, Got: %d\n", result);
    assert(result == 9);

    printf("\nAll tests passed successfully!\n");
}

int main() {
    test_get_n_element();
    return 0;
}