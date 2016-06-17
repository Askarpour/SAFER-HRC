
;;	screw driving Parameters
	(defvar parts 1)
	(defvar parts_indexes (loop for i from 1 to parts collect i))
	(defvar jigs 1)
	(defvar jigs_indexes (loop for i from 0 to (- jigs 1) collect i))
	; (defvar iteration_index 0)
<<<<<<< HEAD
	(defvar actions-indexes (loop for i from 1 to (+ 8 (* 6 jigs)) collect i))
=======
		
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

;; Task Parameters
	; actions(i 0) -->priority
	; actions(i 1) -->status
	; actions(i 2) -->exeTime
	; actions(i 3) -->subject

<<<<<<< HEAD

		;;Statuses
=======
	(define-tvar actions *int* *int* *int*)
	(define-tvar Action_Pre *int* *int*)
	(define-tvar Action_Post *int* *int*)
	(define-tvar Action_SafetyPro *int* *int*)
	(defvar actions-indexes (loop for i from 1 to (+ 8 (* 6 jigs)) collect i))
	; (defvar similar-sf-indexes (loop for i from 5 to 9 collect i))

	;;Statuses
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
		(defvar notstarted 0)
		(defvar waiting 1)
		(defvar executing 2)
		; (defvar parallel-executing 3)
		(defvar pause 3)
		(defvar done 4)

<<<<<<< HEAD
(defvar actionexetime 0)
=======
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
	; ;;priorities
	; 	(defvar superhigh-p 4)
	; 	(defvar high-p 3)
	; 	(defvar medium-p 2)
	; 	(defvar low-p 1)
	
	;subject identifier
		
		(defconstant operator 1)
		(defconstant robot 2)

