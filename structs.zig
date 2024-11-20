const expect = @import("std").testing.expect;

// Structs are Zig's most common kind of composite data type, allowing you to define types that can store a fixed set of named fields.
// Zig gives no guarantees about the in-memory order of fields in a struct or its size. Like arrays, structs are also neatly constructed with T{} syntax.
// Here is an example of declaring and filling a struct.

const Vec3 = struct { x: f32, y: f32, z: f32 };

test "struct usage" {
    const my_vector = Vec3{
        .x = 0,
        .y = 100,
        .z = 50,
    };
    _ = my_vector;
}

// Struct fields cannot be implicitly uninitialised:

// test "missing struct field" {
//     const my_vector = Vec3{
//         .x = 0,
//         .z = 50,
//     };
//     _ = my_vector;
// }

// Fields may be given defaults:

const Vec4 = struct { x: f32 = 0, y: f32 = 0, z: f32 = 0 };

test "struct default" {
    const my_vector = Vec4{
        .x = 0,
        .y = 100,
    };
    _ = my_vector;
}

// Like enums, structs may also contain functions and declarations.

// Structs have the unique property that when given a pointer to a struct, one level of dereferencing is done automatically when accessing fields.
// Notice how, in this example, self.x and self.y are accessed in the swap function without needing to dereference the self pointer.

const Stuff = struct {
    x: i32,
    y: i32,
    fn swap(self: *Stuff) void {
        const tmp = self.x;
        self.x = self.y;
        self.y = tmp;
    }
};

test "automatic dereference" {
    var thing = Stuff{ .x = 10, .y = 20 };
    thing.swap();
    try expect(thing.x == 20);
    try expect(thing.y == 10);
}
