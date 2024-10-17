const std = @import("std");

pub fn panic2(cause: std.builtin.Panic.Cause, data: anytype) noreturn {
    if (cause == .accessed_inactive_field) {
        if (@hasField(@TypeOf(data.expected), "int") and
            data.found == .float and data.expected == .int)
        {
            std.process.exit(0);
        }
    }
    std.process.exit(1);
}

const Foo = union {
    float: f32,
    int: u32,
};

pub fn main() !void {
    var f = Foo{ .int = 42 };
    bar(&f);
    return error.TestFailed;
}

fn bar(f: *Foo) void {
    f.float = 12.34;
}
// run
// backend=llvm
// target=native
