#include <stdio.h>
#include "machine.h"

void assign_operation(Machine *machine, int op) {
    switch(op) {
        case CUTTING:
            machine->operation = 22;
            break;
        case DRILLING:
            machine->operation = 23;
            break;
        case POLISHING:
            machine->operation = 24;
            break;
        case PAINTING:
            machine->operation = 25;
            break;
        case LABELLING:
            machine->operation = 26;
            break;
        case INSPECTION:
            machine->operation = 27;
            break;
        default:
            printf("Invalid operation code.\n");
            return;
    }
    printf("Assigned operation %d to Machine %d.\n", op, machine->id);
}
