;;Operator grasps and Robot Screw-drives
(defvar jigs 17)
(defvar T1 1)
(defvar actions1-indexes (loop for i from 1 to (+ 10 (* 4 jigs)) collect i))
(defvar jigs_indexes (loop for i from 0 to (- jigs 1) collect i))
(loop for i in actions1-indexes collect
  (progn
    (eval `(define-tvar ,(read-from-string (format nil "Action_Time_~A_~A" i 1)) *int*))))    


(defconstant mutually_exclusive2
  (&&
    (mutually_exclusive "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_dn" "Action_State_exrm" "Action_State_hd" "Action_State_ex"  actions1-indexes 1)
    (mutually_exclusive "Action_State_wt" "Action_State_ns" "Action_State_exe" "Action_State_dn" "Action_State_exrm" "Action_State_hd" "Action_State_ex"  actions1-indexes 1)
    (mutually_exclusive "Action_State_exe" "Action_State_ns" "Action_State_wt" "Action_State_dn" "Action_State_exrm" "Action_State_hd" "Action_State_ex"  actions1-indexes 1)
    (mutually_exclusive "Action_State_dn" "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_exrm" "Action_State_hd" "Action_State_ex"  actions1-indexes 1)
    (mutually_exclusive "Action_State_exrm" "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_dn" "Action_State_hd" "Action_State_ex"  actions1-indexes 1)
    (mutually_exclusive "Action_State_hd" "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_dn" "Action_State_exrm" "Action_State_ex"  actions1-indexes 1)
    (mutually_exclusive "Action_State_ex" "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_dn" "Action_State_exrm" "Action_State_hd"  actions1-indexes 1)))

(defconstant *Action1T1* 
 (alwf(&&
	(-P- Action_Doer_op_1_1)
	(-P- Action_Safe_L_1_1)
	(-> (-P- Action_Pre_1_1) (-P- Robot_Homing))
	(-> (-P- Action_Pre_L_1_1) (!!([=](-V- Body_Part_pos hand) L_bin)))
	(-> (-P- Action_Post_1_1)(&&([=](-V- Body_Part_pos hand) L_bin)(-P- Robot_Homing)))
	(-> (-P- Action_Post_L_1_1)([=](-V- Body_Part_pos hand) L_bin))
	; (limiting_erroneous_actions actions1-indexes 1 1) <-************************
	)))

(defconstant *Action2T1* 
 (alwf(&&
	(-P- Action_Doer_op_2_1)
	(-P- Action_Safe_L_2_1)
	(-> (&& (-P- Action_State_dn_2_1) (-P- Action_State_ns_13_1)) (-P- partTaken))

	(->(-P- Action_Pre_2_1)(&& ([=](-V- Body_Part_pos hand) L_bin)(-P- Action_State_dn_1_1)(-P- Robot_Homing)))
	(->(-P- Action_Pre_L_2_1)(&& (-P- Action_State_dn_1_1) ([=](-V- Body_Part_pos hand) L_bin)))
	(->(-P- Action_Post_2_1)(&& (-P- partTaken)([=](-V- Body_Part_pos hand) L_bin)(-P- Robot_Homing)))
	(->(-P- Action_Post_L_2_1)(&& (-P- partTaken)(&& (-P- Action_State_dn_1_1)([=](-V- Body_Part_pos hand) L_bin))))
	(->(|| (-P- Action_State_exe_2_1) (-P- Action_State_exrm_2_1))([=](-V- Body_Part_pos hand) L_bin))
	; (limiting_erroneous_actions actions1-indexes 2 1) <-************************
	(->(-P- partTaken) (-P- Action_State_dn_2_1)))))

(defconstant *Action3T1* 
 (alwf(&&
	(-P- Action_Doer_op_3_1)
	; (-P- Action_Safe_L_3_1)
	(->(-P- Action_Pre_3_1)(&& (-P- Action_State_dn_2_1)(-P- partTaken)(-P- Robot_Homing)))
	(->(-P- Action_Pre_L_3_1)(&& (-P- Action_State_dn_2_1)(-P- partTaken)))
	(->(-P- Action_Post_3_1)(&& ([=](-V- Body_Part_pos hand) L_1_3)(-P- partTaken)(-P- Robot_Homing)))
	(->(-P- Action_Post_L_3_1)(&& (-P- Action_State_dn_2_1)(-P- partTaken)))
	(->(|| (-P- Action_State_exe_3_1) (-P- Action_State_exrm_3_1))(&&(-P- partTaken) (-P- Robot_Homing)))
	; (limiting_erroneous_actions actions1-indexes 3 1) <-************************
	)))

(defconstant *Action4T1* 
 (alwf(&&
	(-P- Action_Doer_op_4_1)
	(->(-P- Action_Pre_4_1)(&& (-P- Action_State_dn_3_1)([=](-V- Body_Part_pos hand) L_1_3)(-P- partTaken))) ;(-P- Robot_Homing)))
	(->(-P- Action_Pre_L_4_1)(&& (-P- Action_State_dn_3_1)([=](-V- Body_Part_pos hand) L_1_3) (-P- partTaken)))
	(->(-P- Action_Post_4_1)(&& ([=](-V- Body_Part_pos hand) L_1_3)(-P- partFixed)(-P- partTaken)(-P- Robot_Homing)))
	(->(-P- Action_Post_L_4_1)(&& ([=](-V- Body_Part_pos hand) L_1_3)))
	(->(|| (-P- Action_State_exe_4_1) (-P- Action_State_exrm_4_1))([=](-V- Body_Part_pos hand) L_1_3))		
	; (limiting_erroneous_actions actions1-indexes 4 1) <-************************
	; (-> (!!(-P- Action_State_dn_4_1)) (-P- Robot_Homing))
	)))

(defconstant *Action5T1* 
	(alwf(&&
		(-P- Action_Doer_op_5_1)
		(->(-P- Action_Pre_5_1)(&& (-P- Action_State_dn_4_1)([=](-V- Body_Part_pos hand) L_1_3)(!! (-P- LINK1_Moving))(!! (-P- LINK2_Moving))))
		(->(-P- Action_Pre_L_5_1)(&& (-P- Action_State_dn_3_1) ([=](-V- Body_Part_pos hand) L_1_3)))
		(->(-P- Action_Post_5_1)(&& (|| (-P- Action_State_exe_5_1) (-P- Action_State_exrm_5_1))([=](-V- Body_Part_pos hand) L_1_3) (!! (-P- LINK1_Moving))(!! (-P- LINK2_Moving))(-P- preparedJig)))
		(->(-P- Action_Post_L_5_1)(&& ([=](-V- Body_Part_pos hand) L_1_3) ([=](-V- Body_Part_pos hand) L_1_3)(-P- preparedJig)))
		(->(|| (-P- Action_State_exe_5_1) (-P- Action_State_exrm_5_1))([=](-V- Body_Part_pos hand) L_1_3)))))

(defconstant *Action6T1* 
	(alwf(&&
		(-P- Action_Doer_op_6_1)
		(->(-P- Action_Pre_6_1)(&& (-P- Action_State_dn_5_1)([=](-V- Body_Part_pos hand) L_1_3)(!! (-P- LINK1_Moving))(!! (-P- LINK2_Moving))))
		; (->(-P- Action_Pre_L_6_1)([=](-V- Body_Part_pos hand) L_1_3))
		(->(-P- Action_Post_6_1)(&& (|| (-P- Action_State_exe_6_1) (-P- Action_State_exrm_6_1))([=](-V- Body_Part_pos hand) L_1_3) (!! (-P- LINK1_Moving))(!! (-P- LINK2_Moving))(-P- preparedJig)))
		(->(-P- Action_Post_L_6_1)(&& ([=](-V- Body_Part_pos hand) L_1_3)))
		(->(|| (-P- Action_State_exe_6_1) (-P- Action_State_exrm_6_1))([=](-V- Body_Part_pos hand) L_1_3)))))

(defun Action7T1 (j)
 (eval (list `alwf (append `(&&)
  (loop for i from j to j collect `(&&
	(-P- Action_Doer_op_7_1)
 	(<->(-P- Action_Pre_7_1)
 		 (&&
 		 	(-P- partTaken) 
 		 	(-P- partFixed)
 		 	([=](-V- Body_Part_pos hand) L_1_3)
 		 	(-P- Action_State_dn_6_1)
	 	)
	 ) 
	(->(-P- Action_Pre_L_7_1)(&&(-P- Action_State_dn_4_1)(-P- partFixed)(-P- partTaken)([=](-V- Body_Part_pos hand) L_1_3) )) 
	(->(-P- Action_Post_7_1) (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (+ i 8) 1))))
	(->(-P- Action_Post_L_7_1)(&&(-P- Action_State_dn_4_1)(-P- partFixed)(-P- partTaken)([=](-V- Body_Part_pos hand) L_1_3) )) 
	;; robot_homing untill op action5 is ready to start
	; (->(!!(SomP(-P- Action_State_wt_5_1)))(-P- Robot_Homing))
	(->(|| (-P- Action_State_exe_7_1) (-P- Action_State_exrm_7_1)) (&& ([=](-V- Body_Part_pos hand) L_1_3)(-P- partFixed)))

	; (limiting_erroneous_actions actions1-indexes 5 1) <-************************
	))))))
	
