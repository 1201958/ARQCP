#include <stdio.h>
#include <string.h>
#include <ctype.h>  // For toupper function
#include <stdbool.h>
#include "machine.h"

// Function prototypes
int format_command_C(char* op, int n, char* cmd);
bool generate_command(Machine machine, char *cmd);
void send_cmd_to_machine(const char *cmd);
void display_machine_status(Machine machine);

int format_command_C(char* op, int n, char* cmd) {
    // Check for valid op: "ON" or "OFF"
    printf("Debug: Checking operation string: '%s'\n", op);  // Debug statement
    if (strncmp(op, "ON", 2) == 0 || strncmp(op, "OFF", 3) == 0) {
        // Convert operation string to uppercase for uniformity
        for (int i = 0; op[i]; i++) {
            op[i] = toupper(op[i]);
        }

        // Start building the command string with the operation (ON or OFF)
        strncpy(cmd, op, 20);  // Copy operation string ("ON" or "OFF")
        strcat(cmd, ","); // Add a comma

        // Ensure the value of n is within 5 bits (0 to 31)
        if (n < 0 || n > 31) {
            printf("Error: n should be between 0 and 31.\n");
            return 0;  // Failure
        }

        // Append the 5-bit binary representation of n
        for (int i = 4; i >= 0; i--) {
            int bit = (n >> i) & 1;  // Extract the bit at position i
            char bit_char = bit + '0'; // Convert to character ('0' or '1')
            strncat(cmd, &bit_char, 1); // Append the bit to the cmd string

            if (i > 0) {
                strcat(cmd, ",");  // Separate bits with commas
            }
        }

        return 1;  // Success
    }

    // Invalid operation string
    printf("Error: Invalid operation. Expected 'ON' or 'OFF'.\n");
    return 0;  // Failure
}
// machine_status.c or operations.c

#include "machine.h"
#include <stdio.h>

// Function to find a machine by its ID
int find_machine(Machine machines[], int machine_count, int id, Machine *result) {
    for (int i = 0; i < machine_count; i++) {
        if (machines[i].id == id) {
            *result = machines[i];
            return 1;  // Found the machine, return success
        }
    }
    return 0;  // Machine not found, return failure
}

bool generate_command(Machine machine, char *cmd) {
    printf("Debug: Machine ID: %d\n", machine.id);
    printf("Debug: Machine Status: '%s'\n", machine.status);  // Debug statement to see the raw status string
    printf("Debug: Machine Operation: %d\n", machine.operation);
    
    int value = machine.operation;

    // Sanitize the machine status (make sure it is uppercase and has no extra spaces)
    char sanitized_status[10];  // Assuming status is always less than 10 characters
    int i = 0;
    
    // Remove leading and trailing spaces (trim)
    while (machine.status[i] != '\0' && isspace(machine.status[i])) i++;  // Skip leading spaces
    int j = 0;
    while (machine.status[i] != '\0') {
        sanitized_status[j++] = toupper(machine.status[i++]);  // Copy and convert to uppercase
    }
    sanitized_status[j] = '\0';  // Null-terminate the string
    printf("Debug: Sanitized Status: '%s'\n", sanitized_status);  // Debug statement to print sanitized status

    // Call format_command function
    printf("BEFORE FORMAT \n");
    int res = format_command_C(sanitized_status, value, cmd);  // Pass sanitized status and operation value
    printf("AFTER FORMAT \n");

    if (res == 1) {
        printf("Generated command: %s\n", cmd);
        return true;  // Return true if successful
    } else {
        printf("Error: Invalid command format.\n");
        return false;  // Return false if there's an error
    }
}

void send_cmd_to_machine(const char *cmd) {
    printf("Command sent to machine: %s\n", cmd);
}

void display_machine_status(Machine machine) {
    char cmd[20] = {0};
    
    // Generate the command and check if it's successful
    if (generate_command(machine, cmd)) {
        send_cmd_to_machine(cmd);  // If successful, send the command
    } else {
        printf("Failed to generate command for Machine ID: %d.\n", machine.id);  // If failed, print error
    }
}
