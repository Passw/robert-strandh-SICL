(cl:in-package #:sicl-new-boot-backtrace-inspector)

(define-inspector-command (com-quit :name t) ()
  (clim:frame-exit clim:*application-frame*))

(define-inspector-command (com-show-source :name t)
    ((entry 'cbe:call-stack-entry))
  (setf (current-entry clim:*application-frame*)
        entry))

(clim:define-presentation-to-command-translator show-source
    (cbe:call-stack-entry
     com-show-source
     inspector
     :documentation "Show Source")
    (object)
  (list object))

(define-inspector-command (com-inspect-argument :name t)
    ((argument 'argument))
  (clouseau:inspect argument))

(clim:define-presentation-to-command-translator inspect-argument
    (argument
     com-inspect-argument
     inspector
     :documentation "Inspect Argument")
    (object)
  (list object))
