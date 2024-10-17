const panic_in_panic = false;
pub fn simple(id: anytype) noreturn {
    @branchHint(.cold);
    @setRuntimeSafety(panic_in_panic);
    if (@TypeOf(id) == std.builtin.Panic.Id) {
        std.debug.defaultPanic(messages[@intFromEnum(id)], null, @returnAddress());
    } else {
        std.debug.defaultPanic(id, null, @returnAddress());
    }
}
pub fn canonical(id: std.builtin.Panic.Id, ctx: ?*const anyopaque) callconv(.C) noreturn {
    @branchHint(.cold);
    @setRuntimeSafety(panic_in_panic);
    if (ctx == null) {
        std.debug.defaultPanic(messages[@intFromEnum(id)], null, @returnAddress());
    }
    switch (id) {
        else => {
            std.debug.defaultPanic(messages[@intFromEnum(id)], null, @returnAddress());
        },
        .message => {
            const data: *const []const u8 = @alignCast(@ptrCast(ctx));
            std.debug.defaultPanic(data.*, null, @returnAddress());
        },
        .unwrapped_error => {
            const data: *const std.builtin.Panic.ErrorStackTrace = @alignCast(@ptrCast(ctx));
            unwrappedError(data.st, data.err, @returnAddress());
        },
        .unwrapped_error_extra => {
            const data: *const std.builtin.Panic.ErrorStackTraceExtra = @alignCast(@ptrCast(ctx));
            unwrappedErrorExtra(data.st, data.err, data.msg, @returnAddress());
        },
        .index_out_of_bounds => {
            const data: *const std.builtin.Panic.IndexBounds = @alignCast(@ptrCast(ctx));
            indexOutOfBounds(data.index, data.length, @returnAddress());
        },
        .reference_out_of_bounds => {
            const data: *const std.builtin.Panic.OrderedBounds = @alignCast(@ptrCast(ctx));
            referenceOutOfBounds(data.start, data.end, @returnAddress());
        },
        .reference_out_of_order => {
            const data: *const std.builtin.Panic.OrderedBounds = @alignCast(@ptrCast(ctx));
            referenceOutOfOrder(data.start, data.end, @returnAddress());
        },
        .reference_out_of_order_extra => {
            const data: *const std.builtin.Panic.OrderedBoundsExtra = @alignCast(@ptrCast(ctx));
            referenceOutOfOrderExtra(data.start, data.end, data.length, @returnAddress());
        },
        .memcpy_argument_aliasing => {
            const data: *const std.builtin.Panic.AddressRanges = @alignCast(@ptrCast(ctx));
            memcpyArgumentAliasing(data.dest_start, data.dest_end, data.src_start, data.src_end, @returnAddress());
        },
        .mismatched_memcpy_argument_lengths => {
            const data: *const std.builtin.Panic.ArgumentLengths = @alignCast(@ptrCast(ctx));
            mismatchedMemcpyLengths(data.dest_len, data.src_len, @returnAddress());
        },
        .mismatched_for_loop_capture_lengths => {
            const data: *const std.builtin.Panic.CaptureLengths = @alignCast(@ptrCast(ctx));
            mismatchedForLoopCaptureLengths(data.loop_len, data.capture_len, @returnAddress());
        },
        .mismatched_sentinel_null => {
            const data: *const u8 = @alignCast(@ptrCast(ctx));
            mismatchedSentinelNull(data.*, @returnAddress());
        },
        .cast_to_ptr_from_invalid => {
            const data: *const std.builtin.Panic.Address = @alignCast(@ptrCast(ctx));
            castToPointerFromInvalid(data.value, data.alignment, @returnAddress());
        },
    }
}
pub fn generic(comptime cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    @branchHint(.cold);
    @setRuntimeSafety(panic_in_panic);
    if (@TypeOf(data) == void) {
        std.debug.defaultPanic(messages[@intFromEnum(cause)], null, @returnAddress());
    }
    // zig fmt: off
    switch (cause) {
        .message => std.debug.defaultPanic(data, null, @returnAddress()),
        .unwrapped_error,
        => unwrappedError(
            data.st, data.err, @returnAddress(),
        ),
        .unwrapped_error_extra,
        => unwrappedErrorExtra(
            data.st, data.err, data.msg, @returnAddress(),
        ),
        .index_out_of_bounds,
        => indexOutOfBounds(
            data.index, data.length, @returnAddress(),
        ),
        .reference_out_of_bounds,
        => referenceOutOfBounds(
            data.start, data.end, @returnAddress(),
        ),
        .reference_out_of_order,
        => referenceOutOfOrder(
            data.start, data.end, @returnAddress(),
        ),
        .reference_out_of_order_extra,
        => referenceOutOfOrderExtra(
            data.start, data.end, data.length, @returnAddress(),
        ),
        .accessed_inactive_field,
        => accessedInactiveField(
            @tagName(data.expected), @tagName(data.found), @returnAddress(),
        ),
        .memcpy_argument_aliasing,
        => memcpyArgumentAliasing(
            data.dest_start, data.dest_end, data.src_start, data.src_end, @returnAddress(),
        ),
        .mismatched_memcpy_argument_lengths,
        => mismatchedMemcpyLengths(
            data.dest_len, data.src_len, @returnAddress(),
        ),
        .mismatched_for_loop_capture_lengths,
        => mismatchedForLoopCaptureLengths(
            data.loop_len, data.capture_len, @returnAddress(),
        ),
        .mismatched_sentinel_null,
        => mismatchedSentinelNull(
            data, @returnAddress(),
        ),
        .cast_to_enum_from_invalid,
        => |enum_type| castToEnumFromInvalid(
            ResizeBest(enum_type), @typeName(enum_type), data, @returnAddress(),
        ),
        .cast_to_error_from_invalid,
        => |error_type| castToErrorFromInvalid(
            error_type.from, @typeName(error_type.to), data, @returnAddress(),
        ),
        .add_overflowed,
        .sub_overflowed,
        .mul_overflowed,
        .div_overflowed,
        => |int_type| ArithOverflow(ResizeBest(int_type)).simple(cause,
            @typeName(Scalar(int_type)), extremaBest(int_type),
            data.lhs, data.rhs, @returnAddress(),
        ),
        .shl_overflowed,
        .shr_overflowed,
        => |int_type| ArithOverflow(ResizeBest(int_type)).shift(cause,
            @typeName(Scalar(int_type)), data.value, data.shift_amt,
            ~@abs(@as(Scalar(int_type), 0)), @returnAddress(),
        ),
        .shift_amt_overflowed,
        => |int_type| ArithOverflow(ResizeBest(int_type)).shiftRhs(
            @typeName(Scalar(int_type)), @bitSizeOf(int_type), data, @returnAddress(),
        ),
        .div_with_remainder,
        => |num_type| exactDivisionWithRemainder(
            ResizeBest(num_type), data.lhs, data.rhs, @returnAddress(),
        ),
        .mismatched_sentinel,
        => |elem_type| mismatchedSentinel(
            ResizeBest(elem_type), @typeName(elem_type),
            data.expected, data.actual, @returnAddress(),
        ),
        .cast_to_ptr_from_invalid,
        => castToPointerFromInvalid(
            data.value, data.alignment, @returnAddress(),
        ),
        .cast_to_int_from_invalid,
        => |num_types| castToIntFromInvalid(
            ResizeBest(num_types.to), @typeName(Scalar(num_types.to)),
            ResizeBest(num_types.from), @typeName(Scalar(num_types.from)),
            extremaBest(num_types.to), data, @returnAddress(),
        ),
        .cast_to_unsigned_from_negative,
        .cast_truncated_data,
        => |num_types| castTruncatedData(
            ResizeBest(num_types.to), @typeName(Scalar(num_types.to)),
            ResizeBest(num_types.from), @typeName(Scalar(num_types.from)),
            extremaBest(num_types.to), data, @returnAddress(),
        ),
        else => @compileError(@tagName(cause)),
    }
    // zig fmt: on
}
const message_strings = .{
    .message = undefined,
    .unwrapped_error = "attempt to unwrap error",
    .unwrapped_error_extra = "attempt to unwrap error with @panic",
    .returned_noreturn = "'noreturn' function returned",
    .reached_unreachable = "reached unreachable code",
    .corrupt_switch = "switch on corrupt value",
    .index_out_of_bounds = "index greater than or equal to length",
    .reference_out_of_bounds = "end index is larger than length",
    .reference_out_of_order = "start index is larger than end index",
    .reference_out_of_order_extra = "end index is larger than length or start index is larger than end index",
    .accessed_inactive_field = "access of inactive union field",
    .accessed_null_value = "attempt to use null value",
    .divided_by_zero = "division by zero",
    .memcpy_argument_aliasing = "@memcpy arguments alias",
    .mismatched_memcpy_argument_lengths = "@memcpy arguments have non-equal lengths",
    .mismatched_for_loop_capture_lengths = "for loop over objects with non-equal lengths",
    .mismatched_sentinel = "sentinel mismatch",
    .mismatched_sentinel_null = "mismatched null terminator",
    .shl_overflowed = "left shift overflowed bits",
    .shr_overflowed = "right shift overflowed bits",
    .shift_amt_overflowed = "shift amount is greater than the type size",
    .div_with_remainder = "exact division produced remainder",
    .mul_overflowed = "mul overflowed",
    .add_overflowed = "add overflowed",
    .sub_overflowed = "sub overflowed",
    .div_overflowed = "div overflowed",
    .cast_truncated_data = "integer cast truncated bits",
    .cast_to_enum_from_invalid = "invalid enum value",
    .cast_to_error_from_invalid = "invalid error code",
    .cast_to_ptr_from_invalid = "cast to invalid pointer",
    .cast_to_int_from_invalid = "integer part of floating point value out of bounds",
    .cast_to_unsigned_from_negative = "cast to unsigned integer from negative value",
};
const messages = blk: {
    const fields = @typeInfo(std.builtin.Panic.Id).@"enum".fields;
    var buf: [fields.len][]const u8 = undefined;
    for (fields, 0.., &buf) |field, idx, *message| {
        std.debug.assert(field.value == idx);
        message.* = @field(message_strings, field.name);
    }
    break :blk buf[0..buf.len].*;
};
fn unwrappedError(
    st: ?*std.builtin.StackTrace,
    err: anyerror,
    ret_addr: usize,
) noreturn {
    @setRuntimeSafety(panic_in_panic);
    var buf: [256]u8 = undefined;
    const ptr: [*]u8 = writeUnwrappedError(&buf, @errorName(err));
    std.debug.defaultPanic(buf[0 .. ptr - &buf], st, ret_addr);
}
fn unwrappedErrorExtra(
    st: ?*std.builtin.StackTrace,
    err: anyerror,
    msg: []const u8,
    ret_addr: usize,
) noreturn {
    @setRuntimeSafety(panic_in_panic);
    var buf: [4352]u8 = undefined;
    const ptr: [*]u8 = writeUnwrappedErrorExtra(&buf, @errorName(err), msg);
    std.debug.defaultPanic(buf[0 .. ptr - &buf], st, ret_addr);
}
fn accessedInactiveField(
    expected: []const u8,
    found: []const u8,
    ret_addr: usize,
) noreturn {
    @setRuntimeSafety(panic_in_panic);
    var buf: [256]u8 = undefined;
    const ptr: [*]u8 = writeAccessedInactiveField(&buf, expected, found);
    std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
}
fn indexOutOfBounds(
    index: usize,
    length: usize,
    ret_addr: usize,
) noreturn {
    @setRuntimeSafety(panic_in_panic);
    var buf: [256]u8 = undefined;
    const ptr: [*]u8 = writeIndexOutOfBounds(&buf, index, length);
    std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
}
fn referenceOutOfBounds(
    start: usize,
    end: usize,
    ret_addr: usize,
) noreturn {
    @setRuntimeSafety(panic_in_panic);
    var buf: [256]u8 = undefined;
    const ptr: [*]u8 = writeReferenceOutOfBounds(&buf, start, end);
    std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
}
fn referenceOutOfOrder(
    start: usize,
    end: usize,
    ret_addr: usize,
) noreturn {
    @setRuntimeSafety(panic_in_panic);
    var buf: [256]u8 = undefined;
    const ptr: [*]u8 = writeReferenceOutOfOrder(&buf, start, end);
    std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
}
fn referenceOutOfOrderExtra(
    start: usize,
    end: usize,
    length: usize,
    ret_addr: usize,
) noreturn {
    @setRuntimeSafety(panic_in_panic);
    var buf: [256]u8 = undefined;
    const ptr: [*]u8 = writeReferenceOutOfOrderExtra(&buf, start, end, length);
    std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
}
fn memcpyArgumentAliasing(
    dest_start: usize,
    dest_end: usize,
    src_start: usize,
    src_end: usize,
    ret_addr: usize,
) noreturn {
    @setRuntimeSafety(panic_in_panic);
    var buf: [256]u8 = undefined;
    const ptr: [*]u8 = writeMemcpyArgumentAliasing(&buf, dest_start, dest_end, src_start, src_end);
    std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
}
fn mismatchedMemcpyLengths(
    dest_len: usize,
    src_len: usize,
    ret_addr: usize,
) noreturn {
    @setRuntimeSafety(panic_in_panic);
    var buf: [256]u8 = undefined;
    const ptr: [*]u8 = writeMismatchedMemcpyLengths(&buf, dest_len, src_len);
    std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
}
fn mismatchedForLoopCaptureLengths(
    loop_len: usize,
    capture_len: usize,
    ret_addr: usize,
) noreturn {
    @setRuntimeSafety(panic_in_panic);
    var buf: [256]u8 = undefined;
    const ptr: [*]u8 = writeMismatchedForLoopCaptureLengths(&buf, loop_len, capture_len);
    std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
}
fn mismatchedSentinelNull(
    value: u8,
    ret_addr: usize,
) noreturn {
    @setRuntimeSafety(panic_in_panic);
    var buf: [128]u8 = undefined;
    const ptr: [*]u8 = writeMismatedSentinelNull(&buf, value);
    std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
}
fn castToPointerFromInvalid(
    address: usize,
    alignment: usize,
    ret_addr: usize,
) noreturn {
    @setRuntimeSafety(panic_in_panic);
    var buf: [256]u8 = undefined;
    const ptr: [*]u8 = writeCastToPointerFromInvalid(&buf, address, alignment);
    std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
}
fn castToEnumFromInvalid(
    comptime Integer: type,
    type_name: []const u8,
    value: Integer,
    ret_addr: usize,
) noreturn {
    @setRuntimeSafety(panic_in_panic);
    var buf: [256]u8 = undefined;
    const ptr: [*]u8 = writeCastToTagFromInvalid(&buf, Integer, type_name, value);
    std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
}
fn castToErrorFromInvalid(
    comptime From: type,
    type_name: []const u8,
    value: From,
    ret_addr: usize,
) noreturn {
    @setRuntimeSafety(panic_in_panic);
    var buf: [256]u8 = undefined;
    const ptr: [*]u8 = writeCastToErrorFromInvalid(&buf, From, type_name, value);
    std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
}
fn mismatchedSentinel(
    comptime Number: type,
    type_name: []const u8,
    expected: Number,
    found: Number,
    ret_addr: usize,
) noreturn {
    @setRuntimeSafety(panic_in_panic);
    var buf: [256]u8 = undefined;
    const ptr: [*]u8 = writeMismatchedSentinel(&buf, Number, type_name, expected, found);
    std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
}
fn ArithOverflow(comptime Operand: type) type {
    if (@typeInfo(Operand) != .vector) {
        return ScalarArithOverflow(Operand);
    }
    return VectorArithOverflow(Operand);
}
fn exactDivisionWithRemainder(
    comptime Number: type,
    lhs: Number,
    rhs: Number,
    ret_addr: usize,
) noreturn {
    @setRuntimeSafety(panic_in_panic);
    const num_info = @typeInfo(Number);
    if (num_info == .vector) {
        var buf: [384 * num_info.vector.len]u8 = undefined;
        const lhs_values: [num_info.vector.len]num_info.vector.child = lhs;
        const rhs_values: [num_info.vector.len]num_info.vector.child = rhs;
        const ptr: [*]u8 = writeVectorExactDivisionWithRemainder(&buf, num_info.vector.child, &lhs_values, &rhs_values);
        std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
    } else {
        var buf: [256]u8 = undefined;
        const ptr: [*]u8 = writeScalarExactDivisionWithRemainder(&buf, Number, lhs, rhs);
        std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
    }
}
fn castTruncatedData(
    comptime To: type,
    to_type_name: []const u8,
    comptime From: type,
    from_type_name: []const u8,
    extrema: anytype,
    value: From,
    ret_addr: usize,
) noreturn {
    @setRuntimeSafety(panic_in_panic);
    const from_info: std.builtin.Type = @typeInfo(From);
    const to_info: std.builtin.Type = @typeInfo(To);
    if (to_info == .vector) {
        var buf: [384 * from_info.vector.len]u8 = undefined;
        const values = &@as([from_info.vector.len]from_info.vector.child, value);
        const ptr: [*]u8 = writeVectorCastTruncatedData(&buf, To, to_type_name, from_info.vector.child, from_type_name, extrema, values);
        std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
    } else {
        var buf: [256]u8 = undefined;
        const ptr: [*]u8 = writeScalarCastTruncatedData(&buf, To, to_type_name, From, from_type_name, extrema, value);
        std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
    }
}
fn castToIntFromInvalid(
    comptime To: type,
    to_type_name: []const u8,
    comptime From: type,
    from_type_name: []const u8,
    extrema: anytype,
    value: From,
    ret_addr: usize,
) noreturn {
    @setRuntimeSafety(panic_in_panic);
    const from_info: std.builtin.Type = @typeInfo(From);
    const to_info: std.builtin.Type = @typeInfo(To);
    if (from_info == .vector) {
        var buf: [384 * from_info.vector.len]u8 = undefined;
        const values: [from_info.vector.len]from_info.vector.child = value;
        const ptr: [*]u8 = writeVectorCastToIntFromInvalid(&buf, to_info.vector.child, to_type_name, from_info.vector.child, from_type_name, extrema, &values);
        std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
    } else {
        var buf: [256]u8 = undefined;
        const ptr: [*]u8 = writeScalarCastToIntFromInvalid(&buf, To, to_type_name, From, from_type_name, extrema, value);
        std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
    }
}

