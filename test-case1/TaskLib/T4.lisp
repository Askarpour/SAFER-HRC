;;Robot changes the tool

; (defvar T4 4)
; (defvar actions4-indexes (loop for i from 1 to 2 collect i))

(defconstant SeqAction4
  (-A- i actions4-indexes
 	 (alw (&&
 	 	([>=] (-V- actions i 1 T4) 0) 
       	([<=] (-V- actions i 1 T4) 7)

       	([>=] (-V- Action_Pre i T4) 0) 
       	([<=] (-V- Action_Pre i T4) 1)

       	([>=] (-V- Action_Post i T4) 0) 
       	([<=] (-V- Action_Post i T4) 1)
  
       	;robot actions do not have waiting state
       	(->
       		([=] (-V- actions i 3 T4) robot) 
       		(!! ([=] (-V- actions i 1 T4) 1))
   		)
   		(->
   			(&& ([=] (-V- actions i 3 T4) robot) (||([=] (-V- actions i 1 T4) executing) ([=] (-V- actions i 1 T4) exrm)))
   			(!!(-P- Robot_Idle))
		)
  		
  		;;ns
  		(<->
	       	([=] (-V- actions i 1 T4) notstarted)
	       	(&&
		        (alwp (|| ([=] (-V- actions i 1 T4) notstarted) ([=] (-V- actions i 1 T4) waiting)))
		       	([=] (-V- Action_Pre i T4) 0)
		       	(next (|| ([=] (-V- actions i 1 T4) notstarted) ([=] (-V- actions i 1 T4) waiting) ([=] (-V- actions i 1 T4) executing)))

	       	)
	    )
	    		;;ns to exe 
	    		(->
	    				(&& ([=] (-V- actions i 1 T4) executing) (Yesterday ([=] (-V- actions i 1 T4) notstarted)))
	    				([=] (-V- Action_Pre i T4) 1)
	    				
    			)
    			
    			(->
	    				(&& ([=] (-V- actions i 1 T4) notstarted) ([=] (-V- actions i 3 T4) robot) (next ([=] (-V- Action_Pre i T4) 1)))
	    				(next ([=] (-V- actions i 1 T4) executing))
    			)

	    ;;waiting
	    (->
	    	([=] (-V- actions i 1 T4) waiting)
	    	(&&
	    		([=] (-V- actions i 3 T4) operator)
	    		(!! (-P- OpActs)) 
	    		([=] (-V- Action_Pre i T4) 1)
			    (alwp (||([=] (-V- actions i 1 T4) notstarted) ([=] (-V- actions i 1 T4) waiting)))
	       )	

		)

				
				;;waiting to ns
				(->
					(&& (Yesterday ([=] (-V- actions i 1 T4) waiting)) ([=] (-V- actions i 1 T4) notstarted))
					(|| ([=] (-V- Action_Pre i T4) 0) (withinp_ie (!! (-P- OpActs)) delta))
					 
				)

				(->
					(&& ([=] (-V- actions i 1 T4) waiting) (withinp_ei (!! (-P- OpActs)) delta))
					(next ([=] (-V- actions i 1 T4) notstarted))
					 
				)

				;;ns to waiting 
				(->
					(&& (Yesterday([=] (-V- actions i 1 T4) notstarted)) ([=] (-V- actions i 1 T4) waiting))
					([=] (-V- Action_Pre i T4) 1)
					
				)

				(->
					(&& (Yesterday ([=] (-V- actions i 1 T4) notstarted)) ([=] (-V- actions i 3 T4) operator) ([=] (-V- Action_Pre i T4) 1))
					([=] (-V- actions i 1 T4) waiting)
				)
				(->
					(&& (Yesterday([=] (-V- actions i 1 T4) notstarted)) ([=] (-V- actions i 3 T4) robot) ([=] (-V- Action_Pre i T4) 1))
					 ([=] (-V- actions i 1 T4) executing)
				)

				;;waiting to exe
				(->
					(&& (Yesterday([=] (-V- actions i 1 T4) waiting)) ([=] (-V- actions i 1 T4) executing)) 
					(&& ([=] (-V- Action_Pre i T4) 1) (-P- OpActs))
				)

				(->
					(&& (Yesterday([=] (-V- actions i 1 T4) waiting)) ([=] (-V- Action_Pre i T4) 1) (-P- OpActs)) 
					([=] (-V- actions i 1 T4) executing)
				)
   				

	    ;;exe
    	(-> 
    		 
    		([=] (-V- actions i 1 T4) executing)
    		(&&
          		([=] (-V- Action_Post i T4) 0)
          		(!! (-E- k RRM-indexes
          				([=](-V- RRM k) on)

          			)
          		)
          			(next (!!(|| ([=] (-V- actions i 1 T4) notstarted) ([=] (-V- actions i 1 T4) waiting))))
             )
		)
				;;exe to done
				(->
					(&& (Yesterday ([=] (-V- actions i 1 T4) executing)) ([=] (-V- actions i 1 T4) done))
					(&& ([=] (-V- Action_Post i T4) 1)
					 ; (!! (-E- k RRM-indexes  ([=](-V- RRM k) on)))
					 )
						
				)

				(->
					(&& 
					([=] (-V- actions i 1 T4) executing) (next (&& ([=] (-V- Action_Post i T4) 1) (!! (-E- k RRM-indexes  ([=](-V- RRM k) on))))))
					(next ([=] (-V- actions i 1 T4) done))
				)

				;;exe to hold
				(->
					(&&
						([=] (-V- actions i 1 T4) executing) (next (-P- hold)))
					(next ([=] (-V- actions i 1 T4) hold))
				)

				;;exe to exrm
				(->
					(&& ([=] (-V- actions i 1 T4) exrm) (Yesterday ([=] (-V- actions i 1 T4) executing)))
					(&& 
						(-E- k RRM-indexes  ([=](-V- RRM k) on))
						(!!(-P- hold))
						([=] (-V- Action_Post i T4) 0) 
					)
				 )
	    ;;exrm

	    (-> 
    		 
    		([=] (-V- actions i 1 T4) exrm)
    		(&&
          		([=] (-V- Action_Post i T4) 0)
          		(!! (-P- hold))
          		(-E- k RRM-indexes
          				([=](-V- RRM k) on)
  				)
  				(next (!!(|| ([=] (-V- actions i 1 T4) notstarted) ([=] (-V- actions i 1 T4) waiting))))
             )
		)

				;exrm to exe
				(->
					(&& ([=] (-V- actions i 1 T4) executing) (Yesterday ([=] (-V- actions i 1 T4) exrm)))
					(&& 
				 		([=] (-V- Action_Post i T4) 0)
				 		(!!
				 			(-E- k RRM-indexes 
				 				([=](-V- RRM k) on)
			 				)
		 				)
				 	)
				)

				(->
					(&& (Yesterday ([=] (-V- actions i 1 T4) exrm)) ([=] (-V- Action_Post i T4) 0) (!! (-E- k RRM-indexes ([=](-V- RRM k) on))))				 	
					([=] (-V- actions i 1 T4) executing)
				)

				;;exrm to done
				(->
					(&& ([=] (-V- actions i 1 T4) done) (Yesterday ([=] (-V- actions i 1 T4) exrm)))
						
					(&&	([=] (-V- Action_Post i T4) 1) (!!(-E- k RRM-indexes ([=](-V- RRM k) on))))
				)
				;;exrm to hold
				(->

					(&&	([=] (-V- actions i 1 T4) hold) ([=] (-V- actions i 3 T4) robot) (Yesterday ([=] (-V- actions i 1 T4) exrm)))
					(&& (-P- hold) ([=] (-V- Action_Post i T4) 0))		
				)

	    ;;hold

	    (-> 
    		 
    		([=] (-V- actions i 1 T4) hold)
    		(&&
          		(-P- hold)
          		(!!(-E- k RRM-indexes
          				([=](-V- RRM k) on)
  				))
  				(Yesterday (|| ([=] (-V- actions i 1 T4) executing) ([=] (-V- actions i 1 T4) hold)))
  				(next (!!(|| ([=] (-V- actions i 1 T4) notstarted) ([=] (-V- actions i 1 T4) waiting) ([=] (-V- actions i 1 T4) done))))
             )
		)
				;;hold to exe
				(->
					(&& (Yesterday ([=] (-V- actions i 1 T4) hold)) ([=] (-V- actions i 1 T4) executing)) 
					(&& (!!(-P- hold)) 
						(!!(-E- k RRM-indexes
          						([=](-V- RRM k) on)
						)))
				)
					

				;;hold to exrm
				(->
					(&&([=] (-V- actions i 1 T4) exrm) (Yesterday ([=] (-V- actions i 1 T4) hold)))
					(&&
						(!!(-P- hold)) 
						(-E- k RRM-indexes
      						([=](-V- RRM k) on)
					))
				)


	    ;;done
	    (->
	    	([=] (-V- actions i 1 T4) done)
	    	(&&
	    		(alwf ([=] (-V- actions i 1 T4) done))
	    		(Yesterday (|| ([=] (-V- actions i 1 T4) done) ([=] (-V- actions i 1 T4) executing) ([=] (-V- actions i 1 T4) exrm)))
    		)

    	)

	     ;;exit
	    (->
	    	([=] (-V- actions i 1 T4) exitt)
	    	(&&
	    		(alwf ([=] (-V- actions i 1 T4) exitt))
	    		(Yesterday (|| ([=] (-V- actions i 1 T4) exitt) ([=] (-V- actions i 1 T4) inexitt)))
	    	)
    	)

	   ;;intermediate exit
	    (<->
	    	([=] (-V- actions i 1 T4) inexitt)
	    	(&& 
	    		([>] (-V- Risk) Threshold)
	    		(Yesterday (!! ([>] (-V- Risk) Threshold)))
	    		(next (!! ([=] (-V- actions i 1 T4) inexitt)))
	    	)
    	)
    	;;inexit to exit
   		(->
	  		(&& ([>] (-V- Risk) Threshold) (Yesterday ([=] (-V- actions i 1 T4) inexitt)))
	  		([=] (-V- actions i 1 T4) exitt)
		)
		;;anything to inexit
      	(->
      		(&& (Yesterday (!!([=] (-V- actions i 1 T4) inexitt))) ([=] (-V- actions i 1 T4) inexitt))
			(&& ([>] (-V- Risk) Threshold) (Yesterday (!!([>] (-V- Risk) Threshold))))
  		)

  		(-> ;;inexit to anything
      		(&& (Yesterday ([=] (-V- actions i 1 T4) inexitt)) (!!([>] (-V- Risk) Threshold)))
			(&& (!!([=] (-V- actions i 1 T4) inexitt)) (!!([=] (-V- actions i 1 T4) exitt)))
  		)
	  )
	)
  )
)


