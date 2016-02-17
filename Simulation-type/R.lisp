;;Robot

;; Robot Parameters

	;Trajectory points
		
		
		;Trajectory Initial Point (x, y): TIP(0) -> x , TIP(1) -> y
		(define-tvar TIP *int* *int*)

		;Trajectory Middle Point (x, y): TMP(0) -> x , TMP(1) -> y
		(define-tvar TMP *int* *int*)

		;Trajectory End Point (x, y): TEP(0) -> x , TEP(1) -> y
		(define-tvar TEP *int* *int*)

	;Arm points
		
		;robot arm ARM1 Point (x, y): ARM1(0) -> x , ARM1(1) -> y, ARM1(2) -> V_x,  ARM1(3) -> V_y
		(define-tvar ARM1 *int* *int*)

		;robot arm ARM2 Point (x, y): ARM2(0) -> x , ARM2(1) -> y, ARM2(2) -> V_x,  ARM2(3) -> V_y
		(define-tvar ARM2 *int* *int*)

		;End_Eff_Front Point (x, y): End_Eff_F(0) -> x , End_Eff_F(1) -> y, End_Eff_F(2) -> V_x,  End_Eff_F(3) -> V_y
		(define-tvar End_Eff_F *int* *int*)

		;End_Eff_Back Point (x, y): End_Eff_B(0) -> x , End_Eff_B(1) -> y, End_Eff_B(2) -> V_x,  End_Eff_B(3) -> V_y
		(define-tvar End_Eff_B *int* *int*)



;;Presence sensing devices (light curtains, single beam lights, laser scanning devices, pressure sensitive mats)

; (defconstant *Robot_Idle*   ;;V_R=0

; 	; (&& 
; 		(Alwf 
; 			(->
; 				(-P- idle)
; 				(&&
; 					([=] (-V- ARM1 2) 0)
; 					([=] (-V- ARM1 3) 0)
; 					([=] (-V- ARM2 2) 0)
; 					([=] (-V- ARM2 3) 0)					
; 					([=] (-V- End_Eff_F 2) 0)
; 					([=] (-V- End_Eff_F 3) 0)
; 					([=] (-V- End_Eff_B 2) 0)
; 					([=] (-V- End_Eff_B 3) 0)
; 					)
; 			)
; 		)

; 		)


(defconstant *Structure*
	(alw
		(&&

			([<=] ([abs](- (-V- ARM1 0) (-V- ARM2 0))) Max_Distance_Arm1_Arm2_x)
			([<=] ([abs](- (-V- ARM1 1) (-V- ARM2 1))) Max_Distance_Arm1_Arm2_y)
			([<=] ([abs](- (-V- ARM2 0) (-V- End_Eff_B 0))) Max_Distance_End_Eff_B_Arm2_x)
			([<=] ([abs](- (-V- ARM2 1) (-V- End_Eff_B 1))) Max_Distance_End_Eff_B_Arm2_y)
			([<=] ([abs](- (-V- End_Eff_F 0) (-V- End_Eff_B 0)) Max_Distance_End_Eff_F_End_Eff_B_x)
			([<=] ([abs](- (-V- End_Eff_B 1) (-V- End_Eff_B 1))) Max_Distance_End_Eff_F_End_Eff_B_y)
		)
	)
)

; (defconstant *Robot_InBin*
; 		(->
; 			([=] z robot)

; 					 (&& ([<] (-V- End_Eff_F 0) 1500)
; 					 	 ([>] (-V- End_Eff_F 0) 1000)
; 					 	 ([>] (-V- End_Eff_F 1) 0)
; 					 	 ([<] (-V- End_Eff_F 1) 500)
; 				 	 )
; 	 	 )

; )

	; 	(Alwf
	; 		(|| (-P- idle) (-P- moving) (-P- screw) (-P- moveBackward) (-P- moveForward))
	; 	)

	; 	; (Alwf
	; 	; 	(->
	; 	; 		(-P- idle)
	; 	; 		([=] (-V- opZone) 0)
	; 	; 	)
	; 	; )
	; )



; (defconstant *whenRobotIsMoving*
; 	(Alwf 
; 		(&&
; 			(->
; 				(-P- moving)
; 				(|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 13 1) executing))
; 			)

; 			; (->
; 			; 	(-P- moving)
; 			; 	(|| ([!=] (-V- arm1 2) 0) ([!=] (-V- arm1 3) 0) ([!=] (-V- arm2 2) 0) ([!=] (-V- arm2 3) 0))
; 			; )
		 
; 			(->
; 				(!!([=] (yesterday (-V- roZone)) (-V- roZone)))
; 				(-P- moving)
; 			)
; 		)
; 	)

; )

; (defconstant *whenRobotIsMovingForward*

; 	(Alwf 
; 		(->
; 			(-P- moveForward)
; 			([=] (-V- actions 7 1) executing)
; 		)
; 	)

; )

; (defconstant *whenRobotIsScrewing*

; 	(Alwf 
; 		(->
; 			(-P- screw)
; 			([=] (-V- actions 8 1) executing)
; 		)
; 	)

; )

; (defconstant *whenRobotIsMovingBackward*

; 	(Alwf 
; 		(->
; 			(-P- moveBackward)
; 			([=] (-V- actions 9 1) executing)
; 		)
; 	)

; )

; ; (defconstant *whenClampingIsPossible*

; ; 	(Alwf

; ; 		(-> 
; ; 			(-P- clamping)
; ; 			(&& ([=] (-V- roZone) 4) ([=] (-V- opZone) 4))
; ; 		)
; ; 	)

; ; )




(defconstant *RelativeVelocityCheck*
	
	(alwf

		(-A- i (loop for i from 1 to 6 collect i) 
			(-E- j actions-indexes
				(&&
			
					(->
						(&&
						
							([<](-V- Allowed_Relative_Velocities i 0) (-V- Relative_Velocities i 0))
				
							(||

								([=] (-V- actions j 1) executing)
								([=] (-V- actions j 1) parallel-executing)
							)
							([=] (-V- actions j 3) robot)
						)

							(next 
							 	([=] (-V- actions j 1) pause)
						 	)
					 	)
					


					(->
						(&&
						
							([<](-V- Allowed_Relative_Velocities i 1) (-V- Relative_Velocities i 1))
				
							(||

								([=] (-V- actions j 1) executing)
								([=] (-V- actions j 1) parallel-executing)
							)
							([=] (-V- actions j 3) robot)
						)

						(next 
						 	([=] (-V- actions j 1) pause)
					 	)
				 	)
				)
			)
		)
	)
)



