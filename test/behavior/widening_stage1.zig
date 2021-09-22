const std = @import("std");
const expect = std.testing.expect;
const mem = std.mem;

test "float widening" {
    var a: f16 = 12.34;
    var b: f32 = a;
    var c: f64 = b;
    var d: f128 = c;
    try expect(a == b);
    try expect(b == c);
    try expect(c == d);
}

test "float widening f16 to f128" {
    // TODO https://github.com/ziglang/zig/issues/3282
    if (@import("builtin").stage2_arch == .aarch64) return error.SkipZigTest;
    if (@import("builtin").stage2_arch == .powerpc64le) return error.SkipZigTest;

    var x: f16 = 12.34;
    var y: f128 = x;
    try expect(x == y);
}

test "cast small unsigned to larger signed" {
    try expect(castSmallUnsignedToLargerSigned1(200) == @as(i16, 200));
    try expect(castSmallUnsignedToLargerSigned2(9999) == @as(i64, 9999));
}
fn castSmallUnsignedToLargerSigned1(x: u8) i16 {
    return x;
}
fn castSmallUnsignedToLargerSigned2(x: u16) i64 {
    return x;
}
