;;Real World


;class identifiers
	(defconstant operator 1)
	(defconstant robot 2)
	(defconstant pallet 3)
	(defvar V_Current 400)
	(defvar Max_Distance_Arm1_Arm2_x 400)

;Relative Parameters
	
	;Only relative velocity is enough since by having that and mass and area we can have the amount of presure and 
	;compare it with allowed presure value given in ISO	

	(define-tvar Relative_Velocities *int* *int* *int* *int*)
	(define-tvar Allowed_Relative_Velocities *int* *int* *int*)

	; Relative_Velocities(0,0,BodyPart) Relative_Velocities_Op_Arm1_x
	; Relative_Velocities(0,1,BodyPart) Relative_Velocities_Op_Arm1_y
	; Relative_Velocities(1,0,BodyPart) Relative_Velocities_Op_Arm2_x
	; Relative_Velocities(1,1,BodyPart) Relative_Velocities_Op_Arm2_y
	; Relative_Velocities(2,0,BodyPart) Relative_Velocities_Op_End_Eff_B_x
	; Relative_Velocities(2,1,BodyPart) Relative_Velocities_Op_End_Eff_B_y
	; Relative_Velocities(3,0,BodyPart) Relative_Velocities_Op_End_Eff_F_x
	; Relative_Velocities(3,1,BodyPart) Relative_Velocities_Op_End_Eff_F_y
	; Relative_Velocities(4,0,BodyPart) Relative_Velocities_Op_Pallet_Angle1_x
	; Relative_Velocities(4,1,BodyPart) Relative_Velocities_Op_Pallet_Angle1_y 
	; Relative_Velocities(5,0,BodyPart) Relative_Velocities_Op_Pallet_Angle2_x
	; Relative_Velocities(5,1,BodyPart) Relative_Velocities_Op_Pallet_Angle2_y
	; Relative_Velocities(6,0,BodyPart) Relative_Velocities_Op_Pallet_Bump1_x
	; Relative_Velocities(6,1,BodyPart) Relative_Velocities_Op_Pallet_Bump1_y
	; Relative_Velocities(7,0,BodyPart) Relative_Velocities_Op_Pallet_Bump2_x
	; Relative_Velocities(7,1,BodyPart) Relative_Velocities_Op_Pallet_Bump2_y




(defun Current_Relative_Velocity (x y)

	
	

		(&&

			(->
				(|| (&& ([=] x operator) ([=] y robot)) (&& ([=] y operator) ([=] x robot)))
				
				(-A- i body-indexes
					(&&

					([=] (-V- Relative_Velocities 0 0 i) V_Current) 
					([=] (-V- Relative_Velocities 0 1 i) V_Current) 
					([=] (-V- Relative_Velocities 1 0 i) V_Current)  
					([=] (-V- Relative_Velocities 1 1 i) V_Current) 
					([=] (-V- Relative_Velocities 2 0 i) V_Current)  
					([=] (-V- Relative_Velocities 2 1 i) V_Current) 
					([=] (-V- Relative_Velocities 3 0 i) V_Current)
					([=] (-V- Relative_Velocities 3 1 i) V_Current) 
				)
			)
				)

			(->
				(|| (&& ([=] x operator) ([=] y robot)) (&& ([=] y operator) ([=] x robot)))
				(-A- i body-indexes
					(&&
					([=] (-V- Relative_Velocities 4 0 i) V_Current) 
					([=] (-V- Relative_Velocities 4 1 i) V_Current) 
					([=] (-V- Relative_Velocities 5 0 i) V_Current)  
					([=] (-V- Relative_Velocities 5 1 i) V_Current) 
					([=] (-V- Relative_Velocities 6 0 i) V_Current)  
					([=] (-V- Relative_Velocities 6 1 i) V_Current) 
					([=] (-V- Relative_Velocities 7 0 i) V_Current)
					([=] (-V- Relative_Velocities 7 1 i) V_Current) 
				)
					)

			)

		)
	)

(defconstant *Allowed_Relative_Velocity*

	(-A- i body-indexes
		(&&

		([=] (-V- Relative_Velocities 0 0 i) V_Current) 
		([=] (-V- Relative_Velocities 0 1 i) V_Current) 
		([=] (-V- Relative_Velocities 1 0 i) V_Current)  
		([=] (-V- Relative_Velocities 1 1 i) V_Current) 
		([=] (-V- Relative_Velocities 2 0 i) V_Current)  
		([=] (-V- Relative_Velocities 2 1 i) V_Current) 
		([=] (-V- Relative_Velocities 3 0 i) V_Current)
		([=] (-V- Relative_Velocities 3 1 i) V_Current) 
	)
		) 

)
