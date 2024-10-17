const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .cast_to_error_from_invalid) {
        if (@TypeOf(data) != u16) {
            if (data == error.B) {
                std.process.exit(0);
            }
        }
    }
    std.process.exit(1);
}
const Set1 = error{ A, B };
const Set2 = error{ A, C };
pub fn main() !void {
    foo(Set1.B) catch {};
    return error.TestFailed;
}
fn foo(set1: Set1) Set2 {
    return @errorCast(set1);
}
// run
// backend=llvm
// target=native
