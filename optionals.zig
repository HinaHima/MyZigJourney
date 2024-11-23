const expect = @import("std").testing.expect;

// Optionals use the syntax ?T and are used to store the data null, or a value of type T.

test "optional" {
    var found_index: ?usize = null;
    const data = [_]u16{ 1, 2, 3, 5, 7, 10 };
    for (data, 0..) |value, i| {
        if (value == 8) found_index = i;
    }
    try expect(found_index == null);
}

// Optionals support the orelse expression, which acts when the optional is null. This unwraps the optional to its child type.

test "orelse" {
    const a: ?f32 = null;
    const fallback_value: f32 = 0;
    const b = a orelse fallback_value;
    try expect(b == 0);
    try expect(@TypeOf(b) == f32);
}

// .? is a shorthand for orelse unreachable. This is used for when you know it is impossible
// for an optional value to be null, and using this to unwrap a null value is detectable illegal behaviour.

test "orelse unreachable" {
    const a: ?f32 = 5;
    const b = a orelse unreachable;
    const c = a.?;
    try expect(b == c);
    try expect(@TypeOf(c) == f32);
}

// Both if expressions and while loops support taking optional values as conditions, allowing you to "capture" the inner non-null value.
//Here we use an if optional payload capture; a and b are equivalent here. if (b) |value| captures the value of b (in the cases where b is not null), and makes it available as value.
// As in the union example, the captured value is immutable, but we can still use a pointer capture to modify the value stored in b.

test "if optional payload capture" {
    const a: ?i32 = 5;
    if (a != 5) {
        const value = a;
        _ = value;
    }

    var b: ?i32 = 5;
    if (b) |*value| {
        value.* += 1;
    }
    try expect(b.? == 6);
}

// And with while:

var numbers_left: u32 = 4;

fn eventuallyNullSequence() ?u32 {
    if (numbers_left == 0) return null;
    numbers_left -= 1;
    return numbers_left;
}

test "while null capture" {
    var summ: u32 = 0;

    while (eventuallyNullSequence()) |value| {
        summ += value;
    }
    try expect(summ == 6);
}

// Optional pointer and optional slice types do not take up any extra memory compared to non-optional ones. This is because internally they use the 0 value of the pointer for null.
// This is how null pointers in Zig work - they must be unwrapped to a non-optional before dereferencing, which stops null pointer dereferences from happening accidentally.
