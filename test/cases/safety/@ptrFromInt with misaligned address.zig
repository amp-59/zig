const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .cast_to_ptr_from_invalid) {
        if (data.alignment == 4) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    var x: usize = 5;
    _ = &x;
    const y: [*]align(4) u8 = @ptrFromInt(x);
    _ = y;
    return error.TestFailed;
}
// run
// backend=llvm
// target=native
