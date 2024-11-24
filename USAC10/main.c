#include <stdio.h>
#include "asm.h"

extern int median(int* vec, int length, int* me);

int main() {
    int vec[] = {1, 3, 5, 7, 9};  // Vetor já ordenado
    int length = 5;
    int median_value = -1;       // Inicia com um valor inválido para depuração

    printf("Antes da chamada: median_value = %d\n", median_value);

    if (median(vec, length, &median_value)) {
        printf("Depois da chamada: median_value = %d\n", median_value);
        printf("A mediana é: %d\n", median_value);
    } else {
        printf("Erro ao calcular a mediana.\n");
    }

    return 0;
}
