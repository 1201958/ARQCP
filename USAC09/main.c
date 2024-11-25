#include <stdio.h>

extern int sort_array(int* vec, int length, char order);

int main() {
    int arr[] = {5, 2, 8, 1, 9};
    sort_array(arr, 5, 1);  // ascending
    return 0;
}
