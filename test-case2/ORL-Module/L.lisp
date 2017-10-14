; ; LayOut
(defvar L_first 1)
(defvar L1 1)
(defvar BP 1)

(defvar L2 2)
(defvar L3 3)

(defvar L4 4)
(defvar BP1 4)
(defvar BP2 10)
(defvar L10 10)

(defvar L5 5)

(defvar HBP1 6)
(defvar HBP2 6)
(defvar HBP 6)

(defvar L6 6)

(defvar L7 7)
(defvar HTC 7)

(defvar L8 8)
(defvar TC1 8)
(defvar TC2 8)
(defvar TC3 8)
(defvar PP 8)

(defvar L9 9)
(defvar L_last 10)




(defun Adj (i j)

	(||
		(&& ([=] i L1) ([=] j L2))
		(&& ([=] i L2) (|| ([=] j L1) ([=] j L3) ([=] j L9)))
		(&& ([=] i L3) (|| ([=] j L4) ([=] j L5) ([=] j L6) ([=] j L2)))
		(&& ([=] i L4) (|| ([=] j L3) ([=] j L5) ([=] j L10)))
		(&& ([=] i L5) (|| ([=] j L4) ([=] j L3) ([=] j L6) ([=] j L10) ))
		(&& ([=] i L6) (|| ([=] j L3) ([=] j L5) ([=] j L7) ([=] j L8) ([=] j L9) ))
		(&& ([=] i L7) ([=] j L8))
		(&& ([=] i L8) (|| ([=] j L6) ([=] j L7) ([=] j L9) ))
		(&& ([=] i L9) (|| ([=] j L2) ([=] j L3) ([=] j L6) ([=] j L8) ))
		(&& ([=] i L10) (|| ([=] j L4) ([=] j L5) ))

	
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