(defconstant *Action8T1* 
 (alwf(&&

	(-P- Action_Doer_ro_8_1)
	; (->(-P- Action_Pre_8_1)(&& (SomP (|| (-P- Action_State_exe_7_1) (-P- Action_State_exrm_7_1))) (|| (-P- Action_State_exe_7_1) (-P- Action_State_exrm_7_1))(-P- Action_State_dn_6_1)([=](-V- Body_Part_pos hand) L_1_3)))
 	(->(-P- Action_Pre_8_1)(Yesterday(-P- op_starts_6_1)))
 	(->(-P- Action_Pre_L_8_1)(Yesterday(-P- op_starts_6_1)))
	(->(-P- Action_Post_8_1)
		(&& 
			(|| (-P- Action_State_exe_7_1) (-P- Action_State_exrm_7_1))
			([=](-V- Body_Part_pos hand) L_1_3)(-P- partFixed)
			(!! (-P- LINK1_Moving))
			(!! (-P- LINK2_Moving))
			([=](-V- End_Eff_B_Position) L_1_2) 
		))
	(->(-P- Action_Post_L_8_1)(&& ([=](-V- Body_Part_pos hand) L_1_3)(-P- partFixed)([=](-V- End_Eff_B_Position) L_1_2) ))
	; (limiting_erroneous_actions actions1-indexes 8 1) <-************************
	)))
	
