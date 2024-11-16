const expect = @import("std").testing.expect;

// Slices can be thought of as a pair of [*]T (the pointer to the data) and a usize (the element count). Their syntax is []T, with T being the child type.
// Slices have the same attributes as pointers, meaning that there also exists const slices. For loops also operate over slices. String literals in Zig coerce to []const u8.

// Here, the syntax x[n..m] is used to create a slice from an array. This is called slicing, and creates a slice of the elements starting at x[n] and ending at x[m - 1].
// This example uses a const slice, as the values to which the slice points need not be modified.
fn total(values: []const u8) usize {
    var sum: usize = 0;
    for (values) |v| sum += v;
    return sum;
}

test "slices" {
    const array = [_]u8{ 1, 2, 3, 4, 5 };
    const slice = array[0..3];
    try expect(total(slice) == 6);
}

// When these n and m values are both known at compile time, slicing will actually produce a pointer to an array. This is not an issue as a pointer to an array i.e. *[N]T will coerce to a []T.
test "slices 2" {
    const array = [_]u8{ 1, 2, 3, 4, 5 };
    const slice = array[0..3];
    try expect(@TypeOf(slice) == *const [3]u8);
}

// The syntax x[n..] can also be used when you want to slice to the end.
test "slices 3" {
    const array = [_]u8{ 1, 2, 3, 4, 5 };
    const slice = array[0..];
    _ = slice;
}
