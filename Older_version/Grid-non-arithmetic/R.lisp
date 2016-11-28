;;Robot

;; Robot Parameters

	;Trajectory points
		
		
<<<<<<< HEAD
		; ;Trajectory Initial Point
		; (define-tvar TIP *int*)


		; ;Trajectory Middle Point
		; (define-tvar TMP *int*)

		; ;Trajectory End Point
		; (define-tvar TEP *int*)
=======
		;Trajectory Initial Point
		(define-tvar TIP *int*)

		;Trajectory Middle Point
		(define-tvar TMP *int*)

		;Trajectory End Point
		(define-tvar TEP *int*)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

	;Arm points -> to keep the area of each point
		
		;robot  LINK1 position
<<<<<<< HEAD
		; (define-tvar LINK1_Position *int*)
		(define-item LINK1_Position L_indexes)

		;robot  LINK2 position
		; (define-tvar LINK2_Position *int*)
		(define-item LINK2_Position L_indexes)

		;End_Eff_Front Point 

		; (define-tvar End_Eff_F_Position *int*) 
		(define-item End_Eff_F_Position L_indexes)

		;End_Eff_Back Point 
		; (define-tvar End_Eff_B_Position *int*) 
		(define-item End_Eff_B_Position L_indexes)
=======
		(define-tvar LINK1_Position *int*)

		;robot  LINK2 position
		(define-tvar LINK2_Position *int*)

		;End_Eff_Front Point 

		(define-tvar End_Eff_F_Position *int*) 

		;End_Eff_Back Point 
		(define-tvar End_Eff_B_Position *int*) 
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243


		; ;End_Eff is facing the operator 
		; (define-tvar End_Eff_facing_Operator *bool*)






