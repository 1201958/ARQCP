#include <stdio.h>
#include <string.h>

extern int format_command(char* op, int n, char* cmd);

int main() {
    int value = 26; // 11010 em binário
    char str[] = " oN ";
    char cmd[20] = {0};

    int res = format_command(str, value, cmd);
    printf("%d: %s\n", res, cmd); // Esperado: 1: ON,1,1,0,1,0

    char str2[] = " aaa ";
    res = format_command(str2, value, cmd);
    printf("%d: %s\n", res, cmd); // Esperado: 0:
    return 0;
}
