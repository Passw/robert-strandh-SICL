(cl:in-package #:asdf-user)

(defsystem #:sicl-arithmetic
  :depends-on (#:sicl-arithmetic-base)
  :serial t
  :components
  ((:file "number-defclass")
   (:file "real-defclass")
   (:file "rational-defclass")
   (:file "integer-defclass")
   (:file "fixnum-defclass")
   (:file "bignum-defclass")
   (:file "ratio-defclass")
   (:file "float-defclass")
   (:file "single-float-defclass")
   (:file "double-float-defclass")
   (:file "complex-defclass")
   (:file "binary-add-defgeneric")
   (:file "binary-add-defmethods")
   (:file "plus-defun")
   (:file "binary-subtract-defgeneric")
   (:file "binary-subtract-defmethods")
   (:file "minus-defun")))
