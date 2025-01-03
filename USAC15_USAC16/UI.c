
#include <stdio.h>
#include <string.h>
#include "machine.h"

void show_menu(Machine machines[], int machine_count) {
    int choice, machine_id, operation;
    Machine selected_machine;

    while (1) {
        printf("\n=== Machine Management Menu ===\n");
        printf("1. Assign Operation to Machine\n");
        printf("2. Query Machine Status\n");
        printf("3. Exit\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                printf("Enter Machine ID: ");
                scanf("%d", &machine_id);
                for (int i = 0; i < machine_count; i++) {
                    if (machines[i].id == machine_id) {
                        printf("Enter Operation (1-Cutting, 2-Drilling, 3-Polishing, 4-Painting, 5-Labelling, 6-Inspection): ");
                        scanf("%d", &operation);
                        assign_operation(&machines[i], operation);
                        break;
                    }
                }
                break;
            case 2:
                printf("Enter Machine ID: ");
                scanf("%d", &machine_id);
                if (find_machine(machines, machine_count, machine_id, &selected_machine)) {
                    display_machine_status(selected_machine);
                } else {
                    printf("Machine ID %d not found.\n", machine_id);
                }
                break;
            case 3:
                printf("Exiting program.\n");
                return;
            default:
                printf("Invalid choice. Please try again.\n");
                break;
        }
    }
}
