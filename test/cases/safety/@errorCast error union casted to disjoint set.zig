const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .cast_to_error_from_invalid) {
        if (@TypeOf(data) != u16) {
            if (data == error.Bar) {
                std.process.exit(0);
            }
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    const bar: error{Foo}!i32 = @errorCast(foo());
    _ = &bar;
    return error.TestFailed;
}
fn foo() anyerror!i32 {
    return error.Bar;
}
// run
// backend=llvm
// target=native
