<<<<<<< HEAD
(asdf:operate 'asdf:load-op 'ae2sbvzot)
=======
(asdf:operate 'asdf:load-op 'ae2bvzot)
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
(use-package :trio-utils)
(defvar TSPACE 50)

(load "L.lisp")
<<<<<<< HEAD
(load "R.lisp")
(load "O.lisp")
(load "Task-nop.lisp")
(load "RRM.lisp")
(load "Hazards.lisp")
(load "Properties.lisp")
=======
(load "O.lisp")
(load "R.lisp")
(load "Task-nop.lisp")
(load "RRM.lisp")
(load "Hazards.lisp")
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2



(defvar Init 
	(&& 

		(!! (-P- partFixed))
		(!! (-P- partTaken))
		(-P- Robot_Homing)
		(somf (-P- partFixed))
		
		
	   	(-A- i actions-indexes
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
	   	 
<<<<<<< HEAD
	   	 (somf (&& ([!=](-V- Body_Part_pos head) L_1) ([=] (-V- actions 6 1) executing)))
	   	 (somf (&& ([!=](-V- Body_Part_pos head) L_1) ([=] (-V- actions 7 1) executing)))
	   	 (somf (&& ([!=](-V- Body_Part_pos belly) L_1) ([=] (-V- actions 8 1) executing)))
=======
	   	 (somf (&& ([!=](-V- Body_Part head) L_1) ([=] (-V- actions 6 1) executing)))
	   	 (somf (&& ([!=](-V- Body_Part head) L_1) ([=] (-V- actions 7 1) executing)))
	   	 (somf (&& ([!=](-V- Body_Part belly) L_1) ([=] (-V- actions 8 1) executing)))
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2


		(alwf 
			(-A- i actions-indexes
				(&&

				   	(|| ([=] (-V- Action_Pre i) 0) ([=] (-V- Action_Pre i) 1))
				   	(|| ([=] (-V- Action_SafetyPro i) 0) ([=] (-V- Action_SafetyPro i) 1))
				    (|| ([=] (-V- Action_Post i) 0) ([=] (-V- Action_Post i) 1))
				)
			)

	 	)
	 	
	)
)

(defconstant *sys* 
 	(yesterday
 		(&&
 			Init

<<<<<<< HEAD
 			; ;;Layout
 			;  *adjacencies*

 			;Operator 
 			*Operator_Body*

 			; ;;Robot		 
 			*Robot_Structure*

 			;;Hazards
 			 (alwf Hazards)

 			

 		
 			;;Task
=======
 			;;Operator 
 			*Operator_Body*

 			;;Robot		 
 			*Robot_Structure*

 			; ;;Hazards
 			 (alwf Hazards)
 			; ; ; (alwf riskEstimation)
 		
 			; ; ;;Task
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
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
(ae2sbvzot:zot TSPACE 
	(&&
		*sys*
		; (!! noHazard)
=======
(ae2bvzot:zot TSPACE 
	(&&
		*sys*
	
>>>>>>> 4418f41ce45058233940e9541edafc6b68fa44d2
		
	)
 )
