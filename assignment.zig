const std = @import("std");

// Value assignment has the following syntax: (const|var) identifier[: type] = value.
// const indicates that identifier is a constant that stores an immutable value.
// var indicates that identifier is a variable that stores a mutable value.
// : type is a type annotation for identifier, and may be omitted if the data type of value can be inferred.
const constant: i32 = 5;
var variable: i32 = 5000;

pub fn main() void {
    std.debug.print("The constant value is {d}.\nThe variable value is {d}.\n", .{ constant, variable });
}

// Constants and variables must have a value. If no known value can be given, the undefined value, which coerces to any type, may be used as long as a type annotation is provided.
const a: i32 = undefined;
var b: u32 = undefined;

// However in Zig, using undefined like this is a bad idea as undefined works very differently.
// In JavaScript, values can be checked for being undefined, whereas in Zig, an undefined value is impossible to detect.
// Usage of undefined values is not safe. Zig's undefined is "undefined" as in "undefined behaviour", and should not be used as a stand-in for an optional.
