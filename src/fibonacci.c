#include "fibonacci.h"

#define BANK 15
#pragma bank 15

int fibonacci(int n)
{
    if (n <= 1)
    {
        return n;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
}