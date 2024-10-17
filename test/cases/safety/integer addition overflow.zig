const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .add_overflowed) {
        if (data.lhs == 65530 and data.rhs == 10) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    const x = add(65530, 10);
    if (x == 0) return error.Whatever;
    return error.TestFailed;
}

fn add(a: u16, b: u16) u16 {
    return a + b;
}

// run
// backend=llvm
// target=native