(defun Action9T1(j)
  (eval (list `alwf (append `(&&)
  (loop for i from j to j collect
   `(&&	
	; (-P- ,(read-from-string (frommat nil "Action_Doer_ro_~A_~A" i 1)))
	
	(->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" i 1)))
		(&& (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- i 1) 1))) (|| (-P- Action_State_exe_7_1) (-P- Action_State_exrm_7_1)) (-P- preparedjig)))

	(->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" i 1)))
		(&& 
			; (|| ([=](-V- Body_Part_pos hand) L_1_2)	([=](-V- Body_Part_pos hand) L_1_3)	)
			(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- i 1) 1)))
			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))

	(->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" i 1)))
		(&&
			([=](-V- Body_Part_pos hand) L_1_3)
			(-P- partFixed)
			([=](-V- End_Eff_B_Position) L_1_3)
				(|| (-P- Action_State_exe_7_1) (-P- Action_State_exrm_7_1))
				(-A- j body_indexes (->  ([!=] j hand)([!=](-V- Body_Part_pos j) (-V- End_Eff_B_Position))))
				(-P- preparedjig)
				)
		)

	(->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" i 1))) (&& (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- i 1) 1))) ([=](-V- End_Eff_B_Position) L_1_3)))

	(->(|| (-P- Action_State_exe_9_1) (-P- Action_State_exrm_9_1)  )(&& (|| (-P- Action_State_exe_7_1) (-P- Action_State_exrm_7_1) ) (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3)) (-P- preparedjig) (|| (-P- LINK2_Moving)(-P- End_Eff_Moving)) ))
	(->(|| (-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" i 1))) (-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" i 1))) )
	 (&& (|| (-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" (- i 2) 1))) (-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" (- i 2) 1))) ) 
	 	(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3)) (-P- preparedjig) (|| (-P- LINK2_Moving)(-P- End_Eff_Moving)) ))

	; (limiting_erroneous_actions actions1-indexes ,(read-from-string (format nil "~A" i)) 1) <-************************
	))))))

(defun Action10T1(j) 
  (eval (list `alwf (append `(&&)
  (loop for i from j to j collect
   `(&&	
		(-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" i 1)))

		(->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" i 1)))(&& (-P- preparedjig)(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- i 1) 1)))(|| (-P- Action_State_exe_7_1) (-P- Action_State_exrm_7_1)) ([=](-V- End_Eff_B_Position) L_1_3)(-P- partFixed)))

 		(->	(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i 1))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i 1)))  )(|| (-P- relativeForce_critical) (-P- relativeForce_normal)))

 		(-> (-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" i 1))) (&& (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- i 1) 1))) (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3)) ))	

 		(->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" i 1))) (&&([=](-V- End_Eff_B_Position) L_1_3)(|| (-P- Action_State_exe_7_1) (-P- Action_State_exrm_7_1))))

		(->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" i 1)))(&&(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))

		(->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i 1))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i 1))) )(&&([=](-V- End_Eff_B_Position) L_1_3) (|| (-P- Action_State_exe_7_1) (-P- Action_State_exrm_7_1) )))
		
		))))))

	
