const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, _: anytype) noreturn {
    if (cause == .cast_to_unsigned_from_negative) {
        std.process.exit(0);
    }
    std.process.exit(1);
}

pub fn main() !void {
    var x: @Vector(4, i32) = @splat(-2147483647);
    _ = &x;
    const y: @Vector(4, u32) = @intCast(x);
    _ = y;
    return error.TestFailed;
}

// run
// backend=llvm
// target=native
