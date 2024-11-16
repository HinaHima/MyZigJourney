const expect = @import("std").testing.expect;

// Zig's enums allow you to define types with a restricted set of named values.
const Direction = enum { north, south, east, west };

// Enums types may have specified (integer) tag types.
const Value = enum(u2) { zero, one, two };

// Enum's ordinal values start at 0. They can be accessed with the built-in function @intFromEnum.
test "enum ordinal value" {
    try expect(@intFromEnum(Value.zero) == 0);
    try expect(@intFromEnum(Value.one) == 1);
    try expect(@intFromEnum(Value.two) == 2);
}

// Values can be overridden, with the next values continuing from there.
const Value2 = enum(u32) { hundred = 100, thousand = 1000, million = 1000000, next };

test "set enum ordinal value" {
    try expect(@intFromEnum(Value2.hundred) == 100);
    try expect(@intFromEnum(Value2.thousand) == 1000);
    try expect(@intFromEnum(Value2.million) == 1000000);
    try expect(@intFromEnum(Value2.next) == 1000001);
}

// Enums can be given methods. These act as namespaced functions that can be called with the dot syntax.
const Suit = enum {
    clubs,
    spades,
    diamonds,
    hearts,
    pub fn isClubs(self: Suit) bool {
        return self == Suit.clubs;
    }
};

test "enum method" {
    try expect(Suit.spades.isClubs() == Suit.isClubs(.spades));
}

// Enums can also be given var and const declarations. These act as namespaced globals and their values are unrelated and unattached to instances of the enum type.
const Mode = enum {
    var count: u32 = 0;
    on,
    off,
};

test "hmm" {
    Mode.count += 1;
    try expect(Mode.count == 1);
}
