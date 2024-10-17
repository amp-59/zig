const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .mul_overflowed) {
        if (data.lhs == 300 and data.rhs == 6000) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    const x = mul(300, 6000);
    if (x == 0) return error.Whatever;
    return error.TestFailed;
}
fn mul(a: u16, b: u16) u16 {
    return a * b;
}
// run
// backend=llvm
// target=native
