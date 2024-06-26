(cl:in-package #:sicl-clos)

;;; For the specification of this generic function, see
;;; http://metamodular.com/CLOS-MOP/ensure-generic-function-using-class.html
;;;
;;; We handle an additional keyword argument compared to the
;;; specification, namely ENVIRONMENT.  It can be used to specify in
;;; which the generic function is to be found or defined.  It defaults
;;; to the environment in which this function was loaded.
(defgeneric ensure-generic-function-using-class
    (generic-function
     function-name
     &key
       argument-precedence-order
       declarations
       documentation
       generic-function-class
       lambda-list
       method-class
       method-combination
       name
       class-environment
       function-environment
     &allow-other-keys))

(defun canonicalize-generic-function-class
    (generic-function-class environment)
  (cond ((symbolp generic-function-class)
         (find-class generic-function-class t environment))
        ((subtypep-1 generic-function-class
                     (find-class 'generic-function t environment))
         generic-function-class)
        (t
         (error 'generic-function-class-must-be-class-or-name
                :object generic-function-class))))

;;; The MOP specification of ENSURE-GENERIC-FUNCTION-USING-CLASS says
;;; that if the :METHOD-CLASS argument was received, it is converted
;;; into a class metaobject before MAKE-INSTANCE is called, which
;;; suggests that only a symbol is valid here.  But then, the Common
;;; Lisp standard description of ENSURE-GENERIC-FUNCTION says that the
;;; METHOD-CLASS can also be a class object.  So obviously, if
;;; ENSURE-GENERIC-FUNCTION receives a class object, it will transmit
;;; that object to ENSURE-GENERIC-FUNCTION-USING-CLASS.  Therefore
;;; ENSURE-GENERIC-FUNCTION-USING-CLASS must also be able to handle a
;;; class object as this argument.
(defun canonicalize-method-class (method-class environment)
  (cond ((symbolp method-class)
         (find-class method-class t environment))
        ((subtypep-1 method-class (find-class 'method t environment))
         method-class)
        (t
         (error "method class must be a class or a name"))))

(defun canonicalize-keyword-arguments (keyword-arguments)
  (let ((result (copy-list keyword-arguments)))
    (loop while (remf result :generic-function-class))
    (loop while (remf result :environment))
    result))

(defvar *standard-method-combination*)

(defmethod ensure-generic-function-using-class
    ((generic-function null)
     function-name
     &rest
       all-keyword-arguments
     &key
       (class-environment sicl-environment:*environment*)
       (function-environment sicl-environment:*environment*)
       (generic-function-class
        (find-class 'standard-generic-function t class-environment))
       (method-class nil method-class-p)
       (method-combination nil method-combination-p)
     &allow-other-keys)
  (declare (ignore generic-function))
  (setf generic-function-class
        (canonicalize-generic-function-class
         generic-function-class class-environment))
  (when method-class-p
    (setf method-class
          (canonicalize-method-class method-class class-environment)))
  (unless method-combination-p
    ;; Neither the Common Lisp standard nor the AMOP indicates where
    ;; this keyword argument is defaulted, but it has to be here,
    ;; because, this is where we find out that there is no generic
    ;; function with the name given as an argument.
    ;;
    ;; An alternative would be to count on the generic-function
    ;; initialization protocol to default the method combination, and
    ;; just not pass that keword argument if it was not supplied here.
    ;; But that would make this code more twisted.
    (setf method-combination *standard-method-combination*))
  (let* ((remaining-keys
           (canonicalize-keyword-arguments all-keyword-arguments))
         (result
           (if method-class-p
               (apply #'make-instance generic-function-class
                      ;; The AMOP does
                      :name function-name
                      :method-class method-class
                      :method-combination method-combination
                      remaining-keys)
               (apply #'make-instance generic-function-class
                      :name function-name
                      :method-combination method-combination
                      remaining-keys))))
    (setf (fdefinition function-name :environment function-environment)
          result)))

(defmethod ensure-generic-function-using-class
    ((generic-function generic-function)
     function-name
     &rest
       all-keyword-arguments
     &key
       (class-environment sicl-environment:*environment*)
       function-environment
       (generic-function-class
        (find-class 'standard-generic-function t class-environment))
       (method-class nil method-class-p)
       (method-combination nil method-combination-p)
     &allow-other-keys)
  (declare (ignore function-name function-environment))
  (setf generic-function-class
        (canonicalize-generic-function-class
         generic-function-class class-environment))
  (unless (eq generic-function-class (class-of generic-function))
    (error "classes don't agree ~s and ~s of ~s"
           generic-function-class (class-of generic-function) generic-function))
  (when method-class-p
    (setf method-class
          (canonicalize-method-class method-class class-environment)))
  (unless method-combination-p
    (setf method-combination
          (clostrophilia:generic-function-method-combination
           generic-function)))
  (let ((remaining-keys
          (canonicalize-keyword-arguments all-keyword-arguments)))
    (if method-class-p
        (apply #'reinitialize-instance generic-function
               :method-combination method-combination
               :method-class method-class
               remaining-keys)
        (apply #'reinitialize-instance generic-function
               :method-combination method-combination
               remaining-keys)))
  generic-function)
