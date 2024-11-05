const std = @import("std");

const constant: i32 = 5;
var variable: i32 = 5000;

pub fn main() void {
    std.debug.print("The constant value is {d}.\nThe variable value is {d}.\n", .{ constant, variable });
}
