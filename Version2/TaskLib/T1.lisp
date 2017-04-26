;;Operator grasps and Robot Screw-drives
(defconstant *ActionInitT1*
 (alwF	
  (&&
	;; robot_homing untill op action5 is ready to start
	(->
		(!!(SomP([=] (-V- actions 5 1 T1) waiting)))
		(-P- Robot_Homing)

	)			
	; Initialization of exe-time
   (-A- i actions1-indexes ([=] (-V- actions i 2 T1) 3))
	
	; Initialization of subject
 	([=] (-V- actions 1 3 T1) operator)
 	([=] (-V- actions 2 3 T1) operator)
 	([=] (-V- actions 3 3 T1) operator)
 	([=] (-V- actions 4 3 T1) operator)
 	([=] (-V- actions 5 3 T1) operator)
 	([=] (-V- actions 6 3 T1) robot)
 	
 	(-A- k jigs_indexes
	 	(&&
	 	 	([=] (-V- actions (+  (* k 6) 7) 3 T1) operator)
	 	    ([=] (-V- actions (+  (* k 6) 8) 3 T1) robot)
		    ([=] (-V- actions (+  (* k 6) 9) 3 T1) robot)
	 	 	([=] (-V- actions (+  (* k 6) 10) 3 T1) robot)
	 	 	([=] (-V- actions (+  (* k 6) 11) 3 T1) robot)
	 	 	([=] (-V- actions (+  (* k 6) 12) 3 T1) robot)
	 	)
 	)
 	([=] (-V- actions (+  (* (- jigs 1) 6) 13) 3 T1) operator)
 	([=] (-V- actions (+  (* (- jigs 1) 6) 14) 3 T1) robot) 

 	(-A- x '(5 6 7 8 9 10 11 12 13 14)
		(<->
 			([=] (-V- safe_L x T1) 1)
 			(&&
 				(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	
 				(!! (-E- k body_indexes
 						(&&
 							(!! ([=] k hand))
 							(|| ([=](-V- Body_Part_pos k) L_1_2) ([=](-V- Body_Part_pos k) L_1_3))	
						)
 					)
 				)
 			)
		)
	)
	(-A- x ' (1 2 3 4)
		([=] (-V- safe_L x T1) 1)
	)		
  )
)
 )
;;1. the operator moves to the bin
(defconstant *Action1T1* 
	(alwf
	 (&&
	 	(->
	 		([=] (-V- Action_Pre 1 T1) 1) 
 			(-P- Robot_Homing)
 		)

 		(->
	 		([=] (-V- Action_Pre_L 1 T1) 1) 
			(!!([=](-V- Body_Part_pos hand) L_bin))
 		)

 		(->
 			([=] (-V- Action_Post 1 T1) 1)
 			(&&
 				([=](-V- Body_Part_pos hand) L_bin)
 				(-P- Robot_Homing)
 			)
		)

		(->
 			([=] (-V- Action_Post_L 1 T1) 1)
			([=](-V- Body_Part_pos hand) L_bin)
		)
	  )
	)
)

;;2. he grasps a part
(defconstant *Action2T1* 
 (alwf
 	(&&
		(->
	 		([=] (-V- Action_Pre 2 T1) 1)
	 		(&& 
	 			([=](-V- Body_Part_pos hand) L_bin)
	 			([=] (-V- actions 1 1 T1) done)
	 			(-P- Robot_Homing)
 			)
 		)

 		(->
	 		([=] (-V- Action_Pre_L 2 T1) 1)
 			([=](-V- Body_Part_pos hand) L_bin)
 		)

 		(->
 			([=] (-V- Action_Post 2 T1) 1)
 			(&& 
				(-P- partTaken)
				([=](-V- Body_Part_pos hand) L_bin)
				(-P- Robot_Homing)
		 	)
		)
		(->
 			([=] (-V- Action_Post_L 2 T1) 1)
 			(&& 
				(-P- partTaken)
				([=](-V- Body_Part_pos hand) L_bin)
		 	)
		)
 	)
  )
 )

;;3. he takes the part to the tombstone
(defconstant *Action3T1* 
	(alwf
	(&&
		(->
	 		([=] (-V- Action_Pre 3 T1) 1)
			(&& 
				([=] (-V- actions 2 1 T1) done)
				([=](-V- Body_Part_pos hand) L_bin)
				(-P- partTaken)
				(-P- Robot_Homing)

		 	)	 		
 		)

 		(->
	 		([=] (-V- Action_Pre_L 3 T1) 1)
			(&& 
				; ([=] (-V- actions 2 1 T1) done)
				([=](-V- Body_Part_pos hand) L_bin)
				(-P- partTaken)
				; (-P- Robot_Homing)

		 	)	 		
 		)

 		(->
 			([=] (-V- Action_Post 3 T1) 1)
 			(&& 
			  (|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))
				(-P- partTaken)
				(-P- Robot_Homing)
	 		)
		)

		(->
 			([=] (-V- Action_Post_L 3 T1) 1)
 			(&& 
			  (|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))
				(-P- partTaken)
				; (-P- Robot_Homing)
	 		)
		)
	  )
	)
)

;;4. he puts the part on the stone
(defconstant *Action4T1* 
	(alwf(&&

		(->
	 		([=] (-V- Action_Pre 4 T1) 1)
	 		(&& 
	 			([=] (-V- actions 3 1 T1) done)
				(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	
				(-P- partTaken)
				(-P- Robot_Homing)
	 		)

 		)

 		(->
	 		([=] (-V- Action_Pre_L 4 T1) 1)
	 		(&& 
	 			; ([=] (-V- actions 3 1 T1) done)
				(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	
				(-P- partTaken)
				(-P- partFixed)
				(!!(-P- partFixed))
				; (-P- Robot_Homing)
	 		)

 		)

 		 (->
			(!!([=] (-V- actions 4 1 T1) done)) 
			; (&&
				(-P- Robot_Homing)
				; ([<=] (-V- relativeForce) 1)
			; )

		)

 		(->
 			([=] (-V- Action_Post 4 T1) 1)
 			(&& 
				(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	
				(-P- partFixed)
				(-P- partTaken)
				(-P- Robot_Homing)
	 		)
		)

		(->
 			([=] (-V- Action_Post_L 4 T1) 1)
 			(&& 
				(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	
				; (-P- partFixed)
				; (-P- partTaken)
				; (-P- Robot_Homing)
	 		)
		)		
	 )
	)
 )

;;5. Operator holding the part
(defconstant *Action5T1*
  (alwf
	(&&
		
	 	(->
	 		([=] (-V- Action_Pre 5 T1) 1)
	 		(&&
	 			([=] (-V- actions 4 1 T1) done)
	 			
	 			(-P- partTaken)
	 			(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	
				
				(-P- partFixed)
				(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
	 			
 			)
	 		
 		)

 		(->
	 		([=] (-V- Action_Pre_L 5 T1) 1)
	 		(&&
	 			([=] (-V- actions 4 1 T1) done)
	 			(-P- partTaken)
	 			(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	
				(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))
 			)
	 		
 		)
	)
  )
)

;;6. robot moves from home to stone/ operator holds the part
(defconstant *Action6T1* 
	(alwf(&&


		(->
	 		([=] (-V- Action_Pre 6 T1) 1)
			(&& 
				(|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
				(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	
	 		)

 		)

 		(->
	 		([=] (-V- Action_Pre_L 6 T1) 1)
			; (&& 
			; 	(|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
				(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	
	 		; )

 		)

 		(->
 			([=] (-V- Action_Post 6 T1) 1)
 			(&& 

				(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	
				(|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
				(-P- partFixed)
				(!! (-P- LINK1_Moving))
				(!! (-P- LINK2_Moving))
	 			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	

	 		)	
		)

		(->
 			([=] (-V- Action_Post_L 6 T1) 1)
 			(&& 

				(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	
				; (|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
				(-P- partFixed)
				; (!! (-P- LINK1_Moving))
				; (!! (-P- LINK2_Moving))
	 			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	

	 		)	
		)
	  )	
	 )
 )

;;7.operator prepares a jig
(defun Action7T1(i)
 	(alwf
	   (&&

		(->
	 		([=] (-V- Action_Pre i T1) 1)
 			(&& 	 				
 				([=] (-V- actions (- i 1) 1 T1) done)
 				(|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
 				(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	
				(!! (-P- LINK1_Moving))
				(!! (-P- LINK2_Moving))
		 		)
		 		
 		)

 		(->
	 		([=] (-V- Action_Pre_L i T1) 1)
 			; (&& 	 				
 				; ([=] (-V- actions (- i 1) 1 T1) done)
 				; (|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
 				(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	
				; (!! (-P- LINK1_Moving))
				; (!! (-P- LINK2_Moving))
		 		; )
		 		
 		)	

 		(->
 			([=] (-V- Action_Post i T1) 1)
 			(&& 
				(|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
				(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	
				(!! (-P- LINK1_Moving))
				(!! (-P- LINK2_Moving))
	 			(-P- preparedJig)
	 		)	
		)

		(->
 			([=] (-V- Action_Post_L i T1) 1)
 			(&& 
				; (|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
				(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	
				; (!! (-P- LINK1_Moving))
				; (!! (-P- LINK2_Moving))
	 			(-P- preparedJig)
	 		)	
		)

 		)
	 )
	)

;;8. robot moves toward stone/ operator holds the part
(defun Action8T1(i)
  (alwf
	(&&
		
		(->
	 		([=] (-V- Action_Pre i T1) 1)
	 		(&& 
	 			
	 			([=] (-V- actions (- i 1) 1 T1) done)
	 			(|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
		 		(|| ([=](-V- Body_Part_pos hand) L_1_2)	([=](-V- Body_Part_pos hand) L_1_3)	)
				(-P- partFixed)
	 			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
	 			(-P- preparedjig)
 			)
 		)

 		(->
	 		([=] (-V- Action_Pre_L i T1) 1)
	 		(&& 
	 			
	 			; ([=] (-V- actions (- i 1) 1 T1) done)
	 			; (|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
		 		(|| ([=](-V- Body_Part_pos hand) L_1_2)	([=](-V- Body_Part_pos hand) L_1_3)	)
				; (-P- partFixed)
	 			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
	 			; (-P- preparedjig)
 			)
 		)

 		(->
 			([=] (-V- Action_Post i T1) 1)
 			(&&
 				(|| ([=](-V- Body_Part_pos hand) L_1_2)	([=](-V- Body_Part_pos hand) L_1_3))
				(-P- partFixed)
	 			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
	 			(|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) (-V- End_Eff_B_Position))
					)
				)
				(-P- preparedjig)
			)
		)

		(->
 			([=] (-V- Action_Post_L i T1) 1)
 			(&&
 				(|| ([=](-V- Body_Part_pos hand) L_1_2)	([=](-V- Body_Part_pos hand) L_1_3))
				; (-P- partFixed)
	 			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
	 			; (|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) (-V- End_Eff_B_Position))
					)
				)
				; (-P- preparedjig)
			)
		)
 			
		)

		

	 )
   )

;;9. robot screws the prepared jig of a part/ operator holds the part
(defun Action9T1(i) 
 (alwf
	(&&
		(->
	 		([=] (-V- Action_Pre i T1) 1)
	 		(&& 
	 			(-P- preparedjig)
	 			([=] (-V- actions (- i 1) 1 T1) done)
	 			(|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
	 			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
				(-P- partFixed)
	 			; ([=](-V- End_Eff_B_Position) L_1)
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) (-V- End_Eff_B_Position))
					)
				)
 			)

 		)
 		(->	
 			
 			(|| ([=] (-V- actions i 1 T1) executing) ([=] (-V- actions i 1 T1) exrm))
 			([>=] (-V- relativeForce) 2)
		)

 		(->
	 		([=] (-V- Action_Pre_L i T1) 1)
	 		(&& 
	 			; (-P- preparedjig)
	 			; ([=] (-V- actions (- i 1) 1 T1) done)
	 			; (|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
	 			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
				; (-P- partFixed)
	 			; ([=](-V- End_Eff_B_Position) L_1)
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) (-V- End_Eff_B_Position))
					)
				)
 			)

 		)
		

 		(->
 			([=] (-V- Action_Post i T1) 1)
 			(&&
				(|| ([=](-V- Body_Part_pos hand) L_1_2)	([=](-V- Body_Part_pos hand) L_1_3)	)
				(-P- partFixed)
	 			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
	 			(|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) (-V- Body_Part_pos hand))
					)
				)
				
			)
 			
		)

		(->
 			([=] (-V- Action_Post_L i T1) 1)
 			(&&
				(|| ([=](-V- Body_Part_pos hand) L_1_2)	([=](-V- Body_Part_pos hand) L_1_3)	)
				; (-P- partFixed)
	 			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
	 			; (|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) (-V- Body_Part_pos hand))
					)
				)
				
			)
 			
		)
 	   )
		
	 )
 )

;;10. robot moves backward from the stone/ operator holds the part
(defun Action10T1(i) 
 (alwf
	(&&
		  
		
		(->
	 		([=] (-V- Action_Pre i T1) 1)
	 		(&&
	 			([=] (-V- actions (- i 1) 1 T1) done)
	 			(|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
				(|| ([=](-V- Body_Part_pos hand) L_1_2)	([=](-V- Body_Part_pos hand) L_1_3)	)
				(-P- partFixed)
	 			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) (-V- Body_Part_pos hand))
					)
				)
			)

 		)

 		(->
	 		([=] (-V- Action_Pre_L i T1) 1)
	 		(&&
	 			; ([=] (-V- actions (- i 1) 1 T1) done)
	 			; (|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
				(|| ([=](-V- Body_Part_pos hand) L_1_2)	([=](-V- Body_Part_pos hand) L_1_3)	)
				; (-P- partFixed)
	 			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) (-V- Body_Part_pos hand))
					)
				)
			)

 		)

 		(->
 			([=] (-V- Action_Post i T1) 1)
 			(&&
				(|| ([=](-V- Body_Part_pos hand) L_1_2)	([=](-V- Body_Part_pos hand) L_1_3)	)
				([=] (-V- actions 5 1 T1) executing)
				(|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
				(-P- partFixed)
	 			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) (-V- Body_Part_pos hand))
					)
				)
			)
 			
		)

		(->
 			([=] (-V- Action_Post_L i T1) 1)
 			(&&
				(|| ([=](-V- Body_Part_pos hand) L_1_2)	([=](-V- Body_Part_pos hand) L_1_3)	)
				; ([=] (-V- actions 5 1 T1) executing)
				; (|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
				; (-P- partFixed)
	 			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) (-V- Body_Part_pos hand))
					)
				)
			)
 			
		)

		)
		
	)
 )

