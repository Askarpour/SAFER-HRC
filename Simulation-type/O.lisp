;; Operator

;; Operator Parameters

	;number of body parts
		

		(define-tvar Body_Part  *int* *int* *int*)
	
	;Body Parts : for each body part we keep 7 values as the following.
		 ; Body_Part(0) -> nameIndex ,
		 ; Body_Part(1) -> x ,
		 ; Body_Part(2) -> y, 
		 ; Body_Part(3) -> V_x,
		 ; Body_Part(4) -> V_y,
		 ; Body_Part(5) -> mass,
		 ; Body_Part(6) -> Area,
		 ; Body_Part(7) -> Allowed presure  (presure is selected because ot is the basis of painlevel in the ISO)
			 
		; (defvar Mid_forehead 1);1. Mid of forehead  
		; (defvar Temple 2);2. Temple 
		; (defvar Masticatory_muscle 3);Masticatory muscle
		; (defvar Shoulder_joint 6);Shoulder joint
		; (defvar Sternum 8);Sternum
		; (defvar Pectoral_muscle 9);Pectoral muscle
		; (defvar Abdominal_muscle 10);Abdominal muscle
		; (defvar Pelvic_bone 11);Pelvic bone
		; (defvar Arm_nerve 16);Arm nerve
		; (defvar Forefinger_pad_d 17);Forefinger pad d
		; (defvar Forefinger_pad_nd 18);Forefinger pad nd
		; (defvar Thenar 21);Thenar
		; (defvar Palm_hand_d 22);Palm of hand d
		; (defvar Palm_hand_nd 23);Palm of hand nd
		; (defvar Thigh_muscle 26);Thigh muscle
		; (defvar Kneecap 27);Kneecap
		; (defvar Shin_splint 28);Shin splint
		; (defvar Neck_muscle 4);Neck muscle
		; (defvar 7th_neck_muscle 5);7th neck muscle
		; (defvar 5th_lumbar_vertebra 7);5th lumbar vertebra
		; (defvar Deltoid_muscle 12);Deltoid muscle
		; (defvar Humerus 13);Humerus
		; (defvar Radius_bone 14);Radius bone
		; (defvar Forearm_muscle 15);Forearm muscle
		; (defvar Forefinger_end_joint_nd 19);Forefinger end joint nd
		; (defvar Forefinger_end_joint_d 20);Forefinger end joint d
		; (defvar Back_hand_d 24);Back of the hand d
		; (defvar Back_hand_nd 25);Back of the hand nd
		; (defvar Calf_muscle 29);Calf muscle
		; ;_d Dominant body side
		; ;_nd Non dominant body side

	;there is a matrix of 12*12 for keeping the anatomy correct -> x axis
		
		(define-tvar Anatomy_x  *int* *int* *int*)

	;there is a matrix of 12*12 for keeping the anatomy correct -> y axis
		(define-tvar Anatomy_y  *int* *int* *int*)



(defvar body-indexes (loop for i from 1 to 12 collect i))
;Body anatomy should be respected

;  (defconstant *OperatorInit*
;  	(alwf
;  		(-A- i body-indexes
		
; 			(&&
; 	 			 ([=] (-V- Body_Part i 5) mass)
; 	 			 ([=] (-V- Body_Part i 6) Area)
; 	 			 ([=] (-V- Body_Part i 7) allowed presure)

; 			)
; 		)
; 	)
; )



