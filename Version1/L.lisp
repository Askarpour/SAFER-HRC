; LayOut
;; Layout Parameters
	;Current Positions
		
		; (define-tvar roZone *int*)
		; (define-tvar opZone *int*)

	;We divide the layout into 11 regions and name them by L_i
	;We divide the layout into 9 regions and name them by L_i
	;L_6 is pallet and L_4 is bin
	;robot mainely moves in L_1,2,3,4,5,6 and doesnt arrive to L_7,8,9

		(defvar L_1 1)
		(defvar L_2 2)
		(defvar L_3_a 3)
		(defvar L_3_b 4)
		(defvar L_3_c 5)
		(defvar L_4_a 6)
		(defvar L_4_b 7)
		(defvar L_5_a 8)
		(defvar L_5_b 9)
		(defvar L_6 10)
		(defvar L_7 11)

;;we can say that we define three sets of relevant properties, each for a group of bodyparts (upper, waist lower limbs).		
;;
;;
(define-tvar relevantVelocity *int*)
;;relevant velocity of robot and Operator which can have one of the following three values: critical, normal, low

(define-tvar relevantForce *int*)
;;relevant velocity of robot and Operator which can have one of the following three values: critical, normal, low


(define-tvar relevantSeparation *int*)
;;relevant velocity of robot and Operator which can have one of the following two values: critical, normal


(define-tvar moveDirection *int*)
;;It takes two possible values which say of the operator and robot are getting closer (moving towards each other), or are getting apart.
(defvar critical 3)
(defvar normal 2)
(defvar low 1)
(defvar moveapart 1)
(defvar moveclose 2)
(defconstant *relevantProperties*
	(alwf 
		(&&

			([>=] (-V- relevantVelocity) 1) 
			([<=] (-V- relevantVelocity) 3)

			([>=] (-V- relevantForce) 1) 
			([<=] (-V- relevantForce) 3)	

			([>=] (-V- relevantSeparation) 1) 
			([<=] (-V- relevantSeparation) 2)

			([>=] (-V- moveDirection) moveapart) 
			([<=] (-V- moveDirection) moveclose)			


		)
	)
)