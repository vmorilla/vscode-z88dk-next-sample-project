#include <stdio.h>
#include <input.h>
#include "clear-ula.h"
#include "fibonacci.h"
#include "factorial.h"
#include "calls.h"

struct BitFields
{
    unsigned int x : 9; // 9 bits
};

int main(void)
{
    clear_ula();
    printf("Normal 16-16 -> 16: %d\n", normal_16_16_r16(10, 20));
    printf("Normal 8-8 -> 16: %d\n", normal_8_8_r16(10, 20));
    printf("Normal 8-16-8 -> 16: %d\n", normal_8_16_8_r16(10, 30, 20));
    printf("Fibonacci(10) = %d\n", fibonacci(10));
    printf("Factorial(10) = %d\n", factorial(10));

    struct BitFields bf;

    *((unsigned char *)(&bf + 1)) = 0;
    *((unsigned char *)(&bf)) = 0;

    bf.x = 258;
    if (bf.x == 258)
        printf("OK\n");

    unsigned char *p = (unsigned char *)&bf;

    printf("bit1: %u\n", bf.x);
    printf("Byte 1: %u\n", *p);
    printf("Byte 2: %u\n", *(p + 1));

    printf("Size of struct: %zu bytes\n", sizeof(bf));

    in_wait_key();

    return 0;
}
