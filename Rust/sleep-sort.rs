extern mod std;
use std::timer::sleep;
use std::uv::global_loop;
fn main() {
    for os::args().tail().each |&arg| {
        do task::spawn {
            let n = uint::from_str(arg).get();
            sleep(global_loop::get(), n);
            io::println(arg);
        }
    }
}
