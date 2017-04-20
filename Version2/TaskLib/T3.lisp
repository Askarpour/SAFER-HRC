;;Operator changes the tool

; (defvar T3 3)
; (defvar actions3-indexes (loop for i from 1 to 2 collect i))

(defconstant SeqAction3
  (-A- i actions3-indexes
 	 (alw (&&
 	 	([>=] (-V- actions i 1 T3) 0)
       	([<=] (-V- actions i 1 T3) 7)

       	([>=] (-V- Action_Pre i T3) 0)
       	([<=] (-V- Action_Pre i T3) 1)

       	([>=] (-V- Action_Post i T3) 0)
       	([<=] (-V- Action_Post i T3) 1)

       	;robot actions do not have waiting state
       	(->
       		([=] (-V- actions i 3 T3) robot)
       		(!! ([=] (-V- actions i 1 T3) 1))
   		)
   		(->
   			(&& ([=] (-V- actions i 3 T3) robot) (||([=] (-V- actions i 1 T3) executing) ([=] (-V- actions i 1 T3) exrm)))
   			(!!(-P- Robot_Idle))
		)

  		;;ns
  		(<->
	       	([=] (-V- actions i 1 T3) notstarted)
	       	(&&
		        (alwp (|| ([=] (-V- actions i 1 T3) notstarted) ([=] (-V- actions i 1 T3) waiting)))
		       	([=] (-V- Action_Pre i T3) 0)
		       	(next (|| ([=] (-V- actions i 1 T3) notstarted) ([=] (-V- actions i 1 T3) waiting) ([=] (-V- actions i 1 T3) executing)))

	       	)
	    )
	    		;;ns to exe
	    		(->
	    				(&& ([=] (-V- actions i 1 T3) executing) (Yesterday ([=] (-V- actions i 1 T3) notstarted)))
	    				([=] (-V- Action_Pre i T3) 1)

    			)

    			(->
	    				(&& ([=] (-V- actions i 1 T3) notstarted) ([=] (-V- actions i 3 T3) robot) (next ([=] (-V- Action_Pre i T3) 1)))
	    				(next ([=] (-V- actions i 1 T3) executing))
    			)

	    ;;waiting
	    (->
	    	([=] (-V- actions i 1 T3) waiting)
	    	(&&
	    		([=] (-V- actions i 3 T3) operator)
	    		(!! (-P- OpActs))
	    		([=] (-V- Action_Pre i T3) 1)
			   	(alwp (||([=] (-V- actions i 1 T3) notstarted) ([=] (-V- actions i 1 T3) waiting)))
	       )

		)


				;;waiting to ns
				(->
					(&& (Yesterday ([=] (-V- actions i 1 T3) waiting)) ([=] (-V- actions i 1 T3) notstarted))
					(|| ([=] (-V- Action_Pre i T3) 0) (withinp_ie (!! (-P- OpActs)) delta))

				)

				(->
					(&& ([=] (-V- actions i 1 T3) waiting) (withinp_ei (!! (-P- OpActs)) delta))
					(next ([=] (-V- actions i 1 T3) notstarted))

				)

				;;ns to waiting
				(->
					(&& (Yesterday([=] (-V- actions i 1 T3) notstarted)) ([=] (-V- actions i 1 T3) waiting))
					([=] (-V- Action_Pre i T3) 1)

				)

				(->
					(&& (Yesterday ([=] (-V- actions i 1 T3) notstarted)) ([=] (-V- actions i 3 T3) operator) ([=] (-V- Action_Pre i T3) 1))
					([=] (-V- actions i 1 T3) waiting)
				)
				(->
					(&& (Yesterday([=] (-V- actions i 1 T3) notstarted)) ([=] (-V- actions i 3 T3) robot) ([=] (-V- Action_Pre i T3) 1))
					 ([=] (-V- actions i 1 T3) executing)
				)

				;;waiting to exe
				(->
					(&& (Yesterday([=] (-V- actions i 1 T3) waiting)) ([=] (-V- actions i 1 T3) executing))
					(&& ([=] (-V- Action_Pre i T3) 1) (-P- OpActs))
				)

				(->
					(&& (Yesterday([=] (-V- actions i 1 T3) waiting)) ([=] (-V- Action_Pre i T3) 1) (-P- OpActs)) 
					([=] (-V- actions i 1 T3) executing)
				)


	    ;;exe
    	(->

    		([=] (-V- actions i 1 T3) executing)
    		(&&
          		([=] (-V- Action_Post i T3) 0)
          		(!! (-E- k RRM-indexes
          				([=](-V- RRM k) on)

          			)
          		)
          			(next (!!(|| ([=] (-V- actions i 1 T3) notstarted) ([=] (-V- actions i 1 T3) waiting))))
             )
		)
				;;exe to done
				(->
					(&& (Yesterday ([=] (-V- actions i 1 T3) executing)) ([=] (-V- actions i 1 T3) done))
					(&& ([=] (-V- Action_Post i T3) 1)
					 ; (!! (-E- k RRM-indexes  ([=](-V- RRM k) on)))
					 )
				)

				(->
					(&& 
					([=] (-V- actions i 1 T3) executing) (next (&& ([=] (-V- Action_Post i T3) 1) (!! (-E- k RRM-indexes  ([=](-V- RRM k) on))))))
					(next ([=] (-V- actions i 1 T3) done))
				)

				;;exe to hold
				(->
					(&&
					([=] (-V- actions i 1 T3) executing) ([=] (-V- actions i 3 T3) robot) (next(-P- hold)))
					(next([=] (-V- actions i 1 T3) hold))
				)

				;;exe to exrm
				(->
					(&& ([=] (-V- actions i 1 T3) exrm) (Yesterday ([=] (-V- actions i 1 T3) executing)))
					(&&
						(-E- k RRM-indexes  ([=](-V- RRM k) on))
						(!!(-P- hold))
						([=] (-V- Action_Post i T3) 0)
					)
				 )
	    ;;exrm

	    (->

    		([=] (-V- actions i 1 T3) exrm)
    		(&&
          		([=] (-V- Action_Post i T3) 0)
          		(!! (-P- hold))
          		(-E- k RRM-indexes
          				([=](-V- RRM k) on)
  				)
  				(next (!!(|| ([=] (-V- actions i 1 T3) notstarted) ([=] (-V- actions i 1 T3) waiting))))
             )
		)

				;exrm to exe
				(->
					(&& ([=] (-V- actions i 1 T3) executing) (Yesterday ([=] (-V- actions i 1 T3) exrm)))
					(&&
				 		([=] (-V- Action_Post i T3) 0)
				 		(!!
				 			(-E- k RRM-indexes
				 				([=](-V- RRM k) on)
			 				)
		 				)
				 	)
				)

				(->
					(&& (Yesterday ([=] (-V- actions i 1 T3) exrm)) ([=] (-V- Action_Post i T3) 0) (!! (-E- k RRM-indexes ([=](-V- RRM k) on))))				 	
					([=] (-V- actions i 1 T3) executing)
				)

				;;exrm to done
				(->
					(&& ([=] (-V- actions i 1 T3) done) (Yesterday ([=] (-V- actions i 1 T3) exrm)))

					(&&	([=] (-V- Action_Post i T3) 1) (!!(-E- k RRM-indexes ([=](-V- RRM k) on))))
				)
				;;exrm to hold
				(->

					(&&	([=] (-V- actions i 1 T3) hold) ([=] (-V- actions i 3 T3) robot) (Yesterday ([=] (-V- actions i 1 T3) exrm)))
					(&& (-P- hold) ([=] (-V- Action_Post i T3) 0))		
				)

	    ;;hold

	    (->

    		([=] (-V- actions i 1 T3) hold)
    		(&&
          		(-P- hold)
          		(!!(-E- k RRM-indexes
          				([=](-V- RRM k) on)
  				))
  				(Yesterday (|| ([=] (-V- actions i 1 T3) executing) ([=] (-V- actions i 1 T3) hold)))
  				(next (!!(|| ([=] (-V- actions i 1 T3) notstarted) ([=] (-V- actions i 1 T3) waiting) ([=] (-V- actions i 1 T3) done))))
             )
		)
				;;hold to exe
				(->
					(&& (Yesterday ([=] (-V- actions i 1 T3) hold)) ([=] (-V- actions i 1 T3) executing))
					(&& (!!(-P- hold))
						(!!(-E- k RRM-indexes
          						([=](-V- RRM k) on)
						)))
				)


				;;hold to exrm
				(->
					(&&([=] (-V- actions i 1 T3) exrm) (Yesterday ([=] (-V- actions i 1 T3) hold)))
					(&&
						(!!(-P- hold))
						(-E- k RRM-indexes
      						([=](-V- RRM k) on)
					))
				)


	    ;;done
	    (->
	    	([=] (-V- actions i 1 T3) done)
	    	(&&
	    		(alwf ([=] (-V- actions i 1 T3) done))
	    		(Yesterday (|| ([=] (-V- actions i 1 T3) done) ([=] (-V- actions i 1 T3) executing) ([=] (-V- actions i 1 T3) exrm)))
    		)

    	)

	     ;;exit
	    (->
	    	([=] (-V- actions i 1 T3) exitt)
	    	(&&
	    		(alwf ([=] (-V- actions i 1 T3) exitt))
	    		(Yesterday (|| ([=] (-V- actions i 1 T3) exitt) ([=] (-V- actions i 1 T3) inexitt)))
	    	)
    	)

	    ;;intermediate exit
	    (<->
	    	([=] (-V- actions i 1 T3) inexitt)
	    	(&& 
	    		([>] (-V- Risk) Threshold)
	    		(Yesterday (!! ([>] (-V- Risk) Threshold)))
	    		(next (!! ([=] (-V- actions i 1 T3) inexitt)))
	    	)
    	)
    	;;inexit to exit
   		(->
	  		(&& ([>] (-V- Risk) Threshold) (Yesterday ([=] (-V- actions i 1 T3) inexitt)))
	  		([=] (-V- actions i 1 T3) exitt)
		)
		;;anything to inexit
      	(->
      		(&& (Yesterday (!!([=] (-V- actions i 1 T3) inexitt))) ([=] (-V- actions i 1 T3) inexitt))
			(&& ([>] (-V- Risk) Threshold) (Yesterday (!!([>] (-V- Risk) Threshold))))
  		)

  		(-> ;;inexit to anything
      		(&& (Yesterday ([=] (-V- actions i 1 T3) inexitt)) (!!([>] (-V- Risk) Threshold)))
			(&& (!!([=] (-V- actions i 1 T3) inexitt)) (!!([=] (-V- actions i 1 T3) exitt)))
  		)
	  )
	)
  )
)

