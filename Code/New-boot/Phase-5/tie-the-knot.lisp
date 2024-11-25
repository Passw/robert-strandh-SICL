(cl:in-package #:sicl-new-boot-phase-5)

(eval-when (:compile-toplevel) (sb:enable-parcl-symbols client))

;;; Create a hash table mapping each class in E3 to the analogous
;;; class in E4.
(defun create-class-mapping (e3 e4)
  (let ((table3 (clostrum-basic::types e3))
        (table4 (clostrum-basic::types e4))
        (result (make-hash-table :test #'eq)))
    (loop for name being each hash-key of table3 using (hash-value entry3)
          for cell3 = (clostrum-basic::cell entry3)
          for type3 = (car cell3)
          when (typep type3 'sb:header)
            do (let ((entry4 (gethash name table4)))
                 (assert (not (null entry4)))
                 (let* ((cell4 (clostrum-basic::cell entry4))
                        (class4 (car cell4)))
                   (setf (gethash type3 result) class4))))
    result))

;;; This variable holds a hash table mapping each class in E3 to the
;;; analogous class in E4.
(defvar *class-map*)

;;; This variable holds a hash table of visited objects.
(defvar *visited*)

;;; This variable holds the list of objects yet to be processed.
(defvar *worklist*)

(defun object-is-an-impure-ersatz-object-p (object)
  (and (typep object 'sb:header)
       (not (typep (sb:class object) 'sb:header))))

(defun add-to-worklist (item)
  (assert (not (object-is-an-impure-ersatz-object-p item)))
  (push item  *worklist*))

(defun load-worklist-with-classes (e4)
  (loop with table = (clostrum-basic::types e4)
        for entry being each hash-value of table
        for cell = (clostrum-basic::cell entry)
        for class = (car cell)
        do (add-to-worklist class)))

(defun load-worklist-with-operators (e4)
  (loop with table = (clostrum-basic::functions e4)
        for entry being each hash-value of table
        for cell = (clostrum-basic::cell entry)
        for operator = (car cell)
        do (add-to-worklist operator)))

(defun replacement (item)
  (if (object-is-an-impure-ersatz-object-p item)
      ;; It had better be an E3 class.
      (let ((new-item (gethash item *class-map*)))
        (assert (not (null new-item)))
        new-item)
      (progn (unless (gethash item *visited*)
               (setf (gethash item *visited*) t)
               (add-to-worklist item))
             item)))

(defgeneric process-item (item))

(defmethod process-item (item)
  nil)

(defvar *class-slots-function*)

(defmethod process-item ((item sb:header))
  (if (object-is-an-impure-ersatz-object-p (sb:class item))
      ;; This is the case we want to fix up.
      (let* ((class (sb:class item))
             (new-class (gethash class *class-map*)))
        (assert (not (null new-class)))
        ;; Update the class slot.
        (setf (sb:class item) new-class)
        ;; Update the slot with the list of effective slots.
        (setf (aref (sb:rack item) 1)
              (funcall *class-slots-function* new-class))
        (setf (gethash item *visited*) t)
        (let ((rack (sb:rack item)))
          (loop with length = (length rack)
                for i from 0 below length
                do (setf (aref rack i) (replacement (aref rack i))))))
      ;; Otherwise this object already has a pure class.  Do nothing.
      nil))
    
(defmethod process-item ((item cons))
  (setf (car item) (replacement (car item)))
  (setf (cdr item) (replacement (cdr item))))

(defun tie-the-knot (client e3 e4)
  (let ((*worklist* '())
        (*class-map* (create-class-mapping e3 e4))
        (*visited* (make-hash-table :test #'eq))
        (*class-slots-function*
          (clostrum:fdefinition client e3 @clostrophilia:class-slots)))
    (load-worklist-with-classes e4)
    (load-worklist-with-operators e4)
    (loop until (null *worklist*)
          do (process-item (pop *worklist*)))))
