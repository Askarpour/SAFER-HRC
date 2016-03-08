(asdf:operate 'asdf:load-op 'ae2bvzot)
(use-package :trio-utils)
(defvar TSPACE 15)



(load "L.lisp")
(load "O.lisp")
(load "R.lisp")
(load "Task.lisp")
(load "RMs.lisp")



(defvar Init 
	(&& 

		(!! (-P- partFixed))
		(!! (-P- partTaken))
		(somf (-P- partFixed))
		
	   	(-A- i actions-indexes
		   			 ([=] (-V- actions i 1) 0)
	   	)


		   	(-A- i actions-indexes
			   			 (somf ([=] (-V- actions i 1) 5))
		   	)
 	)
)

(defconstant *sys* 
 	(yesterday
 		(&&
 			Init
 			


 			;;Operator 
 			*Operator_Body*

 	

 			;;Robot
 			 
 			 *Robot_Structure*

 			 
		 ; ;	(-A- i parts_indexes
 		
	 			;;Task
	    		(alwf *ActionInit*)
	    		(alwf *SeqAction*)

	    			;;Loop
			   		(alwf *Action1*)
			   		(alwf *Action2*)
			   		(alwf *Action3*)
			   		(alwf *Action4*)
			   		(alwf *Action5*)
			   		(alwf *Action6*)
			   		

		   		(alwf *LoopManager*)
		   		(alwf *ActionBeforeLast*)
		   		(alwf *ActionLast*)
	   		)	
		  )
	 	)
	 



(ae2bvzot:zot TSPACE 
	(&&
		*sys*
	
		
	)
 )
