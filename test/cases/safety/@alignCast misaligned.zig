const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .cast_to_ptr_from_invalid and data.alignment == 4) {
        std.process.exit(0);
    }
    std.process.exit(1);
}

pub fn main() !void {
    var array align(4) = [_]u32{ 0x11111111, 0x11111111 };
    const bytes = std.mem.sliceAsBytes(array[0..]);
    if (foo(bytes) != 0x11111111) return error.Wrong;
    return error.TestFailed;
}
fn foo(bytes: []u8) u32 {
    const slice4 = bytes[1..5];
    const aligned: *align(4) [4]u8 = @alignCast(slice4);
    const int_slice = std.mem.bytesAsSlice(u32, aligned);
    return int_slice[0];
}
// run
// backend=llvm
// target=native
