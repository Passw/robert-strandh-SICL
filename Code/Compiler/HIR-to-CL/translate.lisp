(cl:in-package #:sicl-hir-to-cl)

(defvar *visited*)

(defgeneric translate (instruction))

;;; FIXME: Remove this method later.
(defmethod translate (instruction)
  (cons `(invalid ,instruction)
        (reduce #'append
                (mapcar #'translate (cleavir-ir:successors instruction)))))

(defmethod translate ((instruction cleavir-ir:assignment-instruction))
  (let* ((input (first (cleavir-ir:inputs instruction)))
         (output (first (cleavir-ir:outputs instruction)))
         (successor (first (cleavir-ir:successors instruction))))
    (cons `(setq ,(cleavir-ir:name output)
                 ,(if (typep input 'cleavir-ir:constant-input)
                      `',(cleavir-ir:value input)
                      (cleavir-ir:name input)))
          (translate successor))))

(defmethod translate ((instruction cleavir-ir:funcall-instruction))
  (let ((inputs (cleavir-ir:inputs instruction))
        (output (first (cleavir-ir:outputs instruction)))
        (successor (first (cleavir-ir:successors instruction))))
    (cons `(setq ,(cleavir-ir:name output)
                 (multiple-value-list
                  (apply #'funcall ,(mapcar #'cleavir-ir:name inputs))))
          (translate successor))))

(defmethod translate :around (instruction)
  (let ((tag (gethash instruction *visited*)))
    (if (null tag)
        (progn (setf (gethash instruction *visited*) (gensym))
               (cons (gethash instruction *visited*)
                     (call-next-method)))
        `((go ,tag)))))
