(asdf:operate 'asdf:load-op 'sbvzot)
(use-package :trio-utils)
(load "Main.lisp")
; (defvar theLTLformula
;  (yesterday (&& 
;     (-p- first) (!! (-p- second)) (!! (-p- third)) ;;Init
;     (alwf (&& ;;axioms
;         (<-> (-p- first) (next (-p- second)))
;         (<-> (-p- second) (next (-p- third)))
;         (<-> (-p- third) (next (-p- first)))
;     ))
;     (somf (&& (-p- first) (!! (next (next (-p- third))))));;property
;     )))

(loop for bound from 100 to 100 do

       (progn 
        ; (let ((res 
        ; (sbvzot:zot 
        ;  bound
        ;  *sys*
        ;  :loop-free 'nil
        ;  )))
        ;  (if res
        ;    (progn (format t "~%###A counter-example is found with The bound ~S.~%" bound) (return)))
        ;  (format t "~%###No counter-example is found yet with the bound ~S.~%" bound))
        (let ((res 
        (sbvzot:zot 
         bound
         ; theLTLformula
         *sys*
         :loop-free t
         :getLFmodel t
         ; :getLFmodel 'nil
         )))
         (if (not res)
           (progn (format t "~%###Verified with The bound ~S.~%" bound) (return)))
         (format t "~%###Not verified yet with the bound ~S.~%" bound))
        )
       )