(defconstant *ActionInitT4*
	(alw (&&
		(->
			(-P- Robot_Idle)
			(!! (-E- i actions4-indexes (&& ([=] (-V- actions i 3 T4) robot) (||([=] (-V- actions i 1 T4) executing) ([=] (-V- actions i 1 T4) exrm)))))

		)

		  (-A- i actions4-indexes
	 	   ([=] (-V- actions i 2 T4) 3))
			 ; Initialization of subject
 	 		 ([=] (-V- actions 1 3 T4) robot)
 	 		 ([=] (-V- actions 2 3 T4) robot)

		;;robot goes to L_6
		(->
			([=] (-V- Action_Pre 1 T4) 1)
			(&& 
				(-P- Robot_Homing) 
				(!!(||([=](-V- Body_Part_pos hand) L_5_1) ([=](-V- Body_Part_pos hand) L_0)))
			)
		)

		(->
			([=] (-V- Action_Post 1 T4) 1)
			(&& 
				(-P- Robot_Homing) 
				(!!(||([=](-V- Body_Part_pos hand) L_5_1) ([=](-V- Body_Part_pos hand) L_0)))
			)
		)


		;;robot changes the tool(tool)
		(->
			([=] (-V- Action_Pre 2 T4) 1)
			(&&
			(||([=](-V- Body_Part_pos hand) L_5_1) ([=](-V- Body_Part_pos hand) L_0))
			([=] (-V- actions 1 1 T4) done))
		)

		; (<->
		; 	([=] (-V- Action_Post 2 T4) 1)
		; 	;;
		; ;;	which part should be taken 
		; )
	)
  )
)


(defconstant configT4
   (alwf (&&
	SeqAction4
	*ActionInitT4*
	)
))
	 
(defconstant noCallT4
   (alwf (&&

		([=] (-V- actions 1 1 T4) notstarted)
		([=] (-V- actions 2 1 T4) notstarted)
	)
))
 ; (format t "****~S****" (T4 0))

