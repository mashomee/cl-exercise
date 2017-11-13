(in-package :cl-user)
(defpackage cl-exercise.render
  (:use :cl)
  (:import-from :cl-exercise.env
                :*host*
                :*debug*)
  (:import-from :cl-exercise.process
                )
  (:import-from :alexandria
                :hash-table-plist)
  (:export :render-index
           :render-exercise
           :notfound))
(in-package :cl-exercise.render)

(defvar *file-store*
  (make-instance 'djula:file-store
                 :search-path
                 (list (asdf:system-relative-pathname "cl-exercise" "templates/"))))

(defvar *data-directory* (asdf:system-relative-pathname "cl-exercise" "data"))
(defvar *default-store* djula:*current-store*)

(progn
  (setf djula:*current-store* *file-store*)
  (defvar +index.html+ (djula:compile-template* "index.html"))
  (defvar +exercise.html+ (djula:compile-template* "exercise.html"))
  (defvar +404.html+ (djula:compile-template* "404.html"))
  (setf djula:*current-store* *default-store*))

(defun read-string-from-file (path)
  (with-open-file (s path :direction :input)
    (let ((buf (make-string (file-length s))))
      (read-sequence buf s)
      buf)))

(defun read-question-list ()
  (mapcar #'read-question-file
          (directory
            (format nil "~A/*.json"
                    (namestring *data-directory*)))))

(defun hash-table-plist-recur (ht)
  (mapcar (lambda (elm)
            (if (hash-table-p elm)
                (hash-table-plist-recur elm)
                elm))
          (hash-table-plist ht)))

(defun escape (str)
  (let ((stream (make-string-output-stream)))
    (loop for c across str
          if (eq c #\Newline)
          do (write-string "\\n" stream)
          else
          do (write-char c stream))
    (get-output-stream-string stream)))

(defun escape-plist (plist)
  (loop with res = (list)
        for key in plist by #'cddr
        for value in (rest plist) by #'cddr
        if (stringp value)
        do (setf res (append res (list key (escape value))))
        else
        do (setf res (append res (list key value)))
        finally (return res)))

(defun read-question-file (path)
  (let* ((data
          (hash-table-plist-recur
            (yason:parse
              (read-string-from-file path))))
         (filename (pathname-name path)))
    (list "path" filename
          "data" (escape-plist data))))

(defun render-index (env)
  (let ((*current-store* *file-store*)
        (questions (read-question-list)))
  `(200 (:content-type "text/html")
    (,(djula:render-template* +index.html+ nil
                          :questions questions)))))

(defun render-exercise (env fname)
  (let ((*current-store* *file-store*)
        (path (format nil "~A/~A.json"
                      (namestring *data-directory*)
                      fname))
        (host (or *host*
                  (format nil "http://~A:~A"
                          (getf env :server-name)
                          (getf env :server-port)))))
    (if (probe-file path)
        (let ((question (read-question-file path)))
          `(200 (:content-type "text/html")
            (,(djula:render-template* +exercise.html+ nil
                                      :host host
                                      :debug *debug*
                                      ;:runtime (html-runtime env)
                                      :question question))))
        (notfound env))))

(defun notfound (env)
  `(404 (:content-type "text/html")
    (,(djula:render-template* +404.html+ nil))))
