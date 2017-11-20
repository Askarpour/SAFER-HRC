
(defvar L_indexes (loop for i from 1 to 48 collect i))
(loop for i in L_indexes collect
  (progn 
        (eval `(defvar ,(read-from-string (format nil "L_~A" i)) ,(read-from-string (format nil "~A" i))))))

(defvar L_bin1 49)
(defvar L_bin2 50)
(defvar L_bin3 51)

(defvar L_last 51)
(defvar L_first 1)

(defun Adj (i j)
 (&&

  (!!
    (&&
      (||([=] i 14)([=] i 25)([=] i  36)([=] i  42)([=] i  48)([=] i  49)([=] i 15) ([=] i  26)([=] i  37)([=] i  43))
      (||([=] j 14)([=] j 25)([=] j  36)([=] j  42)([=] j  48)([=] j  49)([=] j 15) ([=] j  26)([=] j  37)([=] j  43))
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
      ([>=] j 1) ([<=] j 6)([>=] i 1) ([<=] i 6)
      (||
        (-E- x  L_indexes (&& ([=] x i) ([=] (- x 3) j)))
        (-E- x  L_indexes (&& ([=] x i) ([=] (+ x 3) j)))
      )

      ; (|| ([=] j (- i 3)) ([=] j (+ i 3)))
    )

    (&&
      ([>=] i 1) ([<=] i 6) ([>=] j 1) ([<=] j 6)
      (||
        (-E- x  L_indexes (&& ([=] x j) ([=] (- x 3) i)))
        (-E- x  L_indexes (&& ([=] x j) ([=] (+ x 3) i)))
        )
      ; (|| ([=] i (- j 3)) ([=] i (+ j 3)))
    )

    ;close to bin1
    (&&([=] i L_bin1) (||([=] j 10) ([=] j 11)))    
    (&&([=] j L_bin1) (||([=] i 10) ([=] i 11)))

    ;close to bin2
    (&&([=] i L_bin2) (||([=] j 11) ([=] j 12)))
    (&&([=] j L_bin2) (||([=] i 11) ([=] i 12)))

    ;close to bin3
    (&&([=] i L_bin3) (||([=] j 12) ([=] j 13)))
    (&&([=] j L_bin3) (||([=] i 12) ([=] i 13)))

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

(defun IsBin1 (i)
  ([=] i L_bin1)
)

(defun IsBin2 (i)
  ([=] i L_bin2)
)
(defun IsBin2 (i)
  ([=] i L_bin2)
)

(defvar body_indexes (loop for i from 1 to 11 collect i))

(defun relativeProperties (opID)
 (eval (list `alwf (append `(&&)
  (loop for i in body_indexes collect `(&&
    (<->  (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_clos" opId i))) ([=] (-V- LINK1_Position) (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId i))(loop for x = (read in nil nil) while x collect x)))))
    (<->  (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_clos" opId i))) ([=] (-V- LINK2_Position) (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId i))(loop for x = (read in nil nil) while x collect x)))))
    (<->  (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_clos" opId i))) ([=] (-V- End_Eff_B_Position) (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId i))(loop for x = (read in nil nil) while x collect x)))))
    (<->  (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_far" opId i))) (Adj (-V- LINK1_Position) (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId i))(loop for x = (read in nil nil) while x collect x)))))
    (<->  (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_far" opId i))) (Adj (-V- LINK2_Position) (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId i))(loop for x = (read in nil nil) while x collect x)))))
    (<->  (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_far" opId i))) (Adj (-V- End_Eff_B_Position) (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~A ~A" opId i))(loop for x = (read in nil nil) while x collect x)))))
    (<->  (-P- ,(read-from-string (format nil "moveDirectionLink1_~A_~A_clos" opId i))) (|| (&& (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_clos" opId i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_far" i opId)))))  (&& (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_far" i opId))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_very_far" i opId)))))))
    (<->  (-P- ,(read-from-string (format nil "moveDirectionLink2_~A_~A_clos" opId i))) (||(&& (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_clos" opId i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_far" i opId))))) (&& (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_far" i opId))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_very_far" i opId)))))))
    (<->  (-P- ,(read-from-string (format nil "moveDirectionEndEff_~A_~A_clos" opId i))) (|| (&& (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_clos" opId i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_far" i opId))))) (&& (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_far" i opId))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_very_far" i opId)))))))
    (<->  (-P- ,(read-from-string (format nil "moveDirectionLink1_~A_~A_clos" opId i))) (|| (&& (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_clos" opId i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_far" i opId)))))  (&& (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_very_far" i opId))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_far" i opId)))))))
    (<->  (-P- ,(read-from-string (format nil "moveDirectionLink2_~A_~A_clos" opId i))) (||(&& (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_clos" opId i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_far" i opId))))) (&& (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A__very_far" i opId))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_far" i opId)))))))
    (<->  (-P- ,(read-from-string (format nil "moveDirectionEndEff_~A_~A_clos" opId i))) (|| (&& (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_clos" opId i))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_far" i opId))))) (&& (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_very_far" i opId))) (yesterday (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_far" i opId)))))))
    (<-> (!! (|| (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_clos" opId i))) (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_far" opId i)))))(-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_~A_very_far" opId i))))
    (<-> (!! (|| (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_clos" opId i))) (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_far" opId i)))))(-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_~A_very_far" opId i))))
    (<-> (!! (|| (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_clos" opId i))) (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_far" opId i)))))(-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_~A_very_far" opId i))))
    (<-> (-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i))) (&& (-P- Robot_Idle) (-P- OperatorStill)))
    (<-> (!!(-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i)))) (||(!!(-P- Robot_Idle) )(!!(-P- OperatorStill))))

    (<-> (!!(-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i)))) (|| (-P- ,(read-from-string (format nil "relativeVelocity_critical_~A_~A" opId i))) (-P- ,(read-from-string (format nil "relativeVelocity_normal_~A_~A" opId i)))))
    (<-> (!!(-P- ,(read-from-string (format nil "relativeVelocity_normal_~A_~A" opId i)))) (|| (-P- ,(read-from-string (format nil "relativeVelocity_critical_~A_~A" opId i))) (-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i)))))
    (<-> (!!(-P- ,(read-from-string (format nil "relativeVelocity_critical_~A_~A" opId i)))) (|| (-P- ,(read-from-string (format nil "relativeVelocity_normal_~A_~A" opId i))) (-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i)))))

    (<-> (!!(-P- ,(read-from-string (format nil "relativeForce_low_~A_~A" opId i)))) (|| (-P- ,(read-from-string (format nil "relativeVelocity_normal_~A_~A" opId i))) (-P- ,(read-from-string (format nil "relativeForce_critical_~A_~A" opId i)))))
    (<-> (!!(-P- ,(read-from-string (format nil "relativeForce_normal_~A_~A" opId i)))) (|| (-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i))) (-P- ,(read-from-string (format nil "relativeForce_critical_~A_~A" opId i)))))
    (<-> (!!(-P- ,(read-from-string (format nil "relativeForce_critical_~A_~A" opId i)))) (|| (-P- ,(read-from-string (format nil "relativeVelocity_low_~A_~A" opId i))) (-P- ,(read-from-string (format nil "relativeForce_normal_~A_~A" opId i)))))
))))))  
