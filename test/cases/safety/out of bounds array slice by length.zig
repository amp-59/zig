const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .reference_out_of_bounds) {
        // These values are conceptually wrong because `analyzeSlice` does not
        // support `reference_out_of_order_extra`.
        if (data.start == 16 and data.end == 5) {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

pub fn main() !void {
    var buf: [5]u8 = undefined;
    _ = buf[foo(6)..][0..10];
    return error.TestFailed;
}
fn foo(a: u32) u32 {
    return a;
}
// run
// backend=llvm
// target=native
