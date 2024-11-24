#ifndef ASM_H
#define ASM_H

/**
 * @brief Moves n elements from a circular buffer to an array
 * 
 * @param buffer The source circular buffer
 * @param length The length of the circular buffer
 * @param tail Pointer to the tail index of the buffer
 * @param head Pointer to the head index of the buffer
 * @param n Number of elements to move
 * @param array Destination array for the moved elements
 * 
 * @return 1 if successful (n elements were moved), 0 if failed (not enough elements)
 */
int move_n_to_array(int* buffer, int length, int* tail, int* head, int n, int* array);

#endif /* ASM_H */