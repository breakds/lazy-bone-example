(in-package #:breakds.lazy-bone-example.test-app)

(def-view *my-button
    (('tag-name "button")
     ('template "<%= caption %>")
     ('events '(create click "onClick"))
     ('initialize '(lazy-init (acquire-args (caption) (caption))))
     ('render '(lambda () 
                ((@ this $el html) 
                 ((@ _ template) 
                  (@ this template) 
                  (create caption (@ this caption))))
                this))
     ('on-click '(lambda () nil))))

(def-model *button-state
    (('initialize '(lambda (args)
		    (acquire-args 
		     (caption msg)
		     (caption msg))))))
                    
(def-view *signal-button
    (('initialize '(lazy-init
		    (acquire-args
		     (model msg caption) 
		     (model model.msg model.caption))))
     ('on-click '(lambda () ((@ this model trigger) "clicked" (@ this msg)) nil)))
  :base *my-button)

(def-collection *state-set
    (('model '*button-state)))

(def-collection-view *button-panel
    (('collection-view '*signal-button)
     ('lazy-render '(lambda (view) 
                     ((@ ($ "#main") append) (@ ((@ view render)) el))
                     nil))
     ('initialize '(lazy-init
                    ((@ this bind-to)
                     (@ this collection)
                     "clicked"
                     (lambda (e) 
                       ((@ this collection reset))
                       ((@ this terminate) e)
                       nil))))))
(def-view *gen-button
    (('initialize '(lazy-init 
                    ((@ ($ "#main") append) (@ ((@ this render)) el))))
     ('on-click '(lambda ()
                  (defvar state-yes (new (*button-state (create msg "yes"
                                                                caption "Yes"))))
                  (defvar state-no (new (*button-state (create msg "no"
                                                               caption "No"))))
                  (wait-until panel (new (*button-panel (create collection
                                                                (new (*state-set
                                                                      (ps:array state-yes
                                                                                state-no))))))
                   (((@ console log) (+ "the user clicked " return-form))))
                  nil)))
  :base *my-button)
                               
(define-simple-app test-app-main (:title "Test Application" :port 9010)
  '(defvar btn (new (*gen-button (create caption "Generate")))))
