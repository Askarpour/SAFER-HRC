;;Hazards

<<<<<<< HEAD
; (define-tvar hazards *int* *int* *int*)
(defvar hazards-indexes (loop for i from 1 to 15 collect i))
(defvar CI-indexes (loop for i from 1 to 15 collect i))
(define-array hazards-exists hazards-indexes '(0 1))
(define-array hazards-CI hazards-indexes '(1 2 3 4))
(define-array hazards-Severity hazards-indexes CI-indexes)
(define-array hazards-Risk hazards-indexes '(0 1 2))
(define-array hazards-RRM hazards-indexes '(1 2))
=======
(define-tvar hazards *int* *int* *int*)
(defvar hazards-indexes (loop for i from 1 to 15 collect i))

>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

;; Hazrads Parameters
	
	; hazards(i 0) --> 0/1 exists or no
	; hazrads(i 1) -->(Av+Fr+Pr)
	; hazrads(i 2) --> Severity
	; hazrads(i 3) -->Risk
	; hazrads(i 4) -->RRM ----removed



(defconstant Hazards
  (&&

  	;;initialization of existance and (Av+Fr+Pr)
	
<<<<<<< HEAD
	; (-A- i hazards-indexes
	; 	(alwf 
	; 		(&&

	; 			([>=] (-V- hazards i 0) 0) 
	; 			([<=] (-V- hazards i 0) 1)	

	; 			([>=] (-V- hazards i 1) 1) 
	; 			([<=] (-V- hazards i 1) 15)	
	; 		)	
	; 	)

	; )
=======
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



>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
;;two types of hazards are considered : hit    entangled
;; each of these two can happen by a point of robot, except that end-eff cannot entangle anything, so in total we have 5 category of hazards.
;;then we consider 3 body-parts category: head and shoulders(1,2,10) waist-part(3,4,5) hands and arms(6,7,11)
;;and so we study 15 hazards in fact.


		(->

			(-P- hit)

			(-E- j body_indexes
<<<<<<< HEAD
				(-A- x L_indexes						

				(||
					(<-> (End_Eff_F_Position= x) (Body_Part_pos= j x))
					(<-> (LINK1_Position= x) (Body_Part_pos= j x))
					(<-> (LINK2_Position= x) (Body_Part_pos= j x))

				 ; (Body_Part_pos= j End_Eff_F_Position) (Body_Part_pos= j LINK1_Position) (Body_Part_pos= j LINK2_Position))
				)

			)
		)
			)
=======
										

				(|| ([=](-V- Body_Part_pos j) (-V- End_Eff_F_Position)) ([=](-V- Body_Part_pos j) (-V- LINK1_Position)) ([=](-V- Body_Part_pos j) (-V- LINK2_Position)))

			)
		)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243


		(->

			(-P- entangled)

			(-E- j body_indexes
										
<<<<<<< HEAD
				(-A- x L_indexes						

				(||
					(<-> (End_Eff_F_Position= x) (Body_Part_pos= j x))
					(<-> (LINK1_Position= x) (Body_Part_pos= j x))
					(<-> (LINK2_Position= x) (Body_Part_pos= j x))
					
				 ; (Body_Part_pos= j End_Eff_F_Position) (Body_Part_pos= j LINK1_Position) (Body_Part_pos= j LINK2_Position))
				)

			)
				; (|| (Body_Part_pos= j End_Eff_F_Position) (Body_Part_pos= j LINK1_Position) (Body_Part_pos= j LINK2_Position))
=======

				(|| ([=](-V- Body_Part_pos j) (-V- End_Eff_F_Position)) ([=](-V- Body_Part_pos j) (-V- LINK1_Position)) ([=](-V- Body_Part_pos j) (-V- LINK2_Position)))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

			)
		)
		

		(<-> ;; hit by end-efector 
<<<<<<< HEAD
			(hazards-exists= 1 1)
=======
			([=] (-V- hazards 1 0) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						(-A- x L_indexes						

				
							(<-> (End_Eff_F_Position= x) (Body_Part_pos= j x))


						)
						; (Body_Part_pos= j End_Eff_F_Position)
=======
						
					

						([=](-V- Body_Part_pos j) (-V- End_Eff_F_Position))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

						(|| ([=] j Head) ([=] j Shoulders) ([=] j Neck))
					)
						
				)
				
				(-P- End_Eff_Moving)
			)
		)

		(<-> ;; hit by end-efector 
<<<<<<< HEAD
			(hazards-exists= 2 1)
=======
			([=] (-V- hazards 2 0) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						(-A- x L_indexes						

				
							(<-> (End_Eff_F_Position= x) (Body_Part_pos= j x))


						)
						; (Body_Part_pos= j End_Eff_F_Position)
=======
						([=](-V- Body_Part_pos j) (-V- End_Eff_F_Position))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

						(|| ([=] j Chest) ([=] j Belly) ([=] j Pelvis))
					)
						
				)
				
				(-P- End_Eff_Moving)
			)
		)

		(<-> ;; hit by end-efector 
<<<<<<< HEAD
			(hazards-exists= 3 1)
=======
			([=] (-V- hazards 3 0) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
					
<<<<<<< HEAD
(-A- x L_indexes						

				
							(<-> (End_Eff_F_Position= x) (Body_Part_pos= j x))


						)
						; (Body_Part_pos= j End_Eff_F_Position)
=======

						([=](-V- Body_Part_pos j) (-V- End_Eff_F_Position))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

						(|| ([=] j Upper_Arm) ([=] j Hand) ([=] j Lower_Arm))
					)
						
				)
				
				(-P- End_Eff_Moving)
			)
		)

		;;-----------------------------------------

		(->
<<<<<<< HEAD
			(hazards-exists= 1 1)
=======
			([=] (-V- hazards 1 0) 1)

			; (moveback (-V- End_Eff_F_Position) ([=] (-V- hazards 1 0) 1))

>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(until_ee (-P- End_Eff_Moving) (!!(-P- hit)))
		)

		(->
<<<<<<< HEAD
			(hazards-exists= 2 1)
			; (moveback (-V- End_Eff_F_Position) (hazards-exists= 2 0) 1))
