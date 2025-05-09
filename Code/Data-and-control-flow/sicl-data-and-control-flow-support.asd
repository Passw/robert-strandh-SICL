(cl:in-package #:asdf-user)

(defsystem :sicl-data-and-control-flow-support
  :depends-on ()
  :serial t
  :components
  ((:file "packages")
   (:file "conditions")
   (:file "defun-support")
   (:file "shiftf-support")
   (:file "psetf-support")
   (:file "rotatef-support")))
