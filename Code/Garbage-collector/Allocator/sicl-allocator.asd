(cl:in-package #:asdf-user)

(defsystem :sicl-allocator
  :depends-on (:sicl-memory)
  :serial t
  :components
  ((:file "packages")
   (:file "chunk")
   (:file "allocator")))
