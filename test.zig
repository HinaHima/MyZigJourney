const print = @import("std").debug.print;
const expect = @import("std").testing.expect;

const Vec = struct { a: f32, b: u8, c: i16 };

test "Vector constructor" {
    const myVec = Vec{
        .a = 10,
        .b = 225,
        .c = -226,
    };

    _ = myVec;

    try expect(1 == 1);
    print("{d}\n", .{1});
}