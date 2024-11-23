const expect = @import("std").testing.expect;

// Blocks in Zig are expressions and can be given labels, which are used to yield values. Here, we are using a label called blk.
// Blocks yield values, meaning they can be used in place of a value. The value of an empty block {} is a value of the type void.

test "labbeled blocks" {
    const count = blc: {
        var sum: u32 = 0;
        var i: u32 = 0;
        while (i < 10) : (i += 1) sum += i;
        break :blc sum;
    };
    try expect(count == 45);
    try expect(@TypeOf(count) == u32);
}
