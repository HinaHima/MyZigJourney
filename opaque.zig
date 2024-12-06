const expect = @import("std").testing.expect;

// opaque types in Zig have an unknown (albeit non-zero) size and alignment. Because of this these data types cannot be stored directly.
// These are used to maintain type safety with pointers to types that we don't have information about.

const Window = opaque {
    fn show(self: *Window) void {
        show_window(self);
    }
};
const Button = opaque {};

extern fn show_window(*Window) callconv(.C) void;

// test "opaque" {
//     const main_window: *Window = undefined;
//     show_window(main_window);

//     const ok_button: *Button = undefined;
//     show_window(ok_button);
// }

test "opaque with declarations" {
    var main_windows: *Window = undefined;
    main_windows.show();
}
