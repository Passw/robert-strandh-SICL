(cl:in-package #:sicl-arithmetic)

(defun floor (number &optional (divisor 1))
  (multiple-value-bind (quotient remainder)
      (truncate number divisor)
    (if (and (not (zerop remainder))
             (if (minusp divisor)
                 (plusp number)
                 (minusp number)))
        (values (1- quotient) (+ remainder divisor))
        (values quotient remainder))))
