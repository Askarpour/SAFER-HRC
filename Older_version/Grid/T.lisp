	
;;	screw driving Parameters
	; (defvar parts 1)
	; (defvar parts_indexes (loop for i from 1 to parts collect i))
	; (defvar jigs 1)
	; (defvar jigs_indexes (loop for i from 0 to (- jigs 1) collect i))
	; (defvar tasks_indexes (loop for i from 0 to 3 collect i))
	; (defvar iteration_index 0)		
;; Task Parameters
	; actions(i 1 l) -->status
	; actions(i 2 l) -->exeTime
	; actions(i 3 l) -->subject

	(define-tvar actions *int* *int* *int* *int*)
	(define-tvar Action_Pre *int* *int* *int*)
	(define-tvar Action_Post *int* *int* *int*)

	; (defvar actions-indexes (loop for i from 1 to (+ 8 (* 6 jigs)) collect i))
	
	;;Statuses
		(defvar notstarted 0)
		(defvar waiting 1)
		(defvar executing 2) 
		(defvar exrm 3)
		(defvar hold 4)
		(defvar done 5)
		(defvar exitt 6)
	
		(defvar exetime 3)
	;subject identifier
	
		(defconstant operator 1)
		(defconstant robot 2)

(defconstant *SeqAction*
 (alw
  (-A- i actions-indexes
  	(-A- l tasks_indexes
 	 (&&

       	([>=] (-V- actions i 1 l) 0) 
       	([<=] (-V- actions i 1 l) 6)
  
       	;;robt actions do not have waiting state
       	(->
       		([=] (-V- actions i 3 l) robot) 
       		(!! ([=] (-V- actions i 1 l) 1))
   		)
       	
      	;;exit
      	(->
      		(&& (!!([=] (-V- actions i 1 l) exitt)) (next([>] (-V- Risk 1) Threshold)))
      		(next ([=] (-V- actions i 1 l) exitt))

  		)
      	;;other states rather than exit
  		(->
      		(&& (!!([=] (-V- actions i 1 l) exitt)) (next([<=] (-V- Risk 1) Threshold)))
      		(next (!!([=] (-V- actions i 1 l) exitt)))

  		)

  		;;ns
  		(->
	       	([=] (-V- actions i 1 l) notstarted)
	       	(&&
		        (alwp (|| ([=] (-V- actions i 1 l) notstarted) ([=] (-V- actions i 1 l) waiting)))
		       	([=] (-V- Action_Pre i l) 0)
		       	(next (|| ([=] (-V- actions i 1 l) notstarted) ([=] (-V- actions i 1 l) waiting) ([=] (-V- actions i 1 l) executing)))

	       	)
	    )
	    		;;ns to exe 
	    		(->
	    				(&& ([=] (-V- actions i 1 l) notstarted) ([=] (-V- actions i 3 l) robot) (next ([=] (-V- Action_Pre i l) 1)))
	    				(next ([=] (-V- actions i 1 l) executing))
    			)

	    ;;waiting
	    (->
	    	([=] (-V- actions i 1 l) waiting)
	    	(&&
	    		([=] (-V- actions i 3 l) operator)
	    		(!! (-P- OpActs)) 
	    		([=] (-V- Action_Pre i l) 1)
			   (alwp (||([=] (-V- actions i 1 l) notstarted) ([=] (-V- actions i 1 l) waiting)))
			   	(next (|| ([=] (-V- actions i 1 l) waiting) ([=] (-V- actions i 1 l) executing)))
	       )	

		)

				;;waiting to ns
				(->
					(&& ([=] (-V- actions i 1 l) waiting) (next ([=] (-V- Action_Pre i l) 0)))
					(next ([=] (-V- actions i 1 l) notstarted))
				)
				;;ns to waiting 
				(->
					(&& ([=] (-V- actions i 1 l) notstarted) ([=] (-V- actions i 3 l) operator) (next ([=] (-V- Action_Pre i l) 1)))
					(next ([=] (-V- actions i 1 l) waiting))
				)

				;;waiting to exe
				(->
					(&& ([=] (-V- actions i 1 l) waiting) (next (&& ([=] (-V- Action_Pre i l) 1) (-P- OpActs))))
					(next ([=] (-V- actions i 1 l) executing))
				)

	    ;;exe
    	(-> 
    		 
    		([=] (-V- actions i 1 l) executing)
    		(&&
          		([=] (-V- Action_Post i l) 0)
          		(!! (-E- k RRM-indexes
          				([=](-V- RRM k) on)

          			)
          		)
          			(next (!!(|| ([=] (-V- actions i 1 l) notstarted) ([=] (-V- actions i 1 l) waiting))))
             )
		)
				;;exe to done
				(->
					(&& 
						([=] (-V- actions i 1 l) executing) (next (&& ([=] (-V- Action_Post i l) 0) (!! (-E- k RRM-indexes  ([=](-V- RRM k) on))))))
					(next ([=] (-V- actions i 1 l) done))
				)

				;;exe to hold
				(->
					(&&
						([=] (-V- actions i 1 l) executing) (next (-P- hold)))
					(next ([=] (-V- actions i 1 l) hold))
				)

				;;exe to exrm
				(->
					(&& 
						([=] (-V- actions i 1 l) executing) 
						(next 
							(&& 
								(-E- k RRM-indexes  ([=](-V- RRM k) on))
								(!! (-P- hold))
								([=] (-V- Action_Post i l) 0) 
							)
						)
					)
					(next ([=] (-V- actions i 1 l) exrm))
				)
	    ;;exrm

	    (-> 
    		 
    		([=] (-V- actions i 1 l) exrm)
    		(&&
          		([=] (-V- Action_Post i l) 0)
          		(!! (-P- hold))
          		(-E- k RRM-indexes
          				([=](-V- RRM k) on)
  				)
  				(next (!!(|| ([=] (-V- actions i 1 l) notstarted) ([=] (-V- actions i 1 l) waiting))))
             )
		)

				;exrm to exe
				(->
					(&& 
						([=] (-V- actions i 1 l) exrm)
						(next
						 	(&& 
						 		([=] (-V- Action_Post i l) 0)
						 		(!!
						 			(-E- k RRM-indexes 
						 				([=](-V- RRM k) on)
					 				)
				 				)
						 	)
					 	)
				 	)
				 	(next ([=] (-V- actions i 1 l) executing))
				)

				;;exrm to done
				(->
					(&& 
						([=] (-V- actions i 1 l) exrm)
						(next 
							(&&
								([=] (-V- Action_Post i l) 1)
						 		(!!(-E- k RRM-indexes
          						([=](-V- RRM k) on)
  								))
							)
						)
					)

					(next ([=] (-V- actions i 1 l) done))

				)
				;;exrm to hold
				(->

					(&&	([=] (-V- actions i 1 l) exrm) (next (-P- hold)))
					(next ([=] (-V- actions i 1 l) hold))
						
				)


	    ;;hold

	    (-> 
    		 
    		([=] (-V- actions i 1 l) hold)
    		(&&
          		(-P- hold)
          		(!!(-E- k RRM-indexes
          				([=](-V- RRM k) on)
  				))
  				(Yesterday (|| ([=] (-V- actions i 1 l) executing) ([=] (-V- actions i 1 l) hold)))
  				(next (!!(|| ([=] (-V- actions i 1 l) notstarted) ([=] (-V- actions i 1 l) waiting) ([=] (-V- actions i 1 l) done))))
             )
		)
				;;hold to exe
				(->
					(&&([=] (-V- actions i 1 l) hold)
						(next (&&
							(!!(-P- hold)) 
							(!!(-E- k RRM-indexes
          						([=](-V- RRM k) on)
  								)))
							))
					(next ([=] (-V- actions i 1 l) hold))

					)

				;;hold to exrm
				(->
					(&&([=] (-V- actions i 1 l) hold)
						(next (&&
							(!!(-P- hold)) 
							(-E- k RRM-indexes
          						([=](-V- RRM k) on)
  								))
							))
					(next ([=] (-V- actions i 1 l) hold))

					)


	    ;;done
	    (->
	    	([=] (-V- actions i 1 l) done)
	    	(&&
	    		(alwf ([=] (-V- actions i 1 l) done))
	    		(Yesterday (|| ([=] (-V- actions i 1 l) executing) ([=] (-V- actions i 1 l) exrm)))
    		)

    	)

	    ;;exit
	    (->
	    	([=] (-V- actions i 1 l) exitt)
	    	(alwf ([=] (-V- actions i 1 l) exitt))

    	)
	)
   )
  )
 )
)