(defconstant *ActionInitT3*
	(&&
	;only two operator actions concurrently execute
    (->
    	(-E- j actions3-indexes
    		(&&
    			(||([=] (-V- actions j 1 T3) executing) ([=] (-V- actions j 1 T3) exrm))
    			([=] (-V- actions j 3 T3) operator)
				(-E- k actions3-indexes
    				(&& (||([=] (-V- actions k 1 T3) executing) ([=] (-V- actions k 1 T3) exrm)) ([=] (-V- actions k 3 T3) operator) (!! ([=] j k))))
			)
		)
		(!! (-P- OpActs))
	)

	(->
		(-P- Robot_Idle)
		(!! (-E- i actions3-indexes (&& ([=] (-V- actions i 3 T3) robot) (||([=] (-V- actions i 1 T3) executing) ([=] (-V- actions i 1 T3) exrm)))))

	)
		(-A- i actions3-indexes
	 	   ([=] (-V- actions i 2 T3) 3))
			 ; Initialization of subject
 		([=] (-V- actions 1 3 T3) operator)
 		([=] (-V- actions 2 3 T3) operator)

		;;operator goes to L_6
		(->
			([=] (-V- Action_Pre 1 T3) 1)
			(-P- Robot_Homing)
		)

		(<->
			([=] (-V- Action_Post 1 T3) 1)
			(||([=](-V- Body_Part_pos hand) L_5_1) ([=](-V- Body_Part_pos hand) L_0))
		)

		;;operator changes the tool(tool)
		(<->
			([=] (-V- Action_Pre 2 T3) 1)
			(&&
			([=] (-V- actions 1 1 T3) done)
			(||([=](-V- Body_Part_pos hand) L_5_1) ([=](-V- Body_Part_pos hand) L_0)))
		)

		; (<->
		; 	([=] (-V- Action_Post 2 T3) 1)
		; 	;;
		; ;;	which part should be taken
		; )
	)
)

(defconstant  configT3
	 (alwF (&&
		SeqAction3
		*ActionInitT3*
	))
)
(defconstant  nocallT3
	 (alwf (&&
		SeqAction3
		([=] (-V- actions 1 1 T3) notstarted)
   		([=] (-V- actions 2 1 T3) notstarted)
	))
)
