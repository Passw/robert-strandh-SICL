(cl:in-package #:sicl-package)

(defun package-use-list (package-designator)
  (let ((package (package-designator-to-package package-designator)))
    (parcl:use-list env:*client* package)))