=======
			([=] (-V- hazards 2 0) 1)
			; (moveback (-V- End_Eff_F_Position) ([=] (-V- hazards 2 0) 1))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

			(until_ee (-P- End_Eff_Moving) (!! (-P- hit)))
		)
		(->
<<<<<<< HEAD
			(hazards-exists= 3 1)
			; (moveback (-V- End_Eff_F_Position) (hazards-exists= 3 0) 1))
=======
			([=] (-V- hazards 3 0) 1)
			; (moveback (-V- End_Eff_F_Position) ([=] (-V- hazards 3 0) 1))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

			(until_ee (-P- End_Eff_Moving) (!! (-P- hit)))
		)

		;;-----------------------------------------
		(<-> ;; hit by Link1
<<<<<<< HEAD
			(hazards-exists= 4 1)
=======
			([=] (-V- hazards 4 0) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						(-A- x L_indexes						

				
							(<-> (LINK1_Position= x) (Body_Part_pos= j x))


						)
						; (Body_Part_pos= j LINK1_Position)
=======
						([=](-V- Body_Part_pos j) (-V- LINK1_Position))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

							(|| ([=] j Head) ([=] j Shoulders) ([=] j Neck))
						)
				)
				
				(-P- LINK1_Moving)
			)
		)

		(<-> ;; hit by Link1
<<<<<<< HEAD
			(hazards-exists= 5 1)
=======
			([=] (-V- hazards 5 0) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						; (Body_Part_pos= j LINK1_Position)
						(-A- x L_indexes						

				
							(<-> (LINK1_Position= x) (Body_Part_pos= j x))


						)
=======
						([=](-V- Body_Part_pos j) (-V- LINK1_Position))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

							(|| ([=] j Chest) ([=] j Belly) ([=] j Pelvis))
						)
				)
				
				(-P- LINK1_Moving)
			)
		)

		(<-> ;; hit by Link1
<<<<<<< HEAD
			(hazards-exists= 6 1)
=======
			([=] (-V- hazards 6 0) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						; (Body_Part_pos= j LINK1_Position)
						(-A- x L_indexes						

				
							(<-> (LINK1_Position= x) (Body_Part_pos= j x))


						)
=======
						([=](-V- Body_Part_pos j) (-V- LINK1_Position))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

							(|| ([=] j Upper_Arm) ([=] j Hand) ([=] j Lower_Arm))
						)
				)
				
				(-P- LINK1_Moving)
			)
		)

		;;-----------------------------------------
		(->
<<<<<<< HEAD
			(hazards-exists= 4 1)
			; (moveback (-V- LINK1_Position) (hazards-exists= 4 0) 1))
