(cl:in-package #:cleavir-ast-to-hir)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Compile a CAR-AST

(define-compile-functional-ast
    cleavir-ast:car-ast cleavir-ir:car-instruction
  (cleavir-ast:cons-ast))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Compile a CDR-AST

(define-compile-functional-ast
    cleavir-ast:cdr-ast cleavir-ir:cdr-instruction
  (cleavir-ast:cons-ast))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Compile a RPLACA-AST

(define-compile-functional-ast
    cleavir-ast:rplaca-ast cleavir-ir:rplaca-instruction
  (cleavir-ast:cons-ast cleavir-ast:value-ast))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Compile a RPLACD-AST

(define-compile-functional-ast
    cleavir-ast:rplacd-ast cleavir-ir:rplacd-instruction
  (cleavir-ast:cons-ast cleavir-ast:value-ast))
