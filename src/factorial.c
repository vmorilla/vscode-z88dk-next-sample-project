#include "factorial.h"
#include <stdio.h>

int factorial(int fact_n)
{
    int value = 1;
    printf("value f: %d\n", value);
    for (int i = 2; i <= fact_n; i++)
    {
        value *= i;
        printf("value: %d\n", value);
    }
    return value;
}