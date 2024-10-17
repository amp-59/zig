const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .cast_to_ptr_from_invalid) {
        if (data.value == 0) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

fn getNullPtr() ?*const anyopaque {
    return null;
}
pub fn main() !void {
    const null_ptr: ?*const anyopaque = getNullPtr();
    const required_ptr: *align(1) const fn () void = @ptrCast(null_ptr);
    _ = required_ptr;
    return error.TestFailed;
}

// run
// backend=llvm
// target=native
