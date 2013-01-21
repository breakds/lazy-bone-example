;;;; lazy-bone-example.asd


(asdf:defsystem #:lazy-bone-example
    :serial t
    :depends-on (#:lazy-bone)
    :components ((:file "lisp/package")
                 (:file "lisp/example")))

    