// Writer and formatter functions below.

fn writeMismatedSentinelNull(
    buf: [*]u8,
    value: u8,
) [*]u8 {
    @setRuntimeSafety(false);
    buf[0..28].* = "mismatched null terminator: ".*;
    return writeIntDec(buf[28..][0..8], @as(usize, value));
}
fn writeUnwrappedError(
    buf: [*]u8,
    error_name: []const u8,
) [*]u8 {
    @setRuntimeSafety(false);
    const ptr: [*]u8 = cpyEquTrunc(buf[29..][0..64], error_name);
    buf[0..29].* = "attempted to discard error: '".*;
    ptr[0] = '\'';
    return ptr + 1;
}
fn writeUnwrappedErrorExtra(
    buf: [*]u8,
    error_name: []const u8,
    msg: []const u8,
) [*]u8 {
    @setRuntimeSafety(false);
    const ptr: [*]u8 = cpyEquTrunc(buf[29..][0..64], error_name);
    buf[0..29].* = "attempted to discard error: '".*;
    ptr[0..3].* = "': ".*;
    return cpyEquTrunc(ptr[3..][0..4096], msg);
}
fn writeIndexOutOfBounds(
    buf: [*]u8,
    index: usize,
    length: usize,
) [*]u8 {
    @setRuntimeSafety(false);
    var ptr: [*]u8 = writeIntDec(buf[6..][0..64], index);
    buf[0..6].* = "index ".*;
    if (length == 0) {
        ptr[0..21].* = " of invalid reference".*;
        return ptr + 21;
    }
    if (index == length) {
        ptr[0..40].* = " one past the end of indexable range (0-".*;
        ptr = writeIntDec(ptr + 40, length -% 1);
        ptr[0] = ')';
        return ptr + 1;
    }
    ptr[0..25].* = " out of bounds of length ".*;
    return writeIntDec(ptr[25..][0..64], length);
}
fn writeReferenceOutOfBounds(
    buf: [*]u8,
    start: usize,
    end: usize,
) [*]u8 {
    @setRuntimeSafety(false);
    const ptr: [*]u8 = writeIntDec(buf[10..][0..64], start);
    buf[0..10].* = "end index ".*;
    ptr[0..23].* = " is larger than length ".*;
    return writeIntDec(ptr[23..][0..64], end);
}
fn writeReferenceOutOfOrder(
    buf: [*]u8,
    start: usize,
    end: usize,
) [*]u8 {
    @setRuntimeSafety(false);
    const ptr: [*]u8 = writeIntDec(buf[12..][0..32], start);
    buf[0..12].* = "start index ".*;
    ptr[0..26].* = " is larger than end index ".*;
    return writeIntDec(ptr[26..][0..64], end);
}
fn writeReferenceOutOfOrderExtra(
    buf: [*]u8,
    start: usize,
    end: usize,
    length: usize,
) [*]u8 {
    @setRuntimeSafety(false);
    if (start > end) {
        const ptr: [*]u8 = writeIntDec(buf[12..][0..32], start);
        buf[0..12].* = "start index ".*;
        ptr[0..26].* = " is larger than end index ".*;
        return writeIntDec(ptr[26..][0..64], end);
    } else {
        const ptr: [*]u8 = writeIntDec(buf[10..][0..32], end);
        buf[0..10].* = "end index ".*;
        ptr[0..23].* = " is larger than length ".*;
        return writeIntDec(ptr[23..][0..64], length);
    }
}
fn writeMemcpyArgumentAliasing(
    buf: [*]u8,
    dest_start: usize,
    dest_end: usize,
    src_start: usize,
    src_end: usize,
) [*]u8 {
    @setRuntimeSafety(false);
    const max: usize = @max(dest_start, src_start);
    const min: usize = @min(dest_end, src_end);
    var ptr: [*]u8 = writeIntHex(buf + 29, max);
    buf[0..29].* = "copy arguments alias between ".*;
    ptr[0..5].* = " and ".*;
    ptr = writeIntHex(ptr + 5, min);
    ptr[0..2].* = " (".*;
    ptr = writeIntDec(ptr + 2, min -% max);
    ptr[0..7].* = " bytes)".*;
    return ptr + 7;
}
fn writeMismatchedMemcpyLengths(
    buf: [*]u8,
    dest_len: usize,
    src_len: usize,
) [*]u8 {
    @setRuntimeSafety(false);
    const ptr: [*]u8 = writeIntDec(buf[65..][0..32], dest_len);
    buf[0..65].* = "copy destination and source with mismatched lengths: destination ".*;
    ptr[0..9].* = ", source ".*;
    return writeIntDec(ptr[9..][0..64], src_len);
}
fn writeMismatchedForLoopCaptureLengths(
    buf: [*]u8,
    loop_len: usize,
    capture_len: usize,
) [*]u8 {
    @setRuntimeSafety(false);
    const ptr: [*]u8 = writeIntDec(buf + 56, loop_len);
    buf[0..56].* = "multi-for loop captures with mismatched lengths: common ".*;
    ptr[0..12].* = ", exception ".*;
    return writeIntDec(ptr + 12, capture_len);
}
fn writeAccessedInactiveField(
    buf: [*]u8,
    expected: []const u8,
    found: []const u8,
) [*]u8 {
    @setRuntimeSafety(false);
    var ptr: [*]u8 = cpyEquTrunc(buf[23..][0..32], found);
    buf[0..23].* = "access of union field '".*;
    ptr[0..15].* = "' while field '".*;
    ptr = cpyEquTrunc(ptr[15..][0..32], expected);
    ptr[0..11].* = "' is active".*;
    return ptr + 11;
}
fn writeScalarCastToIntFromInvalid(
    buf: [*]u8,
    comptime To: type,
    to_type_name: []const u8,
    comptime From: type,
    from_type_name: []const u8,
    extrema: ExtremaBest(To),
    value: From,
) [*]u8 {
    @setRuntimeSafety(false);
    const yn: bool = value < 0;
    var ptr: [*]u8 = writeCastToFrom(buf, to_type_name, from_type_name, " overflowed: ");
    ptr = formatAny(ptr[0..64], value);
    return writeAboveOrBelowLimitExtra(ptr, To, to_type_name, yn, if (yn) extrema.min else extrema.max);
}
fn writeVectorCastToIntFromInvalid(
    buf: [*]u8,
    comptime To: type,
    to_type_name: []const u8,
    comptime From: type,
    from_type_name: []const u8,
    extrema: ExtremaBest(To),
    values: []const From,
) [*]u8 {
    @setRuntimeSafety(false);
    var ptr: [*]u8 = writeCastToFrom(buf, to_type_name, from_type_name, " overflowed: ");
    for (values, 0..) |value, idx| {
        const yn: bool = value < 0;
        ptr = writeVectorIndex(ptr, idx);
        ptr = formatAny(ptr[0..64], value);
        ptr = cpyEqu(ptr[0..16], if (yn) " below minimum" else " above maximum");
        ptr = writeAboveOrBelowLimitExtra(ptr, To, to_type_name, yn, if (yn) extrema.min else extrema.max);
    }
    return ptr;
}
fn writeCastToPointerFromInvalid(
    buf: [*]u8,
    address: usize,
    alignment: usize,
) [*]u8 {
    @setRuntimeSafety(false);
    var ptr: [*]u8 = buf + 40;
    buf[0..40].* = "cast to null pointer without 'allowzero'".*;
    if (address != 0) {
        const above: usize = address & (alignment -% 1);
        const below: usize = alignment -% above;
        buf[0..15].* = "cast to 'align(".*;
        ptr = writeIntDec(buf[15..][0..64], alignment);
        ptr[0..45].* = ")' pointer with incorrect alignment: address ".*;
        ptr = writeIntHex(ptr[45..][0..64], address);
        ptr[0..12].* = " misaligned ".*;
        ptr = cpyEquTrunc(ptr[12..][0..64], if (below < above) "below by " else "above by ");
        ptr = writeIntDec(ptr[0..64], @min(above, below));
    }
    return ptr;
}
fn writeScalarCastToIntFromInvalid2(
    buf: [*]u8,
    comptime To: type,
    to_type_name: []const u8,
    comptime From: type,
    from_type_name: []const u8,
    extrema: anytype,
    value: From,
) [*]u8 {
    @setRuntimeSafety(false);
    const yn: bool = value < 0;
    var ptr: [*]u8 = writeCastToFrom(buf, to_type_name, from_type_name, " overflowed: ");
    ptr = formatAny(ptr, value);
    return writeAboveOrBelowLimitExtra(ptr, To, to_type_name, yn, if (yn) extrema.min else extrema.max);
}
fn writeVectorCastToIntFromInvalid2(
    buf: [*]u8,
    comptime To: type,
    to_type_name: []const u8,
    comptime From: type,
    from_type_name: []const u8,
    extrema: anytype,
    vec: []const From,
) [*]u8 {
    @setRuntimeSafety(false);
    var ptr: [*]u8 = writeCastToFrom(buf, to_type_name, from_type_name, " overflowed: ");
    for (vec, 0..) |value, idx| {
        const yn: bool = value < 0;
        ptr = writeVectorIndex(ptr, idx);
        ptr = formatAny(ptr, value);
        ptr = writeAboveOrBelowLimitExtra(ptr, To, to_type_name, yn, if (yn) extrema.min else extrema.max);
    }
    return ptr;
}
fn writeMismatchedSentinel(
    buf: [*]u8,
    comptime Number: type,
    type_name: []const u8,
    expected: Number,
    found: Number,
) [*]u8 {
    @setRuntimeSafety(false);
    var ptr: [*]u8 = cpyEquTrunc(buf[1..][0..64], type_name);
    buf[0] = '\'';
    ptr[0..30].* = "' sentinel mismatch: expected ".*;
    ptr = formatAny(ptr[30..][0..64], expected);
    ptr[0..8].* = ", found ".*;
    return formatAny(ptr[8..][0..64], found);
}
fn writeDivisionWithRemainder(
    buf: [*]u8,
    comptime Number: type,
    lhs: Number,
    rhs: Number,
) [*]u8 {
    @setRuntimeSafety(false);
    var ptr: [*]u8 = formatAny(buf[0..32], lhs);
    ptr[0..3].* = " / ".*;
    ptr = formatAny(ptr[3..][0..32], rhs);
    ptr[0..2].* = " (".*;
    ptr = formatAny(ptr[2..][0..32], @divTrunc(lhs, rhs));
    ptr[0..6].* = " with ".*;
    ptr = formatAny(ptr[6..][0..32], @rem(lhs, rhs));
    ptr[0..11].* = " remainder)".*;
    return ptr + 11;
}
fn writeScalarExactDivisionWithRemainder(
    buf: [*]u8,
    comptime Number: type,
    lhs: Number,
    rhs: Number,
) [*]u8 {
    @setRuntimeSafety(false);
    buf[0..31].* = "exact division with remainder: ".*;
    return writeDivisionWithRemainder(buf[31..], Number, lhs, rhs);
}
fn writeVectorExactDivisionWithRemainder(
    buf: [*]u8,
    comptime Number: type,
    lhs_vec: []const Number,
    rhs_vec: []const Number,
) [*]u8 {
    @setRuntimeSafety(false);
    var ptr: [*]u8 = buf + 31;
    buf[0..31].* = "exact division with remainder: ".*;
    for (lhs_vec, rhs_vec, 0..) |lhs, rhs, idx| {
        ptr = writeVectorIndex(ptr, idx);
        ptr = writeDivisionWithRemainder(ptr, Number, lhs, rhs);
    }
    return ptr;
}
fn writeCastToTagFromInvalid(
    buf: [*]u8,
    comptime Integer: type,
    type_name: []const u8,
    value: Integer,
) [*]u8 {
    @setRuntimeSafety(false);
    var ptr: [*]u8 = cpyEquTrunc(buf[9..][0..32], type_name);
    buf[0..9].* = "cast to '".*;
    ptr[0..21].* = "' from invalid value ".*;
    return formatAny(ptr[21..][0..64], value);
}
fn writeCastToErrorFromInvalid(
    buf: [*]u8,
    comptime From: type,
    type_name: []const u8,
    value: From,
) [*]u8 {
    @setRuntimeSafety(false);
    var ptr: [*]u8 = cpyEquTrunc(buf[9..][0..64], type_name);
    buf[0..9].* = "cast to '".*;
    ptr[0..7].* = "' from ".*;
    if (@typeInfo(From) == .int) {
        ptr[7..32].* = "non-existent error-code (".*;
        ptr = writeIntDec(ptr + 32, value);
        ptr[0] = ')';
        return ptr + 1;
    } else {
        ptr[7] = '\'';
        ptr[0..@typeName(From).len].* = @typeName(From).*;
        ptr += @typeName(From).len;
        ptr[0..2].* = "' ".*;
        return formatAny(ptr[2..][0..64], value);
    }
}
fn writeScalarCastTruncatedData(
    buf: [*]u8,
    comptime To: type,
    to_type_name: []const u8,
    comptime From: type,
    from_type_name: []const u8,
    extrema: anytype,
    value: From,
) [*]u8 {
    @setRuntimeSafety(false);
    const yn: bool = value < 0;
    var ptr: [*]u8 = writeCastToFrom(buf, to_type_name, from_type_name, " truncated bits: ");
    ptr = writeIntDec(ptr, value);
    return writeAboveOrBelowLimitExtra(ptr, To, to_type_name, yn, if (yn) extrema.min else extrema.max);
}
fn writeVectorCastTruncatedData(
    buf: [*]u8,
    comptime _: type,
    to_type_name: []const u8,
    comptime From: type,
    from_type_name: []const u8,
    extrema: anytype,
    values: []const From,
) [*]u8 {
    @setRuntimeSafety(false);
    var ptr: [*]u8 = writeCastToFrom(buf, to_type_name, from_type_name, " truncated bits: ");
    ptr = writeElementsOutOfRange(ptr, extrema);
    for (values, 0..) |value, idx| {
        const yn: bool = value < 0;
        const ab: bool = value > extrema.max or value < extrema.min;
        ptr = writeVectorIndex(ptr, idx);
        ptr = writeIntDec(ptr, value);
        if (ab) ptr = cpyEqu(ptr[0..16], if (yn) " below minimum" else " above maximum");
    }
    return ptr;
}
fn writeCastToFrom(
    buf: [*]u8,
    to_type_name: []const u8,
    from_type_name: []const u8,
    what: []const u8,
) [*]u8 {
    @setRuntimeSafety(false);
    var ptr: [*]u8 = cpyEquTrunc(buf[9..][0..64], to_type_name);
    buf[0..9].* = "cast to '".*;
    ptr[0..8].* = "' from '".*;
    ptr = cpyEquTrunc(ptr[8..][0..64], from_type_name);
    ptr[0] = '\'';
    return cpyEquTrunc(ptr[1..][0..32], what);
}
fn writeAboveOrBelowLimitExtra(
    buf: [*]u8,
    comptime To: type,
    to_type_name: []const u8,
    yn: bool,
    limit: To,
) [*]u8 {
    @setRuntimeSafety(false);
    const ab: [14]u8 = if (yn) " below minimum".* else " above maximum".*;
    var ptr: [*]u8 = buf + 7;
    buf[0..7].* = ab[0..7].*;
    ptr[0] = '\'';
    ptr = cpyEquTrunc(ptr[1..][0..64], to_type_name);
    ptr[0..2].* = "' ".*;
    ptr[2..9].* = ab[7..14].*;
    ptr[9..11].* = " (".*;
    ptr = writeIntDec(ptr + 11, limit);
    ptr[0] = ')';
    return ptr + 1;
}
fn writeVectorIndex(buf: [*]u8, idx: usize) [*]u8 {
    @setRuntimeSafety(false);
    var ptr: [*]u8 = writeIntDec(buf + 3, idx);
    buf[0..3].* = "\n\t[".*;
    ptr[0..2].* = "]\t".*;
    return ptr + 2;
}
fn writeWhatOverflowed(buf: [*]u8, op_name: []const u8, type_name: []const u8) [*]u8 {
    @setRuntimeSafety(false);
    var ptr: [*]u8 = cpyEquTrunc(buf[0..64], op_name);
    ptr[0..5].* = " of '".*;
    ptr = cpyEquTrunc(ptr[5..][0..64], type_name);
    ptr[0..3].* = "': ".*;
    return ptr + 3;
}
fn writeElementsOutOfRange(buf: [*]u8, extrema: anytype) [*]u8 {
    @setRuntimeSafety(false);
    buf[0..26].* = "element(s) below minimum (".*;
    var ptr: [*]u8 = writeIntDec(buf + 26, extrema.min);
    ptr[0..20].* = ") or above maximum (".*;
    ptr = writeIntDec(ptr + 20, extrema.max);
    ptr[0..2].* = "):".*;
    return ptr + 2;
}
fn cpyEquTrunc(slice: []u8, str: []const u8) [*]u8 {
    if (str.len > slice.len) {
        std.debug.assert(slice.len >= 4);
        _ = cpyEqu(slice, str[0..slice.len]);
        (slice.ptr - 4)[slice.len..][0..4].* = "[..]".*;
        return slice.ptr + slice.len;
    } else {
        return cpyEqu(slice, str);
    }
}
fn formatBuf(buf: []u8, comptime fmt: []const u8, args: anytype) []u8 {
    return std.fmt.bufPrint(buf, fmt, args) catch {
        return writeErrorFormattingValue(buf);
    };
}
fn cpyEqu(buf: []u8, str: []const u8) [*]u8 {
    for (buf[0..str.len], str) |*dest, byte| dest.* = byte;
    return buf.ptr + str.len;
}
fn writeErrorFormattingValue(buf: []u8) []u8 {
    if (buf.len < 24) {
        const short: usize = @min(buf.len, 3);
        _ = cpyEqu(buf, "???"[0..short]);
        return buf.ptr[0..short];
    }
    return cpyEqu(buf, "(error formatting value)")[0..24];
}
fn formatAny(buf: []u8, value: anytype) [*]u8 {
    var fbs = std.io.fixedBufferStream(buf);
    std.fmt.format(fbs.writer(), "{any}", .{value}) catch {
        return writeErrorFormattingValue(buf).ptr;
    };
    return buf.ptr + fbs.pos;
}
fn writeIntDec(buf: [*]u8, value: anytype) [*]u8 {
    @setRuntimeSafety(panic_in_panic);
    var abs = @abs(value);
    var ptr: [*]u8 = buf;
    ptr[0] = '-';
    ptr += @intFromBool(value < 0);
    ptr[0] = '0';
    var len: usize = 0;
    while (abs != 0) : (abs /= 10) len +%= 1;
    len = @max(1, len);
    const ret: [*]u8 = ptr + len;
    ptr = ret;
    abs = @abs(value);
    while (abs != 0) : (abs /= 10) {
        ptr -= 1;
        ptr[0] = @intCast(abs % 10 +% '0');
    }
    return ret;
}
fn writeIntHex(buf: [*]u8, value: anytype) [*]u8 {
    @setRuntimeSafety(panic_in_panic);
    var abs = @abs(value);
    var ptr: [*]u8 = buf;
    ptr[0] = '-';
    ptr += @intFromBool(value < 0);
    ptr[0..3].* = "0x0".*;
    var len: usize = 0;
    while (abs != 0) : (abs /= 16) len +%= 1;
    len = @max(1, len);
    const ret: [*]u8 = ptr + 2 + len;
    ptr = ret;
    abs = @abs(value);
    while (abs != 0) : (abs /= 16) {
        ptr -= 1;
        ptr[0] = switch (abs % 16) {
            0...9 => |rem| @intCast(rem +% ('9' -% 9)),
            else => |rem| @intCast(rem +% ('f' -% 15)),
        };
    }
    return ret;
}
fn Scalar(comptime T: type) type {
    switch (@typeInfo(T)) {
        .vector => |vec_info| return vec_info.child,
        else => return T,
    }
}
fn ResizeBest(comptime N: type) type {
    var type_info: std.builtin.Type = @typeInfo(N);
    var len: ?comptime_int = null;
    const scalar: type = switch (type_info) {
        .vector => |vector_info| blk: {
            len = vector_info.len;
            break :blk vector_info.child;
        },
        .@"enum" => |enum_info| enum_info.tag_type,
        .optional => return N,
        else => N,
    };
    type_info = @typeInfo(scalar);
    if (type_info == .float) {
        return N;
    }
    const scalar_bits: u16 = @bitSizeOf(scalar);
    const best_bits: comptime_int = @max(
        @bitSizeOf(*anyopaque),
        1 << (15 -% (@clz(scalar_bits) -% @intFromBool(@popCount(scalar_bits) != 1))),
    );
    @field(type_info, @tagName(type_info)).bits = best_bits;
    if (len) |vec_len| {
        return @Vector(vec_len, @Type(type_info));
    } else {
        return @Type(type_info);
    }
}
/// Informs the return type of `extremaBest`.
fn ExtremaBest(comptime I: type) type {
    const Best = ResizeBest(I);
    switch (@typeInfo(Best)) {
        .vector => |vector_info| return ExtremaBest(vector_info.child),
        else => return struct { min: Best, max: Best },
    }
}
/// Stores the minimum and maximum values of type `I` in the best common
/// type with the same sign (usually `usize` or `isize`).
inline fn extremaBest(comptime I: type) ExtremaBest(I) {
    switch (@typeInfo(I)) {
        .vector => comptime {
            return extremaBest(@typeInfo(I).vector.child);
        },
        .int => comptime {
            const zero: @Type(.{
                .int = .{ .signedness = .unsigned, .bits = @bitSizeOf(I) },
            }) = 0;
            if (@typeInfo(I).int.signedness == .unsigned) {
                return .{ .min = 0, .max = ~zero };
            } else {
                return .{
                    .min = @as(I, @bitCast(~((~zero) >> @truncate(1)))),
                    .max = @as(I, @bitCast((~zero) >> @truncate(1))),
                };
            }
        },
        else => @compileError("Expected integer or vector type, found '" ++ @typeName(I) ++ "'"),
    }
}
fn VectorArithOverflow(comptime Vector: type) type {
    const T = struct {
        const vec_info: std.builtin.Type.Vector = @typeInfo(Vector).vector;
        const Extrema = ExtremaBest(vec_info.child);
        const Absolute = @TypeOf(@abs(@as(vec_info.child, undefined)));
        const ShiftAmt = @Vector(vec_info.len, u16);
        const ScalarFormat = ScalarArithOverflow(vec_info.child);
        fn simple(
            id: std.builtin.Panic.Id,
            type_name: []const u8,
            extrema: Extrema,
            lhs_vec: Vector,
            rhs_vec: Vector,
            ret_addr: usize,
        ) noreturn {
            @setRuntimeSafety(false);
            if (builtin.zig_backend != .stage2_llvm)
                std.debug.defaultPanic(messages[@intFromEnum(id)], ret_addr);
            var buf: [vec_info.len * 384]u8 = undefined;
            var ptr: [*]u8 = writeWhatOverflowed(&buf, messages[@intFromEnum(id)], type_name);
            ptr = writeElementsOutOfRange(ptr, extrema);
            for (0..vec_info.len) |idx| {
                ptr = writeVectorIndex(ptr, idx);
                const lhs: vec_info.child = lhs_vec[idx];
                const rhs: vec_info.child = rhs_vec[idx];
                const yn: bool = switch (id) {
                    .add_overflowed => rhs < 0,
                    .sub_overflowed => rhs > 0,
                    .mul_overflowed, .div_overflowed => (rhs < 0 and lhs > 0) or (rhs > 0 and lhs < 0),
                    else => unreachable,
                };
                ptr = ScalarFormat.writeOverflowed(ptr, null, type_name, switch (id) {
                    .add_overflowed => " + ",
                    .sub_overflowed => " - ",
                    .mul_overflowed => " * ",
                    .div_overflowed => " / ",
                    else => unreachable,
                }, lhs, rhs, switch (id) {
                    .add_overflowed => &@addWithOverflow(lhs, rhs),
                    .sub_overflowed => &@subWithOverflow(lhs, rhs),
                    .mul_overflowed => &@mulWithOverflow(lhs, rhs),
                    .div_overflowed => null,
                    else => unreachable,
                });
                ptr = cpyEqu(ptr[0..16], if (yn) " below minimum" else " above maximum");
            }
            std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
        }
        fn shift(
            id: std.builtin.Panic.Id,
            type_name: []const u8,
            values: Vector,
            shift_amts: ShiftAmt,
            mask: Absolute,
            ret_addr: usize,
        ) noreturn {
            @setRuntimeSafety(false);
            const panic_message: []const u8 = messages[@intFromEnum(id)];
            if (builtin.zig_backend != .stage2_llvm) std.debug.defaultPanic(panic_message, ret_addr);
            const writeFn = &switch (id) {
                .shl_overflowed => ScalarFormat.writeShl,
                .shr_overflowed => ScalarFormat.writeShr,
                else => unreachable,
            };
            var buf: [vec_info.len * 384]u8 = undefined;
            var ptr: [*]u8 = writeWhatOverflowed(&buf, panic_message, type_name);
            for (0..vec_info.len) |idx| {
                ptr = writeVectorIndex(ptr, idx);
                ptr = writeFn(ptr, type_name, values[idx], shift_amts[idx], mask, false);
            }
            std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
        }
        fn shiftRhs(
            type_name: []const u8,
            bit_count: u16,
            shift_amts: ShiftAmt,
            ret_addr: usize,
        ) noreturn {
            @setRuntimeSafety(false);
            if (builtin.zig_backend != .stage2_llvm) std.debug.defaultPanic(message_strings.shift_amt_overflowed, ret_addr);
            var buf: [vec_info.len * 384]u8 = undefined;
            var ptr: [*]u8 = &buf;
            for (0..vec_info.len) |idx| {
                ptr = writeVectorIndex(ptr, idx);
                ptr = ScalarFormat.writeShiftRhs(ptr, type_name, bit_count, shift_amts[idx]);
            }
            std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
        }
    };
    return T;
}
fn ScalarArithOverflow(comptime Value: type) type {
    const T = struct {
        const Extrema = ExtremaBest(Value);
        const large: bool = @bitSizeOf(Value) > @bitSizeOf(usize);
        const Absolute = @TypeOf(@abs(@as(Value, undefined)));
        const writeInt = writeIntDec;
        fn simple(
            id: std.builtin.Panic.Id,
            type_name: []const u8,
            extrema: Extrema,
            lhs: Value,
            rhs: Value,
            ret_addr: usize,
        ) noreturn {
            @setRuntimeSafety(false);
            var buf: [256]u8 = undefined;
            const yn: bool = switch (id) {
                .add_overflowed => rhs < 0,
                .sub_overflowed => rhs > 0,
                .mul_overflowed, .div_overflowed => (rhs < 0 and lhs > 0) or (rhs > 0 and lhs < 0),
                else => unreachable,
            };
            var ptr: [*]u8 = writeOverflowed(&buf, messages[@intFromEnum(id)], type_name, switch (id) {
                .add_overflowed => " + ",
                .sub_overflowed => " - ",
                .mul_overflowed => " * ",
                .div_overflowed => " / ",
                else => unreachable,
            }, lhs, rhs, switch (id) {
                .add_overflowed => &@addWithOverflow(lhs, rhs),
                .sub_overflowed => &@subWithOverflow(lhs, rhs),
                .mul_overflowed => &@mulWithOverflow(lhs, rhs),
                .div_overflowed => null,
                else => unreachable,
            });
            ptr = writeAboveOrBelowLimitExtra(ptr, Value, type_name, yn, if (yn) extrema.min else extrema.max);
            std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
        }
        fn shift(
            id: std.builtin.Panic.Id,
            type_name: []const u8,
            value: Value,
            shift_amt: u16,
            mask: Absolute,
            ret_addr: usize,
        ) noreturn {
            @setRuntimeSafety(false);
            if (large) std.debug.defaultPanic(messages[@intFromEnum(id)], null, ret_addr);
            const writeFn = &switch (id) {
                .shr_overflowed => writeShr,
                .shl_overflowed => writeShl,
                else => unreachable,
            };
            var buf: [256]u8 = undefined;
            const ptr: [*]u8 = writeFn(&buf, type_name, value, shift_amt, mask, true);
            std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
        }
        fn shiftRhs(
            type_name: []const u8,
            bit_count: u16,
            shift_amt: u16,
            ret_addr: usize,
        ) noreturn {
            @setRuntimeSafety(false);
            if (large) std.debug.defaultPanic(message_strings.shift_amt_overflowed, null, ret_addr);
            var buf: [256]u8 = undefined;
            const ptr: [*]u8 = writeShiftRhsVerbose(&buf, type_name, bit_count, shift_amt);
            std.debug.defaultPanic(buf[0 .. ptr - &buf], null, ret_addr);
        }
        fn writeShl(
            buf: [*]u8,
            type_name: []const u8,
            value: Value,
            shift_amt: u16,
            mask: Absolute,
            what: bool,
        ) [*]u8 {
            @setRuntimeSafety(false);
            const a_pc: u16 = @popCount(@abs(value) & mask);
            const b_pc: u16 = @popCount((@abs(value) << @intCast(shift_amt)) & mask);
            const ov: bool = Absolute != Value and (value << @truncate(shift_amt)) < value;
            var ptr: [*]u8 = buf;
            if (what) {
                ptr[0..23].* = "left shift overflowed '".*;
                ptr = cpyEquTrunc(buf[23..][0..64], type_name);
                ptr[0..3].* = "': ".*;
                ptr += 3;
            }
            ptr = writeInt(ptr, value);
            ptr[0..4].* = " << ".*;
            ptr = writeInt(ptr + 4, shift_amt);
            if (a_pc > b_pc) ptr = writeShiftedOutBits(ptr, a_pc -% b_pc);
            if (ov) {
                ptr[0..22].* = " (overflowed sign bit)".*;
                ptr += 22;
            }
            return ptr;
        }
        fn writeShr(
            buf: [*]u8,
            type_name: []const u8,
            value: Value,
            shift_amt: u16,
            mask: Absolute,
            what: bool,
        ) [*]u8 {
            @setRuntimeSafety(false);
            const a_pc: u16 = @popCount(@abs(value) & mask);
            const b_pc: u16 = @popCount((@abs(value) >> @intCast(shift_amt)) & mask);
            var ptr: [*]u8 = buf;
            if (what) {
                ptr[0..24].* = "right shift overflowed '".*;
                ptr = cpyEquTrunc(ptr[24..][0..64], type_name);
                ptr[0..3].* = "': ".*;
                ptr += 3;
            }
            ptr = writeInt(ptr, value);
            ptr[0..4].* = " >> ".*;
            ptr = writeInt(ptr + 4, shift_amt);
            if (a_pc > b_pc) ptr = writeShiftedOutBits(ptr, a_pc -% b_pc);
            return ptr;
        }
        fn writeShiftRhs(
            buf: [*]u8,
            type_name: []const u8,
            bit_count: u16,
            shift_amt: u16,
        ) [*]u8 {
            @setRuntimeSafety(false);
            var ptr: [*]u8 = cpyEquTrunc(buf[0..64], type_name);
            ptr[0..23].* = " RHS of shift too big: ".*;
            ptr = writeInt(ptr + 23, shift_amt);
            ptr[0..3].* = " > ".*;
            return writeInt(ptr + 3, bit_count);
        }
        fn writeShiftRhsVerbose(
            buf: [*]u8,
            type_name: []const u8,
            bit_count: u16,
            shift_amt: u16,
        ) [*]u8 {
            @setRuntimeSafety(false);
            var ptr: [*]u8 = buf;
            if (shift_amt == bit_count) {
                ptr[0..61].* = "shift amount equal to bit-width of destination integer type '".*;
                ptr = cpyEquTrunc(ptr[61..][0..64], type_name);
            } else {
                ptr[0..14].* = "shift amount (".*;
                ptr = writeInt(ptr + 14, shift_amt);
                ptr[0..49].* = ") exceeds bit-width of destination integer type '".*;
                ptr = cpyEquTrunc(ptr[49..][0..64], type_name);
            }
            ptr[0] = '\'';
            return ptr + 1;
        }
        fn writeOverflowed(
            buf: [*]u8,
            op_name_opt: ?[]const u8,
            type_name: []const u8,
            op_sym: *const [3]u8,
            lhs: Value,
            rhs: Value,
            res_opt: ?*const struct { Value, u1 },
        ) [*]u8 {
            @setRuntimeSafety(false);
            var ptr: [*]u8 = buf;
            if (op_name_opt) |op_name| {
                ptr = cpyEquTrunc(ptr[0..32], op_name);
                ptr[0..2].* = " '".*;
                ptr = cpyEquTrunc(ptr[0..64], type_name);
                ptr[0..3].* = "': ".*;
                ptr += 3;
            }
            ptr = writeInt(ptr, lhs);
            ptr[0..3].* = op_sym.*;
            ptr = writeInt(ptr + 3, rhs);
            if (res_opt) |res| {
                if (res[1] == 0) {
                    ptr[0..2].* = " (".*;
                    ptr = writeInt(ptr + 2, res[0]);
                    ptr[0] = ')';
                    ptr += 1;
                }
            }
            return ptr;
        }
        fn writeShiftedOutBits(
            buf: [*]u8,
            ov_bits: u16,
        ) [*]u8 {
            @setRuntimeSafety(false);
            var ptr: [*]u8 = writeInt(buf + 14, ov_bits);
            buf[0..14].* = " (shifted out ".*;
            ptr[0..4].* = " bit".*;
            return cpyEquTrunc(ptr[4..][0..3], "s)"[@intFromBool(ov_bits == 1)..]);
        }
    };
    return T;
}

pub fn testWriterFunction(comptime n: comptime_int, expected: []const u8, comptime fn_name: []const u8, args: anytype) !void {
    var buf: [n]u8 = .{0} ** n;
    _ = @call(.auto, @field(@This(), fn_name), .{&buf} ++ args);
    return std.testing.expectEqualStrings(&buf, expected);
}

const std = @import("../std.zig");
const builtin = @import("builtin");
