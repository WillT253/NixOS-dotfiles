(define-configuration (input-buffer)
  ((default-modes
    (remove-if
     (lambda (nyxt::m)
       (find (symbol-name nyxt::m)
             '("EMACS-MODE" "VI-NORMAL-MODE" "VI-INSERT-MODE") :test
             #'string=))
     %slot-value%))))

(define-configuration (input-buffer)
  ((default-modes (pushnew 'nyxt/mode/vi:vi-normal-mode %slot-value%))))

(define-configuration (prompt-buffer)
  ((default-modes (pushnew 'nyxt/mode/vi:vi-insert-mode %slot-value%))))

(define-configuration browser
  ((theme theme:+dark-theme+)))

(define-configuration (web-buffer)
  ((default-modes (pushnew 'nyxt/mode/style:dark-mode %slot-value%))))

(defmethod customize-instance ((browser browser) &key)
  (setf (slot-value browser 'default-new-buffer-url)
          "https://github.com/WillT253/"))

(define-configuration (web-buffer)
  ((default-modes (pushnew 'nyxt/mode/blocker:blocker-mode %slot-value%))))

(define-configuration (web-buffer)
  ((default-modes
    (pushnew 'nyxt/mode/reduce-tracking:reduce-tracking-mode %slot-value%))))
