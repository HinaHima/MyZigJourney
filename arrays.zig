const std = @import("std");

const a = [5]u8{ 'h', 'e', 'l', 'l', 'o' };
const b = [_]u8{ 'w', 'o', 'r', 'l', 'd' };

pub fn main() void {
    std.debug.print("{s}\n", .{b[0..]});
}
