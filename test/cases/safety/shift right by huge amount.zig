const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .shift_amt_overflowed) {
        if (data == 24) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    var x: u24 = 42;
    var y: u5 = 24;
    _ = .{ &x, &y };
    const z = x << y;
    _ = z;
    return error.TestFailed;
}

// run
// backend=llvm
// target=native
