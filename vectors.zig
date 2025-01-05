// Zig provides vector types for SIMD. These are not to be conflated with vectors in a mathematical sense, or vectors like C++'s std::vector (for this, see "Arraylist" in chapter 2). 
// Vectors may be created using the @Type built-in we used earlier, and std.meta.Vector provides a shorthand for this.

// Vectors can only have child types of booleans, integers, floats and pointers.

// Operations between vectors with the same child type and length can take place.
// These operations are performed on each of the values in the vector.std.meta.eql is used here to check for equality between two vectors (also useful for other types like structs).

const meta = @import("std").meta;

test "vector add" {
    const x: @Vector(4, f32) = .{ 1, -10, 20, -1 };
    const y: @Vector(4, f32) = .{ 2, 10, 0, 1 };
    const z = x + y;
    try expect(meta.eql(z, @Vector(4, f32){ 3, 0, 20, 0 }));
}

// Vectors are indexable.

test "vector indexing" {
    const x: @Vector(4, u8) = .{ 255, 0, 255, 0 };
    try expect(x[0] == 255);
}

// The built-in function @splat may be used to construct a vector where all of the values are the same. Here we use it to multiply a vector by a scalar.