#include <stdio.h>

int get_number_binary(int n, char* bits);
int get_number(char* str, int* n);

int main(){
	
	printf("Starting tests for get_number_binary function...\n");

	int number26 = 26;
	char bits[5];
	int res = get_number_binary(number26, bits);
	printf("Expected result: 1: 1, 1, 0, 1, 0");
	printResult(res, bits);
	
	int number0 = 0;
	res = get_number_binary(number0, bits);
	printf("Expected result: 1: 0, 0, 0, 0, 0");
	printResult(res, bits);
	
	int number31 = 31;
	res = get_number_binary(number31, bits);
	printf("Expected result: 1: 1, 1, 1, 1, 1");
	printResult(res, bits);
	
	int numberNeg = -1;
	res = get_number_binary(numberNeg, bits);
	printf("Expected result: 0: ");
	printResult(res, bits);
	
	int number32 = 32;
	res = get_number_binary(number32, bits);
	printf("Expected result: 0: ");
	printResult(res, bits);
	
	printf("\n");
	printf("\n");
	printf("\n");
	
	printf("Starting tests for get_number function...\n");
	
	int value;
	char str[] = "8--9";
	res = get_number(str, &value);
	printf("Expected result: 0: ");
	printf("\nResult: %d: %d\n",res, value);
	
	char str2[] = "89  ";
	res = get_number(str2, &value);
	printf("Expected result: 1: 89");
	printf("\nResult: %d: %d\n",res, value);
	
	char str3[] = "17--asd";
	res = get_number(str3, &value);
	printf("Expected result: 1: 17");
	printf("\nResult: %d: %d\n",res, value);
	
	char str4[] = "asd";
	res = get_number(str4, &value);
	printf("Expected result: 0: ");
	printf("\nResult: %d: %d\n",res, value);
	
	return 0;
}

int printResult(int result, char bits[]){
	if (result == 1){
		printf("\nResult: %d: %d, %d, %d, %d, %d\n", result, bits[4], bits[3], bits[2], bits[1], bits[0]);
	}else{
		printf("\nResult: %d: \n", result);
	}
	return 0;
}
