# Sample Programs in Ferret

Welcome to Sample Programs in Ferret!

Ferret takes in Clojure files and compiles them to C++.

## Sample Programs

- [Hello World in Ferret](https://github.com/TheRenegadeCoder/sample-programs/issues/504)

## Running instructions

```bash
$ ./ferret -i hello-world.clj
$ g++ -std=c++11 -pthread hello-world.cpp -o hello-world
$ ./hello-world
Hello, World!
```
## Fun Facts

- License: BSD 2 Clause License

## References

- [Ferret](https://ferret-lang.org/)
