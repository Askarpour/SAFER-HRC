;;Risk Estimator


;;----------------Estimation of severity------------------
;;if the origin for hazard_1 is present in the system, 
;;then its severity is one of the following values
;;remember that hazards(1,2)= impact
(defconstant *REs*
  (&&	
	(-A- i hazards-indexes
		(&&
			
			(->
				([<=] i 9)

				(||
						;;risk_j = 4
					(&&
						([=] (-V- hazards i 3) 4)
						(||
							(&& ([=] (-V- relevantVelocity) critical) ([=] (-V- moveDirection) moveclose))
							(&& ([=] (-V- relevantVelocity) normal) ([=] (-V- moveDirection) moveclose) ([=] (-V- relevantForce) critical))
						)
					)
						;;risk_j = 3
					(&&
						([=] (-V- hazards i 3) 3)	
						(&& ([=] (-V- relevantVelocity) normal) ([=] (-V- moveDirection) moveclose) (!!([=] (-V- relevantForce) critical)))
					)
						;;risk_j = 2
					(&&
						([=] (-V- hazards i 3) 2)	
						(&& (!!([=] (-V- relevantVelocity) low)) ([=] (-V- moveDirection) moveapart))
					)
						;;risk_j = 1
					(&&
						([=] (-V- hazards i 3) 1)	
						([=] (-V- relevantVelocity) low)
					)		
				)
			) 
			
			;if the origin for hazard_10 is present in the system, 
			;then its severity is one of the following values
			;remember that hazards(10,2)= entanglement
			(->
				([>] i 9)
				(||
						;;risk_j = 4
					(&&
						([=] (-V- hazards i 3) 4)
						(||
							(&& ([=] (-V- relevantForce) critical) ([=] (-V- moveDirection) moveclose))
							(&& ([=] (-V- relevantForce) normal) ([=] (-V- moveDirection) moveclose) ([=] (-V- relevantVelocity) critical))
						)
					)
						;;risk_j = 3
					(&&
						([=] (-V- hazards i 3) 3)	
						(&& ([=] (-V- relevantForce) normal) ([=] (-V- moveDirection) moveclose) (!!([=] (-V- relevantVelocity) critical)))
					)
						;;risk_j = 2
					(&&
						([=] (-V- hazards i 3) 2)	
						(&& (!!([=] (-V- relevantForce) low)) ([=] (-V- moveDirection) moveapart))
					)
						;;risk_j = 1
					(&&
						([=] (-V- hazards i 3) 1)	
						(&& (!!([=] (-V- relevantForce) low)) (!!([=] (-V- moveDirection) moveapart)))
					)		
				)
			) 
		)
	)

	; ;----------------Estimation of risk for each hazard------------------

	(-A- i hazards-indexes
		(&&
			(->
				([=] (-V- hazards i 4) 0)
				(||
					([=] (-V- hazards i 0) 0)
					(&&
						([=] (-V- hazards i 0) 1)
						(||
							(&& ([=] (-V- hazards i 3) 3) ([<=] (-V- hazards i 1) 4))
							(&& ([=] (-V- hazards i 3) 2) ([<=] (-V- hazards i 1) 7))
							(&& ([=] (-V- hazards i 3) 1) ([<=] (-V- hazards i 1) 10)) 

						)
					)
				)
			)
			(->
				([=] (-V- hazards i 4) 1)
				(&&
					([=] (-V- hazards i 0) 1)
					(||
						(&& ([=] (-V- hazards i 3) 4) ([<=] (-V- hazards i 1) 4))
						(&& ([=] (-V- hazards i 3) 3) ([>=] (-V- hazards i 1) 5)([<=] (-V- hazards i 1) 7))
						(&& ([=] (-V- hazards i 3) 2) ([>=] (-V- hazards i 1) 8)([<=] (-V- hazards i 1) 10))
						(&& ([=] (-V- hazards i 3) 1) ([>=] (-V- hazards i 1) 11)([<=] (-V- hazards i 1) 13))

					)
				)
			)
			(->
				([=] (-V- hazards i 4) 2)
				(&&
					([=] (-V- hazards i 0) 1)
					(||
						(&& ([=] (-V- hazards i 3) 4) ([>=] (-V- hazards i 1) 5))
						(&& ([=] (-V- hazards i 3) 3) ([>=] (-V- hazards i 1) 8))
						(&& ([=] (-V- hazards i 3) 2) ([>=] (-V- hazards i 1) 11))
						(&& ([=] (-V- hazards i 3) 1) ([>=] (-V- hazards i 1) 14)) 
					)
				)
			)
		)
	)
	; ;----------------Estimation of risk for each action------------------

	;for each action, the risk value is the maximum risk value for each of the present hazards.
		
	(-A- i actions-indexes
		(&&

			;;no RRM needed
			(->
				([=] (-V- actions i 4) 0)
				; (&&
				; 	(|| ([=] (-V- actions i 1) paused) ([=] (-V- actions i 1) executing))
					
						(!!(-E- j hazards-indexes
							(&&
							 	(&& ([=] (-V- hazards j 4) 1) ([=] (-V- hazards j 4) 2))
							 	([=] (-V- hazards j 0) 1)
						 	)	
						))
				; )
			)


			;;RRM recommended
			(->
				([=] (-V- actions i 4) 1)
				(&&
					(|| ([=] (-V- actions i 1) paused) ([=] (-V- actions i 1) executing))
					(!!(-E- j hazards-indexes
						(&&
						 	([=] (-V- hazards j 4) 2)
						 	([=] (-V- hazards j 0) 1)
					 	)	
					))
					(-E- j hazards-indexes
						(&&
						 	([=] (-V- hazards j 4) 1)
						 	([=] (-V- hazards j 0) 1)
					 	)	
					)
				)
			)


			;;RRM required
			(->
				([=] (-V- actions i 4) 2)
				(&&
					(|| ([=] (-V- actions i 1) paused) ([=] (-V- actions i 1) executing))
					(-E- j hazards-indexes
						(&&
						 	([=] (-V- hazards j 4) 2)
						 	([=] (-V- hazards j 0) 1)
					 	)	
					)
				)
			)
		)
	)
   )
)
 