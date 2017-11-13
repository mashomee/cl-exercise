# cl-exercise

Common Lisp Learning System

## Who We Are
We are tcool, a Common Lisp training facility in Nara, Japan.

## Our Mission
Our mission is to increase the number of Common lispers in the world.

Why?

Because we love Common Lisp.

## Usage

```lisp
(ql:quickload :cl-exercise)
(cl-exercise:start)
```

## Requirement
* ASDF3
* Quicklisp
* jsonrpc
* darkmatter

## Installation
```bash
$ cd ~/quicklisp/local-projects
$ git clone https://github.com/fukamachi/jsonrpc
$ git clone -b refactor https://github.com/tamamu/darkmatter
$ git clone https://github.com/tamamu/cl-exercise
$ sbcl --eval "(progn (ql:register-local-projects)(ql:quickload :cl-exercise)(exit))"
```

## Authors

Lispers in the world


## Copyright

Copyright (c) 2017 tcool, Eddie

## License

Licensed under the MIT License.
