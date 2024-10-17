const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .cast_to_error_from_invalid) {
        if (@TypeOf(data) == u16) {
            if (data == 0) {
                std.process.exit(0);
            }
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    bar(0) catch {};
    return error.TestFailed;
}
fn bar(x: u16) anyerror {
    return @errorFromInt(x);
}
// run
// backend=llvm
// target=native
