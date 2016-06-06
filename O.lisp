;; Operator

;; Operator Parameters

	;number of body parts
		

<<<<<<< HEAD
		(define-tvar Body_Part_pos *int* *int*)
=======
		(define-tvar Body_Part  *int* *int*)
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
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

<<<<<<< HEAD
=======

>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
(defconstant *Operator_Body*

	(alwf 
	  (-A- i body_indexes
		(&& 
<<<<<<< HEAD
			(&& ([>=](-V- Body_Part_pos i) L_1) ([<=](-V- Body_Part_pos i) L_7))
=======
			(&& ([>=](-V- Body_Part i) L_1) ([<=](-V- Body_Part i) L_7))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2

		
		

	    	(->
	    		(-E- j body_indexes 	
<<<<<<< HEAD
	    			([=](-V- Body_Part_pos j) L_1)
    			)
	    		
				(|| ([=](-V- Body_Part_pos i) L_1) ([=](-V- Body_Part_pos i) L_2) ([=](-V- Body_Part_pos i) L_4_a) ([=](-V- Body_Part_pos i) L_4_b) ([=](-V- Body_Part_pos i) L_7))
=======
	    			([=](-V- Body_Part j) L_1)
    			)
	    		
				(|| ([=](-V- Body_Part i) L_1) ([=](-V- Body_Part i) L_2) ([=](-V- Body_Part i) L_4_a) ([=](-V- Body_Part i) L_4_b) ([=](-V- Body_Part i) L_7))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
			)

	    	(->
	    		(-E- j body_indexes 	
<<<<<<< HEAD
	    			([=](-V- Body_Part_pos j) L_2)
    			)
	    		
				(|| ([=](-V- Body_Part_pos i) L_1) ([=](-V- Body_Part_pos i) L_7) ([=](-V- Body_Part_pos i) L_2) ([=](-V- Body_Part_pos i) L_3_a) ([=](-V- Body_Part_pos i) L_3_b) ([=](-V- Body_Part_pos i) L_3_c) ([=](-V- Body_Part_pos i) L_4_a) ([=](-V- Body_Part_pos i) L_4_b))
=======
	    			([=](-V- Body_Part j) L_2)
    			)
	    		
				(|| ([=](-V- Body_Part i) L_1) ([=](-V- Body_Part i) L_7) ([=](-V- Body_Part i) L_2) ([=](-V- Body_Part i) L_3_a) ([=](-V- Body_Part i) L_3_b) ([=](-V- Body_Part i) L_3_c) ([=](-V- Body_Part i) L_4_a) ([=](-V- Body_Part i) L_4_b))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
			)

			(->
	    		(-E- j body_indexes 	
<<<<<<< HEAD
	    			([=](-V- Body_Part_pos j) L_3_a)
    			)
	    		
				(|| ([=](-V- Body_Part_pos i) L_3_a) ([=](-V- Body_Part_pos i) L_3_b))
=======
	    			([=](-V- Body_Part j) L_3_a)
    			)
	    		
				(|| ([=](-V- Body_Part i) L_3_a) ([=](-V- Body_Part i) L_3_b))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
			)

			(->
	    		(-E- j body_indexes 	
<<<<<<< HEAD
	    			([=](-V- Body_Part_pos j) L_3_b)
    			)
	    		
				(|| ([=](-V- Body_Part_pos i) L_3_a) ([=](-V- Body_Part_pos i) L_3_b) ([=](-V- Body_Part_pos i) L_3_c))
			)
			(->
	    		(-E- j body_indexes 	
	    			([=](-V- Body_Part_pos j) L_3_c)
    			)
	    		
				(|| ([=](-V- Body_Part_pos i) L_1) ([=](-V- Body_Part_pos i) L_2) ([=](-V- Body_Part_pos i) L_7) ([=](-V- Body_Part_pos i) L_3_b) ([=](-V- Body_Part_pos i) L_3_c))
=======
	    			([=](-V- Body_Part j) L_3_b)
    			)
	    		
				(|| ([=](-V- Body_Part i) L_3_a) ([=](-V- Body_Part i) L_3_b) ([=](-V- Body_Part i) L_3_c))
			)
			(->
	    		(-E- j body_indexes 	
	    			([=](-V- Body_Part j) L_3_c)
    			)
	    		
				(|| ([=](-V- Body_Part i) L_1) ([=](-V- Body_Part i) L_2) ([=](-V- Body_Part i) L_7) ([=](-V- Body_Part i) L_3_b) ([=](-V- Body_Part i) L_3_c))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
			)


			(->
	    		(-E- j body_indexes 	
<<<<<<< HEAD
	    			([=](-V- Body_Part_pos j) L_4_a)
    			)
	    		
				(|| ([=](-V- Body_Part_pos i) L_4_a) ([=](-V- Body_Part_pos i) L_4_b) ([=](-V- Body_Part_pos i) L_5_b))
=======
	    			([=](-V- Body_Part j) L_4_a)
    			)
	    		
				(|| ([=](-V- Body_Part i) L_4_a) ([=](-V- Body_Part i) L_4_b) ([=](-V- Body_Part i) L_5_b))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
			)


			(->
	    		(-E- j body_indexes 	
<<<<<<< HEAD
	    			([=](-V- Body_Part_pos j) L_4_b)
    			)
	    		
				(|| ([=](-V- Body_Part_pos i) L_1) ([=](-V- Body_Part_pos i) L_2) ([=](-V- Body_Part_pos i) L_4_a) ([=](-V- Body_Part_pos i) L_4_b) ([=](-V- Body_Part_pos i) L_7))
=======
	    			([=](-V- Body_Part j) L_4_b)
    			)
	    		
				(|| ([=](-V- Body_Part i) L_1) ([=](-V- Body_Part i) L_2) ([=](-V- Body_Part i) L_4_a) ([=](-V- Body_Part i) L_4_b) ([=](-V- Body_Part i) L_7))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
			)


			(->
	    		(-E- j body_indexes 	
<<<<<<< HEAD
	    			([=](-V- Body_Part_pos j) L_5_a)
    			)
	    		
				(|| ([=](-V- Body_Part_pos i) L_5_a) ([=](-V- Body_Part_pos i) L_5_b))
=======
	    			([=](-V- Body_Part j) L_5_a)
    			)
	    		
				(|| ([=](-V- Body_Part i) L_5_a) ([=](-V- Body_Part i) L_5_b))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
			)


			(->
	    		(-E- j body_indexes 	
<<<<<<< HEAD
	    			([=](-V- Body_Part_pos j) L_5_b)
    			)
	    		
				(|| ([=](-V- Body_Part_pos i) L_4_a) ([=](-V- Body_Part_pos i) L_5_a) ([=](-V- Body_Part_pos i) L_5_b))
=======
	    			([=](-V- Body_Part j) L_5_b)
    			)
	    		
				(|| ([=](-V- Body_Part i) L_4_a) ([=](-V- Body_Part i) L_5_a) ([=](-V- Body_Part i) L_5_b))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
			)

			(->
	    		(-E- j body_indexes 	
<<<<<<< HEAD
	    			([=](-V- Body_Part_pos j) L_6)
    			)
	    		
				(!! (&&([=](-V- Body_Part_pos i) L_1) ([=](-V- Body_Part_pos i) L_7)))
=======
	    			([=](-V- Body_Part j) L_6)
    			)
	    		
				(!! (&&([=](-V- Body_Part i) L_1) ([=](-V- Body_Part i) L_7)))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
			)

			(->
	    		(-E- j body_indexes 	
<<<<<<< HEAD
	    			([=](-V- Body_Part_pos j) L_7)
    			)
	    		
				(|| ([=](-V- Body_Part_pos i) L_1) ([=](-V- Body_Part_pos i) L_2) ([=](-V- Body_Part_pos i) L_7) ([=](-V- Body_Part_pos i) L_4_a) ([=](-V- Body_Part_pos i) L_3_c))
=======
	    			([=](-V- Body_Part j) L_7)
    			)
	    		
				(|| ([=](-V- Body_Part i) L_1) ([=](-V- Body_Part i) L_2) ([=](-V- Body_Part i) L_7) ([=](-V- Body_Part i) L_4_a) ([=](-V- Body_Part i) L_3_c))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
			)

			

    		)
		)
	)
)	
	