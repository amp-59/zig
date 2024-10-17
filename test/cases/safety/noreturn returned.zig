const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, _: anytype) noreturn {
    if (cause == .returned_noreturn) {
        std.process.exit(0);
    }
    std.process.exit(1);
}

const T = struct {
    export fn bar() void {
        // ...
    }
};

extern fn bar() noreturn;
pub fn main() void {
    _ = T.bar;
    bar();
}
// run
// backend=llvm
// target=native
