(asdf:operate 'asdf:load-op 'ae2bvzot)
(use-package :trio-utils)
(defvar TSPACE 20)



(load "L.lisp")
(load "O.lisp")
(load "R.lisp")
(load "Task.lisp")
(load "RMs.lisp")





(defvar Init 
	(&& 
		

	   (lasts ([=](-V- ARM1) L_1) 10)
	   (lasts ([=](-V- ARM2) L_2) 10)
	   (withinf_ee ([=](-V- Body_Part 8) L_5) 10)
		

	   
	    ; (-A- i actions-indexes
		   ; 			(somf ([=] (-V- actions i 1) done))
	   	; )

		 ; ([=] (-V- actions 1 1) 0)
	   	; (-A- i actions-indexes
		   ; 			 ([=] (-V- actions i 1) 0)
	   	; )
 	)
)

(defconstant *sys* 
 	(yesterday
 		(&&
 			Init

 			;;Operator 
 			; *Operator_Body*

 	

 			; ;;Robot
 			 
 			;  *Robot_Structure*
 			 

 			;;Task
    		(alwf *ActionInit*)
    		(alwf *SeqAction*)

    			;;Loop
		   		(alwf *Action1*)
		   		(alwf *Action2*)
		   		(alwf *Action3*)
		   		(alwf *Action4*)
		   		(alwf *Action5*)
		   		

		   		(alwf *LoopManager*)
		   		(alwf *Action12*)
		   		(alwf *Action13*)
		   		(alwf *Action14*)

	 		
	  )
 	)
 )



(ae2bvzot:zot TSPACE 
	(&&
		*sys*
	
		
	)
 )