;;11. robot checks the number of jigs/ operator holds the part
(defun Action11T1(i) 
 (alwf
	(&&
		(->
	 		([=] (-V- Action_Pre i T1) 1)
	 		(&&

	 			([=] (-V- actions (- i 1) 1 T1) done)
	 			([=] (-V- actions 5 1 T1) executing)
	 			(|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
				(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))		
				; (-P- partFixed)
	 			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
	 		
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) (-V- Body_Part_pos hand))
					)
				)
			)

 		)

 		(->
	 		([=] (-V- Action_Pre_L i T1) 1)
	 		(&&

	 			; ([=] (-V- actions (- i 1) 1 T1) done)
	 			; ([=] (-V- actions 5 1 T1) executing)
	 			; (|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
				(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))		
				; (-P- partFixed)
	 			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
	 		
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) (-V- Body_Part_pos hand))
					)
				)
			)

 		)

 		(->
 			([=] (-V- Action_Post i T1) 1)
 			(&&
				(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	
				(-P- partFixed)
				(|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
	 			(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	
 		
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) (-V- Body_Part_pos hand))
					)
				)
			)
		)

		(->
 			([=] (-V- Action_Post_L i T1) 1)
 			(&&
				(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	
				; (-P- partFixed)
				; (|| ([=] (-V- actions 5 1 T1) executing) ([=] (-V- actions 5 1 T1) exrm))
	 			(|| ([=](-V- Body_Part_pos hand) L_1_2) ([=](-V- Body_Part_pos hand) L_1_3))	
 		
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) (-V- Body_Part_pos hand))
					)
				)
			)
		)
	)	
   )
)

