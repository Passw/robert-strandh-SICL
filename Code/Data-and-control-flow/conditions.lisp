(cl:in-package #:sicl-data-and-control-flow)

(define-condition odd-number-of-arguments-to-psetf
    (program-error)
  ((%form :initarg :form :reader form))
  (:report (lambda (condition stream)
             (format stream
                     "An odd number of arguments was given to PSETF~@
                      in the following form:~@
                      ~s"
                     (form condition)))))

(define-condition odd-number-of-arguments-to-psetq
    (program-error)
  ((%form :initarg :form :reader form))
  (:report (lambda (condition stream)
             (format stream
                     "An odd number of arguments was given to PSETQ~@
                      in the following form:~@
                      ~s"
                     (form condition)))))

(define-condition too-few-arguments-to-shiftf
    (program-error)
  ((%form :initarg :form :reader form))
  (:report (lambda (condition stream)
             (format stream
                     "Too few arguments were given to SHIFTF~@
                      in the following form:~@
                      ~s"
                     (form condition)))))

(define-condition attempt-to-set-the-fdefinition-of-a-special-operator
    (error)
  ((name :initarg :name :reader name)))

(define-condition numeric-catch-tag (style-warning)
  ((%tag :initarg :tag :reader tag))
  (:report (lambda (condition stream)
             (format stream
                     "CATCH tags are compared with EQ so using a~@
                      number or a character as a CATCH tag may not~@
                      work as expected:~@
                      ~s"
                     (tag condition)))))

(define-condition block-name-must-be-symol (program-error)
  ((%name :initarg :name :reader name))
  (:report (lambda (condition stream)
             (format stream
                     "A block name must be a symbol.~@
                      But the following was found instead:~@
                      ~s"
                     (name condition)))))

;;; This condition type is the base of run-time errors related to
;;; argument mismatches.
(define-condition argument-mismatch (error)
  ((%lambda-list :initarg :lambda-list :reader lambda-list)))

(define-condition too-few-arguments (argument-mismatch)
  ()
  (:report (lambda (condition stream)
             (format stream
                     "Too few arguments supplied for the lambda list:~@
                      ~s"
                     (lambda-list condition)))))

(define-condition too-many-arguments (argument-mismatch)
  ()
  (:report (lambda (condition stream)
             (format stream
                     "Too many arguments supplied for the lambda list:~@
                      ~s"
                     (lambda-list condition)))))
