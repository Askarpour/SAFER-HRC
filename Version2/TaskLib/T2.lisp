;;robot grasps operator screws

(defvar T2 2)
(defvar actions2-indexes (loop for i from 1 to 8 collect i))

; (defconstant SeqAction2
;   (-A- i actions2-indexes
;  	 (alw (&&
;  	 	([>=] (-V- actions i 1 T2) 0) 
;        	([<=] (-V- actions i 1 T2) 7)

;        	([>=] (-V- Action_Pre i T2) 0) 
;        	([<=] (-V- Action_Pre i T2) 1)

;        	([>=] (-V- Action_Pre_L i T2) 0) 
;        	([<=] (-V- Action_Pre_L i T2) 1)

;        	([>=] (-V- Action_Post i T2) 0) 
;        	([<=] (-V- Action_Post i T2) 1)

;        	([>=] (-V- Action_Post_L i T2) 0) 
;        	([<=] (-V- Action_Post_L i T2) 1)

  
;   ;;**************************

;        	([>=] (-V- OpStarts i T2) 0) 
;        	([<=] (-V- OpStarts i T2) 1)
;        	(-> ([=](-V- OpStarts i T2) 1)	([=] (-V- Action_Pre_L i T2) 1))

;        	([>=] (-V- OpStops i T2) 0) 
;        	([<=] (-V- OpStops i T2) 1)

;        	([>=] (-V- actions i 4 T2) normative) 
;        	([<=] (-V- actions i 4 T2) erroneous)

;        	(-A- x err-phenotype-indexes
;        		(&&
; 	       		([>=] (-V- errorA i T2 x) 0) ;no error
; 	       		([<=] (-V- errorA i T2 x) 1) 
;        		)
;    		)
       	
;        	([>=] (-V- errorF i T2) 0) 
;        	([>=] (-V- errorL i T2) 0)

       	
;        	([<=] (-V- errorF i T2) 1) 
;        	([<=] (-V- errorL i T2) 1) 
       	
;        	;;error
;        	(<->
;        		([=] (-V- actions i 4 T2) erroneous)
;        		(|| 
;        			(-E- x err-phenotype-indexes
; 	       			(!!([=] (-V- errorA i T2 x) 0))
;        			)
; 	       		([=] (-V- errorF i T2) 1) 
; 	       		([=] (-V- errorL i T2) 1)
;        		)
;    		)

; 		;;norm
; 		(<->
; 			([=] (-V- actions i 4 T2) normative)
; 			 (&&
; 			 	(-A- x err-phenotype-indexes
; 	       			([=] (-V- errorA i T2 x) 0)
;        			)
; 				([=] (-V- errorF i T2) 0) 
; 				([=] (-V- errorL i T2) 0)
; 			)
; 		   )

; 		(<->
; 			([=] (-V- errorA i T2 repetition) 1)
; 			(&&
; 				([=] (-V- actions i 3 T2) operator)
; 				([=] (-V- actions i 1 T2) done) 
; 				(|| 
; 					([=](-V- OpStarts i T2) 1)
; 					(Yesterday 
; 						(&& 
; 							([=](-V- OpStops i T2) 0) 
; 							(!! ([=] (-V- actions i 1 T2) done))
; 						)
; 					)
; 				)
; 			)
; 		)

; 		(<->
; 			([=] (-V- errorA i T2 Omission) 1)
; 			(&&
; 				([=] (-V- actions i 3 T2) operator)
; 				(AlwF (|| ([=] (-V- actions i 1 T2) notstarted) ([=] (-V- actions i 1 T2) waiting)))
; 				(AlwF ([=](-V- OpStarts i T2) 0))
; 				(SomP (Lasted ([=] (-V- actions i 1 T2) waiting) delta))
; 				; (Lasted ([=] (-V- errorA i T2 Late) 1) 5)
; 				(AlwF ([=] (-V- errorA i T2 Omission) 1))

; 			)
; 		)	

; 		(<->
; 			([=] (-V- errorA i T2 Late) 1)
; 			(&&
; 				([=] (-V- actions i 3 T2) operator)
; 				(SomP 
; 					(Lasted 
; 						(&& 
; 							([=] (-V- actions i 1 T2) waiting) 
; 							([=](-V- OpStarts i T2) 0)
; 						)
; 					 delta)
; 				)
; 				([=](-V- OpStarts i T2) 1)
; 			)
; 		)

; 		(<->
; 			([=] (-V- errorA i T2 early) 1)
; 			(&&
; 				([=] (-V- actions i 3 T2) operator)
; 			   ; (Next 
; 			   	([=] (-V- actions i 1 T2) notstarted)
; 			   	; )
; 			   ([=](-V- OpStarts i T2) 1)	
; 			)
; 		)	

; 		(<->
; 			([=] (-V- errorA i T2 insertion) 1)
; 			(&& 
; 				([=] (-V- actions i 1 T2) waiting) 
; 				(||
; 					(-E- j actions2-indexes
; 						(Yesterday ([=](-V- OpStarts i T1) 1))
; 					)

; 					(-E- j actions3-indexes
; 						(Yesterday ([=](-V- OpStarts i T3) 1))
; 					)

; 					(-E- j actions4-indexes
; 						(Yesterday ([=](-V- OpStarts i T4) 1))
; 					)
; 				)
; 			)
; 		)

; 		(->
; 			([=] (-V- errorF i T2) 1) 
; 			(|| 
; 				([=] (-V- actions i 1 T2) executing)
; 				([=] (-V- actions i 1 T2) exrm)
; 			)
; 		)

;        	(<->
;        		([=] (-V- errorL i T2) 1) 
;        		(||
;        			; (&& ([=] (-V- actions i 1 T2) notstarted) (Yesterday ([=](-V- OpStarts i T2) 1)))
;        			(&& ([=] (-V- actions i 1 T2) hold) (Yesterday (&& ([=](-V- OpStops i T2) 0) (!!([=] (-V- actions i 1 T2) hold)))))
;    			)
; 		)

;        	;;**************************
       	
;        	;robot actions do not have waiting state
;        	(->
;        		([=] (-V- actions i 3 T2) robot) 
;        		(!! ([=] (-V- actions i 1 T2) 1))
;    		)
;    		(->
;    			(&& ([=] (-V- actions i 3 T2) robot) (||([=] (-V- actions i 1 T2) executing) ([=] (-V- actions i 1 T2) exrm)))
;    			(!!(-P- Robot_Idle))
; 		)

;   		;;ns
;   		(<->
; 	       	([=] (-V- actions i 1 T2) notstarted)
; 	       	(&&
; 		        (alwp 
; 		          (|| 
; 		        	([=] (-V- actions i 1 T2) notstarted)
; 		            ([=] (-V- actions i 1 T2) waiting)
; 		          )
; 		        )
; 		       	([=] (-V- Action_Pre i T2) 0)
; 		       	(next (|| ([=] (-V- actions i 1 T2) notstarted) ([=] (-V- actions i 1 T2) waiting) ([=] (-V- actions i 1 T2) executing)))

; 	       	)
; 	    )
; 	    		;;ns to exe 
; 	    		(->
; 	    				(&& ([=] (-V- actions i 1 T2) executing) (Yesterday ([=] (-V- actions i 1 T2) notstarted)))
; 	    				([=] (-V- Action_Pre i T2) 1)
	    				
;     			)

;     			(->
; 	    				(&& ([=] (-V- actions i 1 T2) notstarted) ([=] (-V- actions i 3 T2) robot) (next ([=] (-V- Action_Pre i T2) 1)))
; 	    				(next ([=] (-V- actions i 1 T2) executing))
;     			)

; 	    ;;waiting
; 	    (->
; 	    	([=] (-V- actions i 1 T2) waiting)
; 	    	(&&
; 	    		([=] (-V- actions i 3 T2) operator)
; 	    		; (!! (-P- OpActs)) 
; 	    		; ([=](-V- OpStarts i T2) 0)
; 	    		([=] (-V- Action_Pre i T2) 1)
; 			    (alwp (||([=] (-V- actions i 1 T2) notstarted) ([=] (-V- actions i 1 T2) waiting)))
; 	       )	

; 		)

; 				;;waiting to ns
; 				(->
; 					(&& (Yesterday ([=] (-V- actions i 1 T2) waiting)) ([=] (-V- actions i 1 T2) notstarted))
; 					([=] (-V- Action_Pre i T2) 0)
					 
; 				)
; 				; ;;waiting to ns
; 				; (->
; 				; 	(&& (Yesterday ([=] (-V- actions i 1 T2) waiting)) ([=] (-V- actions i 1 T2) notstarted))
; 				; 	(|| ([=] (-V- Action_Pre i T2) 0) (withinp_ie (!! (-P- OpActs)) delta))
					 
; 				; )

; 				; (->
; 				; 	(&& ([=] (-V- actions i 1 T2) waiting) (withinp_ei (!! (-P- OpActs)) delta))
; 				; 	(next ([=] (-V- actions i 1 T2) notstarted))
					 
; 				; )

; 				;;ns to waiting 
; 				(->
; 					(&& (Yesterday([=] (-V- actions i 1 T2) notstarted)) ([=] (-V- actions i 1 T2) waiting))
; 					([=] (-V- Action_Pre i T2) 1)
					
; 				)

; 				(->
; 					(&& (Yesterday ([=] (-V- actions i 1 T2) notstarted)) ([=] (-V- actions i 3 T2) operator) ([=] (-V- Action_Pre i T2) 1))
; 					([=] (-V- actions i 1 T2) waiting)
; 				)

; 				(->
; 					(&& (Yesterday([=] (-V- actions i 1 T2) notstarted)) ([=] (-V- actions i 3 T2) robot) ([=] (-V- Action_Pre i T2) 1))
; 					 ([=] (-V- actions i 1 T2) executing)
; 				)

; 				;;waiting to exe
; 				(->
; 					(&& (Yesterday([=] (-V- actions i 1 T2) waiting)) ([=] (-V- actions i 1 T2) executing)) 
; 					(&& 
; 						([=] (-V- Action_Pre i T2) 1) 
; 						; (-P- OpActs)
; 						([=](-V- OpStarts i T2) 1)
; 					)
; 				)

;    				(->
; 					(&& (Yesterday([=] (-V- actions i 1 T2) waiting)) ([=] (-V- Action_Pre i T2) 1)
; 					 ; (-P- OpActs)
; 					 ([=](-V- OpStarts i T2) 1)
; 					 ) 
; 					([=] (-V- actions i 1 T2) executing)
; 				)
; 	    ;;exe
;     	(-> 
    		 
;     		([=] (-V- actions i 1 T2) executing)
;     		(&&
;           		([=] (-V- Action_Post i T2) 0)
;           		(!! (-E- k RRM-indexes
;           				([=](-V- RRM k) on)

;           			)
;           		)
;           			(next (!!(|| ([=] (-V- actions i 1 T2) notstarted) ([=] (-V- actions i 1 T2) waiting))))
;              )
; 		)
; 				;;exe to done
; 				(->
; 					(&& (Yesterday ([=] (-V- actions i 1 T2) executing)) ([=] (-V- actions i 1 T2) done))
; 					(&& ([=] (-V- Action_Post i T2) 1)
; 					 ; (!! (-E- k RRM-indexes  ([=](-V- RRM k) on)))
; 					 )					
; 				)

; 				(->
; 					(&& 
; 					([=] (-V- actions i 1 T2) executing) (next (&& ([=] (-V- Action_Post i T2) 1) (!! (-E- k RRM-indexes  ([=](-V- RRM k) on))))))
; 					(next ([=] (-V- actions i 1 T2) done))
; 				)
				
; 				;;exe to hold
; 				(->
; 					(&&
; 					([=] (-V- actions i 1 T2) executing) ([=] (-V- actions i 3 T2) robot) (next(-P- hold)))
; 					(next([=] (-V- actions i 1 T2) hold))
; 				)

; 				;;exe to exrm
; 				(->
; 					(&& ([=] (-V- actions i 1 T2) exrm) (Yesterday ([=] (-V- actions i 1 T2) executing)))
; 					(&& 
; 						(-E- k RRM-indexes  ([=](-V- RRM k) on))
; 						(!!(-P- hold))
; 						([=] (-V- Action_Post i T2) 0) 
; 					)
; 				 )
; 	    ;;exrm

; 	    (-> 
    		 
;     		([=] (-V- actions i 1 T2) exrm)
;     		(&&
;           		([=] (-V- Action_Post i T2) 0)
;           		(!! (-P- hold))
;           		(-E- k RRM-indexes
;           				([=](-V- RRM k) on)
;   				)
;   				(next (!!(|| ([=] (-V- actions i 1 T2) notstarted) ([=] (-V- actions i 1 T2) waiting))))
;              )
; 		)

; 				;;exrm to exe
; 				(->
; 					(&& ([=] (-V- actions i 1 T2) executing) (Yesterday ([=] (-V- actions i 1 T2) exrm)))
; 					(&& 
; 				 		([=] (-V- Action_Post i T2) 0)
; 				 		(!!
; 				 			(-E- k RRM-indexes 
; 				 				([=](-V- RRM k) on)
; 			 				)
; 		 				)
; 				 	)
; 				)

; 				(->
; 					(&& (Yesterday ([=] (-V- actions i 1 T2) exrm)) ([=] (-V- Action_Post i T2) 0) (!! (-E- k RRM-indexes ([=](-V- RRM k) on))))				 	
; 					([=] (-V- actions i 1 T2) executing)
; 				)

; 				;;exrm to done
; 				(->
; 					(&& ([=] (-V- actions i 1 T2) done) (Yesterday ([=] (-V- actions i 1 T2) exrm)))
						
; 					(&&	([=] (-V- Action_Post i T2) 1) (!!(-E- k RRM-indexes ([=](-V- RRM k) on))))
; 				)
; 				;;exrm to hold
; 				(->

; 					(&&	([=] (-V- actions i 1 T2) hold) ([=] (-V- actions i 3 T2) robot) (Yesterday ([=] (-V- actions i 1 T2) exrm)))
; 					(&& (-P- hold) ([=] (-V- Action_Post i T2) 0))		
; 				)

; 	    ;;hold

; 	    (-> 
    		 
;     		([=] (-V- actions i 1 T2) hold)
;     		(&&
;           		(-P- hold)
;           		(!!(-E- k RRM-indexes
;           				([=](-V- RRM k) on)
;   				))
;   				(Yesterday (|| ([=] (-V- actions i 1 T2) executing) ([=] (-V- actions i 1 T2) hold)))
;   				(next (!!(|| ([=] (-V- actions i 1 T2) notstarted) ([=] (-V- actions i 1 T2) waiting) ([=] (-V- actions i 1 T2) done))))
;              )
; 		)
; 				;;hold to exe
; 				(->
; 					(&& (Yesterday ([=] (-V- actions i 1 T2) hold)) ([=] (-V- actions i 1 T2) executing)) 
; 					(&& (!!(-P- hold)) 
; 						(!!(-E- k RRM-indexes
;           						([=](-V- RRM k) on)
; 						)))
; 				)
					

; 				;;hold to exrm
; 				(->
; 					(&&([=] (-V- actions i 1 T2) exrm) (Yesterday ([=] (-V- actions i 1 T2) hold)))
; 					(&&
; 						(!!(-P- hold)) 
; 						(-E- k RRM-indexes
;       						([=](-V- RRM k) on)
; 						)
; 					)
; 				)


; 	    ;;done
; 	    (->
; 	    	([=] (-V- actions i 1 T2) done)
; 	    	(&&
; 	    		(alwf ([=] (-V- actions i 1 T2) done))
; 	    		(Yesterday (|| ([=] (-V- actions i 1 T2) done) ([=] (-V- actions i 1 T2) executing) ([=] (-V- actions i 1 T2) exrm)))
; 	    		(withinp_ie (!! ([=] (-V- actions i 1 T2) hold)) exetime)
;     		)
;     	)

; 	    ;;exit
; 	    (->
; 	    	([=] (-V- actions i 1 T2) exitt)
; 	    	(&&
; 	    		(alwf ([=] (-V- actions i 1 T2) exitt))
; 	    		(Yesterday (|| ([=] (-V- actions i 1 T2) exitt) ([=] (-V- actions i 1 T2) inexitt)))
; 	    	)
;     	)

; 	   ;;intermediate exit
; 	    (<->
; 	    	([=] (-V- actions i 1 T2) inexitt)
; 	    	(&& 
; 	    		([>] (-V- Risk) Threshold)
; 	    		(Yesterday (!! ([>] (-V- Risk) Threshold)))
; 	    		(next (!! ([=] (-V- actions i 1 T2) inexitt)))
; 	    	)
;     	)
;     	;;inexit to exit
;    		(->
; 	  		(&& ([>] (-V- Risk) Threshold) (Yesterday ([=] (-V- actions i 1 T2) inexitt)))
; 	  		([=] (-V- actions i 1 T2) exitt)
; 		)
; 		;;anything to inexit
;       	(->
;       		(&& (Yesterday (!!([=] (-V- actions i 1 T2) inexitt))) ([=] (-V- actions i 1 T2) inexitt))
; 			(&& ([>] (-V- Risk) Threshold) (Yesterday (!!([>] (-V- Risk) Threshold))))
;   		)

;   		(-> ;;inexit to anything
;       		(&& (Yesterday ([=] (-V- actions i 1 T2) inexitt)) (!!([>] (-V- Risk) Threshold)))
; 			(&& (!!([=] (-V- actions i 1 T2) inexitt)) (!!([=] (-V- actions i 1 T2) exitt)))
;   		)
; 	  )
; 	)
;   )
; )

