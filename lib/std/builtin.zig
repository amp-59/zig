//! Types and values provided by the Zig language.

const builtin = @import("builtin");

/// `explicit_subsystem` is missing when the subsystem is automatically detected,
/// so Zig standard library has the subsystem detection logic here. This should generally be
/// used rather than `explicit_subsystem`.
/// On non-Windows targets, this is `null`.
pub const subsystem: ?std.Target.SubSystem = blk: {
    if (@hasDecl(builtin, "explicit_subsystem")) break :blk builtin.explicit_subsystem;
    switch (builtin.os.tag) {
        .windows => {
            if (builtin.is_test) {
                break :blk std.Target.SubSystem.Console;
            }
            if (@hasDecl(root, "main") or
                @hasDecl(root, "WinMain") or
                @hasDecl(root, "wWinMain") or
                @hasDecl(root, "WinMainCRTStartup") or
                @hasDecl(root, "wWinMainCRTStartup"))
            {
                break :blk std.Target.SubSystem.Windows;
            } else {
                break :blk std.Target.SubSystem.Console;
            }
        },
        else => break :blk null,
    }
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const StackTrace = struct {
    index: usize,
    instruction_addresses: []usize,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const GlobalLinkage = enum {
    internal,
    strong,
    weak,
    link_once,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const SymbolVisibility = enum {
    default,
    hidden,
    protected,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const AtomicOrder = enum {
    unordered,
    monotonic,
    acquire,
    release,
    acq_rel,
    seq_cst,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const ReduceOp = enum {
    And,
    Or,
    Xor,
    Min,
    Max,
    Add,
    Mul,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const AtomicRmwOp = enum {
    /// Exchange - store the operand unmodified.
    /// Supports enums, integers, and floats.
    Xchg,
    /// Add operand to existing value.
    /// Supports integers and floats.
    /// For integers, two's complement wraparound applies.
    Add,
    /// Subtract operand from existing value.
    /// Supports integers and floats.
    /// For integers, two's complement wraparound applies.
    Sub,
    /// Perform bitwise AND on existing value with operand.
    /// Supports integers.
    And,
    /// Perform bitwise NAND on existing value with operand.
    /// Supports integers.
    Nand,
    /// Perform bitwise OR on existing value with operand.
    /// Supports integers.
    Or,
    /// Perform bitwise XOR on existing value with operand.
    /// Supports integers.
    Xor,
    /// Store operand if it is larger than the existing value.
    /// Supports integers and floats.
    Max,
    /// Store operand if it is smaller than the existing value.
    /// Supports integers and floats.
    Min,
};

/// The code model puts constraints on the location of symbols and the size of code and data.
/// The selection of a code model is a trade off on speed and restrictions that needs to be selected on a per application basis to meet its requirements.
/// A slightly more detailed explanation can be found in (for example) the [System V Application Binary Interface (x86_64)](https://github.com/hjl-tools/x86-psABI/wiki/x86-64-psABI-1.0.pdf) 3.5.1.
///
/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const CodeModel = enum {
    default,
    tiny,
    small,
    kernel,
    medium,
    large,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const OptimizeMode = enum {
    Debug,
    ReleaseSafe,
    ReleaseFast,
    ReleaseSmall,
};

/// Deprecated; use OptimizeMode.
pub const Mode = OptimizeMode;

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const CallingConvention = enum(u8) {
    /// This is the default Zig calling convention used when not using `export` on `fn`
    /// and no other calling convention is specified.
    Unspecified,
    /// Matches the C ABI for the target.
    /// This is the default calling convention when using `export` on `fn`
    /// and no other calling convention is specified.
    C,
    /// This makes a function not have any function prologue or epilogue,
    /// making the function itself uncallable in regular Zig code.
    /// This can be useful when integrating with assembly.
    Naked,
    /// Functions with this calling convention are called asynchronously,
    /// as if called as `async function()`.
    Async,
    /// Functions with this calling convention are inlined at all call sites.
    Inline,
    /// x86-only.
    Interrupt,
    Signal,
    /// x86-only.
    Stdcall,
    /// x86-only.
    Fastcall,
    /// x86-only.
    Vectorcall,
    /// x86-only.
    Thiscall,
    /// ARM Procedure Call Standard (obsolete)
    /// ARM-only.
    APCS,
    /// ARM Architecture Procedure Call Standard (current standard)
    /// ARM-only.
    AAPCS,
    /// ARM Architecture Procedure Call Standard Vector Floating-Point
    /// ARM-only.
    AAPCSVFP,
    /// x86-64-only.
    SysV,
    /// x86-64-only.
    Win64,
    /// AMD GPU, NVPTX, or SPIR-V kernel
    Kernel,
    // Vulkan-only
    Fragment,
    Vertex,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const AddressSpace = enum(u5) {
    // CPU address spaces.
    generic,
    gs,
    fs,
    ss,

    // GPU address spaces.
    global,
    constant,
    param,
    shared,
    local,
    input,
    output,
    uniform,

    // AVR address spaces.
    flash,
    flash1,
    flash2,
    flash3,
    flash4,
    flash5,

    // Propeller address spaces.

    /// This address space only addresses the cog-local ram.
    cog,

    /// This address space only addresses shared hub ram.
    hub,

    /// This address space only addresses the "lookup" ram
    lut,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const SourceLocation = struct {
    /// The name chosen when compiling. Not a file path.
    module: [:0]const u8,
    /// Relative to the root directory of its module.
    file: [:0]const u8,
    fn_name: [:0]const u8,
    line: u32,
    column: u32,
};

pub const TypeId = std.meta.Tag(Type);

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const Type = union(enum) {
    type: void,
    void: void,
    bool: void,
    noreturn: void,
    int: Int,
    float: Float,
    pointer: Pointer,
    array: Array,
    @"struct": Struct,
    comptime_float: void,
    comptime_int: void,
    undefined: void,
    null: void,
    optional: Optional,
    error_union: ErrorUnion,
    error_set: ErrorSet,
    @"enum": Enum,
    @"union": Union,
    @"fn": Fn,
    @"opaque": Opaque,
    frame: Frame,
    @"anyframe": AnyFrame,
    vector: Vector,
    enum_literal: void,

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const Int = struct {
        signedness: Signedness,
        bits: u16,
    };

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const Float = struct {
        bits: u16,
    };

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const Pointer = struct {
        size: Size,
        is_const: bool,
        is_volatile: bool,
        /// TODO make this u16 instead of comptime_int
        alignment: comptime_int,
        address_space: AddressSpace,
        child: type,
        is_allowzero: bool,

        /// The type of the sentinel is the element type of the pointer, which is
        /// the value of the `child` field in this struct. However there is no way
        /// to refer to that type here, so we use pointer to `anyopaque`.
        sentinel: ?*const anyopaque,

        /// This data structure is used by the Zig language code generation and
        /// therefore must be kept in sync with the compiler implementation.
        pub const Size = enum(u2) {
            One,
            Many,
            Slice,
            C,
        };
    };

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const Array = struct {
        len: comptime_int,
        child: type,

        /// The type of the sentinel is the element type of the array, which is
        /// the value of the `child` field in this struct. However there is no way
        /// to refer to that type here, so we use pointer to `anyopaque`.
        sentinel: ?*const anyopaque,
    };

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const ContainerLayout = enum(u2) {
        auto,
        @"extern",
        @"packed",
    };

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const StructField = struct {
        name: [:0]const u8,
        type: type,
        default_value: ?*const anyopaque,
        is_comptime: bool,
        alignment: comptime_int,
    };

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const Struct = struct {
        layout: ContainerLayout,
        /// Only valid if layout is .@"packed"
        backing_integer: ?type = null,
        fields: []const StructField,
        decls: []const Declaration,
        is_tuple: bool,
    };

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const Optional = struct {
        child: type,
    };

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const ErrorUnion = struct {
        error_set: type,
        payload: type,
    };

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const Error = struct {
        name: [:0]const u8,
    };

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const ErrorSet = ?[]const Error;

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const EnumField = struct {
        name: [:0]const u8,
        value: comptime_int,
    };

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const Enum = struct {
        tag_type: type,
        fields: []const EnumField,
        decls: []const Declaration,
        is_exhaustive: bool,
    };

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const UnionField = struct {
        name: [:0]const u8,
        type: type,
        alignment: comptime_int,
    };

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const Union = struct {
        layout: ContainerLayout,
        tag_type: ?type,
        fields: []const UnionField,
        decls: []const Declaration,
    };

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const Fn = struct {
        calling_convention: CallingConvention,
        is_generic: bool,
        is_var_args: bool,
        /// TODO change the language spec to make this not optional.
        return_type: ?type,
        params: []const Param,

        /// This data structure is used by the Zig language code generation and
        /// therefore must be kept in sync with the compiler implementation.
        pub const Param = struct {
            is_generic: bool,
            is_noalias: bool,
            type: ?type,
        };
    };

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const Opaque = struct {
        decls: []const Declaration,
    };

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const Frame = struct {
        function: *const anyopaque,
    };

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const AnyFrame = struct {
        child: ?type,
    };

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const Vector = struct {
        len: comptime_int,
        child: type,
    };

    /// This data structure is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const Declaration = struct {
        name: [:0]const u8,
    };
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const FloatMode = enum {
    strict,
    optimized,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const Endian = enum {
    big,
    little,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const Signedness = enum {
    signed,
    unsigned,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const OutputMode = enum {
    Exe,
    Lib,
    Obj,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const LinkMode = enum {
    static,
    dynamic,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const WasiExecModel = enum {
    command,
    reactor,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const CallModifier = enum {
    /// Equivalent to function call syntax.
    auto,

    /// Equivalent to async keyword used with function call syntax.
    async_kw,

    /// Prevents tail call optimization. This guarantees that the return
    /// address will point to the callsite, as opposed to the callsite's
    /// callsite. If the call is otherwise required to be tail-called
    /// or inlined, a compile error is emitted instead.
    never_tail,

    /// Guarantees that the call will not be inlined. If the call is
    /// otherwise required to be inlined, a compile error is emitted instead.
    never_inline,

    /// Asserts that the function call will not suspend. This allows a
    /// non-async function to call an async function.
    no_async,

    /// Guarantees that the call will be generated with tail call optimization.
    /// If this is not possible, a compile error is emitted instead.
    always_tail,

    /// Guarantees that the call will be inlined at the callsite.
    /// If this is not possible, a compile error is emitted instead.
    always_inline,

    /// Evaluates the call at compile-time. If the call cannot be completed at
    /// compile-time, a compile error is emitted instead.
    compile_time,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const VaListAarch64 = extern struct {
    __stack: *anyopaque,
    __gr_top: *anyopaque,
    __vr_top: *anyopaque,
    __gr_offs: c_int,
    __vr_offs: c_int,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const VaListHexagon = extern struct {
    __gpr: c_long,
    __fpr: c_long,
    __overflow_arg_area: *anyopaque,
    __reg_save_area: *anyopaque,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const VaListPowerPc = extern struct {
    gpr: u8,
    fpr: u8,
    reserved: c_ushort,
    overflow_arg_area: *anyopaque,
    reg_save_area: *anyopaque,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const VaListS390x = extern struct {
    __current_saved_reg_area_pointer: *anyopaque,
    __saved_reg_area_end_pointer: *anyopaque,
    __overflow_area_pointer: *anyopaque,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const VaListX86_64 = extern struct {
    gp_offset: c_uint,
    fp_offset: c_uint,
    overflow_arg_area: *anyopaque,
    reg_save_area: *anyopaque,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const VaList = switch (builtin.cpu.arch) {
    .aarch64, .aarch64_be => switch (builtin.os.tag) {
        .windows => *u8,
        .ios, .macos, .tvos, .watchos, .visionos => *u8,
        else => @compileError("disabled due to miscompilations"), // VaListAarch64,
    },
    .arm, .armeb, .thumb, .thumbeb => switch (builtin.os.tag) {
        .ios, .macos, .tvos, .watchos, .visionos => *u8,
        else => *anyopaque,
    },
    .amdgcn => *u8,
    .avr => *anyopaque,
    .bpfel, .bpfeb => *anyopaque,
    .hexagon => if (builtin.target.isMusl()) VaListHexagon else *u8,
    .loongarch32, .loongarch64 => *anyopaque,
    .mips, .mipsel, .mips64, .mips64el => *anyopaque,
    .riscv32, .riscv64 => *anyopaque,
    .powerpc, .powerpcle => switch (builtin.os.tag) {
        .ios, .macos, .tvos, .watchos, .visionos, .aix => *u8,
        else => VaListPowerPc,
    },
    .powerpc64, .powerpc64le => *u8,
    .sparc, .sparc64 => *anyopaque,
    .spirv32, .spirv64 => *anyopaque,
    .s390x => VaListS390x,
    .wasm32, .wasm64 => *anyopaque,
    .x86 => *u8,
    .x86_64 => switch (builtin.os.tag) {
        .windows => @compileError("disabled due to miscompilations"), // *u8,
        else => VaListX86_64,
    },
    else => @compileError("VaList not supported for this target yet"),
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const PrefetchOptions = struct {
    /// Whether the prefetch should prepare for a read or a write.
    rw: Rw = .read,
    /// The data's locality in an inclusive range from 0 to 3.
    ///
    /// 0 means no temporal locality. That is, the data can be immediately
    /// dropped from the cache after it is accessed.
    ///
    /// 3 means high temporal locality. That is, the data should be kept in
    /// the cache as it is likely to be accessed again soon.
    locality: u2 = 3,
    /// The cache that the prefetch should be performed on.
    cache: Cache = .data,

    pub const Rw = enum(u1) {
        read,
        write,
    };

    pub const Cache = enum(u1) {
        instruction,
        data,
    };
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const ExportOptions = struct {
    name: []const u8,
    linkage: GlobalLinkage = .strong,
    section: ?[]const u8 = null,
    visibility: SymbolVisibility = .default,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const ExternOptions = struct {
    name: []const u8,
    library_name: ?[]const u8 = null,
    linkage: GlobalLinkage = .strong,
    is_thread_local: bool = false,
};

/// This data structure is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const BranchHint = enum(u3) {
    /// Equivalent to no hint given.
    none,
    /// This branch of control flow is more likely to be reached than its peers.
    /// The optimizer should optimize for reaching it.
    likely,
    /// This branch of control flow is less likely to be reached than its peers.
    /// The optimizer should optimize for not reaching it.
    unlikely,
    /// This branch of control flow is unlikely to *ever* be reached.
    /// The optimizer may place it in a different page of memory to optimize other branches.
    cold,
    /// It is difficult to predict whether this branch of control flow will be reached.
    /// The optimizer should avoid branching behavior with expensive mispredictions.
    unpredictable,
};

/// This enum is set by the compiler and communicates which compiler backend is
/// used to produce machine code.
/// Think carefully before deciding to observe this value. Nearly all code should
/// be agnostic to the backend that implements the language. The use case
/// to use this value is to **work around problems with compiler implementations.**
///
/// Avoid failing the compilation if the compiler backend does not match a
/// whitelist of backends; rather one should detect that a known problem would
/// occur in a blacklist of backends.
///
/// The enum is nonexhaustive so that alternate Zig language implementations may
/// choose a number as their tag (please use a random number generator rather
/// than a "cute" number) and codebases can interact with these values even if
/// this upstream enum does not have a name for the number. Of course, upstream
/// is happy to accept pull requests to add Zig implementations to this enum.
///
/// This data structure is part of the Zig language specification.
pub const CompilerBackend = enum(u64) {
    /// It is allowed for a compiler implementation to not reveal its identity,
    /// in which case this value is appropriate. Be cool and make sure your
    /// code supports `other` Zig compilers!
    other = 0,
    /// The original Zig compiler created in 2015 by Andrew Kelley. Implemented
    /// in C++. Used LLVM. Deleted from the ZSF ziglang/zig codebase on
    /// December 6th, 2022.
    stage1 = 1,
    /// The reference implementation self-hosted compiler of Zig, using the
    /// LLVM backend.
    stage2_llvm = 2,
    /// The reference implementation self-hosted compiler of Zig, using the
    /// backend that generates C source code.
    /// Note that one can observe whether the compilation will output C code
    /// directly with `object_format` value rather than the `compiler_backend` value.
    stage2_c = 3,
    /// The reference implementation self-hosted compiler of Zig, using the
    /// WebAssembly backend.
    stage2_wasm = 4,
    /// The reference implementation self-hosted compiler of Zig, using the
    /// arm backend.
    stage2_arm = 5,
    /// The reference implementation self-hosted compiler of Zig, using the
    /// x86_64 backend.
    stage2_x86_64 = 6,
    /// The reference implementation self-hosted compiler of Zig, using the
    /// aarch64 backend.
    stage2_aarch64 = 7,
    /// The reference implementation self-hosted compiler of Zig, using the
    /// x86 backend.
    stage2_x86 = 8,
    /// The reference implementation self-hosted compiler of Zig, using the
    /// riscv64 backend.
    stage2_riscv64 = 9,
    /// The reference implementation self-hosted compiler of Zig, using the
    /// sparc64 backend.
    stage2_sparc64 = 10,
    /// The reference implementation self-hosted compiler of Zig, using the
    /// spirv backend.
    stage2_spirv64 = 11,

    _,
};

/// This function type is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const TestFn = struct {
    name: []const u8,
    func: *const fn () anyerror!void,
};

/// This namespace is used by the Zig compiler to emit various kinds of safety
/// panics. These can be overridden by making a public `Panic` namespace in the
/// root source file.
pub const panic = if (@hasDecl(root, "panic"))
    root.panic
else if (builtin.zig_backend == .stage2_riscv64)
    std.debug.SimplePanic.call
else
    std.debug.FormattedPanic.call;

pub fn checkNonScalarSentinel(expected: anytype, actual: @TypeOf(expected)) void {
    if (!std.meta.eql(expected, actual)) {
        panicSentinelMismatch(expected, actual);
    }
}

/// To be deleted after zig1.wasm is updated.
pub const panicSentinelMismatch = std.debug.FormattedPanic.sentinelMismatch;
/// To be deleted after zig1.wasm is updated.
pub const panicUnwrapError = std.debug.FormattedPanic.unwrapError;
/// To be deleted after zig1.wasm is updated.
pub const panicOutOfBounds = std.debug.FormattedPanic.outOfBounds;
/// To be deleted after zig1.wasm is updated.
pub const panicStartGreaterThanEnd = std.debug.FormattedPanic.startGreaterThanEnd;
/// To be deleted after zig1.wasm is updated.
pub const panicInactiveUnionField = std.debug.FormattedPanic.inactiveUnionField;
/// To be deleted after zig1.wasm is updated.
pub const panic_messages = std.debug.FormattedPanic.messages;

pub noinline fn returnError(st: *StackTrace) void {
    @branchHint(.unlikely);
    @setRuntimeSafety(false);
    if (st.index < st.instruction_addresses.len)
        st.instruction_addresses[st.index] = @returnAddress();
    st.index += 1;
}

/// This function is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const panic2 = if (@hasDecl(root, "panic2"))
    root.panic2
else if (builtin.mode == .Debug)
    std.debug.Panic.canonical
else
    std.debug.Panic.simple;

/// This type is used by the Zig language code generation and
/// therefore must be kept in sync with the compiler implementation.
pub const Panic = struct {
    /// This type is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const Id = @typeInfo(Cause).@"union".tag_type.?;

    /// This type is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    ///
    /// Used by panic cause `unwrapped_error`.
    pub const ErrorStackTrace = struct {
        st: ?*StackTrace,
        err: anyerror,
    };

    /// This type is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    ///
    /// Used by panic cause `unwrapped_error_extra`.
    pub const ErrorStackTraceExtra = struct {
        st: ?*StackTrace,
        err: anyerror,
        msg: []const u8,
    };

    /// This type is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    ///
    /// Used by panic cause `index_out_of_bounds`.
    pub const IndexBounds = struct {
        index: usize,
        length: usize,
    };

    /// This type is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    ///
    /// Used by panic cause `reference_out_of_order`.
    pub const OrderedBounds = struct {
        start: usize,
        end: usize,
    };

    /// This type is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    ///
    /// Used by panic cause `reference_out_of_order_extra`.
    pub const OrderedBoundsExtra = struct {
        start: usize,
        end: usize,
        length: usize,
    };

    /// This type is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    ///
    /// Used by panic cause `cast_to_ptr_from_invalid`.
    pub const Address = struct {
        value: usize,
        alignment: usize,
    };

    /// This type is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    ///
    /// Used by panic cause `memcpy_argument_aliasing`.
    pub const AddressRanges = struct {
        dest_start: usize,
        dest_end: usize,
        src_start: usize,
        src_end: usize,
    };

    /// This type is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    ///
    /// Used by panic cause `mismatched_memcpy_argument_lengths`.
    pub const ArgumentLengths = struct {
        dest_len: usize,
        src_len: usize,
    };

    /// This type is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    ///
    /// Used by panic cause `mismatched_for_loop_capture_lengths`.
    pub const CaptureLengths = struct {
        loop_len: usize,
        capture_len: usize,
    };

    /// This type is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    ///
    /// Used by panic causes involving an invalid cast where both types are
    /// relevant: `cast_to_error_from_invalid`, `cast_to_int_from_invalid`,
    /// `cast_to_ptr_from_invalid`, and `cast_to_unsigned_from_negative`.
    pub const Cast = struct { to: type, from: type };

    /// This type is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    ///
    /// This panic function type only permits message data or the ID of the
    /// panic cause. This is the default mode for `Fast` and `Small` builds
    /// with runtime safety.
    pub const SimpleFn = fn (anytype) noreturn;

    /// This type is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    ///
    /// This panic function type allows that any information relevant to the
    /// cause of panic be forwarded to the panic handler. This is the default
    /// mode for `Debug` builds with runtime safety.
    pub const GenericFn = fn (comptime Cause, anytype) noreturn;

    /// This type is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    ///
    /// This panic function type instantiates a single function with a
    /// predictable name. The type of the optional pointer parameter is
    /// determined by the ID. See type function `Data` below for each data type.
    ///
    /// The canonical mode only supports data for a subset of panic causes.
    /// Causes related to invalid casts, undefined arithmetic, and invalid union
    /// field accesses are not supported.
    pub const CanonicalFn = fn (Id, ?*const anyopaque) callconv(.C) noreturn;

    /// This type is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub const Cause = union(enum(u8)) {
        // `@panic`
        message,
        // `err => unreachable` and `catch unreachable`
        unwrapped_error,
        // `err => @panic(msg)` and `catch @panic(msg)`
        unwrapped_error_extra,
        // functions marked `noreturn` which return.
        returned_noreturn,
        // `unreachable`.
        reached_unreachable,
        // Implicit `else => {}` on tags with unused values.
        corrupt_switch,

        // `ptr[idx]`
        index_out_of_bounds,
        // `slice[0..idx]`
        reference_out_of_bounds,
        // `ptr[start..end]`
        reference_out_of_order,
        // `slice[start..end]`
        reference_out_of_order_extra,

        /// Tagged union field accesses.
        accessed_inactive_field: type,
        /// `.?` and slicing C pointers.
        accessed_null_value,
        /// Division in general.
        divided_by_zero,
        /// `@memcpy`
        memcpy_argument_aliasing,

        /// `@memcpy`
        mismatched_memcpy_argument_lengths,
        /// `for (x, y) |xx, yy| {}`
        mismatched_for_loop_capture_lengths,
        /// Any operation asserting a sentinel.
        mismatched_sentinel: type,
        /// Operations asserting a sentinel with value `@as(u8, 0)`.
        mismatched_sentinel_null,

        /// `@shlExact`
        shl_overflowed: type,
        /// `@shrExact`
        shr_overflowed: type,
        /// Any bit-shift where the integer type is not a power-of-two.
        shift_amt_overflowed: type,
        /// `@divExact`
        div_with_remainder: type,
        /// `*`
        mul_overflowed: type,
        /// `+`
        add_overflowed: type,
        /// `-`
        sub_overflowed: type,
        /// `/`, `@divTrunc`, and `@divCeil`.
        div_overflowed: type,

        /// `@intCast`
        cast_truncated_data: Cast,
        /// `@enumFromint` and `@tagName`.
        cast_to_enum_from_invalid: type,
        /// `@errorCast` and  `@errorFromInt`.
        cast_to_error_from_invalid: Cast,
        /// `@ptrCast` and  `@ptrFromInt`.
        cast_to_ptr_from_invalid,
        /// `@intFromFloat`
        cast_to_int_from_invalid: Cast,
        /// `@intCast`
        cast_to_unsigned_from_negative: Cast,
    };

    /// This function is used by the Zig language code generation and
    /// therefore must be kept in sync with the compiler implementation.
    pub fn Data(comptime cause: Cause) type {
        switch (cause) {
            .message => {
                return []const u8;
            },
            .returned_noreturn,
            .reached_unreachable,
            .accessed_null_value,
            .divided_by_zero,
            .corrupt_switch,
            => {
                return void;
            },
            .unwrapped_error => {
                return ErrorStackTrace;
            },
            .unwrapped_error_extra => {
                return ErrorStackTraceExtra;
            },
            .index_out_of_bounds => {
                return IndexBounds;
            },
            .reference_out_of_bounds,
            .reference_out_of_order,
            => {
                return OrderedBounds;
            },
            .reference_out_of_order_extra => {
                return OrderedBoundsExtra;
            },
            .memcpy_argument_aliasing => {
                return AddressRanges;
            },
            .mismatched_memcpy_argument_lengths => {
                return ArgumentLengths;
            },
            .mismatched_for_loop_capture_lengths => {
                return CaptureLengths;
            },
            .mismatched_sentinel_null => {
                return u8;
            },
            .mismatched_sentinel => |elem_type| {
                return struct { expected: elem_type, actual: elem_type };
            },
            .accessed_inactive_field => |tag_type| {
                return struct { expected: tag_type, found: tag_type };
            },
            .mul_overflowed,
            .add_overflowed,
            .sub_overflowed,
            .div_overflowed,
            .div_with_remainder,
            => |val_type| {
                return struct { lhs: val_type, rhs: val_type };
            },
            .shl_overflowed,
            .shr_overflowed,
            => |val_type| {
                switch (@typeInfo(val_type)) {
                    .int => {
                        return struct { value: val_type, shift_amt: u16 };
                    },
                    else => |info| {
                        return struct { value: val_type, shift_amt: @Vector(info.vector.len, u16) };
                    },
                }
            },
            .shift_amt_overflowed => |val_type| {
                switch (@typeInfo(val_type)) {
                    .int => {
                        return u16;
                    },
                    else => |info| {
                        return @Vector(info.vector.len, u16);
                    },
                }
            },
            .cast_to_ptr_from_invalid => {
                return Address;
            },
            .cast_to_int_from_invalid,
            .cast_truncated_data,
            .cast_to_unsigned_from_negative,
            .cast_to_error_from_invalid,
            => |num_types| {
                return num_types.from;
            },
            .cast_to_enum_from_invalid => |enum_type| {
                return @typeInfo(enum_type).@"enum".tag_type;
            },
        }
    }

    // For compatibility with master.
    pub const call = std.debug.FormattedPanic.call;
    pub const sentinelMismatch = std.debug.FormattedPanic.sentinelMismatch;
    pub const unwrapError = std.debug.FormattedPanic.unwrapError;
    pub const outOfBounds = std.debug.FormattedPanic.outOfBounds;
    pub const startGreaterThanEnd = std.debug.FormattedPanic.startGreaterThanEnd;
    pub const startGreaterThanEndExtra = std.debug.FormattedPanic.startGreaterThanEndExtra;
    pub const inactiveUnionField = std.debug.FormattedPanic.inactiveUnionField;
    pub const messages = std.debug.FormattedPanic.messages;
};

const std = @import("std.zig");
const root = @import("root");
