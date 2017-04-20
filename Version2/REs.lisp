;;Risk Estimator


;;----------------Estimation of severity------------------
;;if the origin for hazard_1 is present in the system, 
;;then its severity is one of the following values
;;remember that hazards(1,2)= impact
(defconstant *REs*
  (&&	
	(-A- i hazards-indexes
		(&&
			
			; (->
			; 	([<=] i 9)

				; (||
						
					(->
						([=] (-V- hazards i 3) 4)
						; (&& ([=] (-V- relativeVelocity) critical) ([=] (-V- relativeForce) critical) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose))))
						(|| 
							(&& ([=] (-V- relativeVelocity) critical) ([=] (-V- relativeForce) critical))
							(&& ([=] (-V- relativeVelocity) critical) ([=] (-V- relativeForce) normal) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose))))
							(&& ([=] (-V- relativeVelocity) normal) ([=] (-V- relativeForce) critical) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose))))

						)
					)
						
					(->
						([=] (-V- hazards i 3) 3)	
						; (||
						; 	(&& ([=] (-V- relativeVelocity) critical) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose))))
						; 	(&& ([=] (-V- relativeForce) critical) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose))) )
						; )
						(||
							(&& ([=] (-V- relativeVelocity) critical) ([>=] (-V- relativeForce) normal) (!!(-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose)))))
							(&& ([>=] (-V- relativeVelocity) normal) ([=] (-V- relativeForce) critical) (!!(-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose)))))
							(&& ([=] (-V- relativeVelocity) critical) ([=] (-V- relativeForce) low) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose))) (-P- OperatorStill))
							(&& ([=] (-V- relativeVelocity) low) ([=] (-V- relativeForce) critical) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose))) (-P- OperatorStill))
						)
					)
						
					(->
						([=] (-V- hazards i 3) 2)
						
						; (&& ([=] (-V- relativeVelocity) normal) ([=] (-V- relativeForce) normal) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose))))
						(||
							(&& ([=] (-V- relativeVelocity) critical) ([=] (-V- relativeForce) low) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose))) (!!(-P- OperatorStill)))
							(&& ([=] (-V- relativeVelocity) low) ([=] (-V- relativeForce) critical) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose))) (!!(-P- OperatorStill)))

							(&& ([=] (-V- relativeVelocity) critical) ([=] (-V- relativeForce) low) (!!(-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose)))))
							(&& ([=] (-V- relativeVelocity) low) ([=] (-V- relativeForce) critical) (!!(-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose)))))

							(&& ([=] (-V- relativeVelocity) normal) ([=] (-V- relativeForce) low) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose))) (-P- OperatorStill))
							(&& ([=] (-V- relativeVelocity) low) ([=] (-V- relativeForce) normal) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose))) (-P- OperatorStill))
						)
					)

					(->
						([=] (-V- hazards i 3) 1)
						; (&&  ([=] (-V- relativeVelocity) normal) ([=] (-V- relativeForce) normal) (!! (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose)))))
						(||
							(&& ([=] (-V- relativeVelocity) normal) ([=] (-V- relativeForce) low) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose))) (!!(-P- OperatorStill)))
							(&& ([=] (-V- relativeVelocity) low) ([=] (-V- relativeForce) normal) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose))) (!!(-P- OperatorStill)))

							(&& ([=] (-V- relativeVelocity) normal) ([=] (-V- relativeForce) low) (!!(-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose)))))
							(&& ([=] (-V- relativeVelocity) low) ([=] (-V- relativeForce) normal) (!!(-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose)))))

							(&& ([=] (-V- relativeVelocity) low) ([=] (-V- relativeForce) low) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose))) (-P- OperatorStill))
							(&& ([=] (-V- relativeVelocity) low) ([=] (-V- relativeForce) low) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose)))(-P- OperatorStill))
						)
					)
						
					(->
						([=] (-V- hazards i 3) 0)
						; (&&
						; 	([=] (-V- relativeVelocity) low)
						; 	([=] (-V- relativeForce) low)
						; )
						(||
							(&& ([=] (-V- relativeVelocity) low) ([=] (-V- relativeForce) low) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose))) (!!(-P- OperatorStill)))
							(&& ([=] (-V- relativeVelocity) low) ([=] (-V- relativeForce) low) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose)))(!!(-P- OperatorStill)))
							(&& ([=] (-V- relativeVelocity) low) ([=] (-V- relativeForce) low) (!!(-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose)))))
							(&& ([=] (-V- relativeVelocity) low) ([=] (-V- relativeForce) low) (!!(-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose)))))

							)
					)		
				; )
			; )

			;if the origin for hazard_10 is present in the system, 
			;then its severity is one of the following values
			;remember that hazards(10,2)= entanglement
			; (->
			; 	([>] i 9)
			; 	(||
			; 			;;risk_j = 4
			; 		(&&
			; 			([=] (-V- hazards i 3) 4)
			; 			(||
			; 				(&& ([=] (-V- relativeForce) critical) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose))))
			; 				(&& ([=] (-V- relativeForce) normal) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose))) ([=] (-V- relativeVelocity) critical))
			; 			)
			; 		)
			; 			;;risk_j = 3
			; 		(&&
			; 			([=] (-V- hazards i 3) 3)	
			; 			(&& ([=] (-V- relativeForce) normal) (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose))) (!!([=] (-V- relativeVelocity) critical)))
			; 		)
			; 			;;risk_j = 2
			; 		(&&
			; 			([=] (-V- hazards i 3) 2)	
			; 			(&& (!!([=] (-V- relativeForce) low)) (!! (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose)))))
			; 		)
			; 			;;risk_j = 1
			; 		(&&
			; 			([=] (-V- hazards i 3) 1)	
			; 			(&& (!!([=] (-V- relativeForce) low)) (!! (-E- i body_indexes (||([=] (-V- moveDirectionLink1 i) moveclose) ([=] (-V- moveDirectionLink2 i) moveclose) ([=] (-V- moveDirectionEndEff i) moveclose)))))
			; 		)		
			; 	)
			; ) 
		)
	)

	; ;----------------Estimation of risk for each hazard------------------

	(-A- i hazards-indexes
		(&&
			(<->
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
			; (<->
			; 	(!! (|| ([=] (-V- hazards i 4) 2) ([=] (-V- hazards i 4) 1)))
			; 	([=] (-V- hazards i 4) 0)
			; )
			(<->
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
			(<->
				(!! (|| ([=] (-V- hazards i 4) 0) ([=] (-V- hazards i 4) 1)))
				([=] (-V- hazards i 4) 2)
			)
			(<->
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
	; ;----------------Estimation of total risk------------------
	(alw (-A- i hazards-indexes ;;max of risk values of hazards
	     ([>=](-V- Risk) (-V- hazards i 4))
		)
	)

	(alw 
		(-E- i hazards-indexes  ;;equal to the max risk

	     ([=](-V- Risk) (-V- hazards i 4))
		)
	)
 )
)