(defconstant *ActionInitT2*
	(alwf (&&

	; 	;only two operator actions concurrently execute
    
 ;    	(-A- j actions2-indexes
 ;    		(-A- k actions2-indexes
 ;    			(->
	; 	    		(&& 
	; 	    			(||([=] (-V- actions j 1 T2) executing) ([=] (-V- actions j 1 T2) exrm))
	; 	    			([=] (-V- actions j 3 T2) operator)
	; 					(&& (||([=] (-V- actions k 1 T2) executing) ([=] (-V- actions k 1 T2) exrm)) ([=] (-V- actions k 3 T2) operator) (!! ([=] j k)))
	; 				)
	; 				; (!! (-P- OpActs))
	; 				(!!(-E- x actions2-indexes 
	; 					(&& 
	; 						(!! ([=] x k))
	; 						(!! ([=] x j))
	; 						([=](-V- OpStarts x T2) 1)
	; 					)
	; 				))	
	; 			)
	; 		)
	; 	)

	; ;;only three erroneous actions at the same time
	; ; (-A- i actions2-indexes
	; 	(-A- j actions2-indexes
	; 	   (-A- k actions2-indexes
	; 		(->
	;     		(&& 
	;     			; ([=] (-V- actions i 4 T2) erroneous)
	;     			([=] (-V- actions j 4 T2) erroneous)
	;     			([=] (-V- actions k 4 T2) erroneous)
	;     			(!! ([=] k j))
	;     			; (!! ([=] i j))
	;     			; (!! ([=] k i))
	; 			)
	; 			(!!
	; 				(-E- x actions2-indexes 
	; 					(&& 
	; 						(!! ([=] x k))
	; 						(!! ([=] x j))
	; 						; (!! ([=] x i))
	; 						([=] (-V- actions x 4 T2) erroneous)
	; 					)
	; 				)
	; 			)	
	; 		)
	; 	)
	;  ; )
	; )	

		(->
			(-P- Robot_Idle)
			(!! (-E- i actions2-indexes (&& ([=] (-V- actions i 3 T2) robot) (||([=] (-V- actions i 1 T2) executing) ([=] (-V- actions i 1 T2) exrm)))))

		)

	  	(-A- i actions2-indexes
	 	   ([=] (-V- actions i 2 T2) 3))

	 	   ; Initialization of subject
	 	(-A- i actions2-indexes
	       (-> (!! (|| ([=] i 6) ([=] i 7))) ([=] (-V- actions i 3 T2) robot)))

	 	(-A- i actions2-indexes
	       (-> (|| ([=] i 6) ([=] i 7)) ([=] (-V- actions i 3 T2) operator)))
	 	  
	 	(->
	 			(||
	 				([=] (-V- actions 6 1 T2) executing)
	 				([=] (-V- actions 7 1 T2) executing)
	 				([=] (-V- actions 6 1 T2) exrm)
	 				([=] (-V- actions 7 1 T2) exrm)

				)
				(|| ([=] (-V- actions 5 1 T2) executing) ([=] (-V- actions 5 1 T2) exrm))
			)
	 	  )
  		)
  	)

