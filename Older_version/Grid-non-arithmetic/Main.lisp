<<<<<<< HEAD
(asdf:operate 'asdf:load-op 'sbvzot)
(use-package :trio-utils)
(defvar TSPACE 200)
=======
(asdf:operate 'asdf:load-op 'ae2sbvzot)
(use-package :trio-utils)
(defvar TSPACE 50)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

(load "L.lisp")
(load "R.lisp")
(load "O.lisp")
(load "Task-nop.lisp")
(load "RRM.lisp")
(load "Hazards.lisp")
(load "Properties.lisp")



(defvar Init 
	(&& 

		(!! (-P- partFixed))
		(!! (-P- partTaken))
		(-P- Robot_Homing)
		(somf (-P- partFixed))
		
		
	   	(-A- i actions-indexes
<<<<<<< HEAD

	   			 (actions-status= i notStarted))	

	   	 (somf (&& (!! (Body_Part_pos= head L_1)) (actions-status= 6 executing)))
	   	 (somf (&& (!! (Body_Part_pos= head L_1)) (actions-status= 7 executing)))
	   	 (somf (&& (!! (Body_Part_pos= belly L_1)) (actions-status= 8 executing)))
=======
	   		; (&&
	   			 ([=] (-V- actions i 1) notStarted)
	   			 ; (somf ([=] (-V- actions i 1) done))
   			 ; )
	   	)
	   	 ; (somf ([=] (-V- actions 5 1) 2))
	   	 ; (somf ([=] (-V- actions 6 1) 3))



	   ;; This wont happen. while actions 1-4 are executing no hazard cause of defining homing position
	   ; 	 (somf
	   ; 	 	(-E- i hazards-indexes
				; (||
				; 	(&& ([=] (-V- actions 1 1) executing) ([=] (-V- hazards i 0) 1))
				; 	(&& ([=] (-V- actions 2 1) executing) ([=] (-V- hazards i 0) 1))
				; 	(&& ([=] (-V- actions 3 1) executing) ([=] (-V- hazards i 0) 1))
				; 	(&& ([=] (-V- actions 4 1) executing) ([=] (-V- hazards i 0) 1))


				; )
	   ; 	 	)
   	;  	)
	   	 
	   	 (somf (&& ([!=](-V- Body_Part_pos head) L_1) ([=] (-V- actions 6 1) executing)))
	   	 (somf (&& ([!=](-V- Body_Part_pos head) L_1) ([=] (-V- actions 7 1) executing)))
	   	 (somf (&& ([!=](-V- Body_Part_pos belly) L_1) ([=] (-V- actions 8 1) executing)))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243



		(alwf 
			(-A- i actions-indexes
				(&&

<<<<<<< HEAD
				   	(|| (Action_Pre= i 0) (Action_Pre= i 1))
				   	(|| (Action_SafetyPro= i 0) (Action_SafetyPro= i 1))
				    (|| (Action_Post= i 0) (Action_Post= i 1))
=======
				   	(|| ([=] (-V- Action_Pre i) 0) ([=] (-V- Action_Pre i) 1))
				   	(|| ([=] (-V- Action_SafetyPro i) 0) ([=] (-V- Action_SafetyPro i) 1))
				    (|| ([=] (-V- Action_Post i) 0) ([=] (-V- Action_Post i) 1))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
				)
			)

	 	)
<<<<<<< HEAD


	 	(Somf 
	 		(-E- i actions-indexes
				(actions-status= i pause)
		 	)
	 	)

	 	; (somf 
	 	; 	(-E- i actions-indexes
	 	; 		(&& (actions-status= i executing) (yesterday (actions-status= i executing)))
	 	; 	)
 		; )
 		
 		(somf 
	 		(-A- i actions-indexes
	 			(actions-status= i done))
 		)
	 	
=======
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
	 	
	)
)

(defconstant *sys* 
 	(yesterday
 		(&&
 			Init

<<<<<<< HEAD
 			;Operator 
 			*Operator_Body*

 			;;Robot		 
=======
 			;;Layout
 			 ; *adj*

 			;Operator 
 			*Operator_Body*

 			; ;;Robot		 
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
 			*Robot_Structure*

 			;;Hazards
 			 (alwf Hazards)

<<<<<<< HEAD
=======
 			;;Operator 
 			*Operator_Body*

 			;;Robot		 
 			*Robot_Structure*

 			; ;;Hazards
 			 (alwf Hazards)
 			; ; ; (alwf riskEstimation)
 		
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
 			; ; ;;Task
    		(alwf *ActionInit*)
    		(alwf *SeqAction*)
	   		(alwf *Action1*)
	   		(alwf *Action2*)
	   		(alwf *Action3*)
	   		(alwf *Action4*)
	   		(alwf *Action5*)
	   		(alwf *Action6*)

	   		(alwf (Action7 7))
 			(alwf (Action8 8))
 			(alwf (Action9 9))
 			(alwf (Action10 10))
 			(alwf (Action11 11))
 			(alwf (Action12 12))
 			
 			(alwf (ActionBeforeLast 13))
 			(alwf (ActionLast 14))
<<<<<<< HEAD
			(!! noHazard)
=======

>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

 			; (alwf (Action7 13))
 			; (alwf (Action8 14))
 			; (alwf (Action9 15))
 			; (alwf (Action10 16))
 			; (alwf (Action11 17))
 			; (alwf (Action12 18))
 			; (alwf (ActionBeforeLast 19))
 			; (alwf (ActionLast 20))
	   		
	   		

	   		)	
		  )
	 	)
	 



<<<<<<< HEAD
(sbvzot:zot TSPACE 
=======
(ae2sbvzot:zot TSPACE 
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
	(&&
		*sys*
		; (!! noHazard)

		
	)
 )
