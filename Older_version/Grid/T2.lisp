;;Operator grasps and Robot Screw-drives
(defvar actions-indexes 9)
(defvar T2 2)
(defun T2(ind)
	(&&
		(alwf *ActionInitT2*)
		(alwf *Action1T2*)
		(alwf *Action2T2*)
		(alwf *Action3T2*)
		(alwf *Action4T2*)
		(alwf *Action5T2*)
		(alwf *Action6T2*)
		(alwf *Action7T2*)
		(alwf *Action8T2*)
		(alwf *Action9T2*)
		
   	   )
	)
(defconstant *ActionInitT2*
 (alwf 
  	 (-A- i actions-indexes
  	  (&&
 	   ([=] (-V- actions i 2 T2) 3)
 	   ; Initialization of subject
       (-> (!! (|| ([=] i 6) ([=] i 7))) ([=] (-V- actions i 3 T2) robot))
       (-> (&& ([=] i 6) ([=] i 7)) ([=] (-V- actions i 3 T2) operator))
 	 )
    
  )
 )
)

;;robot moves to the bin
(defconstant *Action1T2*
	(&&
		(<->
			([=] (-V- Action_Pre 1 T2) 1)
			(-P- Robot_Homing)
		)

		(<->
			([=] (-V- Action_Post 1 T2) 1)
			(|| ([=](-V- End_Eff_B_Position) L_5_a) ([=](-V- End_Eff_B_Position) L_5_b))
		)
	)
)

;;robot grasps the part
(defconstant *Action2T2*
	(&&
		(<->
			([=] (-V- Action_Pre 2 T2) 1)
			(|| ([=](-V- End_Eff_B_Position) L_5_a) ([=](-V- End_Eff_B_Position) L_5_b))
		)

		(<->
			([=] (-V- Action_Post 2 T2) 1)
			(&&(-P- partTaken)
			(|| ([=](-V- End_Eff_B_Position) L_5_a) ([=](-V- End_Eff_B_Position) L_5_b)))
		)
	)
)
;;robot moves to the pallet
(defconstant *Action3T2*
	(&&
		(<->
			([=] (-V- Action_Pre 3 T2) 1)
			(&&(-P- partTaken)
			(|| ([=](-V- End_Eff_B_Position) L_5_a) ([=](-V- End_Eff_B_Position) L_5_b)))
		)

		(<->
			([=] (-V- Action_Post 3 T2) 1)
			(&&(-P- partTaken)
			([=](-V- End_Eff_B_Position) L_1))
		)
	)
)

;;robot puts the part on the pallet
(defconstant *Action4T2*
	(&&
		(<->
			([=] (-V- Action_Pre 4 T2) 1)
			(&&(-P- partTaken)
			([=](-V- End_Eff_B_Position) L_1))
		)

		(<->
			([=] (-V- Action_Post 4 T2) 1)
			(&&(-P- partFixed)
			([=](-V- End_Eff_B_Position) L_1))
		)
	)
)
;;robot keeps holding
(defconstant *Action5T2*
	(&&
		(<->
			([=] (-V- Action_Pre 5 T2) 1)
			(&&(-P- partFixed)
			([=](-V- End_Eff_B_Position) L_1))
		)

		(<->
			([=] (-V- Action_Post 5 T2) 1)
			(&&(-P- partFixed)
			([=](-V- End_Eff_B_Position) L_1))
		)
		(->
 			(||
 				([=] (-V- actions 6 1 T2) executing)
 				([=] (-V- actions 7 1 T2) executing)
 				([=] (-V- actions 8 1 T2) executing)
 				([=] (-V- actions 9 1 T2) executing)
 				([=] (-V- actions 10 1 T2) executing)
 				([=] (-V- actions 11 1 T2) executing)
 				([=] (-V- actions 12 1 T2) executing)
 				([=] (-V- actions 6 1 T2) exrm)
 				([=] (-V- actions 7 1 T2) exrm)
 				([=] (-V- actions 8 1 T2) exrm)
 				([=] (-V- actions 9 1 T2) exrm)
 				([=] (-V- actions 10 1 T2) exrm)
 				([=] (-V- actions 11 1 T2) exrm)
 				([=] (-V- actions 12 1 T2) exrm)

			)
			([=] (-V- actions 5 1 T2) executing)
		)
	)
)
;;operator prepares the jigs 
(defconstant *Action6T2*
	(&&
		(<->
			([=] (-V- Action_Pre 6 T2) 1)
			(&&(-P- partTaken)
			([=](-V- End_Eff_B_Position) L_1))
		)

		(<->
			([=] (-V- Action_Post 6 T2) 1)
			(&&(-P- partFixed)
			(-P- preparedJig)
			([=](-V- End_Eff_B_Position) L_1))
		)
	)
)
;;operator screwdrives
(defconstant *Action7T2*
	(&&
		(<->
			([=] (-V- Action_Pre 7 T2) 1)
			(&&(-P- partFixed)
			(-P- preparedJig)
			([=](-V- End_Eff_B_Position) L_1)
			([=](-V- Body_Part_pos hand) L_1))
		)

		(<->
			([=] (-V- Action_Post 7 T2) 1)
			(&&(-P- partFixed)
			([=](-V- End_Eff_B_Position) L_1))
		)
	)
)
;;robot releases the part
(defconstant *Action8T2*
	(&&
		(<->
			([=] (-V- Action_Pre 8 T2) 1)
			(&&(-P- partFixed)
			([=](-V- Body_Part_pos hand) L_1)
			([=](-V- End_Eff_B_Position) L_1))
		)

		(<->
			([=] (-V- Action_Post 8 T2) 1)
			(&&
			(!! (-P- partFixed))
			(!! (-P- partFixed))
			([=](-V- End_Eff_B_Position) L_1))
		)
	)
)
;;robot moves back to home
(defconstant *Action8T2*
	(&&
		(<->
			([=] (-V- Action_Pre 9 T2) 1)
			(&&
			(!! (-P- partFixed))
			(!! (-P- partFixed))
			([=](-V- End_Eff_B_Position) L_1))
		)

		(<->
			([=] (-V- Action_Post 9 T2) 1)
			(&&
			(!! (-P- partFixed))
			(!! (-P- partFixed))
			(-P- Robot_Homing)
		)
	)
)