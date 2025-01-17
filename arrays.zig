const std = @import("std");

// Arrays are denoted by [N]T, where N is the number of elements in the array and T is the type of those elements (i.e., the array's child type).
// For array literals, N may be replaced by _ to infer the size of the array.
const a = [5]u8{ 'h', 'e', 'l', 'l', 'o' };
const b = [_]u8{ 'w', 'o', 'r', 'l', 'd' };

pub fn main() void {
    std.debug.print("{s}\n", .{b[0..]});
}

// To get the size of an array, simply access the array's len field.
const array = [_]u8{ 'h', 'e', 'l', 'l', 'o' };
const lenght = array.len;
