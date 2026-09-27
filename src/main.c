#include <stdio.h>
#include <input.h>
#include "clear-ula.h"
#include "fibonacci.h"
#include "factorial.h"
#include "interrupts.h"

int main(void)
{
    setup_interrupts();
    clear_ula();

    printf("Fibonacci(5) = %d\n", fibonacci(5));
    printf("Factorial(5) = %d\n", factorial(5));

    in_wait_key();

    return 0;
}
