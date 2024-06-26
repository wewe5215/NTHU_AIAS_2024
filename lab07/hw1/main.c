//main.c
#include <stdio.h>
#include <stdlib.h>
#define SIZE 50

int test_c_data[50];
void print_result() {
    int i;
    char str[25];
    puts("Output c & assembly function result\n");
    puts("c result :\n");
    for( i=0 ; i<SIZE ; i++) {
        int j= *(test_c_data+i);
        itoa(i, str, 10);
        puts("test");
        puts(str);
        puts(": ");
        itoa(j, str, 10);
        puts(str);
        puts("\n");
    }
}


void test_asm(int *test_asm_data);
int main() {
    test_asm(test_c_data);
    print_result();
    return 0;
}