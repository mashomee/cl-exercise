# Cl-Exercise

Online Common Lisp Learning System

## Usage

```lisp
(require :cl-exercise)
(cl-exercise:start :port 8000 :debug nil)

;; Deployment
(cl-exercise:start :host "http://example.com" :port 80)
```

## Installation

We recommend use [Roswell](https://github.com/roswell/roswell) to install.  
ASDF3 and Quicklisp have to be installed already.

```bash
# FOR ROSWELL USER

$ ros install asdf
# Install latest jsonrpc
$ ros install fukamachi/jsonrpc
$ cd ~/lisp-local # ASDF source registry
$ git clone -b refactor https://github.com/tamamu/darkmatter
$ ros install tamamu/cl-exercise
```

```bash
# FOR QUICKLISP USER

# Please install ASDF3 before do below instructions
$ cd ~/quicklisp/local-projects
# Install latest jsonrpc
$ git clone https://github.com/fukamachi/jsonrpc
$ git clone -b refactor https://github.com/tamamu/darkmatter
$ git clone https://github.com/tamamu/cl-exercise
$ sbcl --eval "(progn (ql:register-local-projects)(ql:quickload :cl-exercise)(exit))"
```

## See Also

* [Bulma](https://github.com/jgthms/bulma) - Modern CSS framework based on Flexbox
* [CodeMirror](https://github.com/codemirror/codemirror) - In-browser code editor
* [marked](https://github.com/chjj/marked) - A markdown parser and compiler

## Author

* Eddie, Noguchi Hiroki

## Copyright

Copyright (c) 2017 Eddie, Noguchi Hiroki

## License

Licensed under the MIT License.
