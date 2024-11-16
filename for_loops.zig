// For loops are used to iterate over arrays (and other types, to be discussed later).
// For loops follow this syntax. Like while, for loops can use break and continue.
// Here, we've had to assign values to _, as Zig does not allow us to have unused values.
test "for" {
    const string = [_]u8{ 'a', 'b', 'c' };

    for (string, 0..) |character, index| {
        _ = character;
        _ = index;
    }

    for (string) |character| {
        _ = character;
    }

    for (string, 0..) |_, index| {
        _ = index;
    }

    for (string) |_| {}
}
