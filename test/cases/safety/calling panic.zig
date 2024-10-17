const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .message and std.mem.eql(u8, data, "oh no")) {
        std.process.exit(0);
    }
    std.process.exit(1);
}
pub fn main() !void {
    if (true) @panic("oh no");
    return error.TestFailed;
}
// run
// backend=llvm
// target=native
