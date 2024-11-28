const expect = @import("std").testing.expect;
const eql = @import("std").mem.eql;

// Payload captures use the syntax |value| and appear in many places, some of which we've seen already.
// Wherever they appear, they are used to "capture" the value from something.

// With if statements and optionals.

test "optional-if" {
    const maybe_num: ?usize = 10;
    if (maybe_num) |value| {
        try expect(@TypeOf(value) == usize);
        try expect(value == 10);
    } else {
        unreachable;
    }
}

// With if statements and error unions. The else with the error capture is required here.

test "error union if" {
    const ent_num: error{UnknowEntity}!u32 = 5;
    if (ent_num) |entity| {
        try expect(@TypeOf(entity) == u32);
        try expect(entity == 5);
    } else |err| {
        _ = err catch {};
        unreachable;
    }
}

// With while loops and error unions. The else with the error capture is required here.

var numbers_left2: u32 = undefined;

fn eventuallyErrorSequence() !u32 {
    return if (numbers_left2 == 0) error.ReachedZero else blk: {
        numbers_left2 -= 1;
        break :blk numbers_left2;
    };
}

test "while error union capture" {
    var sum: u32 = 0;
    numbers_left2 = 3;
    while (eventuallyErrorSequence()) |value| {
        sum += value;
    } else |err| {
        try expect(err == error.ReachedZero);
    }
}

// For loops

test "for capture" {
    const x = [_]i8{ 1, 5, 120, -5 };
    for (x) |value| {
        try expect(@TypeOf(value) == i8);
    }
}

// Switch cases on tagged unions.

const Info = union(enum) {
    a: u32,
    b: []const u8,
    c,
    d: u32,
};

test "switch capture" {
    const b = Info{ .a = 10 };
    const x = switch (b) {
        .b => |str| blk: {
            try expect(@TypeOf(str) == []const u8);
            break :blk 1;
        },
        .c => 2,
        //if these are of the same type, they
        //may be inside the same capture group
        .a, .d => |num| blk: {
            try expect(@TypeOf(num) == u32);
            break :blk num * 2;
        },
    };
    try expect(x == 20);
}

// As we saw in the Union and Optional sections above, values captured with the |val| syntax are immutable (similar to function arguments),
// but we can use pointer capture to modify the original values. This captures the values as pointers that are themselves still immutable,
//  but because the value is now a pointer, we can modify the original value by dereferencing it:

test "for with pointer capture" {
    var data = [_]u8{ 1, 2, 3 };
    for (&data) |*byte| byte.* += 1;
    try expect(eql(u8, &data, &[_]u8{ 2, 3, 4 }));
}
