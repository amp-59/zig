const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, _: anytype) noreturn {
    if (cause == .sub_overflowed) {
        std.process.exit(0);
    }
    std.process.exit(1);
}
pub fn main() !void {
    var a: @Vector(4, i16) = [_]i16{ 1, -32768, 200, 4 };
    _ = &a;
    const x = neg(a);
    _ = x;
    return error.TestFailed;
}
fn neg(a: @Vector(4, i16)) @Vector(4, i16) {
    return -a;
}
// run
// backend=llvm
// target=native
