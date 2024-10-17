const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .shl_overflowed) {
        if (data.value == 0b0010111111111111 and data.shift_amt == 3) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    const x = shl(0b0010111111111111, 3);
    if (x == 0) return error.Whatever;
    return error.TestFailed;
}
fn shl(a: u16, b: u4) u16 {
    return @shlExact(a, b);
}
// run
// backend=llvm
// target=native
