const expect = @import("std").testing.expect;

// Zig's if statements accept bool values (i.e. true or false). Unlike languages like C or Javascript, there are no values that implicitly coerce to bool values.
// We will be using the expect function from the standard library, which will cause the test to fail if it's given the value false. When a test fails, the error and stack trace will be shown.
test "if statement" {
    const a = true;
    var x: u8 = 0;
    if (a) {
        x += 1;
    } else {
        x += 2;
    }
    try expect(x == 1);
}

// If statements also work as expressions.
test "if statement expression" {
    const a = true;
    var x: u16 = 0;
    x += if (a) 1 else 2;
    try expect(x == 1);
}
