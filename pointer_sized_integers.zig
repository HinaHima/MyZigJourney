const std = @import("std");
const expect = @import("std").testing.expect;

// usize and isize are given as unsigned and signed integers which are the same size as pointers.
test "usize" {
    try expect(@sizeOf(usize) == @sizeOf(*u8));
    try expect(@sizeOf(isize) == @sizeOf(*u8));
}

fn printPointerAddress(ptr: *u8) void {
    const address: usize = @intFromPtr(ptr);
    std.debug.print("Pointer address: {}\n", .{address});
}

test "pointer-sized integers" {
    var buffer: u8 = 42;
    printPointerAddress(&buffer);
}
