#include <stdio.h>
#include <input.h>
#include "clear-ula.h"
#include "fibonacci.h"
#include "factorial.h"

int main(void)
{
    clear_ula();

    printf("Fibonacci(5) = %d\n", fibonacci(1));
    printf("Factorial(5) = %d\n", factorial(1));

    in_wait_key();

    return 0;
}
