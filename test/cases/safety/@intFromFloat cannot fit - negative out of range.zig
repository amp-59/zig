const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .cast_to_int_from_invalid) {
        if (data == -129.1) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    baz(bar(-129.1));
    return error.TestFailed;
}
fn bar(a: f32) i8 {
    return @intFromFloat(a);
}
fn baz(_: i8) void {}
// run
// backend=llvm
// target=native
