# Sample Programs in Opa

Welcome to Sample Programs in Opa!

## Sample Programs

- Hello World in Opa

## Fun Facts

- Debut: 2011
- Developer: MLState
- Typing: Static

## How to run

0. To avoid installing dependencies, you can use [Docker](https://docs.docker.com/install/)
1. To compile the `hello-world.opa` file, `cd` into the file's location and run: `docker run -it --rm -v $PWD:/data/ nicovillanueva/opalang:1.1.1 opa /data/hello-world.opa`
2. The compiled file will be `hello-world.js`. Run it via: `docker run -it --rm -v $PWD:/data/ -p 8080:8080 nicovillanueva/opalang:1.1.1 sh -c '/data/hello-world.js'` (or locally, installing the required npm modules)
3. Go to http://localhost:8080

## References

- [Building Opa](https://github.com/MLstate/opalang/wiki/Building-Opa)
- [Hello Database](https://github.com/MLstate/opalang/wiki/Hello%2C-database)