(defconstant *Robot_Structure*
	(alw
		(&&
<<<<<<< HEAD
			(-A- x L_indexes
			
				(<-> (End_Eff_F_Position= x) (End_Eff_B_Position= x)))
		
			;;end effector and link2 always in same area
			(<->
				(!! (&& (LINK2_Position= L_2) (LINK2_Position= L_7)))
				(-A- x L_indexes 
					(<-> (End_Eff_B_Position= x) (LINK2_Position= x)))
				 ; (End_Eff_B_Position= LINK2_Position)
=======
			

			([=](-V- End_Eff_F_Position) (-V- End_Eff_B_Position))
			(&& ([>=] (-V- End_Eff_F_Position) L_1) ([<=] (-V- End_Eff_F_Position) L_7))

			(&& ([>=] (-V- LINK1_Position) L_1) ([<=] (-V- LINK1_Position) L_7))
	        (&& ([>=] (-V- LINK2_Position) L_1) ([<=] (-V- LINK2_Position) L_7))
			

			;;end effector and link2 always in same area
			(<->
				(!! (&& ([=](-V- LINK2_Position) L_2) ([=](-V- LINK2_Position) L_7)))
				([=] (-V- End_Eff_B_Position) (-V- LINK2_Position))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

			)


			;;L_1 screwdriving position
<<<<<<< HEAD
			(!! (LINK1_Position= L_1))
			(!! (LINK1_Position= L_7))

			(->
				(LINK2_Position= L_1)
			
					(next (|| (LINK2_Position= L_1) (LINK2_Position= L_7) (LINK2_Position= L_3_c) (LINK2_Position= L_4_b)))
				
			)
	
			;;L_2: the section of screw driving, but not close to the stone (close to bin)
			(->
				(LINK2_Position= L_2)
				(&&

					(|| (End_Eff_B_Position= L_7) (End_Eff_B_Position= L_2) )

					(next 
						(&& 
							(|| (LINK2_Position= L_7) (LINK2_Position= L_2)) 
							(|| (LINK1_Position= L_3_c) (LINK1_Position= L_4_b) (LINK1_Position= L_6))
=======
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
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
						)
					)

				)
			)

			(->
<<<<<<< HEAD
				(LINK1_Position= L_2)
				(&&
					(|| (LINK2_Position= L_7) (LINK2_Position= L_3_c) (LINK2_Position= L_4_b))
					(next (|| (LINK1_Position= L_2) (LINK1_Position= L_3_c) (LINK1_Position= L_4_b) (LINK1_Position= L_6)))
=======
				([=](-V- LINK1_Position) L_2)
				(&&
					(|| ([=] (-V- LINK2_Position) L_7) ([=](-V- LINK2_Position) L_3_c) ([=](-V- LINK2_Position) L_4_b))
					(next (|| ([=](-V- LINK1_Position) L_2) ([=](-V- LINK1_Position) L_3_c) ([=](-V- LINK1_Position) L_4_b) ([=](-V- LINK1_Position) L_6)))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

				)
			)

			;;L_7: the section of screw driving, but not close to the stone (in the middle of L_1 and L_2)

			(->
<<<<<<< HEAD
				(LINK2_Position= L_7)
				(&&

					(|| (End_Eff_B_Position= L_7) (End_Eff_B_Position= L_1) )

					(next (|| (LINK2_Position= L_7) (LINK2_Position= L_1) (LINK2_Position= L_2) (LINK2_Position= L_3_c) (LINK2_Position= L_4_b) (LINK1_Position= L_2) (LINK1_Position= L_6)))

				)
			)	
			;;L_3 the free area reachable by robot
			(->
				(LINK1_Position= L_3_a)
				(&&
					(|| (LINK2_Position= L_3_a) (LINK2_Position= L_3_b))
					(next (|| (LINK1_Position= L_3_a) (LINK1_Position= L_3_b) (LINK1_Position= L_6)))
=======
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
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

				)
			)

			(->
<<<<<<< HEAD
				(LINK1_Position= L_3_b)
				(&&
					(|| (LINK2_Position= L_3_a) (LINK2_Position= L_3_b) (LINK2_Position= L_3_c))
					(next (|| (LINK1_Position= L_3_a) (LINK1_Position= L_3_b) (LINK1_Position= L_3_c) (LINK1_Position= L_6)))
=======
				([=](-V- LINK1_Position) L_3_b)
				(&&
					(|| ([=](-V- LINK2_Position) L_3_a) ([=](-V- LINK2_Position) L_3_b) ([=](-V- LINK2_Position) L_3_c))
					(next (|| ([=](-V- LINK1_Position) L_3_a) ([=](-V- LINK1_Position) L_3_b) ([=](-V- LINK1_Position) L_3_c) ([=](-V- LINK1_Position) L_6)))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

				)
			)

			(->
<<<<<<< HEAD
				(LINK1_Position= L_3_c) ;;problematic
				(&&
					(|| (LINK2_Position= L_2) (LINK2_Position= L_7) (LINK2_Position= L_3_b) (LINK2_Position= L_3_c))
					(next 
						(|| (LINK1_Position= L_2) (LINK1_Position= L_3_b) (LINK1_Position= L_3_c) (LINK1_Position= L_6)))
=======
				([=](-V- LINK1_Position) L_3_c) ;;problematic
				(&&
					(|| ([=] (-V- LINK2_Position) L_2) ([=](-V- LINK2_Position) L_7) ([=](-V- LINK2_Position) L_3_b) ([=](-V- LINK2_Position) L_3_c))
					(next 
						(|| ([=](-V- LINK1_Position) L_2) ([=](-V- LINK1_Position) L_3_b) ([=](-V- LINK1_Position) L_3_c) ([=](-V- LINK1_Position) L_6)))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

				)
			)

			(->
<<<<<<< HEAD
				(LINK2_Position= L_3_a)
				(&&

					 (|| (End_Eff_B_Position= L_3_a) (End_Eff_B_Position= L_3_b))

					(next (|| (LINK2_Position= L_3_a) (LINK2_Position= L_3_b) (LINK2_Position= L_6)))
=======
				([=](-V- LINK2_Position) L_3_a)
				(&&

					 (|| ([=](-V- End_Eff_B_Position) L_3_a) ([=](-V- End_Eff_B_Position) L_3_b))

					(next (|| ([=](-V- LINK2_Position) L_3_a) ([=](-V- LINK2_Position) L_3_b) ([=](-V- LINK2_Position) L_6)))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

				)
			)

			(->
<<<<<<< HEAD
				(LINK2_Position= L_3_b)
				(&&

					 (|| (End_Eff_B_Position= L_3_a) (End_Eff_B_Position= L_3_b) (End_Eff_B_Position= L_3_c))

					(next (||(LINK2_Position= L_3_a) (LINK2_Position= L_3_b) (LINK2_Position= L_3_c) (LINK2_Position= L_6)))
=======
				([=](-V- LINK2_Position) L_3_b)
				(&&

					 (|| ([=](-V- End_Eff_B_Position) L_3_a) ([=](-V- End_Eff_B_Position) L_3_b) ([=](-V- End_Eff_B_Position) L_3_c))

					(next (||([=](-V- LINK2_Position) L_3_a) ([=](-V- LINK2_Position) L_3_b) ([=](-V- LINK2_Position) L_3_c) ([=](-V- LINK2_Position) L_6)))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

				)
			)
			(->
<<<<<<< HEAD
				(LINK2_Position= L_3_c)
				(&&
					 (|| (End_Eff_B_Position= L_1) (End_Eff_B_Position= L_7) (End_Eff_B_Position= L_3_b) (End_Eff_B_Position= L_3_c))

					(next (|| (LINK2_Position= L_7) (LINK2_Position= L_2) (LINK2_Position= L_3_a) (LINK2_Position= L_3_b) (LINK2_Position= L_3_c) (LINK2_Position= L_6)))
=======
				([=](-V- LINK2_Position) L_3_c)
				(&&
					 (|| ([=](-V- End_Eff_B_Position) L_1) ([=](-V- End_Eff_B_Position) L_7) ([=](-V- End_Eff_B_Position) L_3_b) ([=](-V- End_Eff_B_Position) L_3_c))

					(next (|| ([=](-V- LINK2_Position) L_7) ([=](-V- LINK2_Position) L_2) ([=](-V- LINK2_Position) L_3_a) ([=](-V- LINK2_Position) L_3_b) ([=](-V- LINK2_Position) L_3_c) ([=](-V- LINK2_Position) L_6)))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

				)
			)

			;;L_4 free area reachable but robot and operator towards bin
			(->
<<<<<<< HEAD
				(LINK1_Position= L_4_a)
				(&&
					(|| (LINK2_Position= L_4_a) (LINK2_Position= L_4_b) (LINK2_Position= L_5_b))
					(next (|| (LINK1_Position= L_4_a) (LINK1_Position= L_4_b) (LINK1_Position= L_6)))
=======
				([=](-V- LINK1_Position) L_4_a)
				(&&
					(|| ([=](-V- LINK2_Position) L_4_a) ([=](-V- LINK2_Position) L_4_b) ([=] (-V- LINK2_Position) L_5_b))
					(next (|| ([=](-V- LINK1_Position) L_4_a) ([=](-V- LINK1_Position) L_4_b) ([=] (-V- LINK1_Position) L_5_b) ([=](-V- LINK1_Position) L_6)))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
				)
			)

			(->
<<<<<<< HEAD
				(LINK1_Position= L_4_b)
				(&&
					(|| (LINK2_Position= L_7) (LINK2_Position= L_1) (LINK2_Position= L_4_a) (LINK2_Position= L_4_b))
					(next (|| (LINK1_Position= L_4_a) (LINK1_Position= L_4_b) (LINK1_Position= L_6)))
=======
				([=](-V- LINK1_Position) L_4_b)
				(&&
					(|| ([=] (-V- LINK2_Position) L_7) ([=] (-V- LINK2_Position) L_1) ([=](-V- LINK2_Position) L_4_a) ([=](-V- LINK2_Position) L_4_b))
					(next (|| ([=](-V- LINK1_Position) L_4_a) ([=](-V- LINK1_Position) L_4_b) ([=](-V- LINK1_Position) L_6)))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
				)
			)

			
			(->
<<<<<<< HEAD
				(LINK2_Position= L_4_a)
				(&&

					 (|| (End_Eff_B_Position= L_4_a) (End_Eff_B_Position= L_4_b) (End_Eff_B_Position= L_5_b))

					(next (|| (LINK2_Position= L_4_a) (LINK2_Position= L_4_b) (LINK2_Position= L_5_a) (LINK2_Position= L_6)))
=======
				([=](-V- LINK2_Position) L_4_a)
				(&&

					 (|| ([=](-V- End_Eff_B_Position) L_4_a) ([=](-V- End_Eff_B_Position) L_4_b) ([=](-V- End_Eff_B_Position) L_5_b))

					(next (|| ([=](-V- LINK2_Position) L_4_a) ([=](-V- LINK2_Position) L_4_b) ([=] (-V- LINK2_Position) L_5_a) ([=](-V- LINK2_Position) L_6)))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

				)
			)	
			(->
<<<<<<< HEAD
				(LINK2_Position= L_4_b)
				(&&

					 (|| (End_Eff_B_Position= L_4_a) (End_Eff_B_Position= L_4_b) (End_Eff_B_Position= L_7) (End_Eff_B_Position= L_1))

					(next (|| (LINK2_Position= L_1) (LINK2_Position= L_7) (LINK2_Position= L_2) (LINK2_Position= L_4_a) (LINK2_Position= L_4_b) (LINK2_Position= L_6)))
=======
				([=](-V- LINK2_Position) L_4_b)
				(&&

					 (|| ([=](-V- End_Eff_B_Position) L_4_a) ([=](-V- End_Eff_B_Position) L_4_b) ([=](-V- End_Eff_B_Position) L_7) ([=](-V- End_Eff_B_Position) L_1))

					(next (|| ([=](-V- LINK2_Position) L_1) ([=](-V- LINK2_Position) L_7) ([=](-V- LINK2_Position) L_2) ([=](-V- LINK2_Position) L_4_a) ([=](-V- LINK2_Position) L_4_b) ([=](-V- LINK2_Position) L_6)))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

				)
			)
			
			;;L_5 the area containing bin
			(->
<<<<<<< HEAD
				(LINK1_Position= L_5_a)
				(&&
					(|| (LINK2_Position= L_5_a) (LINK2_Position= L_5_b))
					(next (|| (LINK1_Position= L_5_a) (LINK1_Position= L_5_b) (LINK1_Position= L_6)))
				)
			)
			(->
				(LINK1_Position= L_5_b)
				(&&
					(|| (LINK2_Position= L_4_a)  (LINK2_Position= L_5_a) (LINK2_Position= L_5_b))
					(next (|| (LINK1_Position= L_4_a)(LINK1_Position= L_5_a) (LINK1_Position= L_5_b) (LINK1_Position= L_6)))
=======
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
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
				)
			)

			(->
<<<<<<< HEAD
				(LINK2_Position= L_5_a)
				(&&

					 (|| (End_Eff_B_Position= L_5_a) (End_Eff_B_Position= L_5_b))

					(next (|| (LINK2_Position= L_5_a) (LINK2_Position= L_5_b) (LINK2_Position= L_6)))
=======
				([=] (-V- LINK2_Position) L_5_a)
				(&&

					 (|| ([=](-V- End_Eff_B_Position) L_5_a) ([=](-V- End_Eff_B_Position) L_5_b))

					(next (|| ([=] (-V- LINK2_Position) L_5_a) ([=] (-V- LINK2_Position) L_5_b) ([=](-V- LINK2_Position) L_6)))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

				)
			)

			(->
<<<<<<< HEAD
				(LINK2_Position= L_5_b)
				(&&

					 (|| (End_Eff_B_Position= L_4_a) (End_Eff_B_Position= L_5_a) (End_Eff_B_Position= L_5_b))

					(next (|| (LINK2_Position= L_4_a)  (LINK2_Position= L_5_a) (LINK2_Position= L_5_b) (LINK2_Position= L_6)))
=======
				([=] (-V- LINK2_Position) L_5_b)
				(&&

					 (|| ([=](-V- End_Eff_B_Position) L_4_a) ([=](-V- End_Eff_B_Position) L_5_a) ([=](-V- End_Eff_B_Position) L_5_b))

					(next (|| ([=](-V- LINK2_Position) L_4_a)  ([=] (-V- LINK2_Position) L_5_a) ([=] (-V- LINK2_Position) L_5_b) ([=](-V- LINK2_Position) L_6)))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

				)
			)
			
			;;L_6 homing position
			(->
<<<<<<< HEAD
				(LINK1_Position= L_6)
				(|| (LINK2_Position= L_2) (LINK2_Position= L_3_a) (LINK2_Position= L_3_b) (LINK2_Position= L_3_c) (LINK2_Position= L_4_a) (LINK2_Position= L_4_b) (LINK2_Position= L_5_a) (LINK2_Position= L_5_b) (LINK2_Position= L_6))
			)

			(->
				(LINK2_Position= L_6)
				(End_Eff_B_Position= L_6)

			)
			(<-> 
				(-P- Robot_Homing)
				(&&
					(LINK2_Position= L_6)
					(LINK1_Position= L_6)
=======
				([=](-V- LINK1_Position) L_6)
				(|| ([=] (-V- LINK2_Position) L_2) ([=](-V- LINK2_Position) L_3_a) ([=](-V- LINK2_Position) L_3_b) ([=](-V- LINK2_Position) L_3_c) ([=](-V- LINK2_Position) L_4_a) ([=](-V- LINK2_Position) L_4_b) ([=](-V- LINK2_Position) L_5_a) ([=](-V- LINK2_Position) L_5_b) ([=](-V- LINK2_Position) L_6))
			)

			(->
				([=](-V- LINK2_Position) L_6)
				([=] (-V- End_Eff_B_Position) L_6)

			)


			


			(<-> 
				(-P- Robot_Homing)
				(&&
					([=](-V- LINK2_Position) L_6)
					([=](-V- LINK1_Position) L_6)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
					(!! (-P- LINK1_Moving))
					(!! (-P- LINK2_Moving))
					(!! (-P- End_Eff_Moving))
				)
			)


			
		)
	)
)




