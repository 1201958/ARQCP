#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "asm.h"



#define BUFFER_LENGTH 5

int main() {
    
    int buffer[BUFFER_LENGTH];  
    int head = 0;               
    int tail = 0;               
    int value;                  // Variável para armazenar o valor retirado

    
    buffer[0] = 10;
    buffer[1] = 20;
    buffer[2] = 30;
    tail = 3; 

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
    buffer[0] = 40;
    buffer[1] = 50;
    buffer[2] = 60;
    tail = 3; 

    printf("Buffer atualizado: ");
    for (int i = 0; i < tail; i++) {
        printf("%d ", buffer[i]);
    }
    printf("\n");

    printf("\nRemover novos valores do buffer:\n");
    head = 0; // Redefinimos head para testar com os novos valores
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