(defun Action11T1(j) 
 (eval (list `alwf (append `(&&)
  (loop for i from j to j collect
   `(&&	
	(-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" i 1)))
	; (<->(-P- ,(read-from-string (format nil "Action_Safe_L_~A_~A" i 1)))(&& ([=](-V- Body_Part_pos hand) L_1_3) ))
	(->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" i 1)))
	 (&&(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- i 1) 1)))
		(|| (-P- Action_State_exe_7_1) (-P- Action_State_exrm_7_1) )))
		; (|| ([=](-V- End_Eff_F_Position) L_1_2) ([=](-V- End_Eff_F_Position) L_1_3)))) ;(-A- j body_indexes (->([!=] j hand)([!=](-V- Body_Part_pos j) (-V- Body_Part_pos hand))))

	(-> (-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" i 1)))
		(&&
			(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- i 1) 1)))
			; (|| ([=](-V- Body_Part_pos hand) L_1_2)	([=](-V- Body_Part_pos hand) L_1_3))
			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
			; (-A- j body_indexes (->([!=] j hand)([!=](-V- Body_Part_pos j) (-V- Body_Part_pos hand))))
			))

	(-> (-P- ,(read-from-string (format nil "Action_Post_~A_~A" i 1)))
		(&&
		(|| (-P- Action_State_exe_7_1) (-P- Action_State_exrm_7_1))
		(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))
		))

	(->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" i 1)))
		(&&(|| ([=](-V- Body_Part_pos hand) L_1_2)	([=](-V- Body_Part_pos hand) L_1_3)	)
		; (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
		; (-A- j body_indexes (->  ([!=] j hand)([!=](-V- Body_Part_pos j) (-V- Body_Part_pos hand))))
		))

			(->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i 1))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i 1))) )
 		   (&& (|| (-P- Action_State_exe_7_1) (-P- Action_State_exrm_7_1) ) (-P- partFixed) (-P- preparedjig) (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3)) (|| (-P- LINK2_Moving)(-P- End_Eff_Moving))))
	;; (limiting_erroneous_actions actions1-indexes ,(read-from-string (format nil "~A" i)) 1) <-************************
	))))))

(defun Action12T1(j) 
 (eval (list `alwf (append `(&&)
  (loop for i from j to j collect
   `(&&	
	
	(-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" i 1)))
	; (<->(-P- ,(read-from-string (format nil "Action_Safe_L_~A_~A" i 1)))(&& ([=](-V- Body_Part_pos hand) L_1_3) ))
	
	(->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" i 1)))
 		(&&(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- i 1) 1)))
 			(|| (-P- Action_State_exe_7_1) (-P- Action_State_exrm_7_1) ))) ;(-A- j body_indexes (-> ([!=] j hand)([!=](-V- Body_Part_pos j)

	(->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" i 1)))
		(&&	(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
		(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- i 1) 1)))))

	(->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" i 1)))
		(&&
		(|| (-P- Action_State_exe_7_1) (-P- Action_State_exrm_7_1) )
		; (-A- j body_indexes (->  ([!=] j hand)([!=](-V- Body_Part_pos j) (-V- Body_Part_pos hand))))
		))
	
	(->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" i 1)))
		(&&(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- i 1) 1)))))
	
			(->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i 1))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i 1))) )
 		   (&& (|| (-P- Action_State_exe_7_1) (-P- Action_State_exrm_7_1) ) (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))))
	; (limiting_erroneous_actions actions1-indexes ,(read-from-string (format nil "~A" i)) 1) <-************************
	))))))

