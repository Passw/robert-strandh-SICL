(cl:in-package #:asdf-user)

(defsystem "sicl-clos-ensure-metaobject"
  :serial t
  :components
  ((:file "ensure-generic-function")
   (:file "ensure-class")
   (:file "ensure-method")
   (:file "ensure-method-combination-template")))
