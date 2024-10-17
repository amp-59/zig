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
    var zero: usize = 0;
    _ = &zero;
    const b: *i32 = @ptrFromInt(zero);
    _ = b;
    return error.TestFailed;
}
// run
// backend=llvm
// target=native
