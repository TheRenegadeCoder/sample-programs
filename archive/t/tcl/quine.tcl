proc q {} {foreach {p a} [info level 0] {puts "[list proc $p $a [info body $p]];$p"}};q