;;12. go back to action7
(defun Action12T1(i)
 (alwf
		(->

	 		([=] (-V- Action_Pre i T1) 1)

	 		([=] (-V- actions (- i 1) 1 T1) done)
		
 		)
	)
)

;;13. else operator releases the part and moves back
(defun ActionBeforeLastT1(i)
	(alwf (&&

		
		(->
	 		([=] (-V- Action_Pre i T1) 1)
	 		(&&
	 			(-P- partTaken)
	 			(|| ([=](-V- Body_Part_pos hand) L_1_2)	([=](-V- Body_Part_pos hand) L_1_3)	)
		 		([=] (-V- actions (- i 1) 1 T1) done)
	 		)
 		)

 		(->
	 		([=] (-V- Action_Pre_L i T1) 1)
	 		(&&(|| ([=](-V- Body_Part_pos hand) L_1_2)	([=](-V- Body_Part_pos hand) L_1_3)	)
	 			 		(-P- partTaken))
 		)

 		(->

 			([=] (-V- Action_Post i T1) 1)
 			(&& 
				
				(!! (-P- partTaken))
				(!! (-P- partHold))
				(-A- i body_indexes  ; no part on pallet
				   ([!=](-V- Body_Part_pos i) (-V- Body_Part_pos hand))	
				)
			)	
		)

		(->

 			([=] (-V- Action_Post_L i T1) 1)
 			; (&& 
				
				; (!! (-P- partTaken))
				; (!! (-P- partHold))
				(-A- i body_indexes  ; no part on pallet
				   ([!=](-V- Body_Part_pos i) (-V- Body_Part_pos hand))	
				)
			; )	
		)
	  )
 	)
)

