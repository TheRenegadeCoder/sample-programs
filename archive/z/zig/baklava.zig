const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const spaces = " " ** 10;
    const stars = "*" ** 21;
    var i: i32 = -10;
    while (i <= 10): (i += 1) {
        const numSpaces: usize = @intCast(@abs(i));
        const numStars: usize = 21 - numSpaces * 2;
        try stdout.print("{s}{s}\n", .{spaces[0..numSpaces], stars[0..numStars]});
    }
}
