const expect = @import("std").testing.expect;
const print = @import("std").debug.print;

// Zig's while loop has three parts - a condition, a block and a continue expression.
// Without a continue expression.
test "while" {
    var count: u8 = 0;
    var i: u8 = 2;
    while (i < 100) {
        i *= 2;
        count += 1;
    }
    print("The were {d} cycles\n", .{count});
    try expect(i == 128);
}

// With a continue expression.
test "while with a continue expression" {
    var sum: u8 = 0;
    var i: u8 = 1;
    while (i <= 10) : (i += 1) {
        sum += i;
    }
    print("The were {d} cycles\n", .{i});
    try expect(sum == 55);
}

// With a continue.
test "while with continue" {
    var sum: u8 = 0;
    var i: u8 = 0;
    while (i <= 3) : (i += 1) {
        if (i == 2) continue;
        sum += 1;
    }
    print("The sum is {d}\nThe i var is {}\n", .{ sum, i });
    try expect(sum == 3);
}

// With a break.
test "while with break" {
    var sum: u8 = 0;
    var i: u8 = 0;
    while (i <= 3) : (i += 1) {
        if (i == 2) break;
        sum += 1;
    }
    print("The sum is {d}\nThe i var is {}\n", .{ sum, i });
    try expect(sum == 2);
}
