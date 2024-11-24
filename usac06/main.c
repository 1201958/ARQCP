#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "asm.h"



#define BUFFER_LENGTH 5

int main() {
    
    int buffer[BUFFER_LENGTH];  
    int head = 0;               
    int tail = 0;               
    int value;                  // Variável para armazenar o valor removido

    
    buffer[0] = 10;
    buffer[1] = 20;
    buffer[2] = 30;
    buffer[3] = 40;
    buffer[4] = 50;
    tail = 5; 

    printf("Buffer inicial: ");
    for (int i = 0; i < tail; i++) {
        printf("%d ", buffer[i]);
    }
    printf("\n");

    // Teste 1: Remover valores do buffer
    printf("\nA remover valores do buffer:\n");
    while (1) {
        int result = dequeue_value(buffer, BUFFER_LENGTH, &head, &tail, &value);
        if (result == 1) {
            printf("Valor removido: %d\n", value);
        } else {
            printf("Buffer está vazio!\n");
            break;
        }
    }

    // Teste 2: Adicionar novos valores no buffer e repetir o processo
    printf("\nAdicionar novos valores no buffer...\n");
    buffer[0] = 60;
    buffer[1] = 70;
    buffer[2] = 80;
    buffer[3] = 90;
    buffer[4] = 95;
    tail = 5; 

    printf("Buffer atualizado: ");
    for (int i = 0; i < tail; i++) {
        printf("%d ", buffer[i]);
    }
    printf("\n");

    printf("\nRemover novos valores do buffer:\n");
    head = 0; 
    while (1) {
        int result = dequeue_value(buffer, BUFFER_LENGTH, &head, &tail, &value);
        if (result == 1) {
            printf("Valor removido: %d\n", value);
        } else {
            printf("Buffer está vazio!\n");
            break;
        }
    }

    return 0;
}
