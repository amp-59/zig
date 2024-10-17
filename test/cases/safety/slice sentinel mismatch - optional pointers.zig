const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .mismatched_sentinel) {
        if (cause.mismatched_sentinel == ?*i32) {
            if (data.expected == null and
                data.actual == @as(*i32, @ptrFromInt(16)))
            {
                std.process.exit(0);
            }
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    var buf: [4]?*i32 = .{ @ptrFromInt(4), @ptrFromInt(8), @ptrFromInt(12), @ptrFromInt(16) };
    const slice = buf[0..3 :null];
    _ = slice;
    return error.TestFailed;
}

// run
// backend=llvm
// target=native
