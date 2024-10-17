const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .div_overflowed) {
        if (data.lhs == -32768 and data.rhs == -1) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    const x = div(-32768, -1);
    if (x == 32767) return error.Whatever;
    return error.TestFailed;
}
fn div(a: i16, b: i16) i16 {
    return @divTrunc(a, b);
}
// run
// backend=llvm
// target=native
