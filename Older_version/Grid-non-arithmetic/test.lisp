(asdf:operate 'asdf:load-op 'sbvzot)
(use-package :trio-utils)
(defvar TSPACE 30)
(defvar arr_indexes (loop for i from 1 to 11 collect i))
(define-array arr arr_indexes '(1 2 3 4 5 6 7 8 9))
(define-item LINK1_Position '(1 2 3 4 5 6 7 8 9))
; (define-tvar arr *int* *int*)
(defvar Init 
	(&& 

		(!! (-P- x))
		(!! (-P- y))
		; (alw ([=] (-V- arr 0) 1))
		(->
			(LINK1_Position= 3) 
			(-P- juju)
		)
	 	
	)
)



(defconstant *sys* 
 	(yesterday
 		(&&
 			Init
 			
 			
	   		

	   		)	
		  )
	 	)
	 
(sbvzot:zot TSPACE 
	(&&
		*sys*
		; (!! noHazard)

		
	)
 )