=======
			([=] (-V- hazards 4 0) 1)
			; (moveback (-V- LINK1_Position) ([=] (-V- hazards 4 0) 1))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

			(until_ee (-P- LINK1_Moving) (!! (-P- hit)))
		)

		(->
<<<<<<< HEAD
			(hazards-exists= 5 1)
=======
			([=] (-V- hazards 5 0) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(until_ee (-P- LINK1_Moving) (!! (-P- hit)))
		)

		(->
<<<<<<< HEAD
			(hazards-exists= 6 1)
=======
			([=] (-V- hazards 6 0) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(until_ee (-P- LINK1_Moving) (!! (-P- hit)))
		)
		;;-----------------------------------------

		(<-> ;; hit by LINK2
<<<<<<< HEAD
			(hazards-exists= 7  1)
=======
			([=] (-V- hazards 7 0) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						(-A- x L_indexes						

				
							(<-> (LINK2_Position= x) (Body_Part_pos= j x))


						)
						; (Body_Part_pos= j LINK2_Position)
=======
						([=](-V- Body_Part_pos j) (-V- LINK2_Position))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

						(|| ([=] j Head) ([=] j Shoulders) ([=] j Neck))
					)
				)
				
				(-P- LINK2_Moving)
			)
		)

		(<-> ;; hit by LINK2
<<<<<<< HEAD
			(hazards-exists= 8  1)
=======
			([=] (-V- hazards 8 0) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						(-A- x L_indexes						

				
							(<-> (LINK2_Position= x) (Body_Part_pos= j x))


						)
						; (Body_Part_pos= j LINK2_Position)
=======
						([=](-V- Body_Part_pos j) (-V- LINK2_Position))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

						(|| ([=] j Chest) ([=] j Belly) ([=] j Pelvis))
					)
				)
				(-P- LINK2_Moving)
			)
		)

		(<-> ;; hit by LINK2
<<<<<<< HEAD
			(hazards-exists= 9  1)
=======
			([=] (-V- hazards 9 0) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						(-A- x L_indexes						

				
							(<-> (LINK2_Position= x) (Body_Part_pos= j x))


						)
						; (Body_Part_pos= j LINK2_Position)
=======
						([=](-V- Body_Part_pos j) (-V- LINK2_Position))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

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
<<<<<<< HEAD
			(hazards-exists= 7  1)
			; moveback ((-V- LINK2_Position))
			; (moveback (-V- LINK2_Position) (hazards-exists= 7  1))
=======
			([=] (-V- hazards 7 0) 1)
			; moveback ((-V- LINK2_Position))
			; (moveback (-V- LINK2_Position) ([=] (-V- hazards 7 0) 1))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(until_ee (-P- LINK2_Moving) (!! (-P- hit)))
		)

		(->
<<<<<<< HEAD
			(hazards-exists= 8  1)
=======
			([=] (-V- hazards 8 0) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			; (moveback (-V- LINK2_Position) (!! (-P- hit))))
			; rrm_LINK2_Move_Back
			(until_ee (-P- LINK2_Moving) (!! (-P- hit)))
		)
		(->
<<<<<<< HEAD
			(hazards-exists= 9  1)
=======
			([=] (-V- hazards 9 0) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			; (moveback (-V- LINK2_Position) (!! (-P- hit)))
			; rrm_LINK2_Move_Back
			(until_ee (-P- LINK2_Moving) (!! (-P- hit)))
		)

		;;-----------------------------------------


		(<-> ;; entanglement by LINK1
<<<<<<< HEAD
			(hazards-exists= 10  1)
			; (&&
				(-E- j body_indexes
					(&&
						(-A- x L_indexes						

				
							(<-> (LINK1_Position= x) (Body_Part_pos= j x))


						)
						; (Body_Part_pos= j LINK1_Position)

						(!! (LINK1_Position= L_6)) 
=======
			([=] (-V- hazards 10 0) 1)
			; (&&
				(-E- j body_indexes
					(&&
						([=](-V- Body_Part_pos j) (-V- LINK1_Position))

						(!! ([=] (-V- LINK1_Position) L_6)) 
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
						(|| ([=] j Head) ([=] j Shoulders) ([=] j Neck))

					)
				)
				
			; 	(next (!! (-P- LINK1_Moving)))
			; )
		)

		(<-> ;; entanglement by LINK1
<<<<<<< HEAD
			(hazards-exists= 11  1)
			; (&&
				(-E- j body_indexes
					(&&
						; (Body_Part_pos= j LINK1_Position)
						(-A- x L_indexes						

				
							(<-> (LINK1_Position= x) (Body_Part_pos= j x))


						)

						(!! (LINK1_Position= L_6)) 
=======
			([=] (-V- hazards 11 0) 1)
			; (&&
				(-E- j body_indexes
					(&&
						([=](-V- Body_Part_pos j) (-V- LINK1_Position))

						(!! ([=] (-V- LINK1_Position) L_6)) 
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
						(|| ([=] j Chest) ([=] j Belly) ([=] j Pelvis))

					)
				)
				
			; 	(next (!! (-P- LINK1_Moving)))
			; )
		)

		(<-> ;; entanglement by LINK1
<<<<<<< HEAD
			(hazards-exists= 12  1)
			; (&&
				(-E- j body_indexes
					(&&
						; (Body_Part_pos= j LINK1_Position)
						(-A- x L_indexes						

				
							(<-> (LINK1_Position= x) (Body_Part_pos= j x))


						)

						(!! (LINK1_Position= L_6)) 
=======
			([=] (-V- hazards 12 0) 1)
			; (&&
				(-E- j body_indexes
					(&&
						([=](-V- Body_Part_pos j) (-V- LINK1_Position))

						(!! ([=] (-V- LINK1_Position) L_6)) 
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
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
<<<<<<< HEAD
			(hazards-exists= 10  1)
			(until_ee rrm_full_stop (!! (-P- entangled)))
		)
		(->
			(hazards-exists= 11  1)
			(until_ee rrm_full_stop (!! (-P- entangled)))
		)
		(->
			(hazards-exists= 12  1)
=======
			([=] (-V- hazards 10 0) 1)
			(until_ee rrm_full_stop (!! (-P- entangled)))
		)
		(->
			([=] (-V- hazards 11 0) 1)
			(until_ee rrm_full_stop (!! (-P- entangled)))
		)
		(->
			([=] (-V- hazards 12 0) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(until_ee rrm_full_stop (!! (-P- entangled)))
		)

		;;-----------------------------------------

		(<-> ;; entanglement by LINK2
<<<<<<< HEAD
			(hazards-exists= 13  1)
=======
			([=] (-V- hazards 13 0) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(&&
				(-P- entangled)
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						; (Body_Part_pos= j LINK2_Position)
						(-A- x L_indexes						

				
							(<-> (LINK2_Position= x) (Body_Part_pos= j x))


						)

						(!! (LINK1_Position= L_6)) 
=======
						([=](-V- Body_Part_pos j) (-V- LINK2_Position))

						(!! ([=] (-V- LINK2_Position) L_6)) 
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
						(|| ([=] j Head) ([=] j Shoulders) ([=] j Neck))
						)
				)
				
			; 	(next (!! (-P- LINK2_Moving)))
			)
		)

		(<-> ;; entanglement by LINK2
<<<<<<< HEAD
			(hazards-exists= 14  1)
=======
			([=] (-V- hazards 14 0) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(&&
				(-P- entangled)
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						; (Body_Part_pos= j LINK2_Position)
						(-A- x L_indexes						

				
							(<-> (LINK2_Position= x) (Body_Part_pos= j x))


						)

						(!! (LINK1_Position= L_6)) 
=======
						([=](-V- Body_Part_pos j) (-V- LINK2_Position))

						(!! ([=] (-V- LINK2_Position) L_6)) 
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
						(|| ([=] j Chest) ([=] j Belly) ([=] j Pelvis))
						)
				)
				
			; 	(next (!! (-P- LINK2_Moving)))
			)
		)

		(<-> ;; entanglement by LINK2
<<<<<<< HEAD
			(hazards-exists= 15  1)
=======
			([=] (-V- hazards 15 0) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(&&
				(-P- entangled)
				(-E- j body_indexes
					(&&
<<<<<<< HEAD
						(-A- x L_indexes						

				
							(<-> (LINK2_Position= x) (Body_Part_pos= j x))


						)
						; (Body_Part_pos= j LINK2_Position)

						(!! (LINK1_Position= L_6)) 
=======
						([=](-V- Body_Part_pos j) (-V- LINK2_Position))

						(!! ([=] (-V- LINK2_Position) L_6)) 
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
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
<<<<<<< HEAD
			(hazards-exists= 13  1)
			(until_ee rrm_full_stop (!! (-P- entangled)))
		)
		(->
			(hazards-exists= 14  1)
			(until_ee rrm_full_stop (!! (-P- entangled)))
		)
		(->
			(hazards-exists= 15  1)
=======
			([=] (-V- hazards 13 0) 1)
			(until_ee rrm_full_stop (!! (-P- entangled)))
		)
		(->
			([=] (-V- hazards 14 0) 1)
			(until_ee rrm_full_stop (!! (-P- entangled)))
		)
		(->
			([=] (-V- hazards 15 0) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(until_ee rrm_full_stop (!! (-P- entangled)))
		)


;;severity initialization


	
<<<<<<< HEAD
	(hazards-Severity= 2 2) 
	(hazards-Severity= 3 3) 
	(hazards-Severity= 4 4) 
	(hazards-Severity= 5 1) 
	(hazards-Severity= 6 2) 
	(hazards-Severity= 7 4) 
	(hazards-Severity= 8 1) 
	(hazards-Severity= 9 2) 
	(hazards-Severity= 10 3) 
	(hazards-Severity= 11 1) 
	(hazards-Severity= 12 2) 
	(hazards-Severity= 13 3) 
	(hazards-Severity= 14 1) 
	(hazards-Severity= 15 2) 
=======
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
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243



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
