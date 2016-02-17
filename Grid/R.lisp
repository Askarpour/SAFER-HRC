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
		
		;robot arm ARM1 Point
		(define-tvar ARM1 *int*)

		;robot arm ARM2 Point
		(define-tvar ARM2 *int*)

		;End_Eff_Front Point 
		(define-tvar End_Eff_F *int*) 

		;End_Eff_Back Point 
		(define-tvar End_Eff_B *int*)




(defconstant *Robot_Structure*
	(alw
		(&&
			(|| ([=](-V- ARM1) L_1) ([=](-V- ARM1) L_2))
			
			([=](-V- End_Eff_F) (-V- End_Eff_B))
			
			(->
				([=](-V- ARM1) L_1)
				(|| ([=] (-V- ARM2) L_2) ([=](-V- ARM2) L_4) ([=](-V- ARM2) L_5))
			)

			(->
				([=](-V- ARM1) L_2)
				(|| ([=] (-V- ARM2) L_2) ([=](-V- ARM2) L_3) ([=](-V- ARM2) L_5))
			)

			(->
				([=](-V- ARM2) L_2)
				(|| ([=] (-V- End_Eff_B) L_4) ([=](-V- End_Eff_B) L_5) ([=](-V- End_Eff_B) L_6))

			)

			(->
				([=](-V- ARM2) L_3)
				(&&
					(||([=](-V- End_Eff_B) L_5) ([=](-V- End_Eff_B) L_6))
					(next (|| ([=](-V- ARM2) L_2) ([=](-V- ARM2) L_3) ([=](-V- ARM2) L_5) ([=](-V- ARM2) L_6)))
				)
			)
			
			(->
				([=](-V- ARM2) L_4)
				(&&

					(|| ([=] (-V- End_Eff_B) L_4) ([=](-V- End_Eff_B) L_7) ([=](-V- End_Eff_B) L_8))
				
					(next (|| ([=](-V- ARM2) L_2) ([=](-V- ARM2) L_4) ([=](-V- ARM2) L_5)))
				)
			)
		
			(->
				([=](-V- ARM2) L_5)
				(|| ([=] (-V- End_Eff_B) L_4) ([=](-V- End_Eff_B) L_7) ([=](-V- End_Eff_B) L_8))
			)
		)
	)
)




