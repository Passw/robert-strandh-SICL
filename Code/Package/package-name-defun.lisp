(cl:in-package #:sicl-package)

(defun package-name (package-designator)
  (let ((package (package-designator-to-package package-designator)))
    (parcl:name env:*client* package)))