(defun ActionBeforeLastT1(j)
 (eval (list `alwf (append `(&&)
  (loop for i from j to j collect
   `(&&	
	(-P- ,(read-from-string (format nil "Action_Doer_op_~A_~A" i 1)))
	; (<->(-P- ,(read-from-string (format nil "Action_Safe_L_~A_~A" i 1)))(&& ([=](-V- Body_Part_pos hand) L_1_3) ))
	(->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" i 1)))(&& (Yesterday (!!(-P- Action_State_dn_7_1))) (-P- Action_State_dn_7_1)(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- i 1) 1)))))
	(->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" i 1)))(&&([=](-V- Body_Part_pos hand) L_1_3) (-P- partTaken)))
	(->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" i 1)))(&& (!! (-P- partTaken))(!! (-P- partHold))))
	(->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" i 1)))(&& (!! (-P- partTaken))(!! (-P- partHold))))
 		   ; (&& (-P- partFixed) (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3)))
 		   )

	; (limiting_erroneous_actions actions1-indexes ,(read-from-string (format nil "~A" i)) 1) <-************************
	)))))

(defun ActionLastT1 (j)
 (eval (list `alwf (append `(&&)
  (loop for i from j to j collect
   `(&&	
  	(-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" i 1)))
  	; (<->(-P- ,(read-from-string (format nil "Action_Safe_L_~A_~A" i 1)))(&& ([=](-V- Body_Part_pos hand) L_1_3) ))
	(->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" i 1)))(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- i 1) 1))))
(->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" i 1)))(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- i 1) 1))))
	; (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" i 1)))(!!([=](-V- End_Eff_B_Position) (-V- Body_Part_pos hand))))
	(->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" i 1)))(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- i 1) 1))))
	; (limiting_erroneous_actions actions1-indexes ,(read-from-string (format nil "~A" i)) 1) <-************************
	))))))

(defconstant configT1
 (alw(&& 
 	
	(SeqAction actions1-indexes 1)
	 mutually_exclusive2
 	(limiting_op_actions actions1-indexes 1)
	(Seq-errors actions1-indexes 1 2) ;;<-************************
	*Action1T1*
	*Action2T1*
	*Action3T1*
	*Action4T1*
	*Action5T1*
	*Action6T1*
	(Action7T1 7)	
	*Action8T1*
	(ActionBeforeLastT1 (+ 9  (* 4 jigs)))
	(ActionLastT1 (+ 10 (* 4 jigs)))
	(-A- i jigs_indexes
	  (&&
		(Action9T1 (+ (* i 4) 9))		
		(Action10T1 (+ (* i 4) 10))
		(Action11T1 (+ (* i 4) 11))
	 	(Action12T1 (+ (* i 4) 12))	
	  )
	)
	)))

(defconstant noCallT1
 (alw(&& 	 
 	
   	(SeqAction actions1-indexes  1)
	; (Seq-errors actions1-indexes 1 2) <-************************
	 (eval (list `alwf (append `(&&)
 		 (loop for i in actions1-indexes collect`(&&	
       		(-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" i 1))) 
       		(-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i 1)))
   		 )))))
	)))


;;1. op moves to the bin 
;;2. op grasps a wp
;;3. op brings the wp to the pallet
;;4. op places the wp on the pallet
;;5. prepares a fixture
;;6. op sends activation signal to ro
;;7. op holding wp
;;8. ro moves from home to pallet

;;9. ee approaches the pallet
;;10. ro screws the prepared fixtures of a part
;;11. ee retracts from the pallet
;;12. ro checks the number of screwed fixtures

;;13. ee approaches the pallet
;;14. ro screws the prepared fixtures of a part
;;15. ee retracts from the pallet
;;16. ro checks the number of screwed fixtures

;;17. op releases the wp and moves back
;;18. ro moves from stone to the home
