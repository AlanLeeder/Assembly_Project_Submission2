#include <stdio.h>
#include <assert.h>

// declare the assembly function
long REGISTER_ADDER(long a, long b);

int main() {

    long result;

    // Test 1
    result = REGISTER_ADDER(2, 3);
    printf("2 + 3 = %ld\n", result);
    assert(result == 5);

    // Test 2
    result = REGISTER_ADDER(-10, 5);
    printf("-10 + 5 = %ld\n", result);
    assert(result == -5);

    // Test 3
    result = REGISTER_ADDER(100, 200);
    printf("100 + 200 = %ld\n", result);
    assert(result == 300);

    printf("The final sum is\n");

    return 0;
}
