(cl:in-package #:common-lisp-user)

(defpackage #:sicl-environment
  (:use #:common-lisp)
  (:shadow #:get-setf-expansion type)
  (:shadowing-import-from
   #:clostrum
   .
   #.(loop for symbol being each external-symbol in '#:clostrum
           unless (member symbol '(clostrum:run-time-environment
                                   clostrum:compilation-environment))
             collect (symbol-name symbol)))
  (:export #:global-environment
           #:*environment*
           #:client
           #:method-combination-template
           #:base-run-time-environment
           #:run-time-environment
           #:evaluation-environment
           #:compilation-environment
           #:function-description
           #:simple-function-description
           #:make-simple-function-description
           #:generic-function-description
           #:make-generic-function-description
           #:lambda-list
           #:class-name
           #:method-class-name
           #:method-combination-info
           #:get-setf-expansion
           #:variable-description
           #:constant-variable-description
           #:make-constant-variable-description
           #:special-variable-description
           #:make-special-variable-description
           #:class-description
           #:make-class-description
           #:name
           #:superclass-names
           #:metaclass-name
           #:type
           #:value
           #:find-method-combination-template
           #:who-calls-information
           #:structure-description
           #:function-cell
           #:variable-cell
           #:traced-functions
           #:map-defined-functions
           #:map-defined-classes
           #:map-defined-method-combination-templates
           #:make-environment-for-file-compilation
           #:add-call-site
           .
           #.(loop for symbol being each external-symbol in '#:clostrum
                   unless (member symbol '(clostrum:run-time-environment
                                           clostrum:compilation-environment))
                     collect (symbol-name symbol))))
