const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .shl_overflowed) {
        if (data.value == -16385 and data.shift_amt == 1) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    const x = shl(-16385, 1);
    if (x == 0) return error.Whatever;
    return error.TestFailed;
}
fn shl(a: i16, b: u4) i16 {
    return @shlExact(a, b);
}
// run
// backend=llvm
// target=native
