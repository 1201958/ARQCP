// machine.h
#ifndef MACHINE_H
#define MACHINE_H
#include <stdbool.h>  // Include this for bool

// Define the Machine structure
typedef struct {
    int id;                // Machine ID
    char status[10];       // Machine status: ON, OFF, OP
    int operation;         // Operation in binary (5 bits)
} Machine;

// Function declarations
bool generate_command(Machine machine, char *cmd);  // To generate a command for the machine
int format_command(char* op, int n, char* cmd);     // Format the command (ON/OFF with operation bits)
void assign_operation(Machine *machine, int op);    // Assign operation to the machine
void display_machine_status(Machine machine);       // Display the machine's current status
void send_cmd_to_machine(const char *cmd);          // Send the generated command to the machine
int find_machine(Machine machines[], int machine_count, int id, Machine *result); // Find a machine by ID
void show_menu(Machine machines[], int machine_count); // Display the menu for machine operations

// Operation Codes (Define operation types)
#define CUTTING      1
#define DRILLING     2
#define POLISHING    3
#define PAINTING     4
#define LABELLING    5
#define INSPECTION   6

#endif
