const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .cast_to_ptr_from_invalid) {
        if (data.value == 0) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    var c_ptr: [*c]u8 = 0;
    _ = &c_ptr;
    const zig_ptr: *u8 = c_ptr;
    _ = zig_ptr;
    return error.TestFailed;
}

// run
// backend=llvm
// target=native
