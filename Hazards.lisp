;;Hazards

(define-tvar hazards *int* *int* *int*)
(defvar hazards-indexes (loop for i from 1 to 15 collect i))


;; Hazrads Parameters
	
	; hazards(i 0) --> 0/1 exists or no
	; hazrads(i 1) -->(Av+Fr+Pr)
	; hazrads(i 2) --> Severity
	; hazrads(i 3) -->Risk
	; hazrads(i 4) -->RRM ----removed



(defconstant Hazards
  (&&

  	;;initialization of existance and (Av+Fr+Pr)
	
	(-A- i hazards-indexes
		(alwf 
			(&&

				([>=] (-V- hazards i 0) 0) 
				([<=] (-V- hazards i 0) 1)	

				([>=] (-V- hazards i 1) 1) 
				([<=] (-V- hazards i 1) 15)	
			)	
		)

	)



;;two types of hazards are considered : hit    entangled
;; each of these two can happen by a point of robot, except that end-eff cannot entangle anything, so in total we have 5 category of hazards.
;;then we consider 3 body-parts category: head and shoulders(1,2,10) waist-part(3,4,5) hands and arms(6,7,11)
;;and so we study 15 hazards in fact.


		(->

			(-P- hit)

			(-E- j body_indexes
										
<<<<<<< HEAD
				(|| ([=](-V- Body_Part_pos j) (-V- End_Eff_F_Position)) ([=](-V- Body_Part_pos j) (-V- LINK1_Position)) ([=](-V- Body_Part_pos j) (-V- LINK2_Position)))
=======
				(|| ([=](-V- Body_Part j) (-V- End_Eff_F)) ([=](-V- Body_Part j) (-V- LINK1_Position)) ([=](-V- Body_Part j) (-V- LINK2_Position)))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
			)
		)


		(->

			(-P- entangled)

			(-E- j body_indexes
										
<<<<<<< HEAD
				(|| ([=](-V- Body_Part_pos j) (-V- End_Eff_F_Position)) ([=](-V- Body_Part_pos j) (-V- LINK1_Position)) ([=](-V- Body_Part_pos j) (-V- LINK2_Position)))
=======
				(|| ([=](-V- Body_Part j) (-V- End_Eff_F)) ([=](-V- Body_Part j) (-V- LINK1_Position)) ([=](-V- Body_Part j) (-V- LINK2_Position)))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
			)
		)
		

		(<-> ;; hit by end-efector 
			([=] (-V- hazards 1 0) 1)
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
						
					
<<<<<<< HEAD
						([=](-V- Body_Part_pos j) (-V- End_Eff_F_Position))
=======
						([=](-V- Body_Part j) (-V- End_Eff_F))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
						(|| ([=] j Head) ([=] j Shoulders) ([=] j Neck))
					)
						
				)
				
				(-P- End_Eff_Moving)
			)
		)

		(<-> ;; hit by end-efector 
			([=] (-V- hazards 2 0) 1)
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
						
					
<<<<<<< HEAD
						([=](-V- Body_Part_pos j) (-V- End_Eff_F_Position))
=======
						([=](-V- Body_Part j) (-V- End_Eff_F))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
						(|| ([=] j Chest) ([=] j Belly) ([=] j Pelvis))
					)
						
				)
				
				(-P- End_Eff_Moving)
			)
		)

		(<-> ;; hit by end-efector 
			([=] (-V- hazards 3 0) 1)
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
					
<<<<<<< HEAD
						([=](-V- Body_Part_pos j) (-V- End_Eff_F_Position))
=======
						([=](-V- Body_Part j) (-V- End_Eff_F))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
						(|| ([=] j Upper_Arm) ([=] j Hand) ([=] j Lower_Arm))
					)
						
				)
				
				(-P- End_Eff_Moving)
			)
		)

		;;-----------------------------------------

		(->
			([=] (-V- hazards 1 0) 1)
<<<<<<< HEAD
			(moveback (-V- End_Eff_F_Position) ([=] (-V- hazards 1 0) 1))
=======
			(moveback (-V- End_Eff_F) ([=] (-V- hazards 1 0) 1))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2

			; (until_ee rrm_End_Eff_F_Move_Back ([=] (-V- hazards 1 0) 0))
		)
		(->
			([=] (-V- hazards 2 0) 1)
<<<<<<< HEAD
			(moveback (-V- End_Eff_F_Position) ([=] (-V- hazards 2 0) 1))
=======
			(moveback (-V- End_Eff_F) ([=] (-V- hazards 2 0) 1))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
			; (until_ee rrm_End_Eff_F_Move_Back ([=] (-V- hazards 2 0) 0))
		)
		(->
			([=] (-V- hazards 3 0) 1)
<<<<<<< HEAD
			(moveback (-V- End_Eff_F_Position) ([=] (-V- hazards 3 0) 1))
=======
			(moveback (-V- End_Eff_F) ([=] (-V- hazards 3 0) 1))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
			; (until_ee rrm_End_Eff_F_Move_Back ([=] (-V- hazards 3 0) 0))
		)

		;;-----------------------------------------
		(<-> ;; hit by Link1
			([=] (-V- hazards 4 0) 1)
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						([=](-V- Body_Part_pos j) (-V- LINK1_Position))
=======
						([=](-V- Body_Part j) (-V- LINK1_Position))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
							(|| ([=] j Head) ([=] j Shoulders) ([=] j Neck))
						)
				)
				
				(-P- LINK1_Moving)
			)
		)

		(<-> ;; hit by Link1
			([=] (-V- hazards 5 0) 1)
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						([=](-V- Body_Part_pos j) (-V- LINK1_Position))
=======
						([=](-V- Body_Part j) (-V- LINK1_Position))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
							(|| ([=] j Chest) ([=] j Belly) ([=] j Pelvis))
						)
				)
				
				(-P- LINK1_Moving)
			)
		)

		(<-> ;; hit by Link1
			([=] (-V- hazards 6 0) 1)
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						([=](-V- Body_Part_pos j) (-V- LINK1_Position))
=======
						([=](-V- Body_Part j) (-V- LINK1_Position))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
							(|| ([=] j Upper_Arm) ([=] j Hand) ([=] j Lower_Arm))
						)
				)
				
				(-P- LINK1_Moving)
			)
		)

		;;-----------------------------------------
		(->
			([=] (-V- hazards 4 0) 1)
			(moveback (-V- LINK1_Position) ([=] (-V- hazards 4 0) 1))

			; (until_ee rrm_LINK1_Move_Back ([=] (-V- hazards 4 0) 0))
		)

		(->
			([=] (-V- hazards 5 0) 1)
			(moveback (-V- LINK1_Position) ([=] (-V- hazards 5 0) 1))
		)

		(->
			([=] (-V- hazards 6 0) 1)
			(moveback (-V- LINK1_Position) ([=] (-V- hazards 6 0) 1))
		)
		;;-----------------------------------------

		(<-> ;; hit by LINK2
			([=] (-V- hazards 7 0) 1)
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						([=](-V- Body_Part_pos j) (-V- LINK2_Position))
=======
						([=](-V- Body_Part j) (-V- LINK2_Position))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
						(|| ([=] j Head) ([=] j Shoulders) ([=] j Neck))
					)
				)
				
				(-P- LINK2_Moving)
			)
		)

		(<-> ;; hit by LINK2
			([=] (-V- hazards 8 0) 1)
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						([=](-V- Body_Part_pos j) (-V- LINK2_Position))
=======
						([=](-V- Body_Part j) (-V- LINK2_Position))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
						(|| ([=] j Chest) ([=] j Belly) ([=] j Pelvis))
					)
				)
				(-P- LINK2_Moving)
			)
		)

		(<-> ;; hit by LINK2
			([=] (-V- hazards 9 0) 1)
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						([=](-V- Body_Part_pos j) (-V- LINK2_Position))
=======
						([=](-V- Body_Part j) (-V- LINK2_Position))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
						(||
							 ([=] j Upper_Arm) 
							 ; ([=] j Hand)
							 ([=] j Lower_Arm))
						)
				)
				
				(-P- LINK2_Moving)
			)
		)
		;;-----------------------------------------

		(->
			([=] (-V- hazards 7 0) 1)
			; moveback ((-V- LINK2_Position))
			(moveback (-V- LINK2_Position) ([=] (-V- hazards 7 0) 1))
			; (until_ee rrm_LINK2_Move_Back ([=] (-V- hazards 7 0) 0))
		)

		(->
			([=] (-V- hazards 8 0) 1)
			(moveback (-V- LINK2_Position) ([=] (-V- hazards 8 0) 1))
			; rrm_LINK2_Move_Back
			; (until_ee rrm_LINK2_Move_Back ([=] (-V- hazards 8 0) 0))
		)
		(->
			([=] (-V- hazards 9 0) 1)
			(moveback (-V- LINK2_Position) ([=] (-V- hazards 9 0) 1))
			; rrm_LINK2_Move_Back
			; (until_ee rrm_LINK2_Move_Back ([=] (-V- hazards 9 0) 0))
		)

		;;-----------------------------------------


		(<-> ;; entanglement by LINK1
			([=] (-V- hazards 10 0) 1)
			; (&&
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						([=](-V- Body_Part_pos j) (-V- LINK1_Position))
=======
						([=](-V- Body_Part j) (-V- LINK1_Position))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
						(!! ([=] (-V- LINK1_Position) L_6)) 
						(|| ([=] j Head) ([=] j Shoulders) ([=] j Neck))

					)
				)
				
			; 	(next (!! (-P- LINK1_Moving)))
			; )
		)

		(<-> ;; entanglement by LINK1
			([=] (-V- hazards 11 0) 1)
			; (&&
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						([=](-V- Body_Part_pos j) (-V- LINK1_Position))
=======
						([=](-V- Body_Part j) (-V- LINK1_Position))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
						(!! ([=] (-V- LINK1_Position) L_6)) 
						(|| ([=] j Chest) ([=] j Belly) ([=] j Pelvis))

					)
				)
				
			; 	(next (!! (-P- LINK1_Moving)))
			; )
		)

		(<-> ;; entanglement by LINK1
			([=] (-V- hazards 12 0) 1)
			; (&&
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						([=](-V- Body_Part_pos j) (-V- LINK1_Position))
=======
						([=](-V- Body_Part j) (-V- LINK1_Position))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
						(!! ([=] (-V- LINK1_Position) L_6)) 
						(|| 
							([=] j Upper_Arm) 
							; ([=] j Hand)
							([=] j Lower_Arm))

					)
				)
				
			; 	(next (!! (-P- LINK1_Moving)))
			; )
		)

		;;-----------------------------------------
		(->
			([=] (-V- hazards 10 0) 1)
			(until_ee rrm_full_stop ([=] (-V- hazards 10 0) 0))
		)
		(->
			([=] (-V- hazards 11 0) 1)
			(until_ee rrm_full_stop ([=] (-V- hazards 11 0) 0))
		)
		(->
			([=] (-V- hazards 12 0) 1)
			(until_ee rrm_full_stop ([=] (-V- hazards 12 0) 0))
		)

		;;-----------------------------------------

		(<-> ;; entanglement by LINK2
			([=] (-V- hazards 13 0) 1)
			(&&
				(-P- entangled)
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						([=](-V- Body_Part_pos j) (-V- LINK2_Position))
=======
						([=](-V- Body_Part j) (-V- LINK2_Position))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
						(!! ([=] (-V- LINK2_Position) L_6)) 
						(|| ([=] j Head) ([=] j Shoulders) ([=] j Neck))
						)
				)
				
			; 	(next (!! (-P- LINK2_Moving)))
			)
		)

		(<-> ;; entanglement by LINK2
			([=] (-V- hazards 14 0) 1)
			(&&
				(-P- entangled)
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						([=](-V- Body_Part_pos j) (-V- LINK2_Position))
=======
						([=](-V- Body_Part j) (-V- LINK2_Position))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
						(!! ([=] (-V- LINK2_Position) L_6)) 
						(|| ([=] j Chest) ([=] j Belly) ([=] j Pelvis))
						)
				)
				
			; 	(next (!! (-P- LINK2_Moving)))
			)
		)

		(<-> ;; entanglement by LINK2
			([=] (-V- hazards 15 0) 1)
			(&&
				(-P- entangled)
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						([=](-V- Body_Part_pos j) (-V- LINK2_Position))
=======
						([=](-V- Body_Part j) (-V- LINK2_Position))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
						(!! ([=] (-V- LINK2_Position) L_6)) 
						(|| 
							([=] j Upper_Arm)
							 ; ([=] j Hand)
							  ([=] j Lower_Arm))
						)
				)
				
			; 	(next (!! (-P- LINK2_Moving)))
			)
		)


		;;-----------------------------------------
		(->
			([=] (-V- hazards 13 0) 1)
			(until_ee rrm_full_stop ([=] (-V- hazards 13 0) 0))
		)
		(->
			([=] (-V- hazards 14 0) 1)
			(until_ee rrm_full_stop ([=] (-V- hazards 14 0) 0))
		)
		(->
			([=] (-V- hazards 15 0) 1)
			(until_ee rrm_full_stop ([=] (-V- hazards 15 0) 0))
		)


