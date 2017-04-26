;; Operator

;; Operator Parameters

	;number of body parts
		
		(define-tvar Body_Part_pos *int* *int*)
		
		; (defvar body_indexes (loop for i from 1 to 11 collect i))
		; (defvar adjacency-indexes (loop for i from 1 to 11 collect i))

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


(defconstant *Operator_Body*
  (alwf 
  	(&&
  	;;op is still
	(<->
		(-P- OperatorStill)
		(-A- i body_indexes ([=](-V- Body_Part_pos i) (yesterday (-V- Body_Part_pos i))))
	)	
	
	(-A- i body_indexes 

		(&& 

		
			([>=](-V- Body_Part_pos i) L_0) 
			([<=](-V- Body_Part_pos i) L_8_2)
			(||
				(Adj (-V- Body_Part_pos i) (yesterday(-V- Body_Part_pos i)))
				([=] (-V- Body_Part_pos i) (yesterday(-V- Body_Part_pos i)))	
			)

			(-A- j body_indexes 

			 	(||
			 		(Adj (-V- Body_Part_pos i) (-V- Body_Part_pos j))
			 		([=] (-V- Body_Part_pos i) (-V- Body_Part_pos j))
			 	)	
			)

			;;
				([=] (-V- Body_Part_pos 1) (-V- Body_Part_pos 2))

				([=] (-V- Body_Part_pos 1) (-V- Body_Part_pos 3))

				([=] (-V- Body_Part_pos 1) (-V- Body_Part_pos 4))

				([=] (-V- Body_Part_pos 1) (-V- Body_Part_pos 5))

				([=] (-V- Body_Part_pos 1) (-V- Body_Part_pos 6))

				([=] (-V- Body_Part_pos 11) (-V- Body_Part_pos 7))

				([=] (-V- Body_Part_pos 1) (-V- Body_Part_pos 8))

				([=] (-V- Body_Part_pos 1) (-V- Body_Part_pos 9))

				([=] (-V- Body_Part_pos 1) (-V- Body_Part_pos 10))

				(|| ([=] (-V- Body_Part_pos 1) (-V- Body_Part_pos 11))
						(Adj (-V- Body_Part_pos 1) (-V- Body_Part_pos 11))
				)
		)
   	)
  )
 )
)