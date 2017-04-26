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

(defvar Link1 "Link1")
(defvar Link2 "Link2")
(defvar End_Eff_B "End_Eff_B")
(defvar End_Eff_F "End_Eff_F")




(defconstant *Robot_Structure*
	(alwf
		(&&
			

			([=](-V- End_Eff_F_Position) (-V- End_Eff_B_Position))
			([>=] (-V- End_Eff_F_Position) L_0)
			([<=] (-V- End_Eff_F_Position) L_8_2)

			(!! ([=](-V- End_Eff_B_Position) L_5_1))
			(!! ([=](-V- End_Eff_B_Position) L_2_3))
			(!! ([=](-V- End_Eff_B_Position) L_2_4))
			(!! ([=](-V- End_Eff_B_Position) L_3_4))
			(!! ([=](-V- End_Eff_B_Position) L_7_3))
			(!! ([=](-V- End_Eff_B_Position) L_6_3))

			([>=] (-V- LINK1_Position) L_0)
			([<=] (-V- LINK1_Position) L_8_2)

			(!! ([=](-V- LINK1_Position) L_5_1))
			(!! ([=](-V- LINK1_Position) L_1_3))
			(!! ([=](-V- LINK1_Position) L_2_3))
			(!! ([=](-V- LINK1_Position) L_2_4))
			(!! ([=](-V- LINK1_Position) L_3_4))
			(!! ([=](-V- LINK1_Position) L_7_3))
			(!! ([=](-V- LINK1_Position) L_6_3))	

			; ([>=] (-V- LINK2_Position) L_0)
			; ([<=] (-V- LINK2_Position) L_8_2)
			
			(|| 
				([=](-V- LINK2_Position) L_0)
				([=](-V- LINK2_Position) L_1_1)
				([=](-V- LINK2_Position) L_2_1)
				([=](-V- LINK2_Position) L_3_1)
				([=](-V- LINK2_Position) L_4_1)
				([=](-V- LINK2_Position) L_5_1)
				([=](-V- LINK2_Position) L_6_1)
				([=](-V- LINK2_Position) L_7_1)
				([=](-V- LINK2_Position) L_8_1)
			)

		 	(||
		 		(Adj (-V- LINK1_Position) (-V- LINK2_Position))
		 		([=] (-V- LINK1_Position) (-V- LINK2_Position))
		 	)	

		 	(||
		 		(Adj (-V- End_Eff_B_Position) (-V- LINK2_Position))
		 		([=] (-V- End_Eff_B_Position) (-V- LINK2_Position))
		 	)

		 	(||
		 		(Adj (-V- LINK1_Position) (Yesterday(-V- LINK1_Position)))
		 		([=] (-V- LINK1_Position) (Yesterday(-V- LINK1_Position)))
	 		)

	 		(||
		 		(Adj (-V- LINK2_Position) (Yesterday(-V- LINK2_Position)))
		 		([=] (-V- LINK2_Position) (Yesterday(-V- LINK2_Position)))
	 		)

	 		(||
		 		(Adj (-V- End_Eff_B_Position) (Yesterday(-V- End_Eff_B_Position)))
		 		([=] (-V- End_Eff_B_Position) (Yesterday(-V- End_Eff_B_Position)))
	 		)

			
			(->
				(-P- Robot_Idle)

				(&& 
					(!! (-P- LINK1_Moving))
					(!! (-P- LINK2_Moving))
					(!! (-P- End_Eff_Moving))
				)
			)


			(<-> 
				(-P- Robot_Homing)
				(&&
					([=](-V- LINK2_Position) L_0)
					([=](-V- LINK1_Position) L_0)
					([=](-V- End_Eff_F_Position) L_0)
					(!! (-P- LINK1_Moving))
					(!! (-P- LINK2_Moving))
					(!! (-P- End_Eff_Moving))
					; ([=] (-V- relativeForce) 1)
				)
			)

			(<->
				(-P- LINK1_Moving)
				(!! ([=] (-V- LINK1_Position) (Yesterday (-V- LINK1_Position))))
			)

			(<->
				(-P- LINK2_Moving)
				(!! ([=] (-V- LINK2_Position) (Yesterday (-V- LINK2_Position))))
			)

			(<->
				(-P- End_Eff_Moving)
				(!! ([=] (-V- End_Eff_F_Position) (Yesterday (-V- End_Eff_F_Position))))
			)

			(<->
				(-P- End_Eff_F_Moving)
				(!! ([=] (-V- End_Eff_F_Position) (Yesterday (-V- End_Eff_F_Position))))
			)

			


		)
	)
)

;no ongoing robot actions when robot is idle
(defun robotidle(index Tname)
	(->
		(!! 
			(-E- i index 
				(&&
					([=] (-V- actions i 3 Tname) robot)
					(||
						([=] (-V- actions i 1 Tname) executing)
						([=] (-V- actions i 1 Tname) exrm)
					)
				)
			)
		)
		(-P- Robot_Idle)
		
	)	
)


