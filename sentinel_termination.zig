// Arrays, slices and many pointers may be terminated by a value of their child type. 
// This is known as sentinel termination. These follow the syntax [N:t]T, [:t]T, and [*:t]T, where t is a value of the child type T.

// An example of a sentinel terminated array. The built-in @ptrCast is used to perform an unsafe type conversion. 
// This shows us that the last element of the array is followed by a 0 byte.

const expect = @import("std").testing.expect;

test "sentinel termination" {
    const terminated = [3:0]u8{ 3, 2, 1 };
    try expect(terminated.len == 3);
    try expect(@as(*const [4]u8, @ptrCast(&terminated))[3] == 0);
}

// The types of string literals is *const [N:0]u8, where N is the length of the string. 
// This allows string literals to coerce to sentinel terminated slices, and sentinel terminated many pointers. Note: string literals are UTF-8 encoded.

test "string literal" {
    try expect(@TypeOf("hello") == *const [5:0]u8);
}

// [*:0]u8 and [*:0]const u8 perfectly model C's strings.

test "C string" {
    const c_string: [*:0]const u8 = "hello";
    var array: [5]u8 = undefined;

    var i: usize = 0;
    while (c_string[i] != 0) : (i += 1) {
        array[i] = c_string[i];
    }
}

test "coercion" {
    const a: [*:0]u8 = undefined;
    const b: [*]u8 = a;

    const c: [*:0]u8 = undefined;
    const d: [*]u8 = c;

    const e: [:0]f32 = undefined;
    const f: [*]f32 = e;

    _ = .{ b, d, f};
}

// Sentinel terminated slicing is provided which can be used to create a sentinel terminated slice with the syntax x[n..m:t], where t is the terminator value. 
// Doing this is an assertion from the programmer that the memory is terminated where it should be - getting this wrong is detectable illegal behaviour.

test "sentinel terminated slicing" {
    var x = [_:0]u8{255} ** 3;
    const y = x[0..3 :0];
    _ = y;
}

// The built-in function @splat may be used to construct a vector where all of the values are the same. Here we use it to multiply a vector by a scalar.

test "vector * scalar" {
    const x: @Vector(3, f32) = .{ 12.5, 37.5, 2.5 };
    const y = x * @as(@Vector(3, f32), @splat(2));
    try expect(meta.eql(y, @Vector(3, f32){ 25, 75, 5 }));
}

// Vectors do not have a len field like arrays, but may still be looped over.

test "vector looping" {
    const x = @Vector(4, u8){ 255, 0, 255, 0 };
    const sum = blk: {
        var tmp: u10 = 0;
        var i: u8 = 0;
        while (i < 4) : (i += 1) tmp += x[i];
        break :blk tmp;
    };
    try expect(sum == 510);
}

// Vectors coerce to their respective arrays.

const arr: [4]f32 = @Vector(4, f32){ 1, 2, 3, 4 };

// It is worth noting that using explicit vectors may result in slower software if you do not make the right decisions - the compiler's auto-vectorisation is fairly smart as-is.