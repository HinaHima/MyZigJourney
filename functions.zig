const excpect = @import("std").testing.expect;

// All function arguments are immutable - if a copy is desired the user must explicitly make one. Unlike variables, which are snake_case, functions are camelCase.
// Here's an example of declaring and calling a simple function.
fn addFive(x: u32) u32 {
    // The operation bellow is forbidden.
    // x += 1;
    return x + 5;
}

test "function" {
    const y = addFive(0);
    try excpect(@TypeOf(y) == u32);
    try excpect(y == 5);
}

// Recursion is allowed:
fn fibonacci(n: u16) u16 {
    if (n == 0 or n == 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

test "function recursion" {
    const x = fibonacci(10);
    try excpect(x == 55);
}

// When recursion happens, the compiler is no longer able to work out the maximum stack size, which may result in unsafe behaviour - a stack overflow.
// Details on how to achieve safe recursion will be covered in future.

// Values can be ignored using _ instead of a variable or const declaration.
// This does not work at the global scope (i.e. it only works inside functions and blocks) and is useful for ignoring the values returned from functions if you do not need them.
// _ = 10;
