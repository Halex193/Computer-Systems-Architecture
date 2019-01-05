#include <stdio.h>
#include <stdint.h>
#define MAX_COUNT 100

void open_file(char* file_name);
void close_file();
void read_number(int* number);
void print_numbers(int* numbers, int len);
int32_t end_file();
FILE* file_descriptor;

int main()
{
	char file_name[] = "numbers.txt";
	int P[MAX_COUNT];
	int lenP = 0;
	int N[MAX_COUNT];
	int lenN = 0;
	int number;

	open_file(file_name);
	if (file_descriptor == NULL)
		return -1;

	while (end_file() == 0)
	{
		read_number(&number);
		if (number < 0)
		{
			N[lenN++] = number;
		}
		else
		{
			P[lenP++] = number;
		}
	}
	close_file();
	print_numbers(P, lenP);
	print_numbers(N, lenN);
	return 0;
}