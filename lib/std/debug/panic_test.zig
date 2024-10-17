const runTest = @import("Panic.zig").testWriterFunction;
test {
    try runTest(49,
        \\attempted to discard error: 'ErrorA': catch_extra
    , "writeUnwrappedErrorExtra", .{ "ErrorA", "catch_extra" });
    try runTest(36,
        \\attempted to discard error: 'ErrorA'
    , "writeUnwrappedError", .{"ErrorA"});
    try runTest(50,
        \\attempted to discard error: 'ErrorA': switch_extra
    , "writeUnwrappedErrorExtra", .{ "ErrorA", "switch_extra" });
    try runTest(36,
        \\attempted to discard error: 'ErrorA'
    , "writeUnwrappedError", .{"ErrorA"});
    try runTest(63,
        \\cast to 'u1' from 'u2' truncated bits: 3 above 'u1' maximum (1)
    , "writeScalarCastTruncatedData", .{ u64, "u1", u64, "u2", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, @as(u64, 3) });
    try runTest(167,
        \\cast to 'u1' from 'u2' truncated bits: element(s) below minimum (0) or above maximum (1):
        \\                [0]    3 above maximum
        \\                [1]    3 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u1", u64, "u2", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, &.{ @as(u64, 3), @as(u64, 3) } });
    try runTest(65,
        \\cast to 'u1' from 'u8' truncated bits: 255 above 'u1' maximum (1)
    , "writeScalarCastTruncatedData", .{ u64, "u1", u64, "u8", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, @as(u64, 255) });
    try runTest(171,
        \\cast to 'u1' from 'u8' truncated bits: element(s) below minimum (0) or above maximum (1):
        \\                [0]    255 above maximum
        \\                [1]    255 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u1", u64, "u8", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, &.{ @as(u64, 255), @as(u64, 255) } });
    try runTest(67,
        \\cast to 'u1' from 'u12' truncated bits: 4095 above 'u1' maximum (1)
    , "writeScalarCastTruncatedData", .{ u64, "u1", u64, "u12", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, @as(u64, 4095) });
    try runTest(174,
        \\cast to 'u1' from 'u12' truncated bits: element(s) below minimum (0) or above maximum (1):
        \\                [0]    4095 above maximum
        \\                [1]    4095 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u1", u64, "u12", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, &.{ @as(u64, 4095), @as(u64, 4095) } });
    try runTest(68,
        \\cast to 'u1' from 'u16' truncated bits: 65535 above 'u1' maximum (1)
    , "writeScalarCastTruncatedData", .{ u64, "u1", u64, "u16", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, @as(u64, 65535) });
    try runTest(176,
        \\cast to 'u1' from 'u16' truncated bits: element(s) below minimum (0) or above maximum (1):
        \\                [0]    65535 above maximum
        \\                [1]    65535 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u1", u64, "u16", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, &.{ @as(u64, 65535), @as(u64, 65535) } });
    try runTest(71,
        \\cast to 'u1' from 'u24' truncated bits: 16777215 above 'u1' maximum (1)
    , "writeScalarCastTruncatedData", .{ u64, "u1", u64, "u24", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, @as(u64, 16777215) });
    try runTest(182,
        \\cast to 'u1' from 'u24' truncated bits: element(s) below minimum (0) or above maximum (1):
        \\                [0]    16777215 above maximum
        \\                [1]    16777215 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u1", u64, "u24", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, &.{ @as(u64, 16777215), @as(u64, 16777215) } });
    try runTest(73,
        \\cast to 'u1' from 'u32' truncated bits: 4294967295 above 'u1' maximum (1)
    , "writeScalarCastTruncatedData", .{ u64, "u1", u64, "u32", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, @as(u64, 4294967295) });
    try runTest(186,
        \\cast to 'u1' from 'u32' truncated bits: element(s) below minimum (0) or above maximum (1):
        \\                [0]    4294967295 above maximum
        \\                [1]    4294967295 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u1", u64, "u32", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, &.{ @as(u64, 4294967295), @as(u64, 4294967295) } });
    try runTest(78,
        \\cast to 'u1' from 'u48' truncated bits: 281474976710655 above 'u1' maximum (1)
    , "writeScalarCastTruncatedData", .{ u64, "u1", u64, "u48", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, @as(u64, 281474976710655) });
    try runTest(196,
        \\cast to 'u1' from 'u48' truncated bits: element(s) below minimum (0) or above maximum (1):
        \\                [0]    281474976710655 above maximum
        \\                [1]    281474976710655 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u1", u64, "u48", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, &.{ @as(u64, 281474976710655), @as(u64, 281474976710655) } });
    try runTest(83,
        \\cast to 'u1' from 'u64' truncated bits: 18446744073709551615 above 'u1' maximum (1)
    , "writeScalarCastTruncatedData", .{ u64, "u1", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, ~@as(u64, 0) });
    try runTest(206,
        \\cast to 'u1' from 'u64' truncated bits: element(s) below minimum (0) or above maximum (1):
        \\                [0]    18446744073709551615 above maximum
        \\                [1]    18446744073709551615 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u1", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, &.{ ~@as(u64, 0), ~@as(u64, 0) } });
    try runTest(83,
        \\cast to 'u1' from 'u64' truncated bits: 18446744073709551615 above 'u1' maximum (1)
    , "writeScalarCastTruncatedData", .{ u64, "u1", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, ~@as(u64, 0) });
    try runTest(206,
        \\cast to 'u1' from 'u64' truncated bits: element(s) below minimum (0) or above maximum (1):
        \\                [0]    18446744073709551615 above maximum
        \\                [1]    18446744073709551615 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u1", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, &.{ ~@as(u64, 0), ~@as(u64, 0) } });
    try runTest(64,
        \\cast to 'u1' from 'i2' truncated bits: -2 below 'u1' minimum (0)
    , "writeScalarCastTruncatedData", .{ u64, "u1", i64, "i2", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, -%@as(i64, 2) });
    try runTest(169,
        \\cast to 'u1' from 'i2' truncated bits: element(s) below minimum (0) or above maximum (1):
        \\                [0]    -2 below minimum
        \\                [1]    -2 below minimum
    , "writeVectorCastTruncatedData", .{ u64, "u1", i64, "i2", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, &.{ -%@as(i64, 2), -%@as(i64, 2) } });
    try runTest(65,
        \\cast to 'u1' from 'i8' truncated bits: 127 above 'u1' maximum (1)
    , "writeScalarCastTruncatedData", .{ u64, "u1", i64, "i8", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, @as(i64, 127) });
    try runTest(171,
        \\cast to 'u1' from 'i8' truncated bits: element(s) below minimum (0) or above maximum (1):
        \\                [0]    127 above maximum
        \\                [1]    127 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u1", i64, "i8", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, &.{ @as(i64, 127), @as(i64, 127) } });
    try runTest(67,
        \\cast to 'u1' from 'i12' truncated bits: 2047 above 'u1' maximum (1)
    , "writeScalarCastTruncatedData", .{ u64, "u1", i64, "i12", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, @as(i64, 2047) });
    try runTest(174,
        \\cast to 'u1' from 'i12' truncated bits: element(s) below minimum (0) or above maximum (1):
        \\                [0]    2047 above maximum
        \\                [1]    2047 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u1", i64, "i12", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, &.{ @as(i64, 2047), @as(i64, 2047) } });
    try runTest(68,
        \\cast to 'u1' from 'i16' truncated bits: 32767 above 'u1' maximum (1)
    , "writeScalarCastTruncatedData", .{ u64, "u1", i64, "i16", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, @as(i64, 32767) });
    try runTest(176,
        \\cast to 'u1' from 'i16' truncated bits: element(s) below minimum (0) or above maximum (1):
        \\                [0]    32767 above maximum
        \\                [1]    32767 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u1", i64, "i16", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, &.{ @as(i64, 32767), @as(i64, 32767) } });
    try runTest(70,
        \\cast to 'u1' from 'i24' truncated bits: 8388607 above 'u1' maximum (1)
    , "writeScalarCastTruncatedData", .{ u64, "u1", i64, "i24", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, @as(i64, 8388607) });
    try runTest(180,
        \\cast to 'u1' from 'i24' truncated bits: element(s) below minimum (0) or above maximum (1):
        \\                [0]    8388607 above maximum
        \\                [1]    8388607 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u1", i64, "i24", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, &.{ @as(i64, 8388607), @as(i64, 8388607) } });
    try runTest(73,
        \\cast to 'u1' from 'i32' truncated bits: 2147483647 above 'u1' maximum (1)
    , "writeScalarCastTruncatedData", .{ u64, "u1", i64, "i32", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, @as(i64, 2147483647) });
    try runTest(186,
        \\cast to 'u1' from 'i32' truncated bits: element(s) below minimum (0) or above maximum (1):
        \\                [0]    2147483647 above maximum
        \\                [1]    2147483647 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u1", i64, "i32", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, &.{ @as(i64, 2147483647), @as(i64, 2147483647) } });
    try runTest(78,
        \\cast to 'u1' from 'i48' truncated bits: 140737488355327 above 'u1' maximum (1)
    , "writeScalarCastTruncatedData", .{ u64, "u1", i64, "i48", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, @as(i64, 140737488355327) });
    try runTest(196,
        \\cast to 'u1' from 'i48' truncated bits: element(s) below minimum (0) or above maximum (1):
        \\                [0]    140737488355327 above maximum
        \\                [1]    140737488355327 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u1", i64, "i48", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, &.{ @as(i64, 140737488355327), @as(i64, 140737488355327) } });
    try runTest(82,
        \\cast to 'u1' from 'i64' truncated bits: 9223372036854775807 above 'u1' maximum (1)
    , "writeScalarCastTruncatedData", .{ u64, "u1", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, @as(i64, 9223372036854775807) });
    try runTest(204,
        \\cast to 'u1' from 'i64' truncated bits: element(s) below minimum (0) or above maximum (1):
        \\                [0]    9223372036854775807 above maximum
        \\                [1]    9223372036854775807 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u1", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, &.{ @as(i64, 9223372036854775807), @as(i64, 9223372036854775807) } });
    try runTest(82,
        \\cast to 'u1' from 'i64' truncated bits: 9223372036854775807 above 'u1' maximum (1)
    , "writeScalarCastTruncatedData", .{ u64, "u1", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, @as(i64, 9223372036854775807) });
    try runTest(204,
        \\cast to 'u1' from 'i64' truncated bits: element(s) below minimum (0) or above maximum (1):
        \\                [0]    9223372036854775807 above maximum
        \\                [1]    9223372036854775807 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u1", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 1) }, &.{ @as(i64, 9223372036854775807), @as(i64, 9223372036854775807) } });
    try runTest(65,
        \\cast to 'u2' from 'u8' truncated bits: 255 above 'u2' maximum (3)
    , "writeScalarCastTruncatedData", .{ u64, "u2", u64, "u8", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, @as(u64, 255) });
    try runTest(171,
        \\cast to 'u2' from 'u8' truncated bits: element(s) below minimum (0) or above maximum (3):
        \\                [0]    255 above maximum
        \\                [1]    255 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u2", u64, "u8", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, &.{ @as(u64, 255), @as(u64, 255) } });
    try runTest(67,
        \\cast to 'u2' from 'u12' truncated bits: 4095 above 'u2' maximum (3)
    , "writeScalarCastTruncatedData", .{ u64, "u2", u64, "u12", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, @as(u64, 4095) });
    try runTest(174,
        \\cast to 'u2' from 'u12' truncated bits: element(s) below minimum (0) or above maximum (3):
        \\                [0]    4095 above maximum
        \\                [1]    4095 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u2", u64, "u12", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, &.{ @as(u64, 4095), @as(u64, 4095) } });
    try runTest(68,
        \\cast to 'u2' from 'u16' truncated bits: 65535 above 'u2' maximum (3)
    , "writeScalarCastTruncatedData", .{ u64, "u2", u64, "u16", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, @as(u64, 65535) });
    try runTest(176,
        \\cast to 'u2' from 'u16' truncated bits: element(s) below minimum (0) or above maximum (3):
        \\                [0]    65535 above maximum
        \\                [1]    65535 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u2", u64, "u16", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, &.{ @as(u64, 65535), @as(u64, 65535) } });
    try runTest(71,
        \\cast to 'u2' from 'u24' truncated bits: 16777215 above 'u2' maximum (3)
    , "writeScalarCastTruncatedData", .{ u64, "u2", u64, "u24", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, @as(u64, 16777215) });
    try runTest(182,
        \\cast to 'u2' from 'u24' truncated bits: element(s) below minimum (0) or above maximum (3):
        \\                [0]    16777215 above maximum
        \\                [1]    16777215 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u2", u64, "u24", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, &.{ @as(u64, 16777215), @as(u64, 16777215) } });
    try runTest(73,
        \\cast to 'u2' from 'u32' truncated bits: 4294967295 above 'u2' maximum (3)
    , "writeScalarCastTruncatedData", .{ u64, "u2", u64, "u32", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, @as(u64, 4294967295) });
    try runTest(186,
        \\cast to 'u2' from 'u32' truncated bits: element(s) below minimum (0) or above maximum (3):
        \\                [0]    4294967295 above maximum
        \\                [1]    4294967295 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u2", u64, "u32", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, &.{ @as(u64, 4294967295), @as(u64, 4294967295) } });
    try runTest(78,
        \\cast to 'u2' from 'u48' truncated bits: 281474976710655 above 'u2' maximum (3)
    , "writeScalarCastTruncatedData", .{ u64, "u2", u64, "u48", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, @as(u64, 281474976710655) });
    try runTest(196,
        \\cast to 'u2' from 'u48' truncated bits: element(s) below minimum (0) or above maximum (3):
        \\                [0]    281474976710655 above maximum
        \\                [1]    281474976710655 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u2", u64, "u48", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, &.{ @as(u64, 281474976710655), @as(u64, 281474976710655) } });
    try runTest(83,
        \\cast to 'u2' from 'u64' truncated bits: 18446744073709551615 above 'u2' maximum (3)
    , "writeScalarCastTruncatedData", .{ u64, "u2", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, ~@as(u64, 0) });
    try runTest(206,
        \\cast to 'u2' from 'u64' truncated bits: element(s) below minimum (0) or above maximum (3):
        \\                [0]    18446744073709551615 above maximum
        \\                [1]    18446744073709551615 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u2", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, &.{ ~@as(u64, 0), ~@as(u64, 0) } });
    try runTest(83,
        \\cast to 'u2' from 'u64' truncated bits: 18446744073709551615 above 'u2' maximum (3)
    , "writeScalarCastTruncatedData", .{ u64, "u2", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, ~@as(u64, 0) });
    try runTest(206,
        \\cast to 'u2' from 'u64' truncated bits: element(s) below minimum (0) or above maximum (3):
        \\                [0]    18446744073709551615 above maximum
        \\                [1]    18446744073709551615 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u2", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, &.{ ~@as(u64, 0), ~@as(u64, 0) } });
    try runTest(65,
        \\cast to 'u2' from 'i8' truncated bits: 127 above 'u2' maximum (3)
    , "writeScalarCastTruncatedData", .{ u64, "u2", i64, "i8", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, @as(i64, 127) });
    try runTest(171,
        \\cast to 'u2' from 'i8' truncated bits: element(s) below minimum (0) or above maximum (3):
        \\                [0]    127 above maximum
        \\                [1]    127 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u2", i64, "i8", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, &.{ @as(i64, 127), @as(i64, 127) } });
    try runTest(67,
        \\cast to 'u2' from 'i12' truncated bits: 2047 above 'u2' maximum (3)
    , "writeScalarCastTruncatedData", .{ u64, "u2", i64, "i12", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, @as(i64, 2047) });
    try runTest(174,
        \\cast to 'u2' from 'i12' truncated bits: element(s) below minimum (0) or above maximum (3):
        \\                [0]    2047 above maximum
        \\                [1]    2047 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u2", i64, "i12", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, &.{ @as(i64, 2047), @as(i64, 2047) } });
    try runTest(68,
        \\cast to 'u2' from 'i16' truncated bits: 32767 above 'u2' maximum (3)
    , "writeScalarCastTruncatedData", .{ u64, "u2", i64, "i16", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, @as(i64, 32767) });
    try runTest(176,
        \\cast to 'u2' from 'i16' truncated bits: element(s) below minimum (0) or above maximum (3):
        \\                [0]    32767 above maximum
        \\                [1]    32767 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u2", i64, "i16", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, &.{ @as(i64, 32767), @as(i64, 32767) } });
    try runTest(70,
        \\cast to 'u2' from 'i24' truncated bits: 8388607 above 'u2' maximum (3)
    , "writeScalarCastTruncatedData", .{ u64, "u2", i64, "i24", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, @as(i64, 8388607) });
    try runTest(180,
        \\cast to 'u2' from 'i24' truncated bits: element(s) below minimum (0) or above maximum (3):
        \\                [0]    8388607 above maximum
        \\                [1]    8388607 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u2", i64, "i24", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, &.{ @as(i64, 8388607), @as(i64, 8388607) } });
    try runTest(73,
        \\cast to 'u2' from 'i32' truncated bits: 2147483647 above 'u2' maximum (3)
    , "writeScalarCastTruncatedData", .{ u64, "u2", i64, "i32", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, @as(i64, 2147483647) });
    try runTest(186,
        \\cast to 'u2' from 'i32' truncated bits: element(s) below minimum (0) or above maximum (3):
        \\                [0]    2147483647 above maximum
        \\                [1]    2147483647 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u2", i64, "i32", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, &.{ @as(i64, 2147483647), @as(i64, 2147483647) } });
    try runTest(78,
        \\cast to 'u2' from 'i48' truncated bits: 140737488355327 above 'u2' maximum (3)
    , "writeScalarCastTruncatedData", .{ u64, "u2", i64, "i48", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, @as(i64, 140737488355327) });
    try runTest(196,
        \\cast to 'u2' from 'i48' truncated bits: element(s) below minimum (0) or above maximum (3):
        \\                [0]    140737488355327 above maximum
        \\                [1]    140737488355327 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u2", i64, "i48", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, &.{ @as(i64, 140737488355327), @as(i64, 140737488355327) } });
    try runTest(82,
        \\cast to 'u2' from 'i64' truncated bits: 9223372036854775807 above 'u2' maximum (3)
    , "writeScalarCastTruncatedData", .{ u64, "u2", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, @as(i64, 9223372036854775807) });
    try runTest(204,
        \\cast to 'u2' from 'i64' truncated bits: element(s) below minimum (0) or above maximum (3):
        \\                [0]    9223372036854775807 above maximum
        \\                [1]    9223372036854775807 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u2", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, &.{ @as(i64, 9223372036854775807), @as(i64, 9223372036854775807) } });
    try runTest(82,
        \\cast to 'u2' from 'i64' truncated bits: 9223372036854775807 above 'u2' maximum (3)
    , "writeScalarCastTruncatedData", .{ u64, "u2", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, @as(i64, 9223372036854775807) });
    try runTest(204,
        \\cast to 'u2' from 'i64' truncated bits: element(s) below minimum (0) or above maximum (3):
        \\                [0]    9223372036854775807 above maximum
        \\                [1]    9223372036854775807 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u2", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 3) }, &.{ @as(i64, 9223372036854775807), @as(i64, 9223372036854775807) } });
    try runTest(69,
        \\cast to 'u8' from 'u12' truncated bits: 4095 above 'u8' maximum (255)
    , "writeScalarCastTruncatedData", .{ u64, "u8", u64, "u12", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, @as(u64, 4095) });
    try runTest(176,
        \\cast to 'u8' from 'u12' truncated bits: element(s) below minimum (0) or above maximum (255):
        \\                [0]    4095 above maximum
        \\                [1]    4095 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u8", u64, "u12", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, &.{ @as(u64, 4095), @as(u64, 4095) } });
    try runTest(70,
        \\cast to 'u8' from 'u16' truncated bits: 65535 above 'u8' maximum (255)
    , "writeScalarCastTruncatedData", .{ u64, "u8", u64, "u16", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, @as(u64, 65535) });
    try runTest(178,
        \\cast to 'u8' from 'u16' truncated bits: element(s) below minimum (0) or above maximum (255):
        \\                [0]    65535 above maximum
        \\                [1]    65535 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u8", u64, "u16", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, &.{ @as(u64, 65535), @as(u64, 65535) } });
    try runTest(73,
        \\cast to 'u8' from 'u24' truncated bits: 16777215 above 'u8' maximum (255)
    , "writeScalarCastTruncatedData", .{ u64, "u8", u64, "u24", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, @as(u64, 16777215) });
    try runTest(184,
        \\cast to 'u8' from 'u24' truncated bits: element(s) below minimum (0) or above maximum (255):
        \\                [0]    16777215 above maximum
        \\                [1]    16777215 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u8", u64, "u24", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, &.{ @as(u64, 16777215), @as(u64, 16777215) } });
    try runTest(75,
        \\cast to 'u8' from 'u32' truncated bits: 4294967295 above 'u8' maximum (255)
    , "writeScalarCastTruncatedData", .{ u64, "u8", u64, "u32", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, @as(u64, 4294967295) });
    try runTest(188,
        \\cast to 'u8' from 'u32' truncated bits: element(s) below minimum (0) or above maximum (255):
        \\                [0]    4294967295 above maximum
        \\                [1]    4294967295 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u8", u64, "u32", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, &.{ @as(u64, 4294967295), @as(u64, 4294967295) } });
    try runTest(80,
        \\cast to 'u8' from 'u48' truncated bits: 281474976710655 above 'u8' maximum (255)
    , "writeScalarCastTruncatedData", .{ u64, "u8", u64, "u48", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, @as(u64, 281474976710655) });
    try runTest(198,
        \\cast to 'u8' from 'u48' truncated bits: element(s) below minimum (0) or above maximum (255):
        \\                [0]    281474976710655 above maximum
        \\                [1]    281474976710655 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u8", u64, "u48", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, &.{ @as(u64, 281474976710655), @as(u64, 281474976710655) } });
    try runTest(85,
        \\cast to 'u8' from 'u64' truncated bits: 18446744073709551615 above 'u8' maximum (255)
    , "writeScalarCastTruncatedData", .{ u64, "u8", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, ~@as(u64, 0) });
    try runTest(208,
        \\cast to 'u8' from 'u64' truncated bits: element(s) below minimum (0) or above maximum (255):
        \\                [0]    18446744073709551615 above maximum
        \\                [1]    18446744073709551615 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u8", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, &.{ ~@as(u64, 0), ~@as(u64, 0) } });
    try runTest(85,
        \\cast to 'u8' from 'u64' truncated bits: 18446744073709551615 above 'u8' maximum (255)
    , "writeScalarCastTruncatedData", .{ u64, "u8", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, ~@as(u64, 0) });
    try runTest(208,
        \\cast to 'u8' from 'u64' truncated bits: element(s) below minimum (0) or above maximum (255):
        \\                [0]    18446744073709551615 above maximum
        \\                [1]    18446744073709551615 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u8", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, &.{ ~@as(u64, 0), ~@as(u64, 0) } });
    try runTest(69,
        \\cast to 'u8' from 'i12' truncated bits: 2047 above 'u8' maximum (255)
    , "writeScalarCastTruncatedData", .{ u64, "u8", i64, "i12", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, @as(i64, 2047) });
    try runTest(176,
        \\cast to 'u8' from 'i12' truncated bits: element(s) below minimum (0) or above maximum (255):
        \\                [0]    2047 above maximum
        \\                [1]    2047 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u8", i64, "i12", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, &.{ @as(i64, 2047), @as(i64, 2047) } });
    try runTest(70,
        \\cast to 'u8' from 'i16' truncated bits: 32767 above 'u8' maximum (255)
    , "writeScalarCastTruncatedData", .{ u64, "u8", i64, "i16", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, @as(i64, 32767) });
    try runTest(178,
        \\cast to 'u8' from 'i16' truncated bits: element(s) below minimum (0) or above maximum (255):
        \\                [0]    32767 above maximum
        \\                [1]    32767 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u8", i64, "i16", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, &.{ @as(i64, 32767), @as(i64, 32767) } });
    try runTest(72,
        \\cast to 'u8' from 'i24' truncated bits: 8388607 above 'u8' maximum (255)
    , "writeScalarCastTruncatedData", .{ u64, "u8", i64, "i24", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, @as(i64, 8388607) });
    try runTest(182,
        \\cast to 'u8' from 'i24' truncated bits: element(s) below minimum (0) or above maximum (255):
        \\                [0]    8388607 above maximum
        \\                [1]    8388607 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u8", i64, "i24", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, &.{ @as(i64, 8388607), @as(i64, 8388607) } });
    try runTest(75,
        \\cast to 'u8' from 'i32' truncated bits: 2147483647 above 'u8' maximum (255)
    , "writeScalarCastTruncatedData", .{ u64, "u8", i64, "i32", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, @as(i64, 2147483647) });
    try runTest(188,
        \\cast to 'u8' from 'i32' truncated bits: element(s) below minimum (0) or above maximum (255):
        \\                [0]    2147483647 above maximum
        \\                [1]    2147483647 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u8", i64, "i32", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, &.{ @as(i64, 2147483647), @as(i64, 2147483647) } });
    try runTest(80,
        \\cast to 'u8' from 'i48' truncated bits: 140737488355327 above 'u8' maximum (255)
    , "writeScalarCastTruncatedData", .{ u64, "u8", i64, "i48", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, @as(i64, 140737488355327) });
    try runTest(198,
        \\cast to 'u8' from 'i48' truncated bits: element(s) below minimum (0) or above maximum (255):
        \\                [0]    140737488355327 above maximum
        \\                [1]    140737488355327 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u8", i64, "i48", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, &.{ @as(i64, 140737488355327), @as(i64, 140737488355327) } });
    try runTest(84,
        \\cast to 'u8' from 'i64' truncated bits: 9223372036854775807 above 'u8' maximum (255)
    , "writeScalarCastTruncatedData", .{ u64, "u8", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, @as(i64, 9223372036854775807) });
    try runTest(206,
        \\cast to 'u8' from 'i64' truncated bits: element(s) below minimum (0) or above maximum (255):
        \\                [0]    9223372036854775807 above maximum
        \\                [1]    9223372036854775807 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u8", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, &.{ @as(i64, 9223372036854775807), @as(i64, 9223372036854775807) } });
    try runTest(84,
        \\cast to 'u8' from 'i64' truncated bits: 9223372036854775807 above 'u8' maximum (255)
    , "writeScalarCastTruncatedData", .{ u64, "u8", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, @as(i64, 9223372036854775807) });
    try runTest(206,
        \\cast to 'u8' from 'i64' truncated bits: element(s) below minimum (0) or above maximum (255):
        \\                [0]    9223372036854775807 above maximum
        \\                [1]    9223372036854775807 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u8", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 255) }, &.{ @as(i64, 9223372036854775807), @as(i64, 9223372036854775807) } });
    try runTest(73,
        \\cast to 'u12' from 'u16' truncated bits: 65535 above 'u12' maximum (4095)
    , "writeScalarCastTruncatedData", .{ u64, "u12", u64, "u16", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, @as(u64, 65535) });
    try runTest(180,
        \\cast to 'u12' from 'u16' truncated bits: element(s) below minimum (0) or above maximum (4095):
        \\                [0]    65535 above maximum
        \\                [1]    65535 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u12", u64, "u16", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, &.{ @as(u64, 65535), @as(u64, 65535) } });
    try runTest(76,
        \\cast to 'u12' from 'u24' truncated bits: 16777215 above 'u12' maximum (4095)
    , "writeScalarCastTruncatedData", .{ u64, "u12", u64, "u24", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, @as(u64, 16777215) });
    try runTest(186,
        \\cast to 'u12' from 'u24' truncated bits: element(s) below minimum (0) or above maximum (4095):
        \\                [0]    16777215 above maximum
        \\                [1]    16777215 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u12", u64, "u24", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, &.{ @as(u64, 16777215), @as(u64, 16777215) } });
    try runTest(78,
        \\cast to 'u12' from 'u32' truncated bits: 4294967295 above 'u12' maximum (4095)
    , "writeScalarCastTruncatedData", .{ u64, "u12", u64, "u32", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, @as(u64, 4294967295) });
    try runTest(190,
        \\cast to 'u12' from 'u32' truncated bits: element(s) below minimum (0) or above maximum (4095):
        \\                [0]    4294967295 above maximum
        \\                [1]    4294967295 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u12", u64, "u32", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, &.{ @as(u64, 4294967295), @as(u64, 4294967295) } });
    try runTest(83,
        \\cast to 'u12' from 'u48' truncated bits: 281474976710655 above 'u12' maximum (4095)
    , "writeScalarCastTruncatedData", .{ u64, "u12", u64, "u48", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, @as(u64, 281474976710655) });
    try runTest(200,
        \\cast to 'u12' from 'u48' truncated bits: element(s) below minimum (0) or above maximum (4095):
        \\                [0]    281474976710655 above maximum
        \\                [1]    281474976710655 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u12", u64, "u48", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, &.{ @as(u64, 281474976710655), @as(u64, 281474976710655) } });
    try runTest(88,
        \\cast to 'u12' from 'u64' truncated bits: 18446744073709551615 above 'u12' maximum (4095)
    , "writeScalarCastTruncatedData", .{ u64, "u12", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, ~@as(u64, 0) });
    try runTest(210,
        \\cast to 'u12' from 'u64' truncated bits: element(s) below minimum (0) or above maximum (4095):
        \\                [0]    18446744073709551615 above maximum
        \\                [1]    18446744073709551615 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u12", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, &.{ ~@as(u64, 0), ~@as(u64, 0) } });
    try runTest(88,
        \\cast to 'u12' from 'u64' truncated bits: 18446744073709551615 above 'u12' maximum (4095)
    , "writeScalarCastTruncatedData", .{ u64, "u12", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, ~@as(u64, 0) });
    try runTest(210,
        \\cast to 'u12' from 'u64' truncated bits: element(s) below minimum (0) or above maximum (4095):
        \\                [0]    18446744073709551615 above maximum
        \\                [1]    18446744073709551615 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u12", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, &.{ ~@as(u64, 0), ~@as(u64, 0) } });
    try runTest(73,
        \\cast to 'u12' from 'i16' truncated bits: 32767 above 'u12' maximum (4095)
    , "writeScalarCastTruncatedData", .{ u64, "u12", i64, "i16", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, @as(i64, 32767) });
    try runTest(180,
        \\cast to 'u12' from 'i16' truncated bits: element(s) below minimum (0) or above maximum (4095):
        \\                [0]    32767 above maximum
        \\                [1]    32767 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u12", i64, "i16", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, &.{ @as(i64, 32767), @as(i64, 32767) } });
    try runTest(75,
        \\cast to 'u12' from 'i24' truncated bits: 8388607 above 'u12' maximum (4095)
    , "writeScalarCastTruncatedData", .{ u64, "u12", i64, "i24", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, @as(i64, 8388607) });
    try runTest(184,
        \\cast to 'u12' from 'i24' truncated bits: element(s) below minimum (0) or above maximum (4095):
        \\                [0]    8388607 above maximum
        \\                [1]    8388607 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u12", i64, "i24", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, &.{ @as(i64, 8388607), @as(i64, 8388607) } });
    try runTest(78,
        \\cast to 'u12' from 'i32' truncated bits: 2147483647 above 'u12' maximum (4095)
    , "writeScalarCastTruncatedData", .{ u64, "u12", i64, "i32", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, @as(i64, 2147483647) });
    try runTest(190,
        \\cast to 'u12' from 'i32' truncated bits: element(s) below minimum (0) or above maximum (4095):
        \\                [0]    2147483647 above maximum
        \\                [1]    2147483647 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u12", i64, "i32", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, &.{ @as(i64, 2147483647), @as(i64, 2147483647) } });
    try runTest(83,
        \\cast to 'u12' from 'i48' truncated bits: 140737488355327 above 'u12' maximum (4095)
    , "writeScalarCastTruncatedData", .{ u64, "u12", i64, "i48", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, @as(i64, 140737488355327) });
    try runTest(200,
        \\cast to 'u12' from 'i48' truncated bits: element(s) below minimum (0) or above maximum (4095):
        \\                [0]    140737488355327 above maximum
        \\                [1]    140737488355327 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u12", i64, "i48", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, &.{ @as(i64, 140737488355327), @as(i64, 140737488355327) } });
    try runTest(87,
        \\cast to 'u12' from 'i64' truncated bits: 9223372036854775807 above 'u12' maximum (4095)
    , "writeScalarCastTruncatedData", .{ u64, "u12", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, @as(i64, 9223372036854775807) });
    try runTest(208,
        \\cast to 'u12' from 'i64' truncated bits: element(s) below minimum (0) or above maximum (4095):
        \\                [0]    9223372036854775807 above maximum
        \\                [1]    9223372036854775807 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u12", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, &.{ @as(i64, 9223372036854775807), @as(i64, 9223372036854775807) } });
    try runTest(87,
        \\cast to 'u12' from 'i64' truncated bits: 9223372036854775807 above 'u12' maximum (4095)
    , "writeScalarCastTruncatedData", .{ u64, "u12", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, @as(i64, 9223372036854775807) });
    try runTest(208,
        \\cast to 'u12' from 'i64' truncated bits: element(s) below minimum (0) or above maximum (4095):
        \\                [0]    9223372036854775807 above maximum
        \\                [1]    9223372036854775807 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u12", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 4095) }, &.{ @as(i64, 9223372036854775807), @as(i64, 9223372036854775807) } });
    try runTest(77,
        \\cast to 'u16' from 'u24' truncated bits: 16777215 above 'u16' maximum (65535)
    , "writeScalarCastTruncatedData", .{ u64, "u16", u64, "u24", .{ .min = @as(u64, 0), .max = @as(u64, 65535) }, @as(u64, 16777215) });
    try runTest(187,
        \\cast to 'u16' from 'u24' truncated bits: element(s) below minimum (0) or above maximum (65535):
        \\                [0]    16777215 above maximum
        \\                [1]    16777215 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u16", u64, "u24", .{ .min = @as(u64, 0), .max = @as(u64, 65535) }, &.{ @as(u64, 16777215), @as(u64, 16777215) } });
    try runTest(79,
        \\cast to 'u16' from 'u32' truncated bits: 4294967295 above 'u16' maximum (65535)
    , "writeScalarCastTruncatedData", .{ u64, "u16", u64, "u32", .{ .min = @as(u64, 0), .max = @as(u64, 65535) }, @as(u64, 4294967295) });
    try runTest(191,
        \\cast to 'u16' from 'u32' truncated bits: element(s) below minimum (0) or above maximum (65535):
        \\                [0]    4294967295 above maximum
        \\                [1]    4294967295 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u16", u64, "u32", .{ .min = @as(u64, 0), .max = @as(u64, 65535) }, &.{ @as(u64, 4294967295), @as(u64, 4294967295) } });
    try runTest(84,
        \\cast to 'u16' from 'u48' truncated bits: 281474976710655 above 'u16' maximum (65535)
    , "writeScalarCastTruncatedData", .{ u64, "u16", u64, "u48", .{ .min = @as(u64, 0), .max = @as(u64, 65535) }, @as(u64, 281474976710655) });
    try runTest(201,
        \\cast to 'u16' from 'u48' truncated bits: element(s) below minimum (0) or above maximum (65535):
        \\                [0]    281474976710655 above maximum
        \\                [1]    281474976710655 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u16", u64, "u48", .{ .min = @as(u64, 0), .max = @as(u64, 65535) }, &.{ @as(u64, 281474976710655), @as(u64, 281474976710655) } });
    try runTest(89,
        \\cast to 'u16' from 'u64' truncated bits: 18446744073709551615 above 'u16' maximum (65535)
    , "writeScalarCastTruncatedData", .{ u64, "u16", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 65535) }, ~@as(u64, 0) });
    try runTest(211,
        \\cast to 'u16' from 'u64' truncated bits: element(s) below minimum (0) or above maximum (65535):
        \\                [0]    18446744073709551615 above maximum
        \\                [1]    18446744073709551615 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u16", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 65535) }, &.{ ~@as(u64, 0), ~@as(u64, 0) } });
    try runTest(89,
        \\cast to 'u16' from 'u64' truncated bits: 18446744073709551615 above 'u16' maximum (65535)
    , "writeScalarCastTruncatedData", .{ u64, "u16", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 65535) }, ~@as(u64, 0) });
    try runTest(211,
        \\cast to 'u16' from 'u64' truncated bits: element(s) below minimum (0) or above maximum (65535):
        \\                [0]    18446744073709551615 above maximum
        \\                [1]    18446744073709551615 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u16", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 65535) }, &.{ ~@as(u64, 0), ~@as(u64, 0) } });
    try runTest(76,
        \\cast to 'u16' from 'i24' truncated bits: 8388607 above 'u16' maximum (65535)
    , "writeScalarCastTruncatedData", .{ u64, "u16", i64, "i24", .{ .min = @as(u64, 0), .max = @as(u64, 65535) }, @as(i64, 8388607) });
    try runTest(185,
        \\cast to 'u16' from 'i24' truncated bits: element(s) below minimum (0) or above maximum (65535):
        \\                [0]    8388607 above maximum
        \\                [1]    8388607 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u16", i64, "i24", .{ .min = @as(u64, 0), .max = @as(u64, 65535) }, &.{ @as(i64, 8388607), @as(i64, 8388607) } });
    try runTest(79,
        \\cast to 'u16' from 'i32' truncated bits: 2147483647 above 'u16' maximum (65535)
    , "writeScalarCastTruncatedData", .{ u64, "u16", i64, "i32", .{ .min = @as(u64, 0), .max = @as(u64, 65535) }, @as(i64, 2147483647) });
    try runTest(191,
        \\cast to 'u16' from 'i32' truncated bits: element(s) below minimum (0) or above maximum (65535):
        \\                [0]    2147483647 above maximum
        \\                [1]    2147483647 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u16", i64, "i32", .{ .min = @as(u64, 0), .max = @as(u64, 65535) }, &.{ @as(i64, 2147483647), @as(i64, 2147483647) } });
    try runTest(84,
        \\cast to 'u16' from 'i48' truncated bits: 140737488355327 above 'u16' maximum (65535)
    , "writeScalarCastTruncatedData", .{ u64, "u16", i64, "i48", .{ .min = @as(u64, 0), .max = @as(u64, 65535) }, @as(i64, 140737488355327) });
    try runTest(201,
        \\cast to 'u16' from 'i48' truncated bits: element(s) below minimum (0) or above maximum (65535):
        \\                [0]    140737488355327 above maximum
        \\                [1]    140737488355327 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u16", i64, "i48", .{ .min = @as(u64, 0), .max = @as(u64, 65535) }, &.{ @as(i64, 140737488355327), @as(i64, 140737488355327) } });
    try runTest(88,
        \\cast to 'u16' from 'i64' truncated bits: 9223372036854775807 above 'u16' maximum (65535)
    , "writeScalarCastTruncatedData", .{ u64, "u16", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 65535) }, @as(i64, 9223372036854775807) });
    try runTest(209,
        \\cast to 'u16' from 'i64' truncated bits: element(s) below minimum (0) or above maximum (65535):
        \\                [0]    9223372036854775807 above maximum
        \\                [1]    9223372036854775807 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u16", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 65535) }, &.{ @as(i64, 9223372036854775807), @as(i64, 9223372036854775807) } });
    try runTest(88,
        \\cast to 'u16' from 'i64' truncated bits: 9223372036854775807 above 'u16' maximum (65535)
    , "writeScalarCastTruncatedData", .{ u64, "u16", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 65535) }, @as(i64, 9223372036854775807) });
    try runTest(209,
        \\cast to 'u16' from 'i64' truncated bits: element(s) below minimum (0) or above maximum (65535):
        \\                [0]    9223372036854775807 above maximum
        \\                [1]    9223372036854775807 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u16", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 65535) }, &.{ @as(i64, 9223372036854775807), @as(i64, 9223372036854775807) } });
    try runTest(82,
        \\cast to 'u24' from 'u32' truncated bits: 4294967295 above 'u24' maximum (16777215)
    , "writeScalarCastTruncatedData", .{ u64, "u24", u64, "u32", .{ .min = @as(u64, 0), .max = @as(u64, 16777215) }, @as(u64, 4294967295) });
    try runTest(194,
        \\cast to 'u24' from 'u32' truncated bits: element(s) below minimum (0) or above maximum (16777215):
        \\                [0]    4294967295 above maximum
        \\                [1]    4294967295 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u24", u64, "u32", .{ .min = @as(u64, 0), .max = @as(u64, 16777215) }, &.{ @as(u64, 4294967295), @as(u64, 4294967295) } });
    try runTest(87,
        \\cast to 'u24' from 'u48' truncated bits: 281474976710655 above 'u24' maximum (16777215)
    , "writeScalarCastTruncatedData", .{ u64, "u24", u64, "u48", .{ .min = @as(u64, 0), .max = @as(u64, 16777215) }, @as(u64, 281474976710655) });
    try runTest(204,
        \\cast to 'u24' from 'u48' truncated bits: element(s) below minimum (0) or above maximum (16777215):
        \\                [0]    281474976710655 above maximum
        \\                [1]    281474976710655 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u24", u64, "u48", .{ .min = @as(u64, 0), .max = @as(u64, 16777215) }, &.{ @as(u64, 281474976710655), @as(u64, 281474976710655) } });
    try runTest(92,
        \\cast to 'u24' from 'u64' truncated bits: 18446744073709551615 above 'u24' maximum (16777215)
    , "writeScalarCastTruncatedData", .{ u64, "u24", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 16777215) }, ~@as(u64, 0) });
    try runTest(214,
        \\cast to 'u24' from 'u64' truncated bits: element(s) below minimum (0) or above maximum (16777215):
        \\                [0]    18446744073709551615 above maximum
        \\                [1]    18446744073709551615 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u24", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 16777215) }, &.{ ~@as(u64, 0), ~@as(u64, 0) } });
    try runTest(92,
        \\cast to 'u24' from 'u64' truncated bits: 18446744073709551615 above 'u24' maximum (16777215)
    , "writeScalarCastTruncatedData", .{ u64, "u24", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 16777215) }, ~@as(u64, 0) });
    try runTest(214,
        \\cast to 'u24' from 'u64' truncated bits: element(s) below minimum (0) or above maximum (16777215):
        \\                [0]    18446744073709551615 above maximum
        \\                [1]    18446744073709551615 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u24", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 16777215) }, &.{ ~@as(u64, 0), ~@as(u64, 0) } });
    try runTest(82,
        \\cast to 'u24' from 'i32' truncated bits: 2147483647 above 'u24' maximum (16777215)
    , "writeScalarCastTruncatedData", .{ u64, "u24", i64, "i32", .{ .min = @as(u64, 0), .max = @as(u64, 16777215) }, @as(i64, 2147483647) });
    try runTest(194,
        \\cast to 'u24' from 'i32' truncated bits: element(s) below minimum (0) or above maximum (16777215):
        \\                [0]    2147483647 above maximum
        \\                [1]    2147483647 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u24", i64, "i32", .{ .min = @as(u64, 0), .max = @as(u64, 16777215) }, &.{ @as(i64, 2147483647), @as(i64, 2147483647) } });
    try runTest(87,
        \\cast to 'u24' from 'i48' truncated bits: 140737488355327 above 'u24' maximum (16777215)
    , "writeScalarCastTruncatedData", .{ u64, "u24", i64, "i48", .{ .min = @as(u64, 0), .max = @as(u64, 16777215) }, @as(i64, 140737488355327) });
    try runTest(204,
        \\cast to 'u24' from 'i48' truncated bits: element(s) below minimum (0) or above maximum (16777215):
        \\                [0]    140737488355327 above maximum
        \\                [1]    140737488355327 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u24", i64, "i48", .{ .min = @as(u64, 0), .max = @as(u64, 16777215) }, &.{ @as(i64, 140737488355327), @as(i64, 140737488355327) } });
    try runTest(91,
        \\cast to 'u24' from 'i64' truncated bits: 9223372036854775807 above 'u24' maximum (16777215)
    , "writeScalarCastTruncatedData", .{ u64, "u24", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 16777215) }, @as(i64, 9223372036854775807) });
    try runTest(212,
        \\cast to 'u24' from 'i64' truncated bits: element(s) below minimum (0) or above maximum (16777215):
        \\                [0]    9223372036854775807 above maximum
        \\                [1]    9223372036854775807 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u24", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 16777215) }, &.{ @as(i64, 9223372036854775807), @as(i64, 9223372036854775807) } });
    try runTest(91,
        \\cast to 'u24' from 'i64' truncated bits: 9223372036854775807 above 'u24' maximum (16777215)
    , "writeScalarCastTruncatedData", .{ u64, "u24", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 16777215) }, @as(i64, 9223372036854775807) });
    try runTest(212,
        \\cast to 'u24' from 'i64' truncated bits: element(s) below minimum (0) or above maximum (16777215):
        \\                [0]    9223372036854775807 above maximum
        \\                [1]    9223372036854775807 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u24", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 16777215) }, &.{ @as(i64, 9223372036854775807), @as(i64, 9223372036854775807) } });
    try runTest(89,
        \\cast to 'u32' from 'u48' truncated bits: 281474976710655 above 'u32' maximum (4294967295)
    , "writeScalarCastTruncatedData", .{ u64, "u32", u64, "u48", .{ .min = @as(u64, 0), .max = @as(u64, 4294967295) }, @as(u64, 281474976710655) });
    try runTest(206,
        \\cast to 'u32' from 'u48' truncated bits: element(s) below minimum (0) or above maximum (4294967295):
        \\                [0]    281474976710655 above maximum
        \\                [1]    281474976710655 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u32", u64, "u48", .{ .min = @as(u64, 0), .max = @as(u64, 4294967295) }, &.{ @as(u64, 281474976710655), @as(u64, 281474976710655) } });
    try runTest(94,
        \\cast to 'u32' from 'u64' truncated bits: 18446744073709551615 above 'u32' maximum (4294967295)
    , "writeScalarCastTruncatedData", .{ u64, "u32", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 4294967295) }, ~@as(u64, 0) });
    try runTest(216,
        \\cast to 'u32' from 'u64' truncated bits: element(s) below minimum (0) or above maximum (4294967295):
        \\                [0]    18446744073709551615 above maximum
        \\                [1]    18446744073709551615 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u32", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 4294967295) }, &.{ ~@as(u64, 0), ~@as(u64, 0) } });
    try runTest(94,
        \\cast to 'u32' from 'u64' truncated bits: 18446744073709551615 above 'u32' maximum (4294967295)
    , "writeScalarCastTruncatedData", .{ u64, "u32", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 4294967295) }, ~@as(u64, 0) });
    try runTest(216,
        \\cast to 'u32' from 'u64' truncated bits: element(s) below minimum (0) or above maximum (4294967295):
        \\                [0]    18446744073709551615 above maximum
        \\                [1]    18446744073709551615 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u32", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 4294967295) }, &.{ ~@as(u64, 0), ~@as(u64, 0) } });
    try runTest(89,
        \\cast to 'u32' from 'i48' truncated bits: 140737488355327 above 'u32' maximum (4294967295)
    , "writeScalarCastTruncatedData", .{ u64, "u32", i64, "i48", .{ .min = @as(u64, 0), .max = @as(u64, 4294967295) }, @as(i64, 140737488355327) });
    try runTest(206,
        \\cast to 'u32' from 'i48' truncated bits: element(s) below minimum (0) or above maximum (4294967295):
        \\                [0]    140737488355327 above maximum
        \\                [1]    140737488355327 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u32", i64, "i48", .{ .min = @as(u64, 0), .max = @as(u64, 4294967295) }, &.{ @as(i64, 140737488355327), @as(i64, 140737488355327) } });
    try runTest(93,
        \\cast to 'u32' from 'i64' truncated bits: 9223372036854775807 above 'u32' maximum (4294967295)
    , "writeScalarCastTruncatedData", .{ u64, "u32", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 4294967295) }, @as(i64, 9223372036854775807) });
    try runTest(214,
        \\cast to 'u32' from 'i64' truncated bits: element(s) below minimum (0) or above maximum (4294967295):
        \\                [0]    9223372036854775807 above maximum
        \\                [1]    9223372036854775807 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u32", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 4294967295) }, &.{ @as(i64, 9223372036854775807), @as(i64, 9223372036854775807) } });
    try runTest(93,
        \\cast to 'u32' from 'i64' truncated bits: 9223372036854775807 above 'u32' maximum (4294967295)
    , "writeScalarCastTruncatedData", .{ u64, "u32", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 4294967295) }, @as(i64, 9223372036854775807) });
    try runTest(214,
        \\cast to 'u32' from 'i64' truncated bits: element(s) below minimum (0) or above maximum (4294967295):
        \\                [0]    9223372036854775807 above maximum
        \\                [1]    9223372036854775807 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u32", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 4294967295) }, &.{ @as(i64, 9223372036854775807), @as(i64, 9223372036854775807) } });
    try runTest(99,
        \\cast to 'u48' from 'u64' truncated bits: 18446744073709551615 above 'u48' maximum (281474976710655)
    , "writeScalarCastTruncatedData", .{ u64, "u48", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 281474976710655) }, ~@as(u64, 0) });
    try runTest(221,
        \\cast to 'u48' from 'u64' truncated bits: element(s) below minimum (0) or above maximum (281474976710655):
        \\                [0]    18446744073709551615 above maximum
        \\                [1]    18446744073709551615 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u48", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 281474976710655) }, &.{ ~@as(u64, 0), ~@as(u64, 0) } });
    try runTest(99,
        \\cast to 'u48' from 'u64' truncated bits: 18446744073709551615 above 'u48' maximum (281474976710655)
    , "writeScalarCastTruncatedData", .{ u64, "u48", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 281474976710655) }, ~@as(u64, 0) });
    try runTest(221,
        \\cast to 'u48' from 'u64' truncated bits: element(s) below minimum (0) or above maximum (281474976710655):
        \\                [0]    18446744073709551615 above maximum
        \\                [1]    18446744073709551615 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u48", u64, "u64", .{ .min = @as(u64, 0), .max = @as(u64, 281474976710655) }, &.{ ~@as(u64, 0), ~@as(u64, 0) } });
    try runTest(98,
        \\cast to 'u48' from 'i64' truncated bits: 9223372036854775807 above 'u48' maximum (281474976710655)
    , "writeScalarCastTruncatedData", .{ u64, "u48", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 281474976710655) }, @as(i64, 9223372036854775807) });
    try runTest(219,
        \\cast to 'u48' from 'i64' truncated bits: element(s) below minimum (0) or above maximum (281474976710655):
        \\                [0]    9223372036854775807 above maximum
        \\                [1]    9223372036854775807 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u48", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 281474976710655) }, &.{ @as(i64, 9223372036854775807), @as(i64, 9223372036854775807) } });
    try runTest(98,
        \\cast to 'u48' from 'i64' truncated bits: 9223372036854775807 above 'u48' maximum (281474976710655)
    , "writeScalarCastTruncatedData", .{ u64, "u48", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 281474976710655) }, @as(i64, 9223372036854775807) });
    try runTest(219,
        \\cast to 'u48' from 'i64' truncated bits: element(s) below minimum (0) or above maximum (281474976710655):
        \\                [0]    9223372036854775807 above maximum
        \\                [1]    9223372036854775807 above maximum
    , "writeVectorCastTruncatedData", .{ u64, "u48", i64, "i64", .{ .min = @as(u64, 0), .max = @as(u64, 281474976710655) }, &.{ @as(i64, 9223372036854775807), @as(i64, 9223372036854775807) } });

    try runTest(57,
        \\exact division with remainder: 3 / 2 (1 with 1 remainder)
    , "writeScalarExactDivisionWithRemainder", .{ u64, @as(u64, 3), @as(u64, 2) });
    try runTest(130,
        \\exact division with remainder:
        \\                [0]    3 / 2 (1 with 1 remainder)
        \\                [1]    3 / 2 (1 with 1 remainder)
    , "writeVectorExactDivisionWithRemainder", .{ u64, &.{ @as(u64, 3), @as(u64, 3) }, &.{ @as(u64, 2), @as(u64, 2) } });
    try runTest(61,
        \\exact division with remainder: 255 / 254 (1 with 1 remainder)
    , "writeScalarExactDivisionWithRemainder", .{ u64, @as(u64, 255), @as(u64, 254) });
    try runTest(138,
        \\exact division with remainder:
        \\                [0]    255 / 254 (1 with 1 remainder)
        \\                [1]    255 / 254 (1 with 1 remainder)
    , "writeVectorExactDivisionWithRemainder", .{ u64, &.{ @as(u64, 255), @as(u64, 255) }, &.{ @as(u64, 254), @as(u64, 254) } });
    try runTest(61,
        \\exact division with remainder: 127 / 126 (1 with 1 remainder)
    , "writeScalarExactDivisionWithRemainder", .{ i64, @as(i64, 127), @as(i64, 126) });
    try runTest(138,
        \\exact division with remainder:
        \\                [0]    127 / 126 (1 with 1 remainder)
        \\                [1]    127 / 126 (1 with 1 remainder)
    , "writeVectorExactDivisionWithRemainder", .{ i64, &.{ @as(i64, 127), @as(i64, 127) }, &.{ @as(i64, 126), @as(i64, 126) } });
    try runTest(63,
        \\exact division with remainder: 4095 / 4094 (1 with 1 remainder)
    , "writeScalarExactDivisionWithRemainder", .{ u64, @as(u64, 4095), @as(u64, 4094) });
    try runTest(142,
        \\exact division with remainder:
        \\                [0]    4095 / 4094 (1 with 1 remainder)
        \\                [1]    4095 / 4094 (1 with 1 remainder)
    , "writeVectorExactDivisionWithRemainder", .{ u64, &.{ @as(u64, 4095), @as(u64, 4095) }, &.{ @as(u64, 4094), @as(u64, 4094) } });
    try runTest(63,
        \\exact division with remainder: 2047 / 2046 (1 with 1 remainder)
    , "writeScalarExactDivisionWithRemainder", .{ i64, @as(i64, 2047), @as(i64, 2046) });
    try runTest(142,
        \\exact division with remainder:
        \\                [0]    2047 / 2046 (1 with 1 remainder)
        \\                [1]    2047 / 2046 (1 with 1 remainder)
    , "writeVectorExactDivisionWithRemainder", .{ i64, &.{ @as(i64, 2047), @as(i64, 2047) }, &.{ @as(i64, 2046), @as(i64, 2046) } });
    try runTest(65,
        \\exact division with remainder: 65535 / 65534 (1 with 1 remainder)
    , "writeScalarExactDivisionWithRemainder", .{ u64, @as(u64, 65535), @as(u64, 65534) });
    try runTest(146,
        \\exact division with remainder:
        \\                [0]    65535 / 65534 (1 with 1 remainder)
        \\                [1]    65535 / 65534 (1 with 1 remainder)
    , "writeVectorExactDivisionWithRemainder", .{ u64, &.{ @as(u64, 65535), @as(u64, 65535) }, &.{ @as(u64, 65534), @as(u64, 65534) } });
    try runTest(65,
        \\exact division with remainder: 32767 / 32766 (1 with 1 remainder)
    , "writeScalarExactDivisionWithRemainder", .{ i64, @as(i64, 32767), @as(i64, 32766) });
    try runTest(146,
        \\exact division with remainder:
        \\                [0]    32767 / 32766 (1 with 1 remainder)
        \\                [1]    32767 / 32766 (1 with 1 remainder)
    , "writeVectorExactDivisionWithRemainder", .{ i64, &.{ @as(i64, 32767), @as(i64, 32767) }, &.{ @as(i64, 32766), @as(i64, 32766) } });
    try runTest(71,
        \\exact division with remainder: 16777215 / 16777214 (1 with 1 remainder)
    , "writeScalarExactDivisionWithRemainder", .{ u64, @as(u64, 16777215), @as(u64, 16777214) });
    try runTest(158,
        \\exact division with remainder:
        \\                [0]    16777215 / 16777214 (1 with 1 remainder)
        \\                [1]    16777215 / 16777214 (1 with 1 remainder)
    , "writeVectorExactDivisionWithRemainder", .{ u64, &.{ @as(u64, 16777215), @as(u64, 16777215) }, &.{ @as(u64, 16777214), @as(u64, 16777214) } });
    try runTest(69,
        \\exact division with remainder: 8388607 / 8388606 (1 with 1 remainder)
    , "writeScalarExactDivisionWithRemainder", .{ i64, @as(i64, 8388607), @as(i64, 8388606) });
    try runTest(154,
        \\exact division with remainder:
        \\                [0]    8388607 / 8388606 (1 with 1 remainder)
        \\                [1]    8388607 / 8388606 (1 with 1 remainder)
    , "writeVectorExactDivisionWithRemainder", .{ i64, &.{ @as(i64, 8388607), @as(i64, 8388607) }, &.{ @as(i64, 8388606), @as(i64, 8388606) } });
    try runTest(75,
        \\exact division with remainder: 4294967295 / 4294967294 (1 with 1 remainder)
    , "writeScalarExactDivisionWithRemainder", .{ u64, @as(u64, 4294967295), @as(u64, 4294967294) });
    try runTest(166,
        \\exact division with remainder:
        \\                [0]    4294967295 / 4294967294 (1 with 1 remainder)
        \\                [1]    4294967295 / 4294967294 (1 with 1 remainder)
    , "writeVectorExactDivisionWithRemainder", .{ u64, &.{ @as(u64, 4294967295), @as(u64, 4294967295) }, &.{ @as(u64, 4294967294), @as(u64, 4294967294) } });
    try runTest(75,
        \\exact division with remainder: 2147483647 / 2147483646 (1 with 1 remainder)
    , "writeScalarExactDivisionWithRemainder", .{ i64, @as(i64, 2147483647), @as(i64, 2147483646) });
    try runTest(166,
        \\exact division with remainder:
        \\                [0]    2147483647 / 2147483646 (1 with 1 remainder)
        \\                [1]    2147483647 / 2147483646 (1 with 1 remainder)
    , "writeVectorExactDivisionWithRemainder", .{ i64, &.{ @as(i64, 2147483647), @as(i64, 2147483647) }, &.{ @as(i64, 2147483646), @as(i64, 2147483646) } });
    try runTest(85,
        \\exact division with remainder: 281474976710655 / 281474976710654 (1 with 1 remainder)
    , "writeScalarExactDivisionWithRemainder", .{ u64, @as(u64, 281474976710655), @as(u64, 281474976710654) });
    try runTest(186,
        \\exact division with remainder:
        \\                [0]    281474976710655 / 281474976710654 (1 with 1 remainder)
        \\                [1]    281474976710655 / 281474976710654 (1 with 1 remainder)
    , "writeVectorExactDivisionWithRemainder", .{ u64, &.{ @as(u64, 281474976710655), @as(u64, 281474976710655) }, &.{ @as(u64, 281474976710654), @as(u64, 281474976710654) } });
    try runTest(85,
        \\exact division with remainder: 140737488355327 / 140737488355326 (1 with 1 remainder)
    , "writeScalarExactDivisionWithRemainder", .{ i64, @as(i64, 140737488355327), @as(i64, 140737488355326) });
    try runTest(186,
        \\exact division with remainder:
        \\                [0]    140737488355327 / 140737488355326 (1 with 1 remainder)
        \\                [1]    140737488355327 / 140737488355326 (1 with 1 remainder)
    , "writeVectorExactDivisionWithRemainder", .{ i64, &.{ @as(i64, 140737488355327), @as(i64, 140737488355327) }, &.{ @as(i64, 140737488355326), @as(i64, 140737488355326) } });
    try runTest(95,
        \\exact division with remainder: 18446744073709551615 / 18446744073709551614 (1 with 1 remainder)
    , "writeScalarExactDivisionWithRemainder", .{ u64, ~@as(u64, 0), ~@as(u64, 1) });
    try runTest(206,
        \\exact division with remainder:
        \\                [0]    18446744073709551615 / 18446744073709551614 (1 with 1 remainder)
        \\                [1]    18446744073709551615 / 18446744073709551614 (1 with 1 remainder)
    , "writeVectorExactDivisionWithRemainder", .{ u64, &.{ ~@as(u64, 0), ~@as(u64, 0) }, &.{ ~@as(u64, 1), ~@as(u64, 1) } });
    try runTest(93,
        \\exact division with remainder: 9223372036854775807 / 9223372036854775806 (1 with 1 remainder)
    , "writeScalarExactDivisionWithRemainder", .{ i64, @as(i64, 9223372036854775807), @as(i64, 9223372036854775806) });
    try runTest(202,
        \\exact division with remainder:
        \\                [0]    9223372036854775807 / 9223372036854775806 (1 with 1 remainder)
        \\                [1]    9223372036854775807 / 9223372036854775806 (1 with 1 remainder)
    , "writeVectorExactDivisionWithRemainder", .{ i64, &.{ @as(i64, 9223372036854775807), @as(i64, 9223372036854775807) }, &.{ @as(i64, 9223372036854775806), @as(i64, 9223372036854775806) } });
    try runTest(95,
        \\exact division with remainder: 18446744073709551615 / 18446744073709551614 (1 with 1 remainder)
    , "writeScalarExactDivisionWithRemainder", .{ u64, ~@as(u64, 0), ~@as(u64, 1) });
    try runTest(206,
        \\exact division with remainder:
        \\                [0]    18446744073709551615 / 18446744073709551614 (1 with 1 remainder)
        \\                [1]    18446744073709551615 / 18446744073709551614 (1 with 1 remainder)
    , "writeVectorExactDivisionWithRemainder", .{ u64, &.{ ~@as(u64, 0), ~@as(u64, 0) }, &.{ ~@as(u64, 1), ~@as(u64, 1) } });
    try runTest(93,
        \\exact division with remainder: 9223372036854775807 / 9223372036854775806 (1 with 1 remainder)
    , "writeScalarExactDivisionWithRemainder", .{ i64, @as(i64, 9223372036854775807), @as(i64, 9223372036854775806) });
    try runTest(202,
        \\exact division with remainder:
        \\                [0]    9223372036854775807 / 9223372036854775806 (1 with 1 remainder)
        \\                [1]    9223372036854775807 / 9223372036854775806 (1 with 1 remainder)
    , "writeVectorExactDivisionWithRemainder", .{ i64, &.{ @as(i64, 9223372036854775807), @as(i64, 9223372036854775807) }, &.{ @as(i64, 9223372036854775806), @as(i64, 9223372036854775806) } });
    try runTest(37,
        \\index 257 out of bounds of length 256
    , "writeIndexOutOfBounds", .{ @as(usize, 257), @as(usize, 256) });
    try runTest(30,
        \\index 257 of invalid reference
    , "writeIndexOutOfBounds", .{ @as(usize, 257), @as(usize, 0) });
    try runTest(53,
        \\index 256 one past the end of indexable range (0-255)
    , "writeIndexOutOfBounds", .{ @as(usize, 256), @as(usize, 256) });
    try runTest(39,
        \\end index 385 is larger than length 256
    , "writeReferenceOutOfBounds", .{ @as(usize, 385), @as(usize, 256) });
    try runTest(44,
        \\start index 129 is larger than end index 128
    , "writeReferenceOutOfOrder", .{ @as(usize, 129), @as(usize, 128) });
    try runTest(39,
        \\end index 257 is larger than length 256
    , "writeReferenceOutOfBounds", .{ @as(usize, 257), @as(usize, 256) });
    try runTest(35,
        \\index 33 out of bounds of length 32
    , "writeIndexOutOfBounds", .{ @as(usize, 33), @as(usize, 32) });
    try runTest(29,
        \\index 33 of invalid reference
    , "writeIndexOutOfBounds", .{ @as(usize, 33), @as(usize, 0) });
    try runTest(51,
        \\index 32 one past the end of indexable range (0-31)
    , "writeIndexOutOfBounds", .{ @as(usize, 32), @as(usize, 32) });
    try runTest(37,
        \\end index 49 is larger than length 32
    , "writeReferenceOutOfBounds", .{ @as(usize, 49), @as(usize, 32) });
    try runTest(42,
        \\start index 17 is larger than end index 16
    , "writeReferenceOutOfOrder", .{ @as(usize, 17), @as(usize, 16) });
    try runTest(37,
        \\end index 33 is larger than length 32
    , "writeReferenceOutOfBounds", .{ @as(usize, 33), @as(usize, 32) });
    try runTest(71,
        \\multi-for loop captures with mismatched lengths: common 64, exception 0
    , "writeMismatchedForLoopCaptureLengths", .{ @as(usize, 64), @as(usize, 0) });
    try runTest(63,
        \\copy arguments alias between 0x1084600 and 0x1084620 (32 bytes)
    , "writeMemcpyArgumentAliasing", .{ @as(usize, 17319392), @as(usize, 17319456), @as(usize, 17319424), @as(usize, 17319488) });
    try runTest(77,
        \\copy destination and source with mismatched lengths: destination 64, source 0
    , "writeMismatchedMemcpyLengths", .{ @as(usize, 64), @as(usize, 0) });
    try runTest(46,
        \\'usize' sentinel mismatch: expected 0, found 1
    , "writeMismatchedSentinel", .{ usize, "usize", @as(usize, 0), @as(usize, 1) });
    try runTest(43,
        \\'u8' sentinel mismatch: expected 0, found 1
    , "writeMismatchedSentinel", .{ u8, "u8", @as(u8, 0), @as(u8, 1) });
    try runTest(81,
        \\cast to 'zig_lib.test.all_causes_seqn.UsedInvalidValue().E1' from invalid value 2
    , "writeCastToTagFromInvalid", .{ u64, "zig_lib.test.all_causes_seqn.UsedInvalidValue().E1", @as(u64, 2) });
    try runTest(81,
        \\cast to 'zig_lib.test.all_causes_seqn.UsedInvalidValue().E1' from invalid value 2
    , "writeCastToTagFromInvalid", .{ u64, "zig_lib.test.all_causes_seqn.UsedInvalidValue().E1", @as(u64, 2) });
    try runTest(86,
        \\cast to 'align(2)' pointer with incorrect alignment: address 0x3 misaligned above by 1
    , "writeCastToPointerFromInvalid", .{ @as(usize, 3), @as(usize, 2) });
    try runTest(86,
        \\cast to 'align(2)' pointer with incorrect alignment: address 0x3 misaligned above by 1
    , "writeCastToPointerFromInvalid", .{ @as(usize, 3), @as(usize, 2) });
    try runTest(40,
        \\cast to null pointer without 'allowzero'
    , "writeCastToPointerFromInvalid", .{ @as(usize, 0), @as(usize, 2) });
    try runTest(86,
        \\cast to 'align(2)' pointer with incorrect alignment: address 0x3 misaligned above by 1
    , "writeCastToPointerFromInvalid", .{ @as(usize, 3), @as(usize, 2) });
    try runTest(86,
        \\cast to 'align(2)' pointer with incorrect alignment: address 0x3 misaligned above by 1
    , "writeCastToPointerFromInvalid", .{ @as(usize, 3), @as(usize, 2) });
    try runTest(40,
        \\cast to null pointer without 'allowzero'
    , "writeCastToPointerFromInvalid", .{ @as(usize, 0), @as(usize, 2) });
    try runTest(40,
        \\cast to null pointer without 'allowzero'
    , "writeCastToPointerFromInvalid", .{ @as(usize, 0), @as(usize, 2) });
    try runTest(86,
        \\cast to 'align(2)' pointer with incorrect alignment: address 0x1 misaligned above by 1
    , "writeCastToPointerFromInvalid", .{ @as(usize, 1), @as(usize, 2) });
    try runTest(86,
        \\cast to 'align(2)' pointer with incorrect alignment: address 0x1 misaligned above by 1
    , "writeCastToPointerFromInvalid", .{ @as(usize, 1), @as(usize, 2) });
    try runTest(86,
        \\cast to 'align(4)' pointer with incorrect alignment: address 0x5 misaligned above by 1
    , "writeCastToPointerFromInvalid", .{ @as(usize, 5), @as(usize, 4) });
    try runTest(86,
        \\cast to 'align(4)' pointer with incorrect alignment: address 0x5 misaligned above by 1
    , "writeCastToPointerFromInvalid", .{ @as(usize, 5), @as(usize, 4) });
    try runTest(40,
        \\cast to null pointer without 'allowzero'
    , "writeCastToPointerFromInvalid", .{ @as(usize, 0), @as(usize, 4) });
    try runTest(86,
        \\cast to 'align(4)' pointer with incorrect alignment: address 0x5 misaligned above by 1
    , "writeCastToPointerFromInvalid", .{ @as(usize, 5), @as(usize, 4) });
    try runTest(86,
        \\cast to 'align(4)' pointer with incorrect alignment: address 0x5 misaligned above by 1
    , "writeCastToPointerFromInvalid", .{ @as(usize, 5), @as(usize, 4) });
    try runTest(40,
        \\cast to null pointer without 'allowzero'
    , "writeCastToPointerFromInvalid", .{ @as(usize, 0), @as(usize, 4) });
    try runTest(40,
        \\cast to null pointer without 'allowzero'
    , "writeCastToPointerFromInvalid", .{ @as(usize, 0), @as(usize, 4) });
    try runTest(86,
        \\cast to 'align(4)' pointer with incorrect alignment: address 0x1 misaligned above by 1
    , "writeCastToPointerFromInvalid", .{ @as(usize, 1), @as(usize, 4) });
    try runTest(86,
        \\cast to 'align(4)' pointer with incorrect alignment: address 0x1 misaligned above by 1
    , "writeCastToPointerFromInvalid", .{ @as(usize, 1), @as(usize, 4) });
    try runTest(86,
        \\cast to 'align(8)' pointer with incorrect alignment: address 0x9 misaligned above by 1
    , "writeCastToPointerFromInvalid", .{ @as(usize, 9), @as(usize, 8) });
    try runTest(86,
        \\cast to 'align(8)' pointer with incorrect alignment: address 0x9 misaligned above by 1
    , "writeCastToPointerFromInvalid", .{ @as(usize, 9), @as(usize, 8) });
    try runTest(40,
        \\cast to null pointer without 'allowzero'
    , "writeCastToPointerFromInvalid", .{ @as(usize, 0), @as(usize, 8) });
    try runTest(86,
        \\cast to 'align(8)' pointer with incorrect alignment: address 0x9 misaligned above by 1
    , "writeCastToPointerFromInvalid", .{ @as(usize, 9), @as(usize, 8) });
    try runTest(86,
        \\cast to 'align(8)' pointer with incorrect alignment: address 0x9 misaligned above by 1
    , "writeCastToPointerFromInvalid", .{ @as(usize, 9), @as(usize, 8) });
    try runTest(40,
        \\cast to null pointer without 'allowzero'
    , "writeCastToPointerFromInvalid", .{ @as(usize, 0), @as(usize, 8) });
    try runTest(40,
        \\cast to null pointer without 'allowzero'
    , "writeCastToPointerFromInvalid", .{ @as(usize, 0), @as(usize, 8) });
    try runTest(86,
        \\cast to 'align(8)' pointer with incorrect alignment: address 0x1 misaligned above by 1
    , "writeCastToPointerFromInvalid", .{ @as(usize, 1), @as(usize, 8) });
    try runTest(86,
        \\cast to 'align(8)' pointer with incorrect alignment: address 0x1 misaligned above by 1
    , "writeCastToPointerFromInvalid", .{ @as(usize, 1), @as(usize, 8) });
    try runTest(40,
        \\cast to null pointer without 'allowzero'
    , "writeCastToPointerFromInvalid", .{ @as(usize, 0), @as(usize, 8) });
    try runTest(101,
        \\cast to 'align(8)' pointer with incorrect alignment: address 0xaaaaaaaaaaaaaaaa misaligned above by 2
    , "writeCastToPointerFromInvalid", .{ ~@as(usize, 6148914691236517205), @as(usize, 8) });
    try runTest(67,
        \\cast to 'u64' from 'i64' truncated bits: -1 below 'u64' minimum (0)
    , "writeScalarCastTruncatedData", .{ u64, "u64", i64, "i64", .{ .min = @as(u64, 0), .max = ~@as(u64, 0) }, -%@as(i64, 1) });
    try runTest(55,
        \\cast to 'error{ErrorA,ErrorB}' from 'anyerror' (ErrorC)
    , "writeCastToErrorFromInvalid", .{ anyerror, "error{ErrorA,ErrorB}", error.ErrorC });
    try runTest(55,
        \\cast to 'anyerror' from non-existent error-code (51882)
    , "writeCastToErrorFromInvalid", .{ u16, "anyerror", @as(u16, 51882) });
}
