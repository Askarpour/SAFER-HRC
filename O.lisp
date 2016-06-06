;; Operator

;; Operator Parameters

	;number of body parts
		

		(define-tvar Body_Part_pos *int* *int*)
		(defvar body_indexes (loop for i from 1 to 11 collect i))

	;;Name of bodyParts

		(defvar Head 1)
	;	(define-tvar Face *int*)
		(defvar Shoulders 2)
		(defvar Chest 3)
		(defvar Belly 4)
		(defvar Pelvis 5)
		(defvar Upper_Arm 6)
		(defvar Hand 7)
		(defvar Thigh 8)
		(defvar Leg 9)
		(defvar Neck 10)
		(defvar Lower_Arm 11)




		;1 Skull/Forehead
		;2 Face
		;---> in one : Head
		;3 Back/Shoulders
		;4 Chest
		;5 Belly
		;6 Pelvis
		;8 Upper arm/Elbow joint
		;7 Hand/Finger
		;9 Thigh/Knee
		;10 Lower leg
		;11 Neck (sides/neck)
		;12 Lower arm/Hand joint

(defconstant *Operator_Body*

	(alwf 
	  (-A- i body_indexes
		(&& 
			(&& ([>=](-V- Body_Part_pos i) L_1) ([<=](-V- Body_Part_pos i) L_7))

		
		

	    	(->
	    		(-E- j body_indexes 	
	    			([=](-V- Body_Part_pos j) L_1)
    			)
	    		
				(|| ([=](-V- Body_Part_pos i) L_1) ([=](-V- Body_Part_pos i) L_2) ([=](-V- Body_Part_pos i) L_4_a) ([=](-V- Body_Part_pos i) L_4_b) ([=](-V- Body_Part_pos i) L_7))
			)

	    	(->
	    		(-E- j body_indexes 	
	    			([=](-V- Body_Part_pos j) L_2)
    			)
	    		
				(|| ([=](-V- Body_Part_pos i) L_1) ([=](-V- Body_Part_pos i) L_7) ([=](-V- Body_Part_pos i) L_2) ([=](-V- Body_Part_pos i) L_3_a) ([=](-V- Body_Part_pos i) L_3_b) ([=](-V- Body_Part_pos i) L_3_c) ([=](-V- Body_Part_pos i) L_4_a) ([=](-V- Body_Part_pos i) L_4_b))
			)

			(->
	    		(-E- j body_indexes 	
	    			([=](-V- Body_Part_pos j) L_3_a)
    			)
	    		
				(|| ([=](-V- Body_Part_pos i) L_3_a) ([=](-V- Body_Part_pos i) L_3_b))
			)

			(->
	    		(-E- j body_indexes 	
	    			([=](-V- Body_Part_pos j) L_3_b)
    			)
	    		
				(|| ([=](-V- Body_Part_pos i) L_3_a) ([=](-V- Body_Part_pos i) L_3_b) ([=](-V- Body_Part_pos i) L_3_c))
			)
			(->
	    		(-E- j body_indexes 	
	    			([=](-V- Body_Part_pos j) L_3_c)
    			)
	    		
				(|| ([=](-V- Body_Part_pos i) L_1) ([=](-V- Body_Part_pos i) L_2) ([=](-V- Body_Part_pos i) L_7) ([=](-V- Body_Part_pos i) L_3_b) ([=](-V- Body_Part_pos i) L_3_c))
			)


			(->
	    		(-E- j body_indexes 	
	    			([=](-V- Body_Part_pos j) L_4_a)
    			)
	    		
				(|| ([=](-V- Body_Part_pos i) L_4_a) ([=](-V- Body_Part_pos i) L_4_b) ([=](-V- Body_Part_pos i) L_5_b))
			)


			(->
	    		(-E- j body_indexes 	
	    			([=](-V- Body_Part_pos j) L_4_b)
    			)
	    		
				(|| ([=](-V- Body_Part_pos i) L_1) ([=](-V- Body_Part_pos i) L_2) ([=](-V- Body_Part_pos i) L_4_a) ([=](-V- Body_Part_pos i) L_4_b) ([=](-V- Body_Part_pos i) L_7))
			)


			(->
	    		(-E- j body_indexes 	
	    			([=](-V- Body_Part_pos j) L_5_a)
    			)
	    		
				(|| ([=](-V- Body_Part_pos i) L_5_a) ([=](-V- Body_Part_pos i) L_5_b))
			)


			(->
	    		(-E- j body_indexes 	
	    			([=](-V- Body_Part_pos j) L_5_b)
    			)
	    		
				(|| ([=](-V- Body_Part_pos i) L_4_a) ([=](-V- Body_Part_pos i) L_5_a) ([=](-V- Body_Part_pos i) L_5_b))
			)

			(->
	    		(-E- j body_indexes 	
	    			([=](-V- Body_Part_pos j) L_6)
    			)
	    		
				(!! (&&([=](-V- Body_Part_pos i) L_1) ([=](-V- Body_Part_pos i) L_7)))
			)

			(->
	    		(-E- j body_indexes 	
	    			([=](-V- Body_Part_pos j) L_7)
    			)
	    		
				(|| ([=](-V- Body_Part_pos i) L_1) ([=](-V- Body_Part_pos i) L_2) ([=](-V- Body_Part_pos i) L_7) ([=](-V- Body_Part_pos i) L_4_a) ([=](-V- Body_Part_pos i) L_3_c))
			)

			

    		)
		)
	)
)	
	