;;severity initialization


	
	([=] (-V- hazards 2 2) 2) 
	([=] (-V- hazards 3 2) 3) 
	([=] (-V- hazards 4 2) 4) 
	([=] (-V- hazards 5 2) 1) 
	([=] (-V- hazards 6 2) 2) 
	([=] (-V- hazards 7 2) 4) 
	([=] (-V- hazards 8 2) 1) 
	([=] (-V- hazards 9 2) 2) 
	([=] (-V- hazards 10 2) 3) 
	([=] (-V- hazards 11 2) 1) 
	([=] (-V- hazards 12 2) 2) 
	([=] (-V- hazards 13 2) 3) 
	([=] (-V- hazards 14 2) 1) 
	([=] (-V- hazards 15 2) 2) 



	)
)


; ;;Risk Estimation



; ;;rrm required= req 			rrm recommended=rec


; ;;							(Av+Fr+Pr)		3-4			5-7			8-10			11-13			14-15
; ;;					 		Se = 4			rec 		req 		req 			req 			req
; ;;					 		Se = 3						rec 		req 			req 			req 
; ;;					 		Se = 2									rec 			req 			req
; ;;					 		Se = 1													rec 			req

; 	;;Risk values 0:negligible,  1: rrm recommended,   2: rrm required		

; (defconstant Risks




; 	)
