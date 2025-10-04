const std = @import("std");
const decoder = std.base64.standard.Decoder;
const encoder = std.base64.standard.Encoder;
const process = std.process;

const stdout = std.io.getStdOut().writer();

fn die() !void {
    try stdout.writeAll("Usage: please provide a mode and a string to encode/decode\n");
    process.exit(1);
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var args = process.args();

    _ = args.next();
    const mode_opt = args.next();
    const src_opt = args.next();

    if (mode_opt == null or src_opt == null) {
        try die();
    }

    const mode = mode_opt.?;
    const src = src_opt.?;

    if (src.len == 0) {
        try die();
    }

    if (std.mem.eql(u8, mode, "encode")) {
        const buffer = try allocator.alloc(u8, encoder.calcSize(src.len));
        defer allocator.free(buffer);

        _ = encoder.encode(buffer, src);
        try stdout.writeAll(buffer);
        _ = try stdout.write("\n");
    } else if (std.mem.eql(u8, mode, "decode")) {
        errdefer {
            die() catch unreachable;
        }
        const buflen = try decoder.calcSizeForSlice(src);

        const buffer = try allocator.alloc(u8, buflen);
        defer allocator.free(buffer);

        decoder.decode(buffer, src) catch {
            try die();
        };

        try stdout.writeAll(buffer);
        _ = try stdout.write("\n");
    } else {
        try die();
    }
}
