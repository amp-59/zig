const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .unwrapped_error) {
        if (data.err == error.Whatever) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    bar() catch |err| switch (err) {
        error.Whatever => unreachable,
    };
    return error.TestFailed;
}
fn bar() !void {
    return error.Whatever;
}
// run
// backend=llvm
// target=native