<<<<<<< HEAD
	
	; (define-tvar actions *int* *int* *int*)
	(define-array actions-status actions-indexes '(0 1 2 3 4))
	(define-array actions-exeT actions-indexes '(3))
	(define-array actions-subj actions-indexes '(1 2))


	; (define-tvar Action_Pre *int* *int*)
	(define-array Action_Pre actions-indexes '(0 1))

	; (define-tvar Action_Post *int* *int*)
	(define-array Action_Post actions-indexes '(0 1))

	; (define-tvar Action_SafetyPro *int* *int*)
	(define-array Action_SafetyPro actions-indexes '(0 1))
	
	; (defvar similar-sf-indexes (loop for i from 5 to 9 collect i))



=======
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
(defconstant *ActionInit*

 (alwf 

 	(&&
 		 ; Initialization of priority
<<<<<<< HEAD
		 	(-A- i actions-indexes
		 	 	 (actions-exeT= i 10)
		 	 )
 	 	 ; Initialization of subject
 	 	
		 	 	(actions-subj= 1 operator)
		 	 	 (actions-subj= 2 operator)
		 	 	 (actions-subj= 3 operator)
		 	 	 (actions-subj= 4 operator)
		 	 	 (actions-subj= 5 operator)
		 	 	 (actions-subj= 6 robot)
=======
 			 (-A- i actions-indexes
 			 	(&& 
 			 		 ; ([=] (-V- actions i 0) (- (+ 7 (* 7 jigs)) i))

	    
 		;;;;; 	 	 ([=] (-V- actions 14 0) 1) ;;;;;;;
	 	 	 	
	 	    
	 	  

	 	 ; Initialization of exe-time
	 	    
	 	    
		 	 	 ([=] (-V- actions i 2) 3)
	 	 	 )
		 	)


 	 	 ; Initialization of subject
 	 	 		 ([=] (-V- actions 1 3) operator)
		 	 	 ([=] (-V- actions 2 3) operator)
		 	 	 ([=] (-V- actions 3 3) operator)
		 	 	 ([=] (-V- actions 4 3) operator)
		 	 	 ([=] (-V- actions 5 3) operator)
		 	 	 ([=] (-V- actions 6 3) robot)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
		 	 	
		 	 	 (-A- k jigs_indexes

			 	 (&&
<<<<<<< HEAD
			 	 	 (actions-subj= (+  (* k 6) 7) operator)
			 	     (actions-subj= (+  (* k 6) 8) robot)
		    	     (actions-subj= (+  (* k 6) 9) robot)
			 	 	 (actions-subj= (+  (* k 6) 10) robot)
			 	 	 (actions-subj= (+  (* k 6) 11) robot)
			 	 	 (actions-subj= (+  (* k 6) 12) robot)
		 	 	 )

		 	 	 )
		 	 	 (actions-subj= (+  (* (- jigs 1) 6) 13)  operator)
		 	 	 (actions-subj= (+  (* (- jigs 1) 6) 14)  robot)
		 	 	 
=======
			 	 	 ([=] (-V- actions (+  (* k 6) 7) 3) operator)
			 	     ([=] (-V- actions (+  (* k 6) 8) 3) robot)
		    	     ([=] (-V- actions (+  (* k 6) 9) 3) robot)
			 	 	 ([=] (-V- actions (+  (* k 6) 10) 3) robot)
			 	 	 ([=] (-V- actions (+  (* k 6) 11) 3) robot)
			 	 	 ([=] (-V- actions (+  (* k 6) 12) 3) robot)
		 	 	 )

		 	 	 )
		 	 	 ([=] (-V- actions (+  (* (- jigs 1) 6) 13) 3) operator)
		 	 	 ([=] (-V- actions (+  (* (- jigs 1) 6) 14) 3) robot)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
		 	 	 
	 	 		
	 	 	 )
		)	 	 
	)

<<<<<<< HEAD
;
=======
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
(defconstant *SeqAction* 
 	  (alwf 
	      (-A- i actions-indexes
	       (&& 
<<<<<<< HEAD
		       ;if now notStarted, it was not done and executed before

		       (->
			       	(actions-status= i notstarted)
			       	(&&
			       	(!! (somp (actions-status= i executing)))
			       	(!! (somp (actions-status= i done)))
=======
	       ;status among 1 to 5
		       (&& ([>=] (-V- actions i 1) 0) ([<=] (-V- actions i 1) 4))
		       ;;

		       ;if now notStarted, it was not done and executed before

		       (->
			       	([=] (-V- actions i 1) notstarted)
			       	(&&
			       	(!! (somp ([=] (-V- actions i 1) executing)))
			       	; (!! (somp ([=] (-V- actions i 1) parallel-executing)))
			       	(!! (somp ([=] (-V- actions i 1) done)))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			       	)
		       	)

		       ;if now waiting somp it was notstarted
		        (->
<<<<<<< HEAD
			       	(actions-status= i waiting)
			       	(&&
	       			(somp (actions-status= i notstarted))
			       	(!! (somp (actions-status= i executing)))
			       	(!! (somp (actions-status= i done)))
=======
			       	([=] (-V- actions i 1) waiting)
			       	(&&
	       			(somp ([=] (-V- actions i 1) notstarted))
			       	(!! (somp ([=] (-V- actions i 1) executing)))
			       	; (!! (somp ([=] (-V- actions i 1) parallel-executing)))
			       	(!! (somp ([=] (-V- actions i 1) done)))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			       	)
			       
		       	)
		      		
	      		(-> ;if it is executing then it has started in the past, not done in the past and not starting in the future
	            		; (|| 
<<<<<<< HEAD
	            		(actions-status= i executing)
	            		(&&
	                              (somp (actions-status= i notstarted))
	                              (somp (actions-status= i waiting))
	                              (!! (somp (actions-status= i done)))
	                              (!! (somf (actions-status= i notstarted)))
	                              (!! (somf (actions-status= i waiting)))
	                              ; (somf (actions-status= i done))
=======
	            		([=] (-V- actions i 1) executing)
	            		 ; ([=] (-V- actions i 1) parallel-executing))
	            		(&&
	                              (somp ([=] (-V- actions i 1) notstarted))
	                              (somp ([=] (-V- actions i 1) waiting))
	                              (!! (somp ([=] (-V- actions i 1) done)))
	                              (!! (somf ([=] (-V- actions i 1) notstarted)))
	                              (!! (somf ([=] (-V- actions i 1) waiting)))
	                              (somf ([=] (-V- actions i 1) done))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
	                     )
	      		)

	      		(->
<<<<<<< HEAD
	      			(actions-status= i pause) 
					(&&
                      ; (||
                      (somp (actions-status= i notStarted))
                      	(somp (actions-status= i waiting))
                      	; (somp (actions-status= i executing))
                       ; (somp (actions-status= i parallel-executing)))
                      ; (||
                      ; (somf (actions-status= i executing)) 
                      ; (somf (actions-status= i parallel-executing)))
                      (!! (somf (actions-status= i notstarted)))
			       	  (!! (somf (actions-status= i waiting)))
			       	  ; (yesterday
			       	  ; 	; (|| 
			       	  ; 	(actions-status= i executing) 
			       	  ; 	; (actions-status= i parallel-executing) (actions-status= i pause)
=======
	      			([=] (-V- actions i 1) pause) 
					(&&
                      ; (||
                      	(somp 
                      ([=] (-V- actions i 1) executing)
                      )
                       ; (somp ([=] (-V- actions i 1) parallel-executing)))
                      ; (||
                      (somf ([=] (-V- actions i 1) executing)) 
                      ; (somf ([=] (-V- actions i 1) parallel-executing)))
                      (!! (somf ([=] (-V- actions i 1) notstarted)))
			       	  (!! (somf ([=] (-V- actions i 1) waiting)))
			       	  ; (yesterday
			       	  ; 	; (|| 
			       	  ; 	([=] (-V- actions i 1) executing) 
			       	  ; 	; ([=] (-V- actions i 1) parallel-executing) ([=] (-V- actions i 1) pause)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			       	  ; 	; )
			       	  ; )
                 

                    )
	      		)

	      		;when it is executing then there were no notstarted from last waiting to the start of the execution
	      		(->
	      			; (||
<<<<<<< HEAD
						(actions-status= i executing)
						; (actions-status= i parallel-executing)
					; )

					; (somp 
					; 	(&& 
					; 		(actions-status= i waiting) 
							; (alwf (!! (actions-status= i notStarted)))
							; (Until_ie (!! (actions-status= i notStarted)) (actions-status= i executing))
						(yesterday (|| (actions-status= i executing)  (actions-status= i pause)))
						)
					; )

     ;  			)

	      		;;Robot in home before Action6
	      		(->
	      			(!!(actions-status= 4 done))
=======
						([=] (-V- actions i 1) executing)
						; ([=] (-V- actions i 1) parallel-executing)
					; )

					(somp 
						(&& 
							([=] (-V- actions i 1) waiting) 
							; (alwf (!! ([=] (-V- actions i 1) notStarted)))
							(Until_ie (!! ([=] (-V- actions i 1) notStarted)) ([=] (-V- actions i 1) executing))
						)
					)

      			)



	    ;   		(->  ;definition of parallel executing
	    ;   			(-E- j actions-indexes
					; 	(&&
					; 		([=] (-V- actions i 1) executing)
					; 		([!=] j i)
					; 		(||
					; 			([=] (-V- actions j 1) executing)
					; 			([=] (-V- actions j 1) parallel-executing)
					; 		)
					; 	)
					; 	)
					
					; 		([=] (-V- actions i 1) parallel-executing)

	      				
					; )
      			

	      		;
	      		;;Robot in home before Action6
	      		(->
	      			(!!([=] (-V- actions 4 1) done))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
	      			(-P- Robot_Homing)
	      		)
	      		 
	      		(-> ; waiting robot action must be executed right away
	      			(&& 
<<<<<<< HEAD
	      				(actions-status= i waiting)
	      				(actions-subj= i robot)
	      				(next (Action_SafetyPro= i 1))
	      			)
	      			
	      			; (||
		      			(next (actions-status= i executing))
		      			; (next (actions-status= i parallel-executing))
=======
	      				([=] (-V- actions i 1) waiting)
	      				([=] (-V- actions i 3) robot)
	      			)
	      			
	      			; (||
		      			(next ([=] (-V- actions i 1) executing))
		      			; (next ([=] (-V- actions i 1) parallel-executing))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
	      			; )
	      		)

	      		(-> ; waiting robot action eventually should be executed
	      			(&& 
<<<<<<< HEAD
	      				(actions-status= i waiting)
	      				(actions-subj= i operator)
	      				(next (Action_SafetyPro= i 1))
	      			)
	      			
	      			(||
		      			(withinf_ie (actions-status= i executing) 5)
		      			; (withinf_ie (actions-status= i parallel-executing) 5)
		      			(withinf_ie (actions-status= i notstarted) 5)
	      			)
	      		)

=======
	      				([=] (-V- actions i 1) waiting)
	      				([=] (-V- actions i 3) operator)
	      			)
	      			
	      			(||
		      			(withinf_ie ([=] (-V- actions i 1) executing) 5)
		      			; (withinf_ie ([=] (-V- actions i 1) parallel-executing) 5)
		      			(withinf_ie ([=] (-V- actions i 1) notstarted) 5)
	      			)
	      		)


	      		
      			; (-E- i, j actions-indexes
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
      			
      			(-A-  j actions-indexes
      				(-A-  i actions-indexes 
      					(->
		      				(&&
<<<<<<< HEAD
		      					(actions-subj= i operator)
		      					(actions-subj= j operator)
		      					(actions-status= i executing)
		      					(actions-status= j executing)
=======
		      					([=] (-V- actions i 3) operator)
		      					([=] (-V- actions j 3) operator)
		      					([=] (-V- actions i 1) executing)
		      					([=] (-V- actions j 1) executing)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
		      					(!! ([=] i j))

	      					)
      				
		  					(!! 
		  						(-E- k actions-indexes
		  							(&&
<<<<<<< HEAD
			      						(actions-subj= k operator)
				      					(actions-status= k executing)
=======
			      						([=] (-V- actions k 3) operator)
				      					([=] (-V- actions k 1) executing)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
				      					(!! ([=] i k))
				      					(!! ([=] k j))
			      					)
		      					)
							) 
  						)
  					)
  				)
<<<<<<< HEAD

	      		(-> ;definition of done
	            		(actions-status= i done)

	            		(&&
	            			;when a Action is done it remains done until loop for jigs 
	            			(alwf (actions-status= i done))
	            			; (until_ie (actions-status= i done) (-P- JigLoop))
=======
      				


	      		; (->
	      		; 	([=] (-V- actions i 1) parallel-executing)
	      		; 	(-E- j actions-indexes
	      		; 		(&&
		      	; 			([=] (-V- actions j 1) parallel-executing)
		      	; 			([!=] j i)
	      		; 		)

	      		; 	)
      			; )


	      		(-> ;definition of done
	            		([=] (-V- actions i 1) done)

	            		(&&
	            			;when a Action is done it remains done until loop for jigs 
	            			(alwf ([=] (-V- actions i 1) done))
	            			; (until_ie ([=] (-V- actions i 1) done) (-P- JigLoop))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

	            			


	            			;if its done then it was executing in the past
	            			(somp 
	            			; 	(||
<<<<<<< HEAD
		            				(actions-status= i executing)
		            			; 	(actions-status= i parallel-executing)
	            				; )
	            			)
	            			;no pause within "exeT" time units 
	            			; (!! (withinp_ie (|| (actions-status= i waiting) (actions-status= i pause)) 5))
	            			; (withinp_ie (actions-status= i executing) 5)
	            			(lasted_ee (!!(actions-status= i pause)) (+ 1 actionexetime)) 

=======
		            				([=] (-V- actions i 1) executing)
		            			; 	([=] (-V- actions i 1) parallel-executing)
	            				; )
	            			)
	            			;no pause within "exe_time" time units 
	            			(!! (withinp_ie ([=] (-V- actions i 1) pause) 6))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

	            			;NOTE::::////exetime must be instead of 3
	            		)
            		)

<<<<<<< HEAD
				(->
					(&& (actions-status= i waiting) (yesterday(actions-status= i notstarted)))
					(yesterday (Action_Pre= i 1))
=======

	      		; pre/post/safety conditions
				; (->
				; 	(&& (yesterday (|| ([=] (-V- actions i 1) executing) ([=] (-V- actions i 1) parallel-executing))) ([=] (-V- Action_SafetyPro i) 0))
				; 	(until_ie ([=] (-V- actions i 1) pause) ([=] (-V- Action_SafetyPro i) 1))

				; )
				
				; (->
				; 	(&& (yesterday ([=] (-V- actions i 1) pause)) ([=] (-V- Action_SafetyPro i) 1))
				; 	(|| ([=] (-V- actions i 1) executing) ([=] (-V- actions i 1) parallel-executing))
				; )

				;
				(->
					(&& ([=] (-V- actions i 1) waiting) (yesterday([=] (-V- actions i 1) notstarted)))
					(yesterday ([=] (-V- Action_Pre i) 1))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
				)


				(->
					(&& 
						; (|| 
<<<<<<< HEAD
						(actions-status= i executing)
						 ; (actions-status= i parallel-executing))
						  (yesterday(actions-status= i waiting)))
					(Action_SafetyPro= i 1)
=======
						([=] (-V- actions i 1) executing)
						 ; ([=] (-V- actions i 1) parallel-executing))
						  (yesterday([=] (-V- actions i 1) waiting)))
					([=] (-V- Action_SafetyPro i) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
				)



				(->
					(&& 
						(yesterday 
						; (|| 
<<<<<<< HEAD
						(actions-status= i executing) 
						; (actions-status= i parallel-executing))
						) 
						(actions-status= i pause))
				(until_ie (actions-status= i pause) (Action_SafetyPro= i 1))
					
				)


				(->
					; (|| 
						(actions-status= i executing)
					; 	(actions-status= i parallel-executing)
					; )

					(Action_SafetyPro= i 1)
=======
						([=] (-V- actions i 1) executing) 
						; ([=] (-V- actions i 1) parallel-executing))
						) 
						([=] (-V- actions i 1) pause))
				(until_ie ([=] (-V- actions i 1) pause) ([=] (-V- Action_SafetyPro i) 1))
					
				)

				; ; (->
				; ; 	(&& (|| ([=] (-V- actions i 1) executing) ([=] (-V- actions i 1) parallel-executing)) (yesterday([=] (-V- actions i 1) pause)))
				; ; 	(yesterday ([=] (-V- Action_SafetyPro i) 1))
				; ; )



				(->
					; (|| 
						([=] (-V- actions i 1) executing)
					; 	([=] (-V- actions i 1) parallel-executing)
					; )

					([=] (-V- Action_SafetyPro i) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
				)
				
			 	
				(->
<<<<<<< HEAD
					(&& 
						(actions-status= i done) 
						(yesterday (actions-status= i executing))
					)
					(Action_Post= i 1)
=======
					(&& ([=] (-V- actions i 1) done) 
						(yesterday 
							; (|| 
							([=] (-V- actions i 1) executing) 
							; ([=] (-V- actions i 1) parallel-executing))
							))
					([=] (-V- Action_Post i) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			 	)



				)
			)
		)
)

<<<<<<< HEAD
=======
;;1. the operator moves to the bin
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
(defconstant *Action1* 

	 (&&

	 	(<->
<<<<<<< HEAD
	 		(Action_Pre= 1 1) 
=======
	 		([=] (-V- Action_Pre 1) 1) 
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
	 		(&& 
	 			(-P- Robot_Homing)
	 			; (!! (-P- End_Eff_facing_Operator))
 			)

 		)

 		(<->
<<<<<<< HEAD
 			(Action_Post= 1 1)
 			(&&
 				; (!! (-P- End_Eff_facing_Operator))
 				(|| (Body_Part_pos= hand L_5_a) (Body_Part_pos= hand L_5_b))
=======
 			([=] (-V- Action_Post 1) 1)
 			(&&
 				; (!! (-P- End_Eff_facing_Operator))
 				(|| ([=](-V- Body_Part_pos hand) L_5_a) ([=](-V- Body_Part_pos hand) L_5_b))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

 				(-P- Robot_Homing)
 			)
		)

		(<->	
<<<<<<< HEAD
			(Action_SafetyPro= 1 1)
=======
			([=] (-V- Action_SafetyPro 1) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(&& 
				(-P- Robot_Homing)
	 			; (!! (-P- End_Eff_facing_Operator))
 			)
		)
	 )
)

;;2. he grasps a part
(defconstant *Action2* 
	(&&

		(<->
<<<<<<< HEAD
	 		(Action_Pre= 2 1)
	 		(&& 
	 			(actions-status= 1 done)
	 			(|| (Body_Part_pos= hand L_5_a) (Body_Part_pos= hand L_5_b))
	 			(-P- Robot_Homing)
	 			
=======
	 		([=] (-V- Action_Pre 2) 1)
	 		(&& 
	 			([=] (-V- actions 1 1) done)
	 			(|| ([=](-V- Body_Part_pos hand) L_5_a) ([=](-V- Body_Part_pos hand) L_5_b))
	 			(-P- Robot_Homing)
	 			; (!! (-P- End_Eff_facing_Operator))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
 			)

 		)

 		(<->
<<<<<<< HEAD
 			(Action_Post= 2 1)
=======
 			([=] (-V- Action_Post 2) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
 			(&& 
				(-P- partTaken)
				(-P- Robot_Homing)
				; (!! (-P- End_Eff_facing_Operator))

		 	)
		)
		;part is taken until partfixed
<<<<<<< HEAD
		
=======
		; (->	
		; 	(-P- partTaken)
		; 	(until_ie (-P- partTaken) (-P- partFixed))
		; )

		

	 	
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
 	)
)

;;3. he takes the part to the tombstone
(defconstant *Action3* 

	(&&

		(<->
<<<<<<< HEAD
	 		(Action_Pre= 3 1)
			(&& 
				(actions-status= 2 done)
				(-P- partTaken)
				(-P- Robot_Homing)
				)	 		
=======
	 		([=] (-V- Action_Pre 3) 1)
			(&& 
				([=] (-V- actions 2 1) done)
				(-P- partTaken)
				(-P- Robot_Homing)
				; (!! (-P- End_Eff_facing_Operator))

		 	)	 		
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

 		)

 		(<->
<<<<<<< HEAD
 			(Action_Post= 3 1)
 			(&& 
				(|| (Body_Part_pos= hand L_7) (Body_Part_pos= hand L_1))	
=======
 			([=] (-V- Action_Post 3) 1)
 			(&& 
				(|| ([=](-V- Body_Part_pos hand) L_7) ([=](-V- Body_Part_pos hand) L_1))	
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

				(-P- partTaken)
				(-P- Robot_Homing)
				; (!! (-P- End_Eff_facing_Operator))
	 		)
 			
		)

		(<->
<<<<<<< HEAD
			(Action_SafetyPro= 3 1)
=======
			([=] (-V- Action_SafetyPro 3) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(&&

				(-P- partTaken)
				(-P- Robot_Homing)
				; (!! (-P- End_Eff_facing_Operator))
			)

		)
	)
)

;;4. he puts the part on the stone
(defconstant *Action4* 
	(&&
		(<->
<<<<<<< HEAD
	 		(Action_Pre= 4 1)
	 		(&& 
	 			(actions-status= 3 done)
				(Body_Part_pos= hand L_1)	
=======
	 		([=] (-V- Action_Pre 4) 1)
	 		(&& 
	 			([=] (-V- actions 3 1) done)
				([=](-V- Body_Part_pos hand) L_1)	
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

				(-P- partTaken)
				(-P- Robot_Homing)
				; (!! (-P- End_Eff_facing_Operator))
	 		)

 		)

 		(<->
<<<<<<< HEAD
 			(Action_Post= 4 1)
 			(&& 
				(Body_Part_pos= hand L_1)	
=======
 			([=] (-V- Action_Post 4) 1)
 			(&& 
				([=](-V- Body_Part_pos hand) L_1)	
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

				; (-P- partFixed)
				(-P- partTaken)
				(-P- Robot_Homing)
				; (!! (-P- End_Eff_facing_Operator))
	 		)
		)
<<<<<<< HEAD

		(<->
			(Action_SafetyPro= 4 1)
=======
		
		; (<->	
		; 	([=] (-V- actions 4 1) done)
		; 	(-P- partFixed)
		; )


		(<->
			([=] (-V- Action_SafetyPro 4) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
			(&&

	 			(-P- Robot_Homing)
	 			; (!! (-P- End_Eff_facing_Operator))

			)

		)

		
	 )
 )

;;5. Operator holding the part
(defconstant *Action5*

	(&&

	 	(<->
<<<<<<< HEAD
	 		(Action_Pre= 5 1)
	 		(&&
	 			(actions-status= 4 done)
	 			(-P- partTaken)
	 			(Body_Part_pos= hand L_1)	
				; (-P- partFixed)
	 			(End_Eff_B_Position= L_1)

=======
	 		([=] (-V- Action_Pre 5) 1)
	 		(&&
	 			([=] (-V- actions 4 1) done)
	 			(-P- partTaken)
	 			([=](-V- Body_Part_pos hand) L_1)	
				; (-P- partFixed)
	 			([=](-V- End_Eff_B_Position) L_1)

	 			; (!! (-P- End_Eff_facing_Operator))
	 			; (!!(-P- partHold))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
 			)
	 		
 		)

<<<<<<< HEAD
 
		(<->
			(Action_SafetyPro= 5 1)
	 			(Body_Part_pos= hand L_1)	

		)

=======
 	; 	(<->
 	; 		([=] (-V- Action_Post 5) 1)
 	; 		(!!(-P- partFixed))

		; )

		(<->
			([=] (-V- Action_SafetyPro 5) 1)
			; (&&
	 			([=](-V- Body_Part_pos hand) L_1)	

				; (-P- partFixed)
	 			; ([=](-V- End_Eff_B) L_1)
 			; )
		)

		; (->
		; 	(&& 
		; 		([=] (-V- actions 5 1) pause)
		; 		(yesterday (|| ([=] (-V- actions 5 1) parallel-executing) ([=] (-V- actions 5 1) parallel-executing)))
		; 	)
			
			
		; 	(-E- j actions-indexes
		; 		(&&
		; 			(->
		; 				(&&
		; 					(yesterday (|| ([=] (-V- actions j 1) parallel-executing) ([=] (-V- actions j 1) parallel-executing)))
		; 					(!! ([=] j 5))
		; 				)
		; 				(until_ie  ([=] (-V- actions j 1) pause) (!! ([=] (-V- actions 5 1) pause)))
		; 			)

		; 			(->
		; 				(&&
		; 					(yesterday ([=] (-V- actions j 1) waiting))
		; 					(!! ([=] j 5))
		; 				)
		; 				(until_ie ([=] (-V- actions j 1) waiting) (!! ([=] (-V- actions 5 1) pause)))
		; 			)
		; 		)
		; 	)
 	; 	)


>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
	)
)

;;6. robot moves from home to stone/ operator holds the part
(defconstant *Action6* 
	(&&


		(<->
<<<<<<< HEAD
	 		(Action_Pre= 6 1)
			(&& 
				; (|| 
				(actions-status= 5 executing)
				(Body_Part_pos= hand L_1)	
=======
	 		([=] (-V- Action_Pre 6) 1)
			(&& 
				; (|| 
				([=] (-V- actions 5 1) executing)
				 ; ([=] (-V- actions 5 1) parallel-executing))

				([=](-V- Body_Part_pos hand) L_1)	
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

	 		)
	

 		)

 		(<->
<<<<<<< HEAD
 			(Action_Post= 6 1)
 			(&& 
				(actions-status= 5 executing) 
				(!! (-P- LINK1_Moving))
				(!! (-P- LINK2_Moving))

	 			(End_Eff_B_Position= L_1)
=======
 			([=] (-V- Action_Post 6) 1)
 			(&& 

				; ([=](-V- Body_Part_pos hand) L_6)

				; (|| 
				([=] (-V- actions 5 1) executing) 
				; ([=] (-V- actions 5 1) parallel-executing))

				; (-P- partFixed)
				(!! (-P- LINK1_Moving))
				(!! (-P- LINK2_Moving))

	 			([=](-V- End_Eff_B_Position) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

	 		)	
		)

		(<->
<<<<<<< HEAD
			(Action_SafetyPro= 6 1)
			(&&
				(Body_Part_pos= hand L_1)

				; (|| 
				(actions-status= 5 executing) 
				(-A- i body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] i hand)
						(!! (Body_Part_pos= i L_1))
=======
			([=] (-V- Action_SafetyPro 6) 1)
			(&&
				([=](-V- Body_Part_pos hand) L_1)

				; (|| 
				([=] (-V- actions 5 1) executing) 
				; ([=] (-V- actions 5 1) parallel-executing))
				; (-P- partFixed)

				(-A- i body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] i hand)
						([!=](-V- Body_Part_pos i) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

					)
				)
			)
		)

		
	 )
 )

; ;;7.operator prepares a jig
(defun Action7(i)
 	(&&
	   

		(<->
	 		; (-P- Action7_Pre) 
<<<<<<< HEAD
	 		(Action_Pre= i 1)
	 		; (||
	 			(&& 
	 				
	 				(actions-status= 6 done)
	 				(actions-status= (- i 1) done)
	 				(actions-status= 5 executing)
					(Body_Part_pos= hand L_1)	
					; (-P- partFixed)
					(!! (-P- LINK1_Moving))
					(!! (-P- LINK2_Moving))
		 			(End_Eff_B_Position= L_1)
=======
	 		([=] (-V- Action_Pre i) 1)
	 		; (||
	 			(&& 
	 				
	 				([=] (-V- actions 6 1) done)
	 				([=] (-V- actions (- i 1) 1) done)
	 				; (|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))
	 				([=] (-V- actions 5 1) executing)
					([=](-V- Body_Part_pos hand) L_1)	
					; (-P- partFixed)
					(!! (-P- LINK1_Moving))
					(!! (-P- LINK2_Moving))
		 			([=](-V- End_Eff_B_Position) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
		 		)
		 		
 		)	

 		(<->
 			; (-P- Action7_Post)
<<<<<<< HEAD
 			(Action_Post= i 1)
 			(&& 
				(Body_Part_pos= hand L_1)	
				(actions-status= 5 executing)
				; (-P- partFixed)
				(!! (-P- LINK1_Moving))
					(!! (-P- LINK2_Moving))
	 			(End_Eff_B_Position= L_1)
=======
 			([=] (-V- Action_Post i) 1)
 			(&& 
				([=](-V- Body_Part_pos hand) L_1)	
				; (|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))
				([=] (-V- actions 5 1) executing)
				; (-P- partFixed)
				(!! (-P- LINK1_Moving))
					(!! (-P- LINK2_Moving))
	 			([=](-V- End_Eff_B_Position) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
	 			(-P- preparedJig)
	 			; (!! (-P- NewIteration))


	 		)	
		)

		(<->
<<<<<<< HEAD
			(Action_SafetyPro= i 1)
			; (-P- Action7_SafetyPro)
			(&&
				(Body_Part_pos= hand L_1)	
				(actions-status= 5 executing)
				; (-P- partFixed)
				(!! (-P- LINK1_Moving))
				(!! (-P- LINK2_Moving))
	 			(End_Eff_B_Position= L_1)
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						(!!(Body_Part_pos= j L_1))
=======
			([=] (-V- Action_SafetyPro i) 1)
			; (-P- Action7_SafetyPro)
			(&&
				([=](-V- Body_Part_pos hand) L_1)	
				; (|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))
				([=] (-V- actions 5 1) executing)
				; (-P- partFixed)
				(!! (-P- LINK1_Moving))
				(!! (-P- LINK2_Moving))
	 			([=](-V- End_Eff_B_Position) L_1)
	 			; (!! ([=] (-V- actions (+ i 1) 1) executing))
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
					)
				)
			)
		)


		
		
	 )
	)

; ;; 8. robot moves toward stone/ operator holds the part
(defun Action8(i)
<<<<<<< HEAD
=======
 ;   (->
	; (&& ([=] ([%] i 6 ) 2) (!!([=] i (+ (* (- jigs 1) 6) 14))) ([>] i 6))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

	(&&
		
		(<->
<<<<<<< HEAD
	 		(Action_Pre= i 1)
	 		(&& 
	 			
	 			(actions-status= (- i 1) done)
	 			(actions-status= 5 executing)
	 			(Body_Part_pos= hand L_1)	
				; (-P- partFixed)
	 			(End_Eff_B_Position= L_1)
=======
	 		([=] (-V- Action_Pre i) 1)
	 		(&& 
	 			
	 			([=] (-V- actions (- i 1) 1) done)
	 			([=] (-V- actions 5 1) executing)
	 			; (|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))
		 		([=](-V- Body_Part_pos hand) L_1)	
				; (-P- partFixed)
	 			([=](-V- End_Eff_B_Position) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
	 			(-P- preparedjig)
 			)
 		)

 		(<->
<<<<<<< HEAD
 			(Action_Post= i 1)
 			(&&
 				(Body_Part_pos= hand L_1)	
				; (-P- partFixed)
	 			(End_Eff_B_Position= L_1)
	 			(actions-status= 5 executing)
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						(!! (Body_Part_pos= j L_1))
=======
 			([=] (-V- Action_Post i) 1)
 			(&&
 				([=](-V- Body_Part_pos hand) L_1)	
				; (-P- partFixed)
	 			([=](-V- End_Eff_B_Position) L_1)
	 			([=] (-V- actions 5 1) executing)
	 			;(|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))
	 			; (!! ([=] (-V- actions (+ i 1) executing))
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
					)
				)
				; (-P- ScrewDriveReady)
				(-P- preparedjig)
			)
		)
 			
		(<->
<<<<<<< HEAD
			(Action_SafetyPro= i 1)
			(&&
				(Body_Part_pos= hand L_1)	
				; (-P- partFixed)
	 			(End_Eff_B_Position= L_1)
	 			; (-P- preparedjig)
	 			(actions-status= 5 executing)
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						(!! (Body_Part_pos= j L_1))
=======
			([=] (-V- Action_SafetyPro i) 1)
			(&&
				([=](-V- Body_Part_pos hand) L_1)	
				; (-P- partFixed)
	 			([=](-V- End_Eff_B_Position) L_1)
	 			; (-P- preparedjig)
	 			([=] (-V- actions 5 1) executing)
	 			;(|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
					)
				)
			)

		)

		

	 )
   )

; ;;9. robot screws the prepared jig of a part/ operator holds the part
(defun Action9(i) 
 ; (->
	; (&& ([=] ([%] i 6 ) 3) ([>] i 6))
	(&&
		(<->
<<<<<<< HEAD
	 		(Action_Pre= i 1)
	 		(&& 
	 			(-P- preparedjig)
	 			(actions-status= (- i 1) done)
	 			
	 			(actions-status= 5 executing)
	 			(Body_Part_pos= hand L_1)	
				; (-P- partFixed)
	 			(End_Eff_B_Position= L_1)
=======
	 		([=] (-V- Action_Pre i) 1)
	 		(&& 
	 			(-P- preparedjig)
	 			([=] (-V- actions (- i 1) 1) done)
	 			
	 			([=] (-V- actions 5 1) executing)
	 			;(|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))

	 			([=](-V- Body_Part_pos hand) L_1)	
				; (-P- partFixed)
	 			([=](-V- End_Eff_B_Position) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

	 		
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
<<<<<<< HEAD
						(!! (Body_Part_pos= j L_1))
=======
						([!=](-V- Body_Part_pos j) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
					)
				)
	 			; (-P- ScrewDriveReady)
 			)

 		)

<<<<<<< HEAD
 		(<->
 			(Action_Post= i 1)
 			(&&
				(Body_Part_pos= hand L_1)	
				; (-P- partFixed)
	 			(End_Eff_B_Position= L_1)
	 			(actions-status= 5 executing)
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						(!! (Body_Part_pos= j L_1))
=======

 		; (<->
 		; 	(-P- ScrewDriveReady)
 		; 	(&& ([=] (-V- actions (- i 1) 1) done) (!!([=] (-V- actions i 1) done)))
 		; 	)

 		

 		(<->
 			([=] (-V- Action_Post i) 1)
 			(&&
				([=](-V- Body_Part_pos hand) L_1)	
				; (-P- partFixed)
	 			([=](-V- End_Eff_B_Position) L_1)
	 			([=] (-V- actions 5 1) executing)
	 			;(|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))
	 		
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
					)
				)
				
			)
 			
		)

		(<->
<<<<<<< HEAD
			(Action_SafetyPro= i 1)
			
			(&&
				(Body_Part_pos= hand L_1)	
				; (-P- partFixed)
	 			(End_Eff_B_Position= L_1)
	 			(actions-status= 5 executing)
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						(!! (Body_Part_pos= j L_1))
=======
			([=] (-V- Action_SafetyPro i) 1)
			
			(&&
				([=](-V- Body_Part_pos hand) L_1)	
				; (-P- partFixed)
	 			([=](-V- End_Eff_B_Position) L_1)
	 			([=] (-V- actions 5 1) executing)
	 			;(|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
					)
				)
			)
		)

		
	 )
 )

;;10. robot moves backward from the stone/ operator holds the part
(defun Action10(i) 
 ; (->
	; (&& ([=] ([%] i 6 ) 4) ([>] i 6))
	(&&
		  
		
		(<->
<<<<<<< HEAD
	 		(Action_Pre= i 1)
	 		(&&
	 			(actions-status= (- i 1) done)
	 			(actions-status= 5 executing)
	 			(Body_Part_pos= hand L_1)	
				; (-P- partFixed)
	 			(End_Eff_B_Position= L_1)
=======
	 		([=] (-V- Action_Pre i) 1)
	 		(&&
	 			([=] (-V- actions (- i 1) 1) done)
	 			([=] (-V- actions 5 1) executing)
	 			;(|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))

				([=](-V- Body_Part_pos hand) L_1)	
				; (-P- partFixed)
	 			([=](-V- End_Eff_B_Position) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
	 		
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
<<<<<<< HEAD
						(!! (Body_Part_pos= j L_1))
=======
						([!=](-V- Body_Part_pos j) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
					)
				)
			)

 		)

 		(<->
<<<<<<< HEAD
 			(Action_Post= i 1)
 			(&&
				(Body_Part_pos= hand L_1)	
				(actions-status= 5 executing)
				(End_Eff_B_Position= L_1)
=======
 			([=] (-V- Action_Post i) 1)
 			(&&
				([=](-V- Body_Part_pos hand) L_1)	
				([=] (-V- actions 5 1) executing)
				;(|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))
				; (-P- partFixed)
	 			([=](-V- End_Eff_B_Position) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
	 		
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
<<<<<<< HEAD
						(!! (Body_Part_pos= j L_1))
=======
						([!=](-V- Body_Part_pos j) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
					)
				)
			)
 			
		)

		(<->
<<<<<<< HEAD
			(Action_SafetyPro= i 1)
			(&&
				(Body_Part_pos= hand L_1)	
				; (-P- partFixed)
	 			(End_Eff_B_Position= L_1)
	 			(actions-status= 5 executing)
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						(!! (Body_Part_pos= j L_1))
=======
			([=] (-V- Action_SafetyPro i) 1)
			(&&
				([=](-V- Body_Part_pos hand) L_1)	
				; (-P- partFixed)
	 			([=](-V- End_Eff_B_Position) L_1)
	 			([=] (-V- actions 5 1) executing)
	 			;(|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
					)
				)
			)

		)

		
	)
 )

;;11. robot checks the number of jigs/ operator holds the part
(defun Action11(i) 
 ; (->
	; (&& ([=] ([%] i 6 ) 5) ([>] i 6))
	(&&
		(<->
<<<<<<< HEAD
	 		(Action_Pre= i 1)
	 		(&&

	 			(actions-status= (- i 1) done)
	 			(actions-status= 5 executing)
	 			(Body_Part_pos= hand L_1)	
				; (-P- partFixed)
	 			(End_Eff_B_Position= L_1)
=======
	 		([=] (-V- Action_Pre i) 1)
	 		(&&

	 			([=] (-V- actions (- i 1) 1) done)
	 			([=] (-V- actions 5 1) executing)
	 			;(|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))
				([=](-V- Body_Part_pos hand) L_1)	
				; (-P- partFixed)
	 			([=](-V- End_Eff_B_Position) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
	 		
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
<<<<<<< HEAD
						(!! (Body_Part_pos= j L_1))
=======
						([!=](-V- Body_Part_pos j) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
					)
				)
			)

 		)

 		(<->
<<<<<<< HEAD
 			(Action_Post= i 1)
 			(&&
				(Body_Part_pos= hand L_1)	
				(End_Eff_B_Position= L_1)
=======
 			([=] (-V- Action_Post i) 1)
 			(&&
				([=](-V- Body_Part_pos hand) L_1)	
				; (-P- partFixed)
				; ([=] (-V- actions 5 1) executing)
	 			([=](-V- End_Eff_B_Position) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
	 		
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
<<<<<<< HEAD
						(!! (Body_Part_pos= j L_1))
=======
						([!=](-V- Body_Part_pos j) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
					)
				)
			)
		)

		(<->
<<<<<<< HEAD
			(Action_SafetyPro= i 1)
			(&&
				(Body_Part_pos= hand L_1)	
				; (-P- partFixed)
	 			(End_Eff_B_Position= L_1)
	 			(actions-status= 5 executing)
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						(!! (Body_Part_pos= j L_1))
=======
			([=] (-V- Action_SafetyPro i) 1)
			(&&
				([=](-V- Body_Part_pos hand) L_1)	
				; (-P- partFixed)
	 			([=](-V- End_Eff_B_Position) L_1)
	 			([=] (-V- actions 5 1) executing)
	 			;(|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))
	 		
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
					)
				)
			)		

		)

		
	 )
)

;12. go back to action7
(defun Action12(i)
<<<<<<< HEAD
=======
 ; (->
	; (&& ([=] ([%] i 6 ) 0) ([>] i 6))

>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
	(&&

		(<->

<<<<<<< HEAD
	 		(Action_Pre= i 1)
	 			(actions-status= (- i 1) done))
=======
	 		([=] (-V- Action_Pre i) 1)
	 		; (&&
	 			; ([>=] i 0)
	 			([=] (-V- actions (- i 1) 1) done)
			; 	([=](-V- Body_Part_pos hand) L_6)	
			; 	([=] (-V- actions 5 1) executing)
			; 	(-P- partFixed)
	 	; 		([=](-V- End_Eff_B) L_6)
	 	; 		([=](-V- LINK1_Position) (yesterday(-V- LINK1_Position)))
	 	; 		([=](-V- LINK2_Position) (yesterday(-V- LINK2_Position)))
	 		
	 	; 		(-A- j body_indexes 
			; 		(->  ; no part allowed on pallet except hand
			; 			([!=] j hand)
			; 		)
			; 	)
			; )

 		)



>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
	)
)

; ;;13. else operator releases the part and moves back
(defun ActionBeforeLast(i)
	 (&&

		
		(<->

<<<<<<< HEAD
		 		(Action_Pre= i 1)
		 		(actions-status= (- i 1) done)
=======
		 		([=] (-V- Action_Pre i) 1)
		 		([=] (-V- actions (- i 1) 1) done)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

	 		)

 		(<->

<<<<<<< HEAD
 			(Action_Post= i 1)
=======
 			([=] (-V- Action_Post i) 1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
 			(&& 
				
				(!! (-P- partTaken))
				(!! (-P- partHold))
				(-A- i body_indexes 
					  ; no part on pallet
<<<<<<< HEAD
						(!! (Body_Part_pos= i L_1))
=======
						([!=](-V- Body_Part_pos i) L_1)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
					
				)

				
			)	
		)
			

		(<->
<<<<<<< HEAD
			(Action_SafetyPro= i 1)
				
				(-A- x L_indexes
					(&&
						(<-> (LINK1_Position= x) (yesterday (LINK1_Position= x)))
			 			(<-> (LINK2_Position= x) (yesterday (LINK2_Position= x)))
			 			(<-> (End_Eff_B_Position= x) (yesterday (End_Eff_B_Position= x)))
 					)
				)
=======
			([=] (-V- Action_SafetyPro i) 1)
			(&&
				([=](-V- LINK1_Position) (yesterday(-V- LINK1_Position)))
	 			([=](-V- LINK2_Position) (yesterday(-V- LINK2_Position)))
	 			([=](-V- End_Eff_B_Position) (yesterday(-V- End_Eff_B_Position)))
 			)

>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
		)

 	)
)

; ;;14. robot moves from stone to the home
 (defun ActionLast (i)
	(&&


		(<->
<<<<<<< HEAD
	 		(Action_Pre= i 1)
	 		
	 			(actions-status= (- i 1) done)
=======
	 		([=] (-V- Action_Pre i) 1)
	 		
	 			([=] (-V- actions (- i 1) 1) done)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
		 

 		)


 		(<->
<<<<<<< HEAD
 			(Action_Post= i 1)
				
 					(!!(End_Eff_B_Position= L_1))
				
		)

		
 	)
)
=======
 			([=] (-V- Action_Post i) 1)
				(&& 
					; ([=](-V- LINK1_Position) L_1)
 				; 	([=](-V- LINK2) L_2)
 					(!!([=](-V- End_Eff_B_Position) L_1))
				)
			
		)

		; (<->
		; 	([=] (-V- Action_SafetyPro i) 1)
		; 	([=] (-V- Action_Post 13) 1)

		; )

		




		; (<->
		; 	([=] (-V- Action_SafetyPro i) 1)
		; 	(&&
		; 		([=](-V- LINK1_Position) (yesterday(-V- LINK1_Position)))
	 ; 			([=](-V- LINK2_Position) (yesterday(-V- LINK2_Position)))
	 ; 			([=](-V- End_Eff_B) (yesterday(-V- End_Eff_B)))
 	; 		)

		; )

	
		
 	)
)

>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
