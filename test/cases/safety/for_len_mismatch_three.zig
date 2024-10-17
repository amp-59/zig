const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .mismatched_for_loop_capture_lengths) {
        if (data.loop_len == 10 and data.capture_len == 5) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    var slice: []const u8 = "hello";
    _ = &slice;
    for (10..20, slice, 20..30) |a, b, c| {
        _ = a;
        _ = b;
        _ = c;
        return error.TestFailed;
    }
    return error.TestFailed;
}
// run
// backend=llvm
// target=native
