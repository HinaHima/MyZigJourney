const expect = @import("std").testing.expect;

// Normal pointers in Zig cannot have 0 or null as a value. They follow the syntax *T, where T is the child type.
// Referencing is done with &variable, and dereferencing is done with variable.*.
fn increment(num: *u8) void {
    num.* += 1;
}

test "pointers" {
    var x: u8 = 1;
    increment(&x);
    try expect(x == 2);
}

// Trying to set a *T to the value 0 is detectable illegal behaviour.
test "naughty pointer" {
    const x: u16 = 0;
    const y: *u8 = @ptrFromInt(x);
    _ = y;
}

// Zig also has const pointers, which cannot be used to modify the referenced data. Referencing a const variable will yield a const pointer.
test "const pointers" {
    const x: u8 = 1;
    const y = &x;
    y.* += 1;
}
