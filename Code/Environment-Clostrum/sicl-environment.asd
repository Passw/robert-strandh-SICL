(cl:in-package #:asdf-user)

(defsystem #:sicl-environment
  :depends-on (#:sicl-lexical-environment
               #:common-boot
               #:stealth-mixin
               #:clostrum
               #:clostrum-basic
               #:clostrum-trucler)
  :serial t
  :components
  ((:file "packages")
   (:file "environment-variable")
   (:file "function-entry")
   (:file "generic-functions")
   (:file "environment")
   (:file "trucler-methods")
   (:file "function-description")
   (:file "variable-description")
   (:file "class-description")
   (:file "get-setf-expansion-defun")
   (:file "map-defined-method-combination-templates")
   (:file "file-compilation")))
