#include <stdio.h>
#include <input.h>
#include "clear-ula.h"
#include "fibonacci.h"
#include "factorial.h"
#include "calls.h"

extern uint16_t _register_sp;

int main(void)
{
    clear_ula();
    printf("Normal 16-16 -> 16: %d\n", normal_16_16_r16(10, 20));
    printf("Normal 8-8 -> 16: %d\n", normal_8_8_r16(10, 20));
    printf("Normal 8-16-8 -> 16: %d\n", normal_8_16_8_r16(10, 30, 20));

    printf("\x10\x34"); // Ink green
    printf("Fibonacci(10) = %d\n", fibonacci(10));
    printf("Factorial(10) = %d\n", factorial(10));

    in_wait_key();

    return 0;
}
