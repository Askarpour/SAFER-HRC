(asdf:operate 'asdf:load-op 'ae2sbvzot)
(use-package :trio-utils)
(defvar TSPACE 1)

(loop for i in (loop for x from 1 to 48 collect x) collect
  (progn 
        (eval `(defvar ,(read-from-string (format nil "L_~A" i)) ,(read-from-string (format nil "~A" i))))))


(defun Adj (i j)
(&&

  (!!
    (&&
      (||([=] i 14)([=] i 25)([=] i  36)([=] i  42)([=] i  48) ([=] i 15) ([=] i  26)([=] i  37)([=] i  43))
      (||([=] j 14)([=] j 25)([=] j  36)([=] j  42)([=] j  48) ([=] j 15) ([=] j  26)([=] j  37)([=] j  43))
    )
  )

  (||
    ;rhs
    (&&
      (!! ([=] i 14)) (!!([=] i 25)) (!!([=] i  36)) (!!([=] i  42)) (!!([=] i  48))
      ([=] i (+ j 1))
    )

    (&&
      (!! ([=] j 14)) (!!([=] j 25)) (!!([=] j  36)) (!!([=] j  42)) (!!([=] j  48))
      ([=] j (+ i 1))
    )

    ;lhs
    (&&
      (!!([=] i 15)) (!!([=] i  26))  (!!([=] i  37))(!!([=] i  43)) 
      ([=] i (- j 1))
    )

    (&&
      (!!([=] j 15)) (!!([=] j  26))  (!!([=] j  37))(!!([=] j  43)) 
      ([=] j (- i 1))
    )

    ;up or down
    (&& 
      ([>=] i 15) ([<=] i 25) (|| ([=] j (- i 11)) ([=] j (+ i 11)))
    )

    (&&
      ([>=] j 15) ([<=] j 25) (|| ([=] i (- j 11)) ([=] i (+ j 11)))
    )

    (&&
      ([>=] j 37) ([<=] j 42)(|| ([=] j (- i 6)) ([=] j (+ i 6)))
    )

    (&&
      ([>=] i 37) ([<=] i 42)(|| ([=] i (- j 6)) ([=] i (+ j 6)))
    )

    (&&
      ([>=] j 1) ([<=] j 6)(|| ([=] j (- i 3)) ([=] j (+ i 3)))
    )

    (&&
      ([>=] i 1) ([<=] i 6)(|| ([=] i (- j 3)) ([=] i (+ j 3)))
    )

  )
)
)

(defun IsPallet (i)
  (||
    ([=] i L_2)
    ([=] i L_3)
    ([=] i L_5)
    ([=] i L_6)
  
    ([=] i L_37)
    ([=] i L_38)
    ([=] i L_43)
    ([=] i L_44)
  
    ([=] i L_40)
    ([=] i L_41)
    ([=] i L_46)
    ([=] i L_47)
  )
)

; (<->
;   (-P- occluded)
;   (||
;     (loop for i in `(LINK1_Position LINK2_Position End_Eff_B_Position) collect
;       ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Reg_~A" i))(loop for x = (read in nil nil) while x collect x)))) L_2)
;   ))


; )
(defvar x 27)
; (defvar y 26)
(define-tvar LINK1_Position *int*)
(define-tvar LINK2_Position *int*)
(define-tvar End_Eff_B_Position *int*) 
(defvar indexes (loop for i from 1 to 1 collect i))
 

; (load "Properties.lisp")
(defconstant ExeT1
 (&&
  
))  
  

(defconstant *sys*
 (yesterday(&&
  ExeT1
)))

(format t "~S" *sys*)
; (ae2sbvzot:zot TSPACE
;  (&&
;    *sys*
;    ))