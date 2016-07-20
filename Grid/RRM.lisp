
	; things to export
(defvar Threshold 1)
(define-tvar Risk *int* *int*) ;;max risk in the system

	(define-tvar RRM *int* *int*)
	(defvar RRMnum 10)
	(defvar RRM-indexes (loop for i from 0 to RRMnum collect i))

	(defvar on 1)
	(defvar off 0)
	
(defconstant *RRMProperties*
	(alw
	  	(-A- k RRM-indexes
	  		(&&
			  	([<=](-V- RRM k) on)
				([>=](-V- RRM k) off)
    	
		    	([>=] (-V- Risk k) 0) 
				([<=] (-V- Risk k) 2)

				(-A- i hazards-indexes

						([>=] (-V- Risk k) (-V- hazards i 4))
		      	)
  	  )
    )
  )
)
