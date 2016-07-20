(asdf:operate 'asdf:load-op 'ae2sbvzot)
(use-package :trio-utils)
(defvar TSPACE 100)

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

	   			 ([=] (-V- actions i 1) notStarted))
	   		
	   	 (somf (&& ([!=](-V- Body_Part_pos head) L_1) ([=] (-V- actions 6 1) executing)))
	   	 (somf (&& ([!=](-V- Body_Part_pos head) L_1) ([=] (-V- actions 7 1) executing)))
	   	 (somf (&& ([!=](-V- Body_Part_pos belly) L_1) ([=] (-V- actions 8 1) executing)))



		(alwf 
			(-A- i actions-indexes
				(&&

				   	(|| ([=] (-V- Action_Pre i) 0) ([=] (-V- Action_Pre i) 1))
				   	(|| ([=] (-V- Action_SafetyPro i) 0) ([=] (-V- Action_SafetyPro i) 1))
				    (|| ([=] (-V- Action_Post i) 0) ([=] (-V- Action_Post i) 1))
				)
			)


	 	)
	 	(Somf 
	 		(-E- i actions-indexes
				([=] (-V- actions i 1) pause)
		 	)
	 	)

	 	; (somf 
	 	; 	(-E- i actions-indexes
	 	; 		(&& ([=] (-V- actions i 1) executing) (yesterday ([=] (-V- actions i 1) executing)))
	 	; 	)
 		; )
 		(somf 
	 		(-A- i actions-indexes
	 			([=] (-V- actions i 1) done))
 		)
 	)
	
)

(defconstant *sys* 
 	(yesterday
 		(&&
 			Init

 			;;Layout
 			 ; *adj*

 			;Operator 
 			*Operator_Body*

 			; ;;Robot		 
 			*Robot_Structure*

 			;;Hazards
 			 (alwf Hazards)
 		
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
	 



(ae2sbvzot:zot TSPACE 
	(&&
		*sys*
		; (!! noHazard)

		
	)
 )
