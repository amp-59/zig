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
    bar(1, 1);
    return error.TestFailed;
}

fn bar(one: u1, not_zero: i32) void {
    const x = one << @intCast(not_zero);
    _ = x;
}
// run
// backend=llvm
// target=native
