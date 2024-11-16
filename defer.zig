const expect = @import("std").testing.expect;
const print = @import("std").debug.print;

// Defer is used to execute a statement while exiting the current block.
test "defer" {
    var x: i16 = 5;
    {
        defer x += 2;
        try expect(x == 5);
        print("X is {d}\n", .{x});
    }
    print("X is now {d}\n", .{x});
    try expect(x == 7);
}

// When there are multiple defers in a single block, they are executed in reverse order
test "multi defer" {
    var x: f32 = 5;
    {
        defer x += 2;
        defer x /= 2;
        print("\n\nX is {d}\n", .{x});
    }
    print("X is now {d}\n", .{x});
    try expect(x == 4.5);
}

test "defer test" {
    defer {
        print("Функция завершена\n", .{});
    }

    print("\n\nВыполнение функции\n", .{});
    try expect(true);
}

// Defer is useful to ensure that resources are cleaned up when they are no longer needed.
// Instead of needing to remember to manually free up the resource, you can add a defer statement right next to the statement that allocates the resource.
