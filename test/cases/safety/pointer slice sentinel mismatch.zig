const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .mismatched_sentinel) {
        if (data.expected == 0 and data.actual == 4) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    var buf: [4]u8 = .{ 1, 2, 3, 4 };
    const ptr: [*]u8 = &buf;
    const slice = ptr[0..3 :0];
    _ = slice;
    return error.TestFailed;
}

// run
// backend=llvm
// target=native
