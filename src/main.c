#include <stdio.h>
#include <input.h>
#include "clear-ula.h"
#include "fibonacci.h"
#include "factorial.h"

int main()
{
    clear_ula();
    printf("Fibonacci(10) = %d\n", fibonacci(10));
    printf("Factorial(10) = %d\n", factorial(10));

    in_wait_key();

    return 0;
}
