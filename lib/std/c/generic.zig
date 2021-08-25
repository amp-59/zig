const std = @import("../std.zig");
const Stat = std.c.Stat;
const timespec = std.c.timespec;
const Sigaction = std.c.Sigaction;
const sigset_t = std.c.sigset_t;

pub extern "c" fn realpath(noalias file_name: [*:0]const u8, noalias resolved_name: [*]u8) ?[*:0]u8;
pub extern "c" fn fstatat(dirfd: fd_t, path: [*:0]const u8, stat_buf: *Stat, flags: u32) c_int;
pub extern "c" fn clock_getres(clk_id: c_int, tp: *timespec) c_int;
pub extern "c" fn clock_gettime(clk_id: c_int, tp: *timespec) c_int;
pub extern "c" fn fstat(fd: fd_t, buf: *Stat) c_int;
pub extern "c" fn getrusage(who: c_int, usage: *rusage) c_int;
pub extern "c" fn gettimeofday(noalias tv: ?*timeval, noalias tz: ?*timezone) c_int;
pub extern "c" fn nanosleep(rqtp: *const timespec, rmtp: ?*timespec) c_int;
pub extern "c" fn sched_yield() c_int;
pub extern "c" fn sigaction(sig: c_int, noalias act: ?*const Sigaction, noalias oact: ?*Sigaction) c_int;
pub extern "c" fn sigprocmask(how: c_int, noalias set: ?*const sigset_t, noalias oset: ?*sigset_t) c_int;
pub extern "c" fn socket(domain: c_uint, sock_type: c_uint, protocol: c_uint) c_int;
pub extern "c" fn stat(noalias path: [*:0]const u8, noalias buf: *Stat) c_int;
pub extern "c" fn sigfillset(set: ?*sigset_t) void;
pub extern "c" fn alarm(seconds: c_uint) c_uint;
pub extern "c" fn sigwait(set: ?*sigset_t, sig: ?*c_int) c_int;
