;;Hazards

(define-tvar hazards *int* *int* *int*)
(defvar hazards-indexes (loop for i from 1 to 15 collect i))


;; Hazrads Parameters
	
	; hazards(i 0) --> 0/1 origin exists or no. we assume that each hazard associates with a pair of (origin, consequence) in table A.1 of ISO10218
	; hazrads(i 1) -->(Av+Fr+Pr)
	; hazrads(i 2) --> Consequence: impact (1) / entanglement (2)
	; hazrads(i 3) --> severity 
	; hazrads(i 4) --> risk 
	(defvar impact 1)
	(defvar entanglement 2)
	
(defconstant *HazardsInit*
  	;;initialization of existance and (Av+Fr+Pr)
	
	(-A- i hazards-indexes
		(alwf 
			(&&

				([>=] (-V- hazards i 0) 0) 
				([<=] (-V- hazards i 0) 1)	

				([>=] (-V- hazards i 1) 1) 
				([<=] (-V- hazards i 1) 15)	

				(-> ([<=] i 9) ([=] (-V- hazards i 2) impact)) 
				(-> ([>] i 9) ([=] (-V- hazards i 2) entanglement))	

				([>=] (-V- hazards i 3) 1) 
				([<=] (-V- hazards i 3) 4)	

				([>=] (-V- hazards i 4) 0) 
				([<=] (-V- hazards i 4) 2)	

			)	
		)

	)
)



;;two types of hazards are considered : impact    entangled
;;The origin of each of these two can happen by a point of robot, except that end-eff cannot entangle anything, so in total we have 5 category of hazards.
;;then we consider 3 body-parts category: head and shoulders(1,2,10) waist-part(3,4,5) hands and arms(6,7,11)
;;and so we study 15 hazards in fact.

(defconstant *Hazards*	
	 (&&	
		;; hit by end-efector
		;;Origin: movements (normal or unexpected) of endeffector or any mobile part of robot cell
		;;consequence: impact of upper body area
		(<->  
			([=] (-V- hazards 1 0) 1)
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
						
					

						([=](-V- Body_Part_pos j) (-V- End_Eff_F_Position))

						(|| ([=] j Head) ([=] j Shoulders) ([=] j Neck))
					)
						
				)
				
				(-P- End_Eff_Moving)
			)
		)

		;; hit by end-efector
		;;Origin: movements (normal or unexpected) of endeffector or any mobile part of robot cell
		;;consequence: impact of waist body area
		(<-> 
			([=] (-V- hazards 2 0) 1)
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
						
					

						([=](-V- Body_Part_pos j) (-V- End_Eff_F_Position))

						(|| ([=] j Chest) ([=] j Belly) ([=] j Pelvis))
					)
						
				)
				
				(-P- End_Eff_Moving)
			)
		)

		;; hit by end-efector
		;;Origin: movements (normal or unexpected) of endeffector or any mobile part of robot cell
		;;consequence: impact of lower body area
		(<-> 
			([=] (-V- hazards 3 0) 1)
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
					

						([=](-V- Body_Part_pos j) (-V- End_Eff_F_Position))

						(|| ([=] j Upper_Arm) ([=] j Hand) ([=] j Lower_Arm))
					)
						
				)
				
				(-P- End_Eff_Moving)
			)
		)

		(<-> ;; hit by Link1
			([=] (-V- hazards 4 0) 1)
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
						([=](-V- Body_Part_pos j) (-V- LINK1_Position))

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
						([=](-V- Body_Part_pos j) (-V- LINK1_Position))

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
						([=](-V- Body_Part_pos j) (-V- LINK1_Position))

							(|| ([=] j Upper_Arm) ([=] j Hand) ([=] j Lower_Arm))
						)
				)
				
				(-P- LINK1_Moving)
			)
		)


		(<-> ;; hit by LINK2
			([=] (-V- hazards 7 0) 1)
			(&&
				(-P- hit)
				(-E- j body_indexes
					(&&
						([=](-V- Body_Part_pos j) (-V- LINK2_Position))

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
						([=](-V- Body_Part_pos j) (-V- LINK2_Position))

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
						([=](-V- Body_Part_pos j) (-V- LINK2_Position))

						(||
							 ([=] j Upper_Arm) 
							 ; ([=] j Hand)
							 ([=] j Lower_Arm))
						)
				)
				
				(-P- LINK2_Moving)
			)
		)


		(<-> ;; entanglement by LINK1
			([=] (-V- hazards 10 0) 1)
			; (&&
				(-E- j body_indexes
					(&&
						([=](-V- Body_Part_pos j) (-V- LINK1_Position))

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
						([=](-V- Body_Part_pos j) (-V- LINK1_Position))

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
						([=](-V- Body_Part_pos j) (-V- LINK1_Position))

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

		(<-> ;; entanglement by LINK2
			([=] (-V- hazards 13 0) 1)
			(&&
				(-P- entangled)
				(-E- j body_indexes
					(&&
						([=](-V- Body_Part_pos j) (-V- LINK2_Position))

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
						([=](-V- Body_Part_pos j) (-V- LINK2_Position))

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
						([=](-V- Body_Part_pos j) (-V- LINK2_Position))

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
