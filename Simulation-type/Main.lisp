(asdf:operate 'asdf:load-op 'ae2zot)
(use-package :trio-utils)
(defvar TSPACE 30)


(load "Task.lisp")
(load "O.lisp")
(load "R.lisp")
(load "L.lisp")
(load "RW.lisp")
(load "RMs.lisp")





(defvar Init 
	(&& 
		(-P- idle)
	 	([=] (-V- preparedJigs) 0)

	    ([=] (-V- roZone) 0)

	   
		

	   ; (InBin 1200 200)


	    ; (-A- i actions-indexes
		   ; 			(somf ([=] (-V- actions i 1) done))
	   	; )


	   	; (-A- i actions-indexes
		   ; 			 ([=] (-V- actions i 0) 0)
	   	; )
 	)
)

(defconstant *sys* 
 	(yesterday
 		(&&
 			Init

 			;;Layout
 			*partStatus*
 			
 			;;Operator
 			; *OperatorInit*
 		; 	*Anatomy_X*
 		; 	*Anatomy_Y*

 		; 	;;Robot
 		; 	 
 			 ; *Robot_Idle*
 		; 	 *whenRobotIsMoving*
 		; 	 *whenRobotIsMovingForward*
 		; 	 *whenRobotIsScrewing*
 		; 	 *whenRobotIsMovingBackward*
 		; 	; *whenClampingIsPossible*
			; *RelativeVelocityCheck*

 		; 	;;Actions
   ;  		(alwf *LayOutSegments*)
   ;  		(alwf *ActionInit*)
   ;  		(alwf *SeqAction*)
	  ;  		(alwf *Action1*)
	  ;  		(alwf *Action2*)
	  ;  		(alwf *Action3*)
	  ;  		(alwf *Action4*)
	  ;  		(alwf *Action5*)
	  ;  		(alwf *Action6*)
	  ;  		(alwf *Action7*)
	  ;  		(alwf *Action8*)
	  ;  		(alwf *Action9*)
	  ;  		(alwf *Action10*)
	  ;  		(alwf *Action12*)
	  ;  		(alwf *Action13*)
	  ;  		;; (alwf *ActionEndIt*)

	 		
	  )
 	)
 )



(ae2zot:zot TSPACE 
	(&&
		*sys*
	;	(!! *PT1*)	
	
		
	)
 )
