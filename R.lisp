;;Robot

;; Robot Parameters

	;Trajectory points
		
		
		;Trajectory Initial Point
		(define-tvar TIP *int*)

		;Trajectory Middle Point
		(define-tvar TMP *int*)

		;Trajectory End Point
		(define-tvar TEP *int*)

	;Arm points -> to keep the area of each point
		
		;robot  LINK1 position
		(define-tvar LINK1_Position *int*)

		;robot  LINK2 position
		(define-tvar LINK2_Position *int*)

		;End_Eff_Front Point 
		(define-tvar End_Eff_F_Position *int*) 

		;End_Eff_Back Point 
		(define-tvar End_Eff_B_Position *int*) 

		; ;End_Eff is facing the operator 
		; (define-tvar End_Eff_facing_Operator *bool*)






(defconstant *Robot_Structure*
	(alw
		(&&
			
			([=](-V- End_Eff_F_Position) (-V- End_Eff_B_Position))
			(&& ([>=] (-V- End_Eff_F_Position) L_1) ([<=] (-V- End_Eff_F_Position) L_7))
			(&& ([>=] (-V- LINK1_Position) L_1) ([<=] (-V- LINK1_Position) L_7))
	        (&& ([>=] (-V- LINK2_Position) L_1) ([<=] (-V- LINK2_Position) L_7))
			

			;;end effector and link2 always in same area
			(<->
				(!! (&& ([=](-V- LINK2_Position) L_2) ([=](-V- LINK2_Position) L_7)))
				([=] (-V- End_Eff_B_Position) (-V- LINK2_Position))
			)


			;;L_1 screwdriving position
			(!! ([=](-V- LINK1_Position) L_1))
			(!! ([=](-V- LINK1_Position) L_7))


			; (|| ([=] (-V- adjacency (-V- LINK1_Position) (-V- LINK2_Position)) 1) ([=] (-V- LINK1_Position) (-V- LINK2_Position)))
			; (|| ([=] (-V- adjacency (-V- LINK1_Position) (next (-V- LINK1_Position))) 1) ([=] (-V- LINK1_Position) (next (-V- LINK1_Position))))
			; (|| ([=] (-V- adjacency (-V- LINK2_Position) (next (-V- LINK2_Position))) 1) ([=] (-V- LINK2_Position) (next (-V- LINK2_Position))))



			(->
				([=](-V- LINK2_Position) L_1)
				
					(next (|| ([=](-V- LINK2_Position) L_1) ([=](-V- LINK2_Position) L_7) ([=](-V- LINK2_Position) L_3_c) ([=](-V- LINK2_Position) L_4_b)))
				
			)

			
			;;L_2: the section of screw driving, but not close to the stone (close to bin)
			(->
				([=](-V- LINK2_Position) L_2)
				(&&
					(|| ([=] (-V- End_Eff_B_Position) L_7) ([=] (-V- End_Eff_B_Position) L_2) )
					(next 
						(&& 
							(|| ([=](-V- LINK2_Position) L_7) ([=](-V- LINK2_Position) L_2)) 
							(|| ([=](-V- LINK1_Position) L_3_c) ([=](-V- LINK1_Position) L_4_b) ([=](-V- LINK1_Position) L_6))
						)
					)

				)
			)

			(->
				([=](-V- LINK1_Position) L_2)
				(&&
					(|| ([=] (-V- LINK2_Position) L_7) ([=](-V- LINK2_Position) L_3_c) ([=](-V- LINK2_Position) L_4_b))
					(next (|| ([=](-V- LINK1_Position) L_2) ([=](-V- LINK1_Position) L_3_c) ([=](-V- LINK1_Position) L_4_b) ([=](-V- LINK1_Position) L_6)))

				)
			)

			;;L_7: the section of screw driving, but not close to the stone (in the middle of L_1 and L_2)

			(->
				([=](-V- LINK2_Position) L_7)
				(&&
					(|| ([=] (-V- End_Eff_B_Position) L_7) ([=] (-V- End_Eff_B_Position) L_1) )
					(next (|| ([=](-V- LINK2_Position) L_7) ([=](-V- LINK2_Position) L_1) ([=](-V- LINK2_Position) L_2) ([=](-V- LINK2_Position) L_3_c) ([=](-V- LINK2_Position) L_4_b) ([=](-V- LINK1_Position) L_2) ([=](-V- LINK1_Position) L_6)))

				)
			)

			
			;;L_3 the free area reachable by robot
			(->
				([=](-V- LINK1_Position) L_3_a)
				(&&
					(|| ([=](-V- LINK2_Position) L_3_a) ([=](-V- LINK2_Position) L_3_b))
					(next (|| ([=](-V- LINK1_Position) L_3_a) ([=](-V- LINK1_Position) L_3_b) ([=](-V- LINK1_Position) L_6)))

				)
			)

			(->
				([=](-V- LINK1_Position) L_3_b)
				(&&
					(|| ([=](-V- LINK2_Position) L_3_a) ([=](-V- LINK2_Position) L_3_b) ([=](-V- LINK2_Position) L_3_c))
					(next (|| ([=](-V- LINK1_Position) L_3_a) ([=](-V- LINK1_Position) L_3_b) ([=](-V- LINK1_Position) L_3_c) ([=](-V- LINK1_Position) L_6)))

				)
			)

			(->
				([=](-V- LINK1_Position) L_3_c) ;;problematic
				(&&
					(|| ([=] (-V- LINK2_Position) L_2) ([=](-V- LINK2_Position) L_7) ([=](-V- LINK2_Position) L_3_b) ([=](-V- LINK2_Position) L_3_c))
					(next 
						(|| ([=](-V- LINK1_Position) L_2) ([=](-V- LINK1_Position) L_3_b) ([=](-V- LINK1_Position) L_3_c) ([=](-V- LINK1_Position) L_6)))

				)
			)

			(->
				([=](-V- LINK2_Position) L_3_a)
				(&&
					 (|| ([=](-V- End_Eff_B_Position) L_3_a) ([=](-V- End_Eff_B_Position) L_3_b))
					(next (|| ([=](-V- LINK2_Position) L_3_a) ([=](-V- LINK2_Position) L_3_b) ([=](-V- LINK2_Position) L_6)))

				)
			)

			(->
				([=](-V- LINK2_Position) L_3_b)
				(&&
					 (|| ([=](-V- End_Eff_B_Position) L_3_a) ([=](-V- End_Eff_B_Position) L_3_b) ([=](-V- End_Eff_B_Position) L_3_c))
					(next (||([=](-V- LINK2_Position) L_3_a) ([=](-V- LINK2_Position) L_3_b) ([=](-V- LINK2_Position) L_3_c) ([=](-V- LINK2_Position) L_6)))

				)
			)
			(->
				([=](-V- LINK2_Position) L_3_c)
				(&&
					 (|| ([=](-V- End_Eff_B_Position) L_1) ([=](-V- End_Eff_B_Position) L_7) ([=](-V- End_Eff_B_Position) L_3_b) ([=](-V- End_Eff_B_Position) L_3_c))
					(next (|| ([=](-V- LINK2_Position) L_7) ([=](-V- LINK2_Position) L_2) ([=](-V- LINK2_Position) L_3_a) ([=](-V- LINK2_Position) L_3_b) ([=](-V- LINK2_Position) L_3_c) ([=](-V- LINK2_Position) L_6)))

				)
			)

			;;L_4 free area reachable but robot and operator towards bin
			(->
				([=](-V- LINK1_Position) L_4_a)
				(&&
					(|| ([=](-V- LINK2_Position) L_4_a) ([=](-V- LINK2_Position) L_4_b) ([=] (-V- LINK2_Position) L_5_b))
					(next (|| ([=](-V- LINK1_Position) L_4_a) ([=](-V- LINK1_Position) L_4_b) ([=] (-V- LINK1_Position) L_5_b) ([=](-V- LINK1_Position) L_6)))
				)
			)

			(->
				([=](-V- LINK1_Position) L_4_b)
				(&&
					(|| ([=] (-V- LINK2_Position) L_7) ([=] (-V- LINK2_Position) L_1) ([=](-V- LINK2_Position) L_4_a) ([=](-V- LINK2_Position) L_4_b))
					(next (|| ([=](-V- LINK1_Position) L_4_a) ([=](-V- LINK1_Position) L_4_b) ([=](-V- LINK1_Position) L_6)))
				)
			)

			
			(->
				([=](-V- LINK2_Position) L_4_a)
				(&&
					 (|| ([=](-V- End_Eff_B_Position) L_4_a) ([=](-V- End_Eff_B_Position) L_4_b) ([=](-V- End_Eff_B_Position) L_5_b))
					(next (|| ([=](-V- LINK2_Position) L_4_a) ([=](-V- LINK2_Position) L_4_b) ([=] (-V- LINK2_Position) L_5_a) ([=](-V- LINK2_Position) L_6)))

				)
			)	
			(->
				([=](-V- LINK2_Position) L_4_b)
				(&&
					 (|| ([=](-V- End_Eff_B_Position) L_4_a) ([=](-V- End_Eff_B_Position) L_4_b) ([=](-V- End_Eff_B_Position) L_7) ([=](-V- End_Eff_B_Position) L_1))
					(next (|| ([=](-V- LINK2_Position) L_1) ([=](-V- LINK2_Position) L_7) ([=](-V- LINK2_Position) L_2) ([=](-V- LINK2_Position) L_4_a) ([=](-V- LINK2_Position) L_4_b) ([=](-V- LINK2_Position) L_6)))

				)
			)
			
			;;L_5 the area containing bin
			(->
				([=](-V- LINK1_Position) L_5_a)
				(&&
					(|| ([=] (-V- LINK2_Position) L_5_a) ([=] (-V- LINK2_Position) L_5_b))
					(next (|| ([=](-V- LINK1_Position) L_5_a) ([=](-V- LINK1_Position) L_5_b) ([=](-V- LINK1_Position) L_6)))
				)
			)


			(->
				([=](-V- LINK1_Position) L_5_b)
				(&&
					(|| ([=](-V- LINK2_Position) L_4_a)  ([=] (-V- LINK2_Position) L_5_a) ([=] (-V- LINK2_Position) L_5_b))
					(next (|| ([=](-V- LINK1_Position) L_4_a)([=](-V- LINK1_Position) L_5_a) ([=](-V- LINK1_Position) L_5_b) ([=](-V- LINK1_Position) L_6)))
				)
			)

			(->
				([=] (-V- LINK2_Position) L_5_a)
				(&&
					 (|| ([=](-V- End_Eff_B_Position) L_5_a) ([=](-V- End_Eff_B_Position) L_5_b))
					(next (|| ([=] (-V- LINK2_Position) L_5_a) ([=] (-V- LINK2_Position) L_5_b) ([=](-V- LINK2_Position) L_6)))

				)
			)

			(->
				([=] (-V- LINK2_Position) L_5_b)
				(&&
					 (|| ([=](-V- End_Eff_B_Position) L_4_a) ([=](-V- End_Eff_B_Position) L_5_a) ([=](-V- End_Eff_B_Position) L_5_b))
					(next (|| ([=](-V- LINK2_Position) L_4_a)  ([=] (-V- LINK2_Position) L_5_a) ([=] (-V- LINK2_Position) L_5_b) ([=](-V- LINK2_Position) L_6)))

				)
			)
			
			;;L_6 homing position
			(->
				([=](-V- LINK1_Position) L_6)
				(|| ([=] (-V- LINK2_Position) L_2) ([=](-V- LINK2_Position) L_3_a) ([=](-V- LINK2_Position) L_3_b) ([=](-V- LINK2_Position) L_3_c) ([=](-V- LINK2_Position) L_4_a) ([=](-V- LINK2_Position) L_4_b) ([=](-V- LINK2_Position) L_5_a) ([=](-V- LINK2_Position) L_5_b) ([=](-V- LINK2_Position) L_6))
			)

			(->
				([=](-V- LINK2_Position) L_6)
				([=] (-V- End_Eff_B_Position) L_6)
			)


			(<->

				(-P- LINK1_Moving)	
				(!!([=] (-V- LINK1_Position) (yesterday (-V- LINK1_Position))))
			)

			(<->

				(-P- LINK2_Moving)
				(!!([=] (-V- LINK2_Position) (yesterday (-V- LINK2_Position))))
				
			)

			(<->

				(-P- End_Eff_Moving)
				(!!([=] (-V- End_Eff_B_Position) (yesterday (-V- End_Eff_B_Position))))
					
			)


			(<-> 
				(-P- Robot_Homing)
				(&&
					([=](-V- LINK2_Position) L_6)
					([=](-V- LINK1_Position) L_6)
					(!! (-P- LINK1_Moving))
					(!! (-P- LINK2_Moving))
					(!! (-P- End_Eff_Moving))
				)
			)


			
		)
	)
)




