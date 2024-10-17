const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, _: anytype) noreturn {
    if (cause == .add_overflowed) {
        std.process.exit(0);
    }
    std.process.exit(1);
}

pub fn main() !void {
    var buffer = [6]i32{ 1, 2, 3, 4, 5, 6 };
    var len = buffer.len;
    _ = &len;
    @memset(buffer[0..len], undefined);
    var x: i32 = buffer[1];
    x += buffer[2];
}
// run
// backend=llvm
// target=native
