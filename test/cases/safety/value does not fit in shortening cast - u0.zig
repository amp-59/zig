const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .cast_truncated_data) {
        if (data == 1) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    const x = shorten_cast(1);
    if (x == 0) return error.Whatever;
    return error.TestFailed;
}
fn shorten_cast(x: u8) u0 {
    return @intCast(x);
}
// run
// backend=llvm
// target=native
