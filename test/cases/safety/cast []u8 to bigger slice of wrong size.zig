const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .div_with_remainder) {
        if (data.lhs == 5 and data.rhs == 4) {
            std.process.exit(0);
        } else {
            std.debug.print("{any}\n", .{data});
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    const x = widenSlice(&[_]u8{ 1, 2, 3, 4, 5 });
    if (x.len == 0) return error.Whatever;
    return error.TestFailed;
}
fn widenSlice(slice: []align(1) const u8) []align(1) const i32 {
    return std.mem.bytesAsSlice(i32, slice);
}
// run
// backend=llvm
// target=native
