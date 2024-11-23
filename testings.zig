const expect = @import("std").testing.expect;
const std = @import("std");

pub fn main() !void {
    const a = @as(i32, 1);
    std.debug.print("Check {}", .{a});
    return;
}
