
(defvar L_indexes (loop for i from 1 to 48 collect i))
(loop for i in L_indexes collect
  (progn 
        (eval `(defvar ,(read-from-string (format nil "L_~A" i)) ,(read-from-string (format nil "~A" i))))))

(defvar L_last 48)
(defvar L_first 1)

; (defun Adj (i j)
;  (&&

;   (!!
;     (&&
;       (||([=] i 14)([=] i 25)([=] i  36)([=] i  42)([=] i  48) ([=] i 15) ([=] i  26)([=] i  37)([=] i  43))
;       (||([=] j 14)([=] j 25)([=] j  36)([=] j  42)([=] j  48) ([=] j 15) ([=] j  26)([=] j  37)([=] j  43))
;     )
;   )

;   (||
;     ;rhs
;     (&&
;       (!! ([=] i 14)) (!!([=] i 25)) (!!([=] i  36)) (!!([=] i  42)) (!!([=] i  48))
;       ([=] i (+ j 1))
;     )

;     (&&
;       (!! ([=] j 14)) (!!([=] j 25)) (!!([=] j  36)) (!!([=] j  42)) (!!([=] j  48))
;       ([=] j (+ i 1))
;     )

;     ;lhs
;     (&&
;       (!!([=] i 15)) (!!([=] i  26))  (!!([=] i  37))(!!([=] i  43)) 
;       ([=] i (- j 1))
;     )

;     (&&
;       (!!([=] j 15)) (!!([=] j  26))  (!!([=] j  37))(!!([=] j  43)) 
;       ([=] j (- i 1))
;     )

;     ;up or down
;     (&& 
;       ([>=] i 15) ([<=] i 25) (|| ([=] j (- i 11)) ([=] j (+ i 11)))
;     )

;     (&&
;       ([>=] j 15) ([<=] j 25) (|| ([=] i (- j 11)) ([=] i (+ j 11)))
;     )

;     (&&
;       ([>=] j 37) ([<=] j 42)(|| ([=] j (- i 6)) ([=] j (+ i 6)))
;     )

;     (&&
;       ([>=] i 37) ([<=] i 42)(|| ([=] i (- j 6)) ([=] i (+ j 6)))
;     )

;     (&&
;       ([>=] j 1) ([<=] j 6)(|| ([=] j (- i 3)) ([=] j (+ i 3)))
;     )

;     (&&
;       ([>=] i 1) ([<=] i 6)(|| ([=] i (- j 3)) ([=] i (+ j 3)))
;     )

;   )
;  )
; )


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
      (-E- x  L_indexes (&& ([=] x i) ([=] (- x 1) j)))
    )

    (&&
      (!! ([=] j 14)) (!!([=] j 25)) (!!([=] j  36)) (!!([=] j  42)) (!!([=] j  48))
      (-E- x  L_indexes (&& ([=] x j) ([=] (- x 1) i)))
      ; ([=] j (+ i 1))
    )

    ;lhs
    (&&
      (!!([=] i 15)) (!!([=] i  26))  (!!([=] i  37))(!!([=] i  43)) 
      (-E- x  L_indexes (&& ([=] x i) ([=] (+ x 1) j)))
      ; ([=] i (- j 1))
    )

    (&&
      (!!([=] j 15)) (!!([=] j  26))  (!!([=] j  37))(!!([=] j  43)) 
      (-E- x  L_indexes (&& ([=] x j) ([=] (+ x 1) i)))
      ; ([=] j (- i 1))
    )

    ;up or down
    (&& 
      ([>=] i 15) ([<=] i 25) 
      (||
        (-E- x  L_indexes (&& ([=] x i) ([=] (- x 11) j)))
        (-E- x  L_indexes (&& ([=] x i) ([=] (+ x 11) j)))
        )
      ; (|| ([=] j (- i 11)) ([=] j (+ i 11)))
    )

    (&&
      ([>=] j 15) ([<=] j 25) 
      (||
        (-E- x  L_indexes (&& ([=] x j) ([=] (- x 11) i)))
        (-E- x  L_indexes (&& ([=] x j) ([=] (+ x 11) i)))
      )
      ; (|| ([=] i (- j 11)) ([=] i (+ j 11)))
    )

    (&&
      ([>=] j 37) ([<=] j 42)
      (||
        (-E- x  L_indexes (&& ([=] x i) ([=] (- x 6) j)))
        (-E- x  L_indexes (&& ([=] x i) ([=] (+ x 6) j)))
        )
      ; (|| ([=] j (- i 6)) ([=] j (+ i 6)))
    )

    (&&
      ([>=] i 37) ([<=] i 42)
      (||
        (-E- x  L_indexes (&& ([=] x j) ([=] (- x 6) i)))
        (-E- x  L_indexes (&& ([=] x j) ([=] (+ x 6) i)))
        )
      ; (|| ([=] i (- j 6)) ([=] i (+ j 6)))
    )

    (&&
      ([>=] j 1) ([<=] j 6)
      (||
        (-E- x  L_indexes (&& ([=] x i) ([=] (- x 3) j)))
        (-E- x  L_indexes (&& ([=] x i) ([=] (+ x 3) j)))
      )

      ; (|| ([=] j (- i 3)) ([=] j (+ i 3)))
    )

    (&&
      ([>=] i 1) ([<=] i 6)
      (||
        (-E- x  L_indexes (&& ([=] x j) ([=] (- x 3) i)))
        (-E- x  L_indexes (&& ([=] x j) ([=] (+ x 3) i)))
        )
      ; (|| ([=] i (- j 3)) ([=] i (+ j 3)))
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

(defvar body_indexes (loop for i from 1 to 11 collect i))

(defconstant *relativeProperties*
 (eval (list `alwf (append `(&&)
  (loop for i in body_indexes collect `(&&
  	(<->  (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_clos" i))) ([=] (-V- LINK1_Position) (-V- Body_Part_pos ,(read-from-string (format nil "~A" i)))))
  	(<->  (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_clos" i))) ([=] (-V- LINK2_Position) (-V- Body_Part_pos ,(read-from-string (format nil "~A" i)))))
  	(<->  (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_clos" i))) ([=] (-V- End_Eff_B_Position) (-V- Body_Part_pos ,(read-from-string (format nil "~A" i)))))

	(<->  (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_far" i))) (Adj (-V- LINK1_Position) (-V- Body_Part_pos ,(read-from-string (format nil "~A" i)))))
  	(<->  (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_far" i))) (Adj (-V- LINK2_Position) (-V- Body_Part_pos ,(read-from-string (format nil "~A" i)))))
  	(<->  (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_far" i))) (Adj (-V- End_Eff_B_Position) (-V- Body_Part_pos ,(read-from-string (format nil "~A" i)))))

  	(<->  (-P- ,(read-from-string (format nil "moveDirectionLink1_~A_clos" i))) (|| (&& (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_clos" i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_far" i)))))  (&& (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_far" i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_very_far" i)))))))
  	(<->  (-P- ,(read-from-string (format nil "moveDirectionLink2_~A_clos" i))) (||(&& (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_clos" i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_far" i))))) (&& (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_far" i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_very_far" i)))))))
  	(<->  (-P- ,(read-from-string (format nil "moveDirectionEndEff_~A_clos" i))) (|| (&& (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_clos" i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_far" i))))) (&& (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_far" i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_very_far" i)))))))

  	(<->  (-P- ,(read-from-string (format nil "moveDirectionLink1_~A_apart" i))) (||(&& (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_far" i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_clos" i))))) (&& (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_very_far" i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_far" i)))))   ))
  	(<->  (-P- ,(read-from-string (format nil "moveDirectionLink2_~A_apart" i))) (||(&& (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_far" i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_clos" i))))) (&& (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_very_far" i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_far" i)))))   ))
  	(<->  (-P- ,(read-from-string (format nil "moveDirectionEndEff_~A_apart" i)))(||(&& (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_far" i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_clos" i))))) (&& (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_very_far" i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_far" i)))))   ))

  	(<-> (!! (|| (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_clos" i))) (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_far" i)))))(-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_very_far" i))))
  	(<-> (!! (|| (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_clos" i))) (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_far" i)))))(-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_very_far" i))))
  	(<-> (!! (|| (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_clos" i))) (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_far" i)))))(-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_very_far" i))))
  ))
 (loop for i in '(1) collect `(&&
	(<-> (-P- relativeVelocity_low)(&& (-P- Robot_Idle) (-P- OperatorStill)))
	(<-> (!!(-P- relativeVelocity_low))(||(!!(-P- Robot_Idle) )(!!(-P- OperatorStill))))
	
	(<-> (!!(-P- relativeVelocity_low)) (|| (-P- relativeVelocity_critical) (-P- relativeVelocity_normal)))
	(<-> (!!(-P- relativeVelocity_normal)) (|| (-P- relativeVelocity_critical) (-P- relativeVelocity_low)))
	(<-> (!!(-P- relativeVelocity_critical)) (|| (-P- relativeVelocity_low) (-P- relativeVelocity_normal)))

 	(<-> (!!(-P- relativeForce_low)) (|| (-P- relativeForce_critical) (-P- relativeForce_normal)))
	(<-> (!!(-P- relativeForce_normal)) (|| (-P- relativeForce_critical) (-P- relativeForce_low)))
	(<-> (!!(-P- relativeForce_critical)) (|| (-P- relativeForce_low) (-P- relativeForce_normal)))
))
))))	
