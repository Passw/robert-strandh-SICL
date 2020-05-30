(cl:in-package #:cleavir-cst-to-ast-test)

(defun test01 ()
  (let* ((cst (cst:cst-from-expression '(function (lambda (x) x))))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:function-ast
                 :origin (0)
                 :policy nil
                 :body-ast [cleavir-ast:progn-ast
                             :origin nil
                             :policy nil
                             :form-asts ([cleavir-ast:setq-ast
                                           :origin (0 1 1 0)
                                           :policy nil
                                           :lhs-ast [cleavir-ast:lexical-ast
                                                      :name x
                                                      :origin (0 1 1 0)
                                                      :policy nil]
                                           :value-ast [cleavir-ast:lexical-ast
                                                        :name #:|x|
                                                        :origin (0 1 1 0)
                                                        :policy nil]]
                                         [cleavir-ast:progn-ast
                                           :origin nil
                                           :policy nil
                                           :form-asts
                                           ([cleavir-ast:lexical-ast
                                              :name x
                                              :origin (0 1 1 0)
                                              :policy nil])])]
                 :lambda-list ([cleavir-ast:lexical-ast
                                 :name #:|x|
                                 :origin (0 1 1 0)
                                 :policy nil])]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test02 ()
  (let* ((cst (cst:cst-from-expression '*special1*))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:symbol-value-ast
                 :origin (0)
                 :policy nil
                 :symbol-ast [cleavir-ast:load-time-value-ast
                               :origin (0)
                               :policy nil
                               :read-only-p t
                               :form '*special1*]]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test03 ()
  (let* ((cst (cst:cst-from-expression '(car *special1*)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:call-ast
                 :origin (0)
                 :policy nil
                 :callee-ast
                 [cleavir-ast:fdefinition-ast
                   :origin nil
                   :policy nil
                   :name-ast [cleavir-ast:load-time-value-ast
                               :origin (0 0)
                               :policy nil
                               :read-only-p t
                               :form 'car]]
                 :argument-asts
                 ([cleavir-ast:symbol-value-ast
                    :origin (0 1)
                    :policy nil
                    :symbol-ast [cleavir-ast:load-time-value-ast
                                  :origin (0 1)
                                  :policy nil
                                  :read-only-p t
                                  :form '*special1*]])]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test04 ()
  (let* ((cst (cst:cst-from-expression '((lambda (x) x) 234)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:call-ast
                  :argument-asts
                  ([cleavir-ast:load-time-value-ast
                      :read-only-p t
                      :form '234
                      :policy nil
                      :origin (0 1)])
                  :callee-ast
                  [cleavir-ast:function-ast
                     :body-ast
                     [cleavir-ast:progn-ast
                        :form-asts
                        ([cleavir-ast:setq-ast
                            :value-ast
                            #1=[cleavir-ast:lexical-ast
                                  :name #:|x|
                                  :policy nil
                                  :origin #2=(0 0 1 0)]
                            :lhs-ast
                            #3=[cleavir-ast:lexical-ast
                                  :name cleavir-cst-to-ast-test::x
                                  :policy nil
                                  :origin #2#]
                            :policy nil
                            :origin #2#]
                         [cleavir-ast:progn-ast
                            :form-asts
                            (#3#)
                            :policy nil
                            :origin nil])
                        :policy nil
                        :origin nil]
                     :lambda-list
                     (#1#)
                     :policy nil
                     :origin nil]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test05 ()
  (let* ((cst (cst:cst-from-expression '(let ((x 234)) x)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:call-ast
                  :argument-asts
                  ([cleavir-ast:load-time-value-ast
                      :read-only-p t
                      :form '234
                      :policy nil
                      :origin (0 1 0 1)])
                  :callee-ast
                  [cleavir-ast:function-ast
                     :body-ast
                     [cleavir-ast:progn-ast
                        :form-asts
                        ([cleavir-ast:setq-ast
                            :value-ast
                            #1=[cleavir-ast:lexical-ast
                                  :name #:|x|
                                  :policy nil
                                  :origin #2=(0 1 0 0)]
                            :lhs-ast
                            #3=[cleavir-ast:lexical-ast
                                  :name cleavir-cst-to-ast-test::x
                                  :policy nil
                                  :origin #2#]
                            :policy nil
                            :origin #2#]
                         [cleavir-ast:progn-ast
                            :form-asts
                            (#3#)
                            :policy nil
                            :origin nil])
                        :policy nil
                        :origin nil]
                     :lambda-list
                     (#1#)
                     :policy nil
                     :origin nil]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test06 ()
  (let* ((cst (cst:cst-from-expression '(let* ((x 234)) x)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:call-ast
                  :argument-asts
                  ([cleavir-ast:load-time-value-ast
                      :read-only-p t
                      :form '234
                      :policy nil
                      :origin (0 1 0 1)])
                  :callee-ast
                  [cleavir-ast:function-ast
                     :body-ast
                     [cleavir-ast:progn-ast
                        :form-asts
                        ([cleavir-ast:setq-ast
                            :value-ast
                            #1=[cleavir-ast:lexical-ast
                                  :name #:|x|
                                  :policy nil
                                  :origin #2=(0 1 0 0)]
                            :lhs-ast
                            #3=[cleavir-ast:lexical-ast
                                  :name cleavir-cst-to-ast-test::x
                                  :policy nil
                                  :origin #2#]
                            :policy nil
                            :origin #2#]
                         [cleavir-ast:progn-ast
                            :form-asts
                            ([cleavir-ast:progn-ast
                                :form-asts
                                (#3#)
                                :policy nil
                                :origin nil])
                            :policy nil
                            :origin nil])
                        :policy nil
                        :origin nil]
                     :lambda-list
                     (#1#)
                     :policy nil
                     :origin nil]
                  :policy nil
                  :origin nil]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test07 ()
  (let* ((cst (cst:cst-from-expression '(quote a)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:load-time-value-ast
                  :read-only-p t
                  :form 'cleavir-cst-to-ast-test::a
                  :policy nil
                  :origin (0 1)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test08 ()
  (let* ((cst (cst:cst-from-expression '(block a 234)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:block-ast
                  :body-ast
                  [cleavir-ast:progn-ast
                     :form-asts
                     ([cleavir-ast:load-time-value-ast
                         :read-only-p t
                         :form '234
                         :policy nil
                         :origin (0 2)])
                     :policy nil
                     :origin nil]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test09 ()
  (let* ((cst (cst:cst-from-expression '(block a (return-from a 234))))
         (env (make-instance 'environment))
         (ast2 #1=[cleavir-ast:block-ast
                     :body-ast
                     [cleavir-ast:progn-ast
                        :form-asts
                        ([cleavir-ast:return-from-ast
                            :form-ast
                            [cleavir-ast:load-time-value-ast
                               :read-only-p t
                               :form '234
                               :policy nil
                               :origin (0 2 2)]
                            :block-ast #1#
                            :policy nil
                            :origin (0 2)])
                        :policy nil
                        :origin nil]
                     :policy nil
                     :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test10 ()
  (let* ((cst (cst:cst-from-expression '(eval-when (:execute) 234)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:progn-ast
                  :form-asts
                  ([cleavir-ast:load-time-value-ast
                      :read-only-p t
                      :form '234
                      :policy nil
                      :origin (0 2)])
                  :policy nil
                  :origin nil])
         (cleavir-cst-to-ast:*compiler* 'compile))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test11 ()
  (let* ((cst (cst:cst-from-expression '(tagbody a)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:progn-ast
                  :form-asts
                  ([cleavir-ast:tagbody-ast
                      :item-asts
                      ([cleavir-ast:tag-ast
                          :name a
                          :policy nil
                          :origin (0 1)])
                      :policy nil
                      :origin (0)]
                   [cleavir-ast:load-time-value-ast
                      :read-only-p t
                      :form 'nil
                      :policy nil
                      :origin nil])
                  :policy nil
                  :origin nil]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test12 ()
  (let* ((cst (cst:cst-from-expression '(tagbody a (go a))))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:progn-ast
                  :form-asts
                  ([cleavir-ast:tagbody-ast
                      :item-asts
                      (#1=[cleavir-ast:tag-ast
                             :name a
                             :policy nil
                             :origin (0 1)]
                       [cleavir-ast:go-ast
                          :tag-ast #1#
                          :policy nil
                          :origin (0 2)])
                      :policy nil
                      :origin (0)]
                   [cleavir-ast:load-time-value-ast
                      :read-only-p t
                      :form 'nil
                      :policy nil
                      :origin nil])
                  :policy nil
                  :origin nil]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test13 ()
  (let* ((cst (cst:cst-from-expression '(if *special1* 234 345)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:if-ast
                  :else-ast
                  [cleavir-ast:load-time-value-ast
                     :read-only-p t
                     :form '234
                     :policy nil
                     :origin (0 2)]
                  :then-ast
                  [cleavir-ast:load-time-value-ast
                     :read-only-p t
                     :form '345
                     :policy nil
                     :origin (0 3)]
                  :test-ast
                  [cleavir-ast:eq-ast
                     :arg2-ast
                     [cleavir-ast:load-time-value-ast
                        :read-only-p t
                        :form 'nil
                        :policy nil
                        :origin nil]
                     :arg1-ast
                     [cleavir-ast:symbol-value-ast
                        :symbol-ast
                        [cleavir-ast:load-time-value-ast
                           :read-only-p t
                           :form '*special1*
                           :policy nil
                           :origin #1=(0 1)]
                        :policy nil
                        :origin #1#]
                     :policy nil
                     :origin nil]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test14 ()
  (let* ((cst (cst:cst-from-expression '(load-time-value 123)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:load-time-value-ast
                  :read-only-p nil
                  :form 123
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test15 ()
  (let* ((cst (cst:cst-from-expression '(progn 123 234)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:progn-ast
                  :form-asts
                  ([cleavir-ast:load-time-value-ast
                      :read-only-p t
                      :form '123
                      :policy nil
                      :origin (0 1)]
                   [cleavir-ast:load-time-value-ast
                      :read-only-p t
                      :form '234
                      :policy nil
                      :origin (0 2)])
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test16 ()
  (let* ((cst (cst:cst-from-expression '(locally (declare (special x)) x)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:progn-ast
                  :form-asts
                  ([cleavir-ast:symbol-value-ast
                      :symbol-ast
                      [cleavir-ast:load-time-value-ast
                         :read-only-p t
                         :form 'x
                         :policy nil
                         :origin #1=(0 2)]
                      :policy nil
                      :origin #1#])
                  :policy nil
                  :origin nil]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test17 ()
  (let* ((cst (cst:cst-from-expression '(macrolet ((m (x) `(car ,x))) (m 234))))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:progn-ast
                  :form-asts
                  ([cleavir-ast:call-ast
                      :argument-asts
                      ([cleavir-ast:load-time-value-ast
                          :read-only-p t
                          :form '234
                          :policy nil
                          :origin (0 2 1)])
                      :callee-ast
                      [cleavir-ast:fdefinition-ast
                         :name-ast
                         [cleavir-ast:load-time-value-ast
                            :read-only-p t
                            :form 'car
                            :policy nil
                            :origin nil]
                         :policy nil
                         :origin nil]
                      :policy nil
                      :origin nil])
                  :policy nil
                  :origin nil]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test18 ()
  (let* ((cst (cst:cst-from-expression 42))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:immediate-ast
                  :value 42
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test19 ()
  (let* ((cst (cst:cst-from-expression '(let (x) x)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:call-ast
                  :argument-asts
                  ([cleavir-ast:load-time-value-ast
                      :read-only-p t
                      :form 'nil
                      :policy nil
                      :origin nil])
                  :callee-ast
                  [cleavir-ast:function-ast
                     :body-ast
                     [cleavir-ast:progn-ast
                        :form-asts
                        ([cleavir-ast:setq-ast
                            :value-ast
                            #1=[cleavir-ast:lexical-ast
                                  :name #:|x|
                                  :policy nil
                                  :origin #2=(0 1 0)]
                            :lhs-ast
                            #3=[cleavir-ast:lexical-ast
                                  :name cleavir-cst-to-ast-test::x
                                  :policy nil
                                  :origin #2#]
                            :policy nil
                            :origin #2#]
                         [cleavir-ast:progn-ast
                            :form-asts
                            (#3#)
                            :policy nil
                            :origin nil])
                        :policy nil
                        :origin nil]
                     :lambda-list
                     (#1#)
                     :policy nil
                     :origin nil]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test20 ()
  (let* ((cst (cst:cst-from-expression '(function (lambda (&rest x) x))))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:function-ast
                  :body-ast
                  [cleavir-ast:progn-ast
                     :form-asts
                     ([cleavir-ast:setq-ast
                         :value-ast
                         #1=[cleavir-ast:lexical-ast
                               :name #:|x|
                               :policy nil
                               :origin #2=(0 1 1 1)]
                         :lhs-ast
                         #3=[cleavir-ast:lexical-ast
                               :name x
                               :policy nil
                               :origin #2#]
                         :policy nil
                         :origin #2#]
                      [cleavir-ast:progn-ast
                         :form-asts (#3#)
                         :policy nil
                         :origin nil])
                     :policy nil
                     :origin nil]
                  :lambda-list (&rest #1#)
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test21 ()
  (let* ((cst (cst:cst-from-expression '(function (lambda (&aux (x 1)) x))))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:function-ast
                  :body-ast
                  [cleavir-ast:progn-ast
                     :form-asts
                     ([cleavir-ast:setq-ast
                         :value-ast
                         [cleavir-ast:load-time-value-ast
                            :read-only-p t
                            :form '1
                            :policy nil
                            :origin (0 1 1 1 1)]
                         :lhs-ast
                         #1=[cleavir-ast:lexical-ast
                               :name x
                               :policy nil
                               :origin #2=(0 1 1 1 0)]
                         :policy nil
                         :origin #2#]
                      [cleavir-ast:progn-ast
                         :form-asts (#1#)
                         :policy nil
                         :origin nil])
                     :policy nil
                     :origin nil]
                  :lambda-list nil
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test22 ()
  (let* ((cst (cst:cst-from-expression '(function (lambda (&optional (x 1)) x))))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:function-ast
                  :body-ast
                  [cleavir-ast:progn-ast
                     :form-asts
                     ([cleavir-ast:if-ast
                         :else-ast
                         [cleavir-ast:load-time-value-ast
                            :read-only-p t
                            :form 'nil
                            :policy nil
                            :origin nil]
                         :then-ast
                         [cleavir-ast:setq-ast
                            :value-ast
                            [cleavir-ast:load-time-value-ast
                               :read-only-p t
                               :form '1
                               :policy nil
                               :origin (0 1 1 1 1)]
                            :lhs-ast
                            #1=[cleavir-ast:lexical-ast
                                  :name #:|x|
                                  :policy nil
                                  :origin #2=(0 1 1 1 0)]
                            :policy nil
                            :origin nil]
                         :test-ast
                         [cleavir-ast:eq-ast
                            :arg2-ast
                            [cleavir-ast:load-time-value-ast
                               :read-only-p t
                               :form 'nil
                               :policy nil
                               :origin nil]
                            :arg1-ast
                            #3=[cleavir-ast:lexical-ast
                                  :name #:g309848
                                  :policy nil
                                  :origin nil]
                            :policy nil
                            :origin nil]
                         :policy nil
                         :origin nil]
                      [cleavir-ast:progn-ast :form-asts
                         ([cleavir-ast:setq-ast
                             :value-ast #1#
                             :lhs-ast
                             #4=[cleavir-ast:lexical-ast
                                   :name x
                                   :policy nil
                                   :origin #2#]
                             :policy nil
                             :origin #2#]
                          [cleavir-ast:progn-ast
                             :form-asts (#4#)
                             :policy nil
                             :origin nil])
                         :policy nil
                         :origin nil])
                     :policy nil
                     :origin nil]
                  :lambda-list (&optional (#1# #3#))
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test23 ()
  (let* ((cst (cst:cst-from-expression '(function (lambda (&key (x 1)) x))))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:function-ast
                  :body-ast
                  [cleavir-ast:progn-ast
                     :form-asts
                     ([cleavir-ast:if-ast
                         :else-ast
                         [cleavir-ast:load-time-value-ast
                            :read-only-p t
                            :form 'nil
                            :policy nil
                            :origin nil]
                         :then-ast
                         [cleavir-ast:setq-ast
                            :value-ast
                            [cleavir-ast:load-time-value-ast
                               :read-only-p t
                               :form '1
                               :policy nil
                               :origin (0 1 1 1 1)]
                            :lhs-ast
                            #1=[cleavir-ast:lexical-ast
                                  :name #:|x|
                                  :policy nil
                                  :origin #2=(0 1 1 1 0)]
                            :policy nil
                            :origin nil]
                         :test-ast
                         [cleavir-ast:eq-ast
                            :arg2-ast
                            [cleavir-ast:load-time-value-ast
                               :read-only-p t
                               :form 'nil
                               :policy nil
                               :origin nil]
                            :arg1-ast
                            #3=[cleavir-ast:lexical-ast
                                  :name #:g317068
                                  :policy nil
                                  :origin nil]
                            :policy nil
                            :origin nil]
                         :policy nil
                         :origin nil]
                      [cleavir-ast:progn-ast
                         :form-asts
                         ([cleavir-ast:setq-ast
                             :value-ast #1#
                             :lhs-ast
                             #4=[cleavir-ast:lexical-ast
                                   :name x
                                   :policy nil
                                   :origin #2#]
                             :policy nil
                             :origin #2#]
                          [cleavir-ast:progn-ast
                             :form-asts (#4#)
                             :policy nil
                             :origin nil])
                         :policy nil
                         :origin nil])
                     :policy nil
                     :origin nil]
                  :lambda-list (&key (:x #1# #3#))
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test40 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:float-add short-float *special1* *special2*)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:float-add-ast
                 :origin (0)
                 :policy nil
                 :subtype short-float
                 :arg1-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 2)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                  :origin (0 2)
                                  :policy nil
                                  :read-only-p t
                                  :form '*special1*]]
                 :arg2-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 3)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                 :origin (0 3)
                                 :policy nil
                                 :read-only-p t
                                 :form '*special2*]]]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test41 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:float-sub short-float *special1* *special2*)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:float-sub-ast
                 :origin (0)
                 :policy nil
                 :subtype short-float
                 :arg1-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 2)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                  :origin (0 2)
                                  :policy nil
                                  :read-only-p t
                                  :form '*special1*]]
                 :arg2-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 3)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                 :origin (0 3)
                                 :policy nil
                                 :read-only-p t
                                 :form '*special2*]]]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test42 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:float-mul short-float *special1* *special2*)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:float-mul-ast
                 :origin (0)
                 :policy nil
                 :subtype short-float
                 :arg1-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 2)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                  :origin (0 2)
                                  :policy nil
                                  :read-only-p t
                                  :form '*special1*]]
                 :arg2-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 3)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                 :origin (0 3)
                                 :policy nil
                                 :read-only-p t
                                 :form '*special2*]]]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test43 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:float-div short-float *special1* *special2*)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:float-div-ast
                 :origin (0)
                 :policy nil
                 :subtype short-float
                 :arg1-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 2)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                  :origin (0 2)
                                  :policy nil
                                  :read-only-p t
                                  :form '*special1*]]
                 :arg2-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 3)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                 :origin (0 3)
                                 :policy nil
                                 :read-only-p t
                                 :form '*special2*]]]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test44 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:float-less short-float *special1* *special2*)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:float-less-ast
                 :origin (0)
                 :policy nil
                 :subtype short-float
                 :arg1-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 2)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                  :origin (0 2)
                                  :policy nil
                                  :read-only-p t
                                  :form '*special1*]]
                 :arg2-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 3)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                 :origin (0 3)
                                 :policy nil
                                 :read-only-p t
                                 :form '*special2*]]]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test45 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:float-not-greater short-float *special1* *special2*)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:float-not-greater-ast
                 :origin (0)
                 :policy nil
                 :subtype short-float
                 :arg1-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 2)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                  :origin (0 2)
                                  :policy nil
                                  :read-only-p t
                                  :form '*special1*]]
                 :arg2-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 3)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                 :origin (0 3)
                                 :policy nil
                                 :read-only-p t
                                 :form '*special2*]]]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test46 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:float-greater short-float *special1* *special2*)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:float-greater-ast
                 :origin (0)
                 :policy nil
                 :subtype short-float
                 :arg1-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 2)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                  :origin (0 2)
                                  :policy nil
                                  :read-only-p t
                                  :form '*special1*]]
                 :arg2-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 3)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                 :origin (0 3)
                                 :policy nil
                                 :read-only-p t
                                 :form '*special2*]]]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test47 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:float-not-less short-float *special1* *special2*)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:float-not-less-ast
                 :origin (0)
                 :policy nil
                 :subtype short-float
                 :arg1-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 2)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                  :origin (0 2)
                                  :policy nil
                                  :read-only-p t
                                  :form '*special1*]]
                 :arg2-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 3)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                 :origin (0 3)
                                 :policy nil
                                 :read-only-p t
                                 :form '*special2*]]]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test48 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:float-equal short-float *special1* *special2*)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:float-equal-ast
                 :origin (0)
                 :policy nil
                 :subtype short-float
                 :arg1-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 2)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                  :origin (0 2)
                                  :policy nil
                                  :read-only-p t
                                  :form '*special1*]]
                 :arg2-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 3)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                 :origin (0 3)
                                 :policy nil
                                 :read-only-p t
                                 :form '*special2*]]]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test50 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:float-sin short-float *special1*)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:float-sin-ast
                 :origin (0)
                 :policy nil
                 :subtype short-float
                 :arg-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 2)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                 :origin (0 2)
                                 :policy nil
                                 :read-only-p t
                                 :form '*special1*]]]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test51 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:float-cos short-float *special1*)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:float-cos-ast
                 :origin (0)
                 :policy nil
                 :subtype short-float
                 :arg-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 2)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                 :origin (0 2)
                                 :policy nil
                                 :read-only-p t
                                 :form '*special1*]]]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test52 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:float-sqrt short-float *special1*)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:float-sqrt-ast
                 :origin (0)
                 :policy nil
                 :subtype short-float
                 :arg-ast
                 [cleavir-ast:symbol-value-ast
                   :origin (0 2)
                   :policy nil
                   :symbol-ast [cleavir-ast:load-time-value-ast
                                 :origin (0 2)
                                 :policy nil
                                 :read-only-p t
                                 :form '*special1*]]]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test60 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:fixnum-equal *special1* *special2*)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:fixnum-equal-ast
                  :arg2-ast
                  [cleavir-ast:symbol-value-ast
                     :symbol-ast
                     [cleavir-ast:load-time-value-ast
                        :read-only-p t
                        :form 'cleavir-cst-to-ast-test::*special2*
                        :policy nil
                        :origin #1=(0 2)]
                     :policy nil
                     :origin #1#]
                  :arg1-ast
                  [cleavir-ast:symbol-value-ast
                     :symbol-ast
                     [cleavir-ast:load-time-value-ast
                        :read-only-p t
                        :form 'cleavir-cst-to-ast-test::*special1*
                        :policy nil
                        :origin #2=(0 1)]
                     :policy nil
                     :origin #2#]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test61 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:fixnum-less *special1* *special2*)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:fixnum-less-ast
                  :arg2-ast
                  [cleavir-ast:symbol-value-ast
                     :symbol-ast
                     [cleavir-ast:load-time-value-ast
                        :read-only-p t
                        :form 'cleavir-cst-to-ast-test::*special2*
                        :policy nil
                        :origin #1=(0 2)]
                     :policy nil
                     :origin #1#]
                  :arg1-ast
                  [cleavir-ast:symbol-value-ast
                     :symbol-ast
                     [cleavir-ast:load-time-value-ast
                        :read-only-p t
                        :form 'cleavir-cst-to-ast-test::*special1*
                        :policy nil
                        :origin #2=(0 1)]
                     :policy nil
                     :origin #2#]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test62 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:fixnum-not-greater *special1* *special2*)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:fixnum-not-greater-ast
                  :arg2-ast
                  [cleavir-ast:symbol-value-ast
                     :symbol-ast
                     [cleavir-ast:load-time-value-ast
                        :read-only-p t
                        :form 'cleavir-cst-to-ast-test::*special2*
                        :policy nil
                        :origin #1=(0 2)]
                     :policy nil
                     :origin #1#]
                  :arg1-ast
                  [cleavir-ast:symbol-value-ast
                     :symbol-ast
                     [cleavir-ast:load-time-value-ast
                        :read-only-p t
                        :form 'cleavir-cst-to-ast-test::*special1*
                        :policy nil
                        :origin #2=(0 1)]
                     :policy nil
                     :origin #2#]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test63 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:fixnum-greater *special1* *special2*)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:fixnum-greater-ast
                  :arg2-ast
                  [cleavir-ast:symbol-value-ast
                     :symbol-ast
                     [cleavir-ast:load-time-value-ast
                        :read-only-p t
                        :form 'cleavir-cst-to-ast-test::*special2*
                        :policy nil
                        :origin #1=(0 2)]
                     :policy nil
                     :origin #1#]
                  :arg1-ast
                  [cleavir-ast:symbol-value-ast
                     :symbol-ast
                     [cleavir-ast:load-time-value-ast
                        :read-only-p t
                        :form 'cleavir-cst-to-ast-test::*special1*
                        :policy nil
                        :origin #2=(0 1)]
                     :policy nil
                     :origin #2#]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test64 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:fixnum-not-less *special1* *special2*)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:fixnum-not-less-ast
                  :arg2-ast
                  [cleavir-ast:symbol-value-ast
                     :symbol-ast
                     [cleavir-ast:load-time-value-ast
                        :read-only-p t
                        :form 'cleavir-cst-to-ast-test::*special2*
                        :policy nil
                        :origin #1=(0 2)]
                     :policy nil
                     :origin #1#]
                  :arg1-ast
                  [cleavir-ast:symbol-value-ast
                     :symbol-ast
                     [cleavir-ast:load-time-value-ast
                        :read-only-p t
                        :form 'cleavir-cst-to-ast-test::*special1*
                        :policy nil
                        :origin #2=(0 1)]
                     :policy nil
                     :origin #2#]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test65 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:let-uninitialized (x) x)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:progn-ast
                  :form-asts
                  ([cleavir-ast:lexical-ast
                      :name cleavir-cst-to-ast-test::x
                      :policy nil
                      :origin (0 1 0)])
                  :policy nil
                  :origin nil]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test66 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:let-uninitialized (x)
                 (cleavir-primop:fixnum-add *special1* *special2* x))))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:progn-ast
                  :form-asts
                  ([cleavir-ast:fixnum-add-ast
                      :variable-ast
                      [cleavir-ast:lexical-ast
                         :name cleavir-cst-to-ast-test::x
                         :policy nil
                         :origin (0 1 0)]
                      :arg2-ast
                      [cleavir-ast:symbol-value-ast
                         :symbol-ast
                         [cleavir-ast:load-time-value-ast
                            :read-only-p t
                            :form 'cleavir-cst-to-ast-test::*special2*
                            :policy nil
                            :origin #1=(0 2 2)]
                         :policy nil
                         :origin #1#]
                      :arg1-ast
                      [cleavir-ast:symbol-value-ast
                         :symbol-ast
                         [cleavir-ast:load-time-value-ast
                            :read-only-p t
                            :form 'cleavir-cst-to-ast-test::*special1*
                            :policy nil
                            :origin #2=(0 2 1)]
                         :policy nil
                         :origin #2#]
                      :policy nil
                      :origin (0 2)])
                  :policy nil
                  :origin nil]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test67 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:let-uninitialized (x)
                 (cleavir-primop:fixnum-sub *special1* *special2* x))))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:progn-ast
                  :form-asts
                  ([cleavir-ast:fixnum-sub-ast
                      :variable-ast
                      [cleavir-ast:lexical-ast
                         :name cleavir-cst-to-ast-test::x
                         :policy nil
                         :origin (0 1 0)]
                      :arg2-ast
                      [cleavir-ast:symbol-value-ast
                         :symbol-ast
                         [cleavir-ast:load-time-value-ast
                            :read-only-p t
                            :form 'cleavir-cst-to-ast-test::*special2*
                            :policy nil
                            :origin #1=(0 2 2)]
                         :policy nil
                         :origin #1#]
                      :arg1-ast
                      [cleavir-ast:symbol-value-ast
                         :symbol-ast
                         [cleavir-ast:load-time-value-ast
                            :read-only-p t
                            :form 'cleavir-cst-to-ast-test::*special1*
                            :policy nil
                            :origin #2=(0 2 1)]
                         :policy nil
                         :origin #2#]
                      :policy nil
                      :origin (0 2)])
                  :policy nil
                  :origin nil]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test68 ()
  (let* ((cst (cst:cst-from-expression '(cleavir-primop:ast 234)))
         (env (make-instance 'environment))
         (ast2 234))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test69 ()
  (let* ((cst (cst:cst-from-expression '(cleavir-primop:eq 1 2)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:eq-ast
                  :arg2-ast
                  [cleavir-ast:load-time-value-ast
                     :read-only-p t
                     :form '2
                     :policy nil
                     :origin (0 2)]
                  :arg1-ast
                  [cleavir-ast:load-time-value-ast
                     :read-only-p t
                     :form '1
                     :policy nil
                     :origin (0 1)]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test70 ()
  (let* ((cst (cst:cst-from-expression '(cleavir-primop:car 1)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:car-ast
                  :cons-ast
                  [cleavir-ast:load-time-value-ast
                     :read-only-p t
                     :form '1
                     :policy nil
                     :origin (0 1)]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test71 ()
  (let* ((cst (cst:cst-from-expression '(cleavir-primop:cdr 1)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:cdr-ast
                  :cons-ast
                  [cleavir-ast:load-time-value-ast
                     :read-only-p t
                     :form '1
                     :policy nil
                     :origin (0 1)]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test72 ()
  (let* ((cst (cst:cst-from-expression '(cleavir-primop:rplaca 1 2)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:rplaca-ast
                  :object-ast
                  [cleavir-ast:load-time-value-ast
                     :read-only-p t
                     :form '2
                     :policy nil
                     :origin (0 2)]
                  :cons-ast
                  [cleavir-ast:load-time-value-ast
                     :read-only-p t
                     :form '1
                     :policy nil
                     :origin (0 1)]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test73 ()
  (let* ((cst (cst:cst-from-expression '(cleavir-primop:rplacd 1 2)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:rplacd-ast
                  :object-ast
                  [cleavir-ast:load-time-value-ast
                     :read-only-p t
                     :form '2
                     :policy nil
                     :origin (0 2)]
                  :cons-ast
                  [cleavir-ast:load-time-value-ast
                     :read-only-p t
                     :form '1
                     :policy nil
                     :origin (0 1)]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test74 ()
  (let* ((cst (cst:cst-from-expression '(cleavir-primop:typeq *special1* t)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:typeq-ast
                  :form-ast
                  [cleavir-ast:symbol-value-ast
                     :symbol-ast
                     [cleavir-ast:load-time-value-ast
                        :read-only-p t
                        :form '*special1*
                        :policy nil
                        :origin #1=(0 1)]
                     :policy nil
                     :origin #1#]
                  :type-specifier t
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test75 ()
  (let* ((cst (cst:cst-from-expression '(cleavir-primop:funcall *special1* 1)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:call-ast
                  :argument-asts
                  ([cleavir-ast:load-time-value-ast
                      :read-only-p t
                      :form '1
                      :policy nil
                      :origin (0 2)])
                  :callee-ast
                  [cleavir-ast:symbol-value-ast
                     :symbol-ast
                     [cleavir-ast:load-time-value-ast
                        :read-only-p t
                        :form '*special1*
                        :policy nil
                        :origin #1=(0 1)]
                     :policy nil
                     :origin #1#]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test76 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:multiple-value-call *special1* 1)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:multiple-value-call-ast
                  :form-asts
                  ([cleavir-ast:load-time-value-ast
                      :read-only-p t
                      :form '1
                      :policy nil
                      :origin (0 2)])
                  :function-form-ast
                  [cleavir-ast:symbol-value-ast
                     :symbol-ast
                     [cleavir-ast:load-time-value-ast
                        :read-only-p t
                        :form '*special1*
                        :policy nil
                        :origin #1=(0 1)]
                     :policy nil
                     :origin #1#]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test77 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:slot-read *special1* 1)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:slot-read-ast
                  :slot-number-ast
                  [cleavir-ast:load-time-value-ast
                     :read-only-p t
                     :form '1
                     :policy nil
                     :origin (0 2)]
                  :object-ast
                  [cleavir-ast:symbol-value-ast
                     :symbol-ast
                     [cleavir-ast:load-time-value-ast
                        :read-only-p t
                        :form '*special1*
                        :policy nil
                        :origin #1=(0 1)]
                     :policy nil
                     :origin #1#]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test78 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:slot-write *special1* 1 2)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:slot-write-ast
                  :value-ast
                  [cleavir-ast:load-time-value-ast
                     :read-only-p t
                     :form '2
                     :policy nil
                     :origin (0 3)]
                  :slot-number-ast
                  [cleavir-ast:load-time-value-ast
                     :read-only-p t
                     :form '1
                     :policy nil
                     :origin (0 2)]
                  :object-ast
                  [cleavir-ast:symbol-value-ast
                     :symbol-ast
                     [cleavir-ast:load-time-value-ast
                        :read-only-p t
                        :form '*special1*
                        :policy nil
                        :origin #1=(0 1)]
                     :policy nil
                     :origin #1#]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test79 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:aref *special1* 1 t t t)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:aref-ast
                  :boxed-p t
                  :simple-p t
                  :element-type t
                  :index-ast
                  [cleavir-ast:load-time-value-ast
                     :read-only-p t
                     :form '1
                     :policy nil
                     :origin (0 2)]
                  :array-ast
                  [cleavir-ast:symbol-value-ast
                     :symbol-ast
                     [cleavir-ast:load-time-value-ast
                        :read-only-p t
                        :form '*special1*
                        :policy nil
                        :origin #1=(0 1)]
                     :policy nil
                     :origin #1#]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test80 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:aset *special1* 1 2 t t t)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:aset-ast
                  :boxed-p t
                  :simple-p t
                  :element-type t
                  :value-ast
                  [cleavir-ast:load-time-value-ast
                     :read-only-p t
                     :form '2
                     :policy nil
                     :origin (0 3)]
                  :index-ast
                  [cleavir-ast:load-time-value-ast
                     :read-only-p t
                     :form '1
                     :policy nil
                     :origin (0 2)]
                  :array-ast
                  [cleavir-ast:symbol-value-ast
                     :symbol-ast
                     [cleavir-ast:load-time-value-ast
                        :read-only-p t
                        :form '*special1*
                        :policy nil
                        :origin #1=(0 1)]
                     :policy nil
                     :origin #1#]
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test81 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:coerce integer double-float 1)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:coerce-ast
                  :arg-ast
                  [cleavir-ast:load-time-value-ast
                     :read-only-p t
                     :form '1
                     :policy nil
                     :origin (0 3)]
                  :to double-float
                  :from integer
                  :policy nil
                  :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test82 ()
  (let* ((cst (cst:cst-from-expression
               '(cleavir-primop:unreachable)))
         (env (make-instance 'environment))
         (ast2 [cleavir-ast:unreachable-ast :policy nil :origin (0)]))
    (assign-sources cst)
    (let ((ast1 (cleavir-cst-to-ast:cst-to-ast cst env nil)))
      (assert (ast-equal-p ast1 ast2)))))

(defun test ()
  (test01)
  (test02)
  (test03)
  (test04)
  (test05)
  (test06)
  (test07)
  (test08)
  (test09)
  (test10)
  (test11)
  (test12)
  (test13)
  (test14)
  (test15)
  (test16)
  (test17)
  (test18)
  (test19)
  (test20)
  (test21)
  (test22)
  (test23)
  (test40)
  (test41)
  (test42)
  (test43)
  (test44)
  (test45)
  (test46)
  (test47)
  (test48)
  (test50)
  (test51)
  (test52)
  (test60)
  (test61)
  (test62)
  (test63)
  (test64)
  (test65)
  (test66)
  (test67)
  (test68)
  (test69)
  (test70)
  (test71)
  (test72)
  (test73)
  (test74)
  (test75)
  (test76)
  (test77)
  (test78)
  (test79)
  (test80)
  (test81)
  (test82))
