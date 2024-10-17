const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .cast_to_enum_from_invalid) {
        if (data == 3) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}
const Foo = enum {
    A,
    B,
    C,
};
pub fn main() !void {
    baz(bar(3));
    return error.TestFailed;
}
fn bar(a: u2) Foo {
    return @enumFromInt(a);
}
fn baz(_: Foo) void {}

// run
// backend=llvm
// target=native
