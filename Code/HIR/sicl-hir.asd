(cl:in-package #:asdf-user)

(defsystem "sicl-hir"
  :depends-on ()
  :serial t
  :components
  ((:file "packages")
   (:file "instruction")
   (:file "data")
   (:file "parse-arguments-instruction")
   (:file "make-cell-instruction")))
