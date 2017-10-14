	(defvar L_0 0)
	(defvar L_1_1 1)
	(defvar L_1_2 2)
	(defvar L_1_3 3)
	(defvar L_Pallet 3)
	(defvar L_2_1 4)
	(defvar L_2_2 5)
	(defvar L_2_3 6)
	(defvar L_2_4 7)
	(defvar L_3_1 8)
	(defvar L_3_2 9)
	(defvar L_3_4 10)
	(defvar L_4_1 11)
	(defvar L_4_2 12)
	(defvar L_bin 12)
	(defvar L_5_1 13)
	(defvar L_6_1 14)
	(defvar L_6_2 15)
	(defvar L_6_3 16)
	(defvar L_7_1 17)
	(defvar L_7_2 18)
	(defvar L_7_3 19)
	(defvar L_8_1 20)
	(defvar L_8_2 21)


(defun Adj (i j)

	(||
		; ([=] i j)

		(&& ([=] i L_0) (|| ([=] j L_1_1) ([=] j L_2_1) ([=] j L_3_1) ([=] j L_4_1) ([=] j L_5_1) ([=] j L_6_1) ([=] j L_7_1) ([=] j L_8_1)))

		(&& ([=] i L_1_1) (|| ([=] j L_0) ([=] j L_2_1) ([=] j L_8_1) ([=] j L_1_2) ))
		(&& ([=] i L_1_2) (|| ([=] j L_1_1) ([=] j L_1_3)  ([=] j L_8_2)))
		(&& ([=] i L_1_3) (|| ([=] j L_1_2) ([=] j L_2_3)))

		(&& ([=] i L_2_1) (|| ([=] j L_0) ([=] j L_1_1) ([=] j L_3_1) ([=] j L_2_2)))
		(&& ([=] i L_2_2) (|| ([=] j L_2_3) ([=] j L_2_4) ([=] j L_1_2) ([=] j L_3_2)([=] j L_2_1)))
		(&& ([=] i L_2_3) (|| ([=] j L_1_3) ([=] j L_2_2) ([=] j L_2_4)))
		(&& ([=] i L_2_4) (|| ([=] j L_2_2) ([=] j L_2_3) ([=] j L_3_4)))

		(&& ([=] i L_3_1) (|| ([=] j L_0) ([=] j L_4_1) ([=] j L_2_1) ([=] j L_3_2)))
		(&& ([=] i L_3_2) (|| ([=] j L_3_1) ([=] j L_3_4) ([=] j L_2_2) ([=] j L_4_2)))
		(&& ([=] i L_3_4) (|| ([=] j L_3_2) ([=] j L_2_4)))

		(&& ([=] i L_4_1) (|| ([=] j L_0) ([=] j L_3_1)  ([=] j L_5_1)([=] j L_4_2)))
		(&& ([=] i L_4_2) (|| ([=] j L_4_1) ([=] j L_5_1) ([=] j L_3_2)))

		(&& ([=] i L_5_1) (|| ([=] j L_4_1) ([=] j L_4_2) ([=] j L_6_1) ([=] j L_6_2) ([=] j L_0)))

		(&& ([=] i L_6_1) (|| ([=] j L_5_1) ([=] j L_6_2) ([=] j L_0) ([=] j L_7_1) ))
		(&& ([=] i L_6_2) (|| ([=] j L_6_1) ([=] j L_5_1) ([=] j L_6_3) ([=] j L_7_2)))
		(&& ([=] i L_6_3) (||  ([=] j L_7_3) ([=] j L_6_2)))

		(&& ([=] i L_7_1) (|| ([=] j L_0) ([=] j L_6_1) ([=] j L_8_1) ([=] j L_7_2)))
		(&& ([=] i L_7_2) (|| ([=] j L_7_1) ([=] j L_7_3) ([=] j L_6_2) ([=] j L_8_2)))
		(&& ([=] i L_7_3) (||  ([=] j L_6_3) ([=] j L_7_2)))

		(&& ([=] i L_8_1) (|| ([=] j L_0) ([=] j L_7_1) ([=] j L_1_1) ([=] j L_8_2)))
		(&& ([=] i L_8_2) (|| ([=] j L_7_2) ([=] j L_1_2) ([=] j L_8_1)))
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

;  	(<-> (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_clos" i))) (!! (next (-P- ,(read-from-string (format nil "relativeSeparationLink1_~A_very_far" i))))))
; 	(<-> (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_clos" i))) (!! (next (-P- ,(read-from-string (format nil "relativeSeparationLink2_~A_very_far" i))))))
;  	(<-> (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_clos" i))) (!! (next (-P- ,(read-from-string (format nil "relativeSeparationEndEff_~A_very_far" i))))))

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
