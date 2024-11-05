const expect = @import("std").testing.expect;
const print = @import("std").debug.print;

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

test "while with a continue expression" {
    var sum: u8 = 0;
    var i: u8 = 1;
    while (i <= 10) : (i += 1) {
        sum += i;
    }
    print("The were {d} cycles\n", .{i});
    try expect(sum == 55);
}

test "while with continue" {
    var sum: u8 = 0;
    var i: u8 = 0;
    while (i <= 3) : (i += 1) {
        if (i == 2) continue;
        sum += 1;
    }
    print("The sum is {d}\n", .{sum});
    try expect(sum == 3);
}

test "while with break" {
    var sum: u8 = 0;
    var i: u8 = 0;
    while (i <= 3) : (i += 1) {
        if (i == 2) break;
        sum += 1;
    }
    try expect(sum == 2);
}
