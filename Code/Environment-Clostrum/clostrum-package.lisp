(cl:in-package #:common-lisp-user)

(defpackage #:clostrum
  (:export
   #:find-class
   #:fboundp
   #:fdefinition
   #:macro-function
   #:compiler-macro-function
   #:make-constant))

(defpackage #:clostrum-sys
  (:export
   #:variable-cell
   #:ensure-variable-cell))
