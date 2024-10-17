const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .index_out_of_bounds) {
        if (data.index == 4 and data.length == 4) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    const a = [_]i32{ 1, 2, 3, 4 };
    baz(bar(&a));
    return error.TestFailed;
}
fn bar(a: []const i32) i32 {
    return a[4];
}
fn baz(_: i32) void {}
// run
// backend=llvm
// target=native
