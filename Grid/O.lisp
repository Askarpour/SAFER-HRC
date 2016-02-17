;; Operator

;; Operator Parameters

	;number of body parts
		

		(define-tvar Body_Part  *int* *int*)
		(defvar body_indexes (loop for i from 1 to 11 collect i))

	;;Name of bodyParts

		(define-tvar Head *int*)
	;	(define-tvar Face *int*)
		(define-tvar Shoulders *int*)
		(define-tvar Chest *int*)
		(define-tvar Belly *int*)
		(define-tvar Pelvis *int*)
		(define-tvar Upper_Arm *int*)
		(define-tvar Hand *int*)
		(define-tvar Thigh *int*)
		(define-tvar Leg *int*)
		(define-tvar Neck *int*)
		(define-tvar Lower_Arm *int*)




		;1 Skull/Forehead
		;2 Face
		;---> in one : Head

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


(defconstant *Operator_Body*

	(alwf 
	  (-A- i body_indexes
		(&& 
			(&& ([>=](-V- Body_Part i) L_1) ([<=](-V- Body_Part i) L_9))
			
			([!=](-V- Body_Part i) L_4) ; no part is allowed in bin
			
			; (->  ; no part allowed on pallet except hand
			; 	([!=] i 8)
			; 	([!=](-V- Body_Part i) L_6)
			; )

			(-> ;hand, uper and lower arm always close
				([=](-V- Body_Part 8) L_6)
				(&& ([=](-V- Body_Part 7) L_5) ([=](-V- Body_Part 11) L_5))
			)

			(|| ([=](-V- Body_Part 10) (-V- Body_Part 1)) ([=](-V- Body_Part 10) (-V- Body_Part 2))) ; shoulder and head always close
			(&& ([=](-V- Body_Part 2) (-V- Body_Part 3)) ([=](-V- Body_Part 2) (-V- Body_Part 4))) ; shoulders and chest close
		;	([=](-V- Body_Part 1) (-V- Body_Part 11))

	    	(->
	    		(-E- j body_indexes 	
	    			([=](-V- Body_Part j) L_1)
    			)
	    		
				(|| ([=](-V- Body_Part i) L_1) ([=](-V- Body_Part i) L_2) ([=](-V- Body_Part i) L_4) ([=](-V- Body_Part i) L_5))
			)

	    	(->
	    		(-E- j body_indexes 	
	    			([=](-V- Body_Part j) L_2)
    			)
	    		
				(|| ([=](-V- Body_Part i) L_1) ([=](-V- Body_Part i) L_2) ([=](-V- Body_Part i) L_3) ([=](-V- Body_Part i) L_4) ([=](-V- Body_Part i) L_5))
			)

			(->
	    		(-E- j body_indexes 	
	    			([=](-V- Body_Part j) L_3)
    			)
	    		
				(|| ([=](-V- Body_Part i) L_2) ([=](-V- Body_Part i) L_5) ([=](-V- Body_Part i) L_6))
			)

			(->
	    		(-E- j body_indexes 	
	    			([=](-V- Body_Part j) L_7)
    			)
	    		
				(|| ([=](-V- Body_Part i) L_4) ([=](-V- Body_Part i) L_5) ([=](-V- Body_Part i) L_8))
			)

			(->
	    		(-E- j body_indexes 	
	    			([=](-V- Body_Part j) L_8)
    			)
	    		
				(|| ([=](-V- Body_Part i) L_4) ([=](-V- Body_Part i) L_5) ([=](-V- Body_Part i) L_9))
			)

			(->
	    		(-E- j body_indexes 	
	    			([=](-V- Body_Part j) L_9)
    			)
	    		
				(|| ([=](-V- Body_Part i) L_5) ([=](-V- Body_Part i) L_8))
			)

		    
		    	
    			

    		)
		)
	)
)	
	