const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .cast_to_unsigned_from_negative) {
        if (data == -10) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}
pub fn main() !void {
    const x = unsigned_cast(-10);
    if (x == 0) return error.Whatever;
    return error.TestFailed;
}
fn unsigned_cast(x: i32) u32 {
    return @intCast(x);
}
// run
// backend=llvm
// target=native
