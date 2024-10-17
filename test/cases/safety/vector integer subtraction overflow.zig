const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, _: anytype) noreturn {
    if (cause == .sub_overflowed) {
        std.process.exit(0);
    }
    std.process.exit(1);
}

pub fn main() !void {
    const a: @Vector(4, u32) = [_]u32{ 1, 2, 8, 4 };
    const b: @Vector(4, u32) = [_]u32{ 5, 6, 7, 8 };
    const x = sub(b, a);
    _ = x;
    return error.TestFailed;
}
fn sub(a: @Vector(4, u32), b: @Vector(4, u32)) @Vector(4, u32) {
    return a - b;
}
// run
// backend=llvm
// target=native
