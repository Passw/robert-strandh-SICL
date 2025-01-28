(cl:in-package #:asdf-user)

(defsystem #:sicl-arithmetic-operations
  :depends-on (#:sicl-arithmetic-class-hierarchy)
  :serial t
  :components
  ((:file "binary-add-defgeneric")
   (:file "binary-add-defmethods")
   (:file "plus-defun")
   (:file "binary-subtract-defgeneric")
   (:file "binary-subtract-defmethods")
   (:file "minus-defun")
   (:file "binary-multiply-defgeneric")
   (:file "binary-multiply-defmethods")
   (:file "multiply-defun")
   (:file "binary-divide-defgeneric")
   (:file "binary-divide-defmethods")
   (:file "divide-by-defun")
   (:file "binary-equal-defgeneric")
   (:file "binary-equal-defmethods")
   (:file "equal-defun")
   (:file "binary-less-defgeneric")
   (:file "binary-less-defmethods")
   (:file "less-defun")
   (:file "binary-not-greater-defgeneric")
   (:file "binary-not-greater-defmethods")
   (:file "less-or-equal-defun")
   (:file "greater-defun")
   (:file "greater-or-equal-defun")
   (:file "binary-gcd-defgeneric")
   (:file "binary-gcd-defmethods")
   (:file "gcd-defun")
   (:file "binary-lcm-defgeneric")
   (:file "binary-lcm-defmethods")
   (:file "lcm-defun")
   (:file "binary-logand-defgeneric")
   (:file "binary-logand-defmethods")
   (:file "logand-defun")
   (:file "binary-logior-defgeneric")
   (:file "binary-logior-defmethods")
   (:file "logior-defun")
   (:file "binary-logxor-defgeneric")
   (:file "binary-logxor-defmethods")
   (:file "logxor-defun")
   ;; (:file "lognot-defun")
   ;; (:file "logandc1-defun")
   ;; (:file "logandc2-defun")
   ;; (:file "logorc1-defun")
   ;; (:file "logorc2-defun")
   ;; (:file "lognand-defun")
   ;; (:file "lognor-defun")
   ;; (:file "generic-ceiling-defgeneric")
   ;; (:file "generic-ceiling-defmethods")
   ;; (:file "ceiling-defun")
   ;; (:file "generic-floor-defgeneric")
   ;; (:file "generic-floor-defmethods")
   ;; (:file "floor-defun")
   ;; (:file "generic-round-defgeneric")
   ;; (:file "generic-round-defmethods")
   ;; (:file "round-defun")
   ;; (:file "generic-truncate-defgeneric")
   ;; (:file "generic-truncate-defmethods")
   ;; (:file "truncate-defun")
   ;; (:file "max-defun")
   ;; (:file "min-defun")
   ;; (:file "plusp-defun")
   ;; (:file "minusp-defun")
   ;; (:file "zerop-defun")
   ;; (:file "convert-fixnum-to-bignum-defun")
   ;; (:file "floatp-defgeneric")
   ))
