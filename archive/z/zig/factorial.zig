const std = @import("std");

fn factorial(n: u64) u64 {
    if (n == 0) {
        return 1;
    }
    return n * factorial(n - 1);
}

pub fn main() void {
    const num: u64 = 5; // Change this to any number you want to find factorial of
    const result = factorial(num);
    std.debug.print("Factorial of {} is {}\n", .{num, result});
}