;;14. robot moves from stone to the home
(defun ActionLastT1 (i)
	(alwf
	  (&&

		(->
	 		([=] (-V- Action_Pre i T1) 1 )
 			([=] (-V- actions (- i 1) 1 T1) done)
 		)

 		(->
 			([=] (-V- Action_Post i T1) 1)
			; (&& 
				; ([=](-V- LINK1_Position) L_1)
				(!!([=](-V- End_Eff_B_Position) (-V- Body_Part_pos hand)))
			; )	
		)

		(->
 			([=] (-V- Action_Post_L i T1) 1)
			; (&& 
				; ([=](-V- LINK1_Position) L_1)
				(!!([=](-V- End_Eff_B_Position) (-V- Body_Part_pos hand)))
			; )	
		)

	  )
		
 	)
)

(defconstant configT1
	(&&
		(alw 
			(&& 
				; SeqAction1
				(SeqAction actions1-indexes T1)
				*ActionInitT1*
				*Action1T1*
				*Action2T1*
				*Action3T1*
				*Action4T1*
				*Action5T1*
				*Action6T1*
				(ActionBeforeLastT1 (+ 6 1 (* 6 jigs)))
				(ActionLastT1 (+ 6 2 (* 6 jigs)))
				(-A- i jigs_indexes
				  (&&
					(Action7T1 (+ (* i 6) 7))		
					(Action8T1 (+ (* i 6) 8))
					(Action9T1 (+ (* i 6) 9))
				 	(Action10T1 (+ (* i 6) 10))	
					(Action11T1 (+ (* i 6) 11))
					(Action12T1 (+ (* i 6) 12))
				  )
				)
			)
		)
	)
)

(defconstant noCallT1
   (alw
   	(&&
   	  ; SeqAction1
   	  (SeqAction actions1-indexes T1)
   	  *ActionInitT1*
	  (-A- i actions1-indexes
		 (->
       		([=] (-V- actions i 3 1) robot) 
       		([=] (-V- actions i 1 1) notstarted)
   		 )
	  )
	  )
    )
  )