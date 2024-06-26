(cl:in-package #:asdf-user)

(defsystem "sicl-new-boot-phase-2"
  :depends-on ("sicl-new-boot-phase-1")
  :serial t
  :components
  ((:file "packages")
   (:file "client")
   (:file "environment")
   (:file "configuration")
   (:file "macro-programming")
   (:file "import-from-host")
   (:file "load-predicament")
   (:file "load-ctype")
   (:file "define-class-of-and-stamp")
   (:file "boot")))
