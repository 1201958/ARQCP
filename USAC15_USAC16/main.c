// main.c
#include <stdio.h>
#include <string.h>
#include "machine.h"


int main() {
    int machine_count = 3;
    Machine machines[machine_count];
    for (int i = 0; i < machine_count; i++) {
        machines[i].id = i + 1;          // Assign IDs 1, 2, 3
        strcpy(machines[i].status, " ON "); // Default status is OFF
        machines[i].operation=0; // No operation assigned
    }

    // Show the UI menu
    show_menu(machines, machine_count);

    return 0;
}
