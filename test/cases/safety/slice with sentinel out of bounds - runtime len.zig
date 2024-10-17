const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .reference_out_of_bounds) {
        if (data.start == 5 and data.end == 4) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    var buf = [4]u8{ 'a', 'b', 'c', 0 };
    const input: []u8 = &buf;
    var len: usize = 4;
    _ = &len;
    const slice = input[0..len :0];
    _ = slice;
    return error.TestFailed;
}

// run
// backend=llvm
// target=native
