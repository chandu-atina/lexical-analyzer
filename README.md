# lexical-analyzer
Lexical Analysis

Flex program to handle #define directives in a C program. The C source input file can either be specified on the command line or read from stdin (if no file is specified in the command line). All your normal output will go to stdout, with any error messages or warnings sent to stderr. Flex pattern matching engine is the main driver of your program.


# Generating & Running Executable

$ make install

The above command generates cpp executable, it acts as a C preprocessor to handle #define derivates. 

Usage:

$ ./cpp [filname]

Sample Input:
~~~~~~~~~~~~~
#define MAX 10

int a[MAX], i;
int main()
{
	if (i<MAX)
		return 0;
	else
		return MAX;
}
~~~~~~~~~~~~~
Sample Output:
~~~~~~~~~~~~~
int a[10], i;
int main()
{
	if (i<10)
		return 0;
	else
		return 10;
}
