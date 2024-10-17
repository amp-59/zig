const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .mismatched_for_loop_capture_lengths) {
        if (data.loop_len == 8 and data.capture_len == 2) {
            std.process.exit(0);
        } else {
            std.debug.print("{}\n", .{data});
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    var runtime_i: usize = 1;
    var j: usize = 3;
    var slice = "too long";
    _ = .{ &runtime_i, &j, &slice };
    for (runtime_i..j, slice) |a, b| {
        _ = a;
        _ = b;
        return error.TestFailed;
    }
    return error.TestFailed;
}
// run
// backend=llvm
// target=native
