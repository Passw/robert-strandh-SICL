(cl:in-package #:sicl-package)

(defun unexport (symbols-designator &optional (package-designator *package*))
  (let ((package (package-designator-to-package package-designator))
        (symbols (designated-list-of-symbols symbols-designator)))
    (loop for symbol in symbols
          do (parcl:unexport env:*client* package symbol))))
