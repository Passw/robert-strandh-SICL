(cl:in-package #:sicl-boot-phase-4)

(defun import-number-functions (e4)
  (import-functions-from-host
   '(+ - < <= = /= floor 1+ 1-
     ;; ZEROP is used in CLOS to compute the discriminating function.
     zerop
     ;; RANDOM is used to create a hash code for standard
     ;; objects.
     random)
   e4))

(defun import-cons-functions (e4)
  (import-functions-from-host
   '(;; SECOND is used in many places
     second
     ;; THIRD is used by the expansion of DEFMETHOD
     third
     ;; NTH is used at run time in CLOS.
     nth
     ;; CAR, CDR, FIRST, and REST are used in many places.
     car cdr first rest
     ;; CADR is generated by the expander for REMF, and REMF is used
     ;; in CLOS.
     cadr
     ;; CDDR is used at run time in CLOS.
     cddr
     ;; CONSP is used at run time in CLOS.
     consp
     ;; ATOM is used at run time in CLOS.
     atom
     ;; LISTP is used at run time in CLOS.
     listp
     ;; NULL is used in many places at run time.
     null
     ;; ENDP is used in the expansion of LOOP.
     endp
     ;; CONS is used in many places at run time.
     cons
     ;; LIST is used in many places at run time.
     list
     ;; LIST* is used in CLOS at run time.
     list*
     ;; APPEND is used at run time in several places.
     append
     ;; MAKE-LIST is used in CLOS at run time.
     make-list
     ;; COPY-LIST is used in CLOS at run time, for instance in
     ;; ENSURE-CLASS and ENSURE-GENERIC-FUNCTION.
     copy-list
     ;; CDDDR is generated by the expander for REMF, and REMF is used
     ;; in CLOS.
     cdddr)
   e4))

(defun import-code-utilities (e4)
  (import-functions-from-host
   '(cleavir-code-utilities:proper-list-p
     cleavir-code-utilities:canonicalize-generic-function-lambda-list
     cleavir-code-utilities:extract-required
     cleavir-code-utilities:canonicalize-specialized-lambda-list
     cleavir-code-utilities:separate-function-body)
   e4))

(defun import-misc (e4)
  (import-functions-from-host
   '(sicl-method-combination:define-method-combination-expander)
   e4))

(defun import-sequence-functions (e4)
  (import-functions-from-host
   '(;; POSITION-IF is used in the parser of DEFMETHOD forms to find
     ;; the position of the lambda list, possibly preceded by a bunch
     ;; of method qualifiers.
     position-if
     ;; FIND-IF-NOT is used in COMPUTE-EFFECTIVE-SLOT-DEFINITION to
     ;; determine whether a slot has an :INITFORM.
     find-if-not
     ;; FIND-IF is used in ADD-METHOD to determine whether an existing
     ;; method needs to be removed before the new one is added.
     find-if
     ;; REMOVE-DUPLICATES and REDUCE are used in order to compute all
     ;; superclasses of a given class, for the purpose of computing
     ;; the class precedence list.  This is done by appending the
     ;; class precedence lists of the superclasses and then removing
     ;; duplicates.
     remove-duplicates reduce
     ;; FIND is used in the computation of the class precedence list.
     find
     ;; REMOVE is used at compile time to parse DEFGENERIC forms, and
     ;; in several places in CLOS at run time.
     remove
     ;; SORT is used in CLOS at run time to compute the discriminating
     ;; automaton.
     sort
     ;; SUBSEQ is used at compile time to parse DEFMETHOD forms, and
     ;; at run time in several places in CLOS, like to compute
     ;; applicable methods and to compute the discriminating function.
     subseq
     ;; POSITION is used at run time by CLOS to compute applicable methods
     ;; and to determine which of two specializers is more specific.
     position
     ;; REVERSE is used in several places at run time, for instance
     ;; for computing class precedence lists.
     reverse
     ;; COUNT is used in CLOS in order to finalize inheritance.
     count
     ;; LENGTH is used in various places at run time, such as in CLOS for
     ;; SHARED-INITIALIZE.
     length
     ;; ELT is used for parsing DEFMETHOD forms.
     elt)
   e4))

(defun import-from-host (e4)
  (import-number-functions e4)
  (import-cons-functions e4)
  (import-code-utilities e4)
  (import-misc e4)
  (import-sequence-functions e4))
