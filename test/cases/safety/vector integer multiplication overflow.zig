const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, _: anytype) noreturn {
    if (cause == .mul_overflowed) {
        std.process.exit(0);
    }
    std.process.exit(1);
}

pub fn main() !void {
    const a: @Vector(4, u8) = [_]u8{ 1, 2, 200, 4 };
    const b: @Vector(4, u8) = [_]u8{ 5, 6, 2, 8 };
    const x = mul(b, a);
    _ = x;
    return error.TestFailed;
}
fn mul(a: @Vector(4, u8), b: @Vector(4, u8)) @Vector(4, u8) {
    return a * b;
}
// run
// backend=llvm
// target=native
