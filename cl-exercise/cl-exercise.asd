#|
  This file is a part of cl-exercise project.
  Copyright (c) 2017 Eddie, Noguchi Hiroki
|#

#|
  Author: Eddie, Noguchi Hiroki
|#

(in-package :cl-user)
(defpackage cl-exercise-asd
  (:use :cl :asdf))
(in-package :cl-exercise-asd)

(defsystem cl-exercise
  :version "0.1"
  :author "Eddie, Noguchi Hiroki"
  :license "MIT"
  :depends-on (:alexandria
               :clack
               :djula
               :jsonrpc
               :quri
               :yason)
  :components ((:module "src"
                :components
                ((:file "cl-exercise" :depends-on ("env" "handler"))
                 (:file "handler" :depends-on ("render" "process" "utils"))
                 (:file "render" :depends-on ("process"))
                 (:file "process")
                 (:file "utils")
                 (:file "env"))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op cl-exercise-test))))

(defsystem cl-exercise/darkmatter
  :depends-on (:darkmatter)
  :components ((:module "plugin"
                :components
                ((:file "eval" :depends-on ("messages"))
                 (:file "messages")
                 (:file "package")
                 ))))
