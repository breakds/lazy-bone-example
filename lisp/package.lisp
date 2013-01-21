;;;; package.lisp
;;;; package definition for lazy-bone-example

(defpackage #:breakds.lazy-bone-example.test-app
  (:nicknames #:test-app)
  (:use #:cl
        #:lazy-bone)
  (:import-from #:parenscript #:ps* #:ps #:create
                #:chain #:defpsmacro #:new #:getprop #:@ #:for-in)
  (:export #:start-server
           #:stop-server))


  
    