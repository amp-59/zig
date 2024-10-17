const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .reference_out_of_bounds) {
        if (data.start == 1 and data.end == 0) {
            std.process.exit(0);
        } else {
            std.debug.print("{}\n", .{data});
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    var buf_zero = [0]u8{};
    const input: []u8 = &buf_zero;
    const slice = input[0..0 :0];
    _ = slice;
    return error.TestFailed;
}

// run
// backend=llvm
// target=native
