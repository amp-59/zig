const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, _: anytype) noreturn {
    if (cause == .add_overflowed) {
        std.process.exit(0);
    }
    std.process.exit(1);
}

pub fn main() !void {
    const a: @Vector(4, i32) = [_]i32{ 1, 2, 2147483643, 4 };
    const b: @Vector(4, i32) = [_]i32{ 5, 6, 7, 8 };
    const x = add(a, b);
    _ = x;
    return error.TestFailed;
}
fn add(a: @Vector(4, i32), b: @Vector(4, i32)) @Vector(4, i32) {
    return a + b;
}
// run
// backend=llvm
// target=native