(defconstant *Anatomy_Y*
	
	(alw
	  (&& 
		 (-A- i body-indexes
	 		 (-A- j body-indexes
	 		 	(&&
	   			
		   			
		   				(->
			   				([=] i j)
			   				([=] (-V- Anatomy_y i j) 0)
		   				)

		   				
	   					([=] (-V- Anatomy_y i j) (-V- Anatomy_y j i))
	   					)
		   			)
	 		 )

		   					

		   				;;realistic distances of bodyparts taken from ISO_TC_159 (worldwide design ranges - p5 - Female)


		   				;1 Skull/Forehead
		   				;2 Face
		   				;3 Back/Shoulders
		   				;4 Chest
		   				;5 Belly
		   				;6 Pelvis
		   				;7 Upper arm/Elbow joint
		   				;8 Hand/Finger
		   				;9 Thigh/Knee
		   				;10 Lower leg
		   				;11 Neck (sides/neck)
		   				;12 Lower arm/Hand joint

		   			
		   				([<=] (-V- Anatomy_y 1 2) 135) ;135
		   				([>=] (-V- Anatomy_y 1 2) 100) 
		   				
		   				([<=] (-V- Anatomy_y 1 11) 213) ;213
		   				([>=] (-V- Anatomy_y 1 11) 50) 
		   				
		   				([<=] (-V- Anatomy_y 1 3) 165)	;1735-1570
		   				([>=] (-V- Anatomy_y 1 3) 0)	

		   				([<=] (-V- Anatomy_y 3 5) 557)	;1570-1013
		   				([>=] (-V- Anatomy_y 3 5) 300)	

		   				;([<=] (-V- Anatomy_y 1 11) 149)	;867-718 sitting mode numbers
		   				([>=] (-V- Anatomy_y 4 2) 165)  ; distance of chest to eye larger than distance of shoulder to eye 1735-1570
		   				([<=] (-V- Anatomy_y 4 2) 540)  ; distance of chest to eye smaller than distance of elbow to eye 1735-1175
		   				
		   				; ([<=] (-V- Anatomy_y 6 8) 0)	;1570-
		   				; ([<=] (-V- Anatomy_y 6 9) 0)	;1570-

		   				([<=] (-V- Anatomy_y 1 5) 722)	;1735-1013
		   				([>=] (-V- Anatomy_y 1 5) 0)

		   				([<=] (-V- Anatomy_y 1 6) 830)	;1735-905
		   				([>=] (-V- Anatomy_y 1 6) 200)

		   				([<=] (-V- Anatomy_y 11 7) 421)	;718-297 
		   				([>=] (-V- Anatomy_y 11 7) 0)


		   				([<=] (-V- Anatomy_y 1 12) 910)	;1735-825
		   				([>=] (-V- Anatomy_y 1 12) 0)	


		   				([<=] (-V- Anatomy_y 7 12) 338)	;338
		   				([>=] (-V- Anatomy_y 7 12) 0)


		   				([<=] (-V- Anatomy_y 1 8) 910)	;1735-825
		   				([>=] (-V- Anatomy_y 1 8) 0)


		   				([<=] (-V- Anatomy_y 1 9) 703)		;1735-330-802
		   				([>=] (-V- Anatomy_y 1 9) 500)



		   				([<=] (-V- Anatomy_y 1 9) 1128)	;1735-607
		   				([>=] (-V- Anatomy_y 1 9) 0)


		   				([<=] (-V- Anatomy_y 10 9) 511)	;511
		   				([>=] (-V- Anatomy_y 10 9) 100)


	   				)
	   			)
   			)

(defconstant *Anatomy_X*

	(alw
		
	 	(-A- i body-indexes
	 		 (-A- j body-indexes
	   			
		   			(&& 
		   				(->
			   				([=] i j)
			   				([=] (-V- Anatomy_x i j) 0)
		   				)

		   				
	   					([=] (-V- Anatomy_x i j) (-V- Anatomy_x j i))

	   					(->
			   				([!=] i j)
			   				([>=] (-V- Anatomy_x i j) 200)
		   				)

	   					
	   					(-> 
	   						(&& 
	   						
		   						([!=] i 8)
		   						([!=] i 10)
		   						([!=] j 8)
		   						([!=] j 10)
	   						)
	   						([<=] (-V- Anatomy_x i j) 550);550 shoulder breadth
	   				)

	   					(->
	   						(|| 
	   							([=] i 8)
	   							
	   							([=] j 8)
	 
	   							)
	   						([<=] (-V- Anatomy_x i j) 771);550 shoulder breadth+221 hand lenghth

	   						)


	   					(->
	   						(|| 
	   							([=] i 10)
	   							
	   							([=] j 10)
	 
	   							)
	   						([<=] (-V- Anatomy_x i j) 1151);550 shoulder breadth+607 lower leg lenghth

	   						)
	   			)

   			)

		)
	)
	)