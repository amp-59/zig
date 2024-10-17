const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .sub_overflowed) {
        if (data.lhs == 0 and data.rhs == 1) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    var x: usize = undefined;
    x = 0;
    // We ignore this result but it should still trigger a safety panic!
    _ = x - 1;
    return error.TestFailed;
}

// run
// backend=llvm
// target=native
