(cl:in-package #:asdf-user)

(defsystem #:sicl-package-base
  :serial t
  :description "SICL-Specific Package System, base system"
  :depends-on (#:acclimation
               #:cleavir-code-utilities-list-structure
               #:cleavir-code-utilities-separate-body))

(defparameter *sicl-package-component-designators*
  '((:file "packagep-defgeneric")
    (:file "string-designator-deftype")
    (:file "package-designator-deftype")
    (:file "package-designator-to-package-defun")
    (:file "package-name-defun")
    (:file "package-use-list-defun")
    (:file "package-used-by-list-defun")
    (:file "package-shadowing-symbols-defun")
    (:file "package-defparameter")
    (:file "utilities")
    (:file "find-symbol-defun")
    (:file "do-symbols-defmacro")
    (:file "do-external-symbols-defmacro")
    (:file "export-defun")
    (:file "unexport-defun")
    (:file "import-defun")
    (:file "intern-defun")
    (:file "unintern-defun")
    (:file "shadow-defun")
    (:file "shadowing-import-defun")
    (:file "use-package-defun")
    (:file "make-package-defun")
    (:file "conditions")
    (:file "documentation-strings-english")))


(defparameter *sicl-package-string-designators*
  '(#:home-package
    #:delete-package
    #:make-symbol
    #:package
    #:packagep
    #:*package*
    #:package-name
    #:package-nicknames
    #:package-shadowing-symbols
    #:package-use-list
    #:package-used-by-list
    #:package-error
    #:package-error-package
    #:rename-package
    #:make-package
    #:import
    #:intern
    #:unintern
    #:find-symbol
    #:export
    #:unexport
    #:shadow
    #:shadowing-import
    #:unuse-package
    #:use-package
    #:defpackage
    #:with-package-iterator
    #:do-symbols
    #:do-external-symbols))

(export '(*sicl-package-string-designators*))
