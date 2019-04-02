(asdf:operate 'asdf:load-op 'ae2sbvzot)
(use-package :trio-utils)

; (defvar a 2) 
; (defvar b 5)
(define-tvar a *INT*) 
(define-tvar b *INT*) 
(defvar TSPACE 10)

(defun Adj (i j) 
  (||
    (&& ([=] i 1) (||([=] j 2) ([=] j 5)))
    (&& ([=] i 2) (||([=] j 1) ([=] j 3) ([=] j 4) ))
    (&& ([=] i 3) (||([=] j 2) ([=] j 4) ([=] j 7) ))
    (&& ([=] i 4) (||([=] j 2) ([=] j 3) ([=] j 5) ))
    (&& ([=] i 5) (||([=] j 1) ([=] j 4) ([=] j 8) ([=] j 9) ))
    (&& ([=] i 6) (||([=] j 7) ))
    (&& ([=] i 7) (||([=] j 3) ([=] j 6) ([=] j 8) ))
    (&& ([=] i 8) (||([=] j 5) ([=] j 7) ([=] j 9) ))
    (&& ([=] i 9) (||([=] j 5) ([=] j 8) ))
  ))


(defconstant *sys*
 (yesterday
  (&&
    (Alw (|| (-P- low) (-P- mid)(-P- high)))
    (Alw (!! (&&(-P- low) (-P- mid)(-P- high))))
    (Alw (!! (&&(-P- low) (-P- mid))))
    (Alw (!! (&& (-P- mid)(-P- high))))
    (Alw (!! (&&(-P- low) (-P- high))))
    (Alw ([<] (-V- a) 10))
    (Alw ([>] (-V- a) 0))
    ; (Somf(-P- low))
    (Alw ([<] (-V- b) 10))
    (Alw ([>] (-V- b) 0))

    (<-> (-P- high) (next (!! (-P- low))))
    (<-> (-P- low) (next (!! (-P- high))))
    (-P- low)
    (next(-P- low))
    (Somf(-P- mid))
    (Somf(-P- high))
    (Alw(<->(-P- low) ([=] (yesterday (-V- a)) (-V- a))))
    (Alw(<->(-P- mid) (Adj (yesterday (-V- a)) (-V- a))))
    (Alw(<->(-P- high) (&&
            (Adj (yesterday (yesterday (-V- a))) (-V- b))
            (Adj (-V- b) (-V- a))
         )))
  )
  
))


(format t "~S" *sys*)
(ae2sbvzot:zot TSPACE
 (&& *sys*))
