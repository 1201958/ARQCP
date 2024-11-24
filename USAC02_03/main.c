#include <stdio.h>

int get_number_binary(int n, char* bits);
int get_number(char* str, int* n);

int main(){
	int value = 26; // 0b11010
	char bits[5];
	int res = get_number_binary(value, bits);
	printf("%d: %d, %d, %d, %d, %d\n", res, bits[4], bits[3], bits[2], bits[1], bits[0]); // 1: 1, 1, 0, 1, 0
	
	
	int value2;
	char str[] = "8--9";
	int res2 = get_number(str, &value2);
	printf("%d: %d\n",res2, value2); //1: 89
	char str2[] = "89  ";
	res2 = get_number(str2, &value2);
	printf("%d: %d\n",res2, value2); //0:
	
	return 0;
}