;robot moves to the bin
(defconstant *Action1T2*
	(alwf (&&
		(->
			([=] (-V- Action_Pre 1 T2) 1)
			(-P- Robot_Homing)
		)
		

		(->
			([=] (-V- Action_Post 1 T2) 1)
			(&&
				; (!!(-P- partTaken))
				([=](-V- End_Eff_B_Position) L_bin)
			)
		)
		
		(->
			([=] (-V- Action_Post_L 1 T2) 1)
			(&&
				; (!!(-P- partTaken))
				([=](-V- End_Eff_B_Position) L_bin)
			)
		)
	)
))

;;robot grasps the part
(defconstant *Action2T2*
	(alw(&&
		(->
			([=] (-V- Action_Pre 2 T2) 1)
			(&& 
				([=](-V- End_Eff_B_Position) L_bin)
				([=] (-V- actions 1 1 T2) done)
				
			)	
		)
		(->
			([=] (-V- Action_Post 2 T2) 1)
			(&&
				(-P- partTaken)
				([=](-V- End_Eff_B_Position) L_bin)
				(-A- j body_indexes 
					([!=](-V- Body_Part_pos j) (-V- End_Eff_B_Position))
				)
			)
		)
	))
)

;;robot moves to the pallet
(defconstant *Action3T2*
	(alw(&&
		(->
			([=] (-V- Action_Pre 3 T2) 1)
			(&&
				(-P- partTaken)
				([=] (-V- actions 2 1 T2) done)
				([=] (-V- End_Eff_B_Position) L_bin)
				(-A- j body_indexes 
					([!=](-V- Body_Part_pos j) (-V- End_Eff_B_Position))
				)
			)
		)


		(->
			([=] (-V- Action_Post 3 T2) 1)
			(&&
			  (-P- partTaken)
			  (|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
			  (-A- j body_indexes 
					([!=](-V- Body_Part_pos j) (-V- End_Eff_B_Position))
				)
			)
		)
	)
  )
)

;;robot puts the part on the pallet
(defconstant *Action4T2*
	(alwf 
	  (&&
		(->
			([=] (-V- Action_Pre 4 T2) 1)
			(&&
				(-P- partTaken)
				([=] (-V- actions 3 1 T2) done)
				(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))
				(-A- j body_indexes 
					([!=](-V- Body_Part_pos j) (-V- End_Eff_B_Position))
				)	
			)
		)

		(->
			([=] (-V- Action_Post 4 T2) 1)
			(&&
				(-P- partFixed)
			 	(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))
				(-A- j body_indexes 
					([!=](-V- Body_Part_pos j) (-V- End_Eff_B_Position))
				)
			)
		)
	  )
	)
)	  	
;;robot keeps holding
(defconstant *Action5T2*
	(alwf (&&
		(->
			([=] (-V- Action_Pre 5 T2) 1)
			(&&
				(-P- partFixed)
				([=] (-V- actions 4 1 T2) done)
				(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
			)
		)

		(->
			([=] (-V- Action_Post 5 T2) 1)
			(&&
				(-P- partFixed)
				(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
			)
		)
		
	))
)
;;operator prepares the jigs 
(defconstant *Action6T2*
	(alwf (&&
		(->
			([=] (-V- Action_Pre 6 T2) 1)
			(&&(-P- partTaken)
			([=] (-V- actions 5 1 T2) executing)
			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
			)
		)

		(->
			([=] (-V- Action_Pre_L 6 T2) 1)
			(&&(-P- partTaken)
			; ([=] (-V- actions 5 1 T2) executing)
			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
			)
		)

		(->
			([=] (-V- Action_Post 6 T2) 1)
			(&&(-P- partFixed)
			(-P- preparedJig)
			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
			)
		)

		(->
			([=] (-V- Action_Post_L 6 T2) 1)
			(&&
				(-P- partFixed)
				; (-P- preparedJig)
				(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
			)
		)
	))
)
;;operator screwdrives
(defconstant *Action7T2*
	(alwf (&&
		(->
			([=] (-V- Action_Pre 7 T2) 1)
			(&&
				(-P- partFixed)
				([=] (-V- actions 5 1 T2) executing)
				([=] (-V- actions 6 1 T2) done)
				(-P- preparedJig)
				(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
				(|| ([=](-V- Body_Part_pos hand) L_1_2)	([=](-V- Body_Part_pos hand) L_1_3))
				)
		)

		(->
			([=] (-V- Action_Pre_L 7 T2) 1)
			(&&
				(-P- partFixed)
				(-P- preparedJig)
				(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
				(|| ([=](-V- Body_Part_pos hand) L_1_2)	([=](-V- Body_Part_pos hand) L_1_3))
				)
		)

		(->
			([=] (-V- Action_Post 7 T2) 1)
			(&&
				(-P- partFixed)
			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
			)
		)

		(->
			([=] (-V- Action_Post_L 7 T2) 1)
			(&&
				(-P- partFixed)
			(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
			)
		)
	))
)

;;robot moves back to home
(defconstant *Action8T2*
	(alwf (&&
		(->
			([=] (-V- Action_Pre 8 T2) 1)
			(&&
				([=] (-V- actions 7 1 T2) done)
				([=] (-V- actions 5 1 T2) done)
				(!! (-P- partFixed))
				(|| ([=](-V- End_Eff_B_Position) L_1_2) ([=](-V- End_Eff_B_Position) L_1_3))	
			)

		)

		(->
			([=] (-V- Action_Post 8 T2) 1)
			(&&
				
				(!! (-P- partFixed))
				(-P- Robot_Homing)
			)
		)

	)
)
)
(defconstant configT2
   (alw (&&
	; SeqAction2
	(SeqAction actions2-indexes T2)
	*ActionInitT2*
	*Action1T2*
	*Action2T2*
	*Action3T2*
	*Action4T2*
	*Action5T2*
	*Action6T2*
	*Action7T2*
	*Action8T2*
	)
  ))

(defconstant noCallT2
  (alw
  	(&&	
  		; SeqAction2
  		(SeqAction actions2-indexes T2)
  		*ActionInitT2*
  		*Action6T2*
		*Action7T2*
		([=] (-V- actions 1 1 T2) notstarted)
		([=] (-V- actions 2 1 T2) notstarted)
		([=] (-V- actions 3 1 T2) notstarted)
		([=] (-V- actions 4 1 T2) notstarted)
		([=] (-V- actions 5 1 T2) notstarted)
		([=] (-V- actions 8 1 T2) notstarted)
	)
  )
)
   