const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .reference_out_of_order) {
        if (data.start == 10 and data.end == 1) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    var a: usize = 1;
    var b: usize = 10;
    _ = .{ &a, &b };
    var buf: [16]u8 = undefined;

    const slice = buf[b..a];
    _ = slice;
    return error.TestFailed;
}

// run
// backend=llvm
// target=native
