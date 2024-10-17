const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, _: anytype) noreturn {
    if (cause == .accessed_null_value) {
        std.process.exit(0);
    }
    std.process.exit(1);
}

pub fn main() !void {
    var ptr: [*c]const u32 = null;
    _ = &ptr;
    const slice = ptr[0..3];
    _ = slice;
    return error.TestFailed;
}
// run
// backend=llvm
// target=native
