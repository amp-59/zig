const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .sub_overflowed) {
        if (data.lhs == 0 and data.rhs == -32768) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    const x = neg(-32768);
    if (x == 32767) return error.Whatever;
    return error.TestFailed;
}
fn neg(a: i16) i16 {
    return -a;
}
// run
// backend=llvm
// target=native
