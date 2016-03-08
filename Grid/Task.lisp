
;screw driving Parameters
	(defvar parts 1)
	(defvar parts_indexes (loop for i from 1 to parts collect i))
	
	(defvar jigs 1)
	(defvar jigs_indexes (loop for i from 0 to (- jigs 1) collect i))
	(defvar iteration_index 0)
		

;; Task Parameters
	; actions(i 0) -->priority
	; actions(i 1) -->status
	; actions(i 2) -->exeTime
	; actions(i 3) -->subject
	(define-tvar actions *int* *int* *int*)
	(defvar actions-indexes (loop for i from 1 to (+ 7 (* 7 jigs)) collect i))
	(defvar similar-sf-indexes (loop for i from 5 to 9 collect i))

	;Statuses
		(defvar notstarted 0)
		(defvar waiting 1)
		(defvar executing 2)
		(defvar parallel-executing 3)
		(defvar pause 4)
		(defvar done 5)

	;priorities
		(defvar superhigh-p 4)
		(defvar high-p 3)
		(defvar medium-p 2)
		(defvar low-p 1)
	
		



	;subject identifier
		
		(defconstant operator 1)
		(defconstant robot 2)
	




(defconstant *ActionInit*

 (alwf 

 	(&&
 		 ; Initialization of priority
 			 (-A- i actions-indexes
 			 	(&& 
 			 		 ([=] (-V- actions i 0) i)

	    
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
		 	 	 ([=] (-V- actions 5 3) robot)
		 	 	 ([=] (-V- actions 6 3) operator)
		 	     ([=] (-V- actions 7 3) robot)
	    	     ([=] (-V- actions 8 3) robot)
		 	 	 ([=] (-V- actions 9 3) robot)
		 	 	 ([=] (-V- actions 10 3) robot)
		 	 	 ([=] (-V- actions 11 3) operator)
		 	 	 ([=] (-V- actions 12 3) operator)
		 	 	 ([=] (-V- actions 13 3) robot)
	 	 		 ([=] (-V- actions 14 3) operator)
	 	 	 )
		)	 	 
	)


(defconstant *SeqAction* 
 	  (alwf 
	      (-A- i actions-indexes
	       (&& 
	       ;status among 1 to 5
		       (&& ([>=] (-V- actions i 1) 0) ([<=] (-V- actions i 1) 5))
		       ;;

		       ;if now notStarted, it was not done and executed before

		       (->
			       	([=] (-V- actions i 1) notstarted)
			       	(&&
			       	(!! (somp ([=] (-V- actions i 1) executing)))
			       	(!! (somp ([=] (-V- actions i 1) parallel-executing)))
			       	(!! (somp ([=] (-V- actions i 1) done)))
			       	)
		       	)

		       ;if now waiting somp it was notstarted
		        (->
			       	([=] (-V- actions i 1) waiting)
			       	(&&
	       			(somp ([=] (-V- actions i 1) notstarted))
			       	(!! (somp ([=] (-V- actions i 1) executing)))
			       	(!! (somp ([=] (-V- actions i 1) parallel-executing)))
			       	(!! (somp ([=] (-V- actions i 1) done)))
			       	)
			       
		       	)
		      		
	      		(-> ;if it is executing then it has started in the past, not done in the past and not starting in the future
	            		(|| ([=] (-V- actions i 1) executing) ([=] (-V- actions i 1) parallel-executing))
	            		(&&
	                              (somp ([=] (-V- actions i 1) notstarted))
	                              (somp ([=] (-V- actions i 1) waiting))
	                              (!! (somp ([=] (-V- actions i 1) done)))
	                              (!! (somf ([=] (-V- actions i 1) notstarted)))
	                              (!! (somf ([=] (-V- actions i 1) waiting)))
	                              (somf ([=] (-V- actions i 1) done))
	                     )
	      		)

	      		(->
	      			([=] (-V- actions i 1) pause) 
					(&&
                      (||(somp ([=] (-V- actions i 1) executing)) (somp ([=] (-V- actions i 1) parallel-executing)))
                      (||(somf ([=] (-V- actions i 1) executing)) (somf ([=] (-V- actions i 1) parallel-executing)))
                      (!! (somf ([=] (-V- actions i 1) notstarted)))
			       	  (!! (somf ([=] (-V- actions i 1) waiting)))
                 

                    )
	      		)

	      		; (->

	      		; 	([=] (-V- actions i 1) pause) 
	      		; 	(&& 
	      		; 		([=](-V- Arm1 2)0)
	      		; 		([=](-V- Arm1 3)0)
	      		; 		([=](-V- Arm2 2)0)
	      		; 		([=](-V- Arm2 3)0)
	      		; 		([=](-V- End_Eff_F 2)0)
	      		; 		([=](-V- End_Eff_F 3)0)
	      		; 		([=](-V- End_Eff_B 2)0)
	      		; 		([=](-V- End_Eff_B 3)0)
      			; 	)

      			; )



	      		(->
	      			(-E- j actions-indexes
						(&&
							([=] (-V- actions i 1) executing)
							([!=] j i)
							(||
								([=] (-V- actions j 1) executing)
								([=] (-V- actions j 1) parallel-executing)
							)
						)
						)
					
							([=] (-V- actions i 1) parallel-executing)

	      				
					)
      			

	      		;
	      		 
	      		(->
	      			(&& 
	      				([=] (-V- actions i 1) waiting) 
	      				(!! (-E- j actions-indexes 
		      					(&& 
		      						([=] (-V- actions j 1) waiting)
		      					 	([!=] j i)
		      					 )
      						)
      					)
	      			)
	      			(||
	      			(next ([=] (-V- actions i 1) executing))
	      			(next ([=] (-V- actions i 1) parallel-executing))
	      			)
	      		)



	      		;;running Action is the one which is waiting with higher priority

	      		(->
	      			(&& 
	      				([=] (-V- actions i 1) waiting)
	      				(-E- j actions-indexes 
	      					(&& 
	      						([=] (-V- actions j 1) waiting)
	      						([!=] j i)
	      						([>] (-V- actions i 0) (-V- actions j 0))
	      						)
      						)
      				)

      				(||
		      			(next ([=] (-V- actions i 1) executing))
		      			(next ([=] (-V- actions i 1) parallel-executing))
	      			)
	      		)


	      		;;the other one remains waiting or goes backto notstrated due to violations of pre-cond meanwhile


				(->
	      			(&& 
	      				
	      				 ([=] (-V- actions i 1) waiting)

	      				
	      				(-E- j actions-indexes 
	      					(&& 
	      						([=] (-V- actions j 1) waiting)
	      						([!=] j i)
	      						([>] (-V- actions j 0) (-V- actions i 0))
	      						)
      						)
      				)

      				(||
		      			(next ([=] (-V- actions i 1) notstarted))
		      			(next ([=] (-V- actions i 1) waiting))
	      			)
	      		)




				;; if two actions have same priority then parallel exe
	      		(->
	      			(&& 
	      				([=] (-V- actions i 1) waiting)
	      				(-E- j actions-indexes 
	      					(&& 
	      						([=] (-V- actions j 1) waiting)
	      						([!=] j i)
		      				  	([=] (-V- actions i 0) (-V- actions j 0))
		      				  	)
		      				  )
	      				)
	      			;(&&
	      				(next ([=] (-V- actions i 1) parallel-executing))
	      			;	(next ([=] (-V- actions j 1) parallel-executing))
      				;)
	      		)


	      		(->
	      			([=] (-V- actions i 1) parallel-executing)
	      			(-E- j actions-indexes
	      				(&&
		      				([=] (-V- actions j 1) parallel-executing)
		      				([!=] j i)
	      				)

	      			)
      			)


	      		(-> 
	            		([=] (-V- actions i 1) done)

	            		(&&
	            			;when a Action is done it remains done until loop for jigs 
	            			(alwf ([=] (-V- actions i 1) done))
	            			; (until_ie ([=] (-V- actions i 1) done) (-P- JigLoop))
	            			


	            			;if its done then it was executing in the past
	            			(somp 
	            				(||
		            				([=] (-V- actions i 1) executing)
		            				([=] (-V- actions i 1) parallel-executing)
	            				)
	            			)
	            			;no pause within "exe_time" time units 
	            			(!! (withinp_ie ([=] (-V- actions i 1) pause) 3))

	            			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;NOTE::::////exetime must be instead of 3
	            		)
	            		
	      		)
	      		
			)
		)
	)
)


;;1. the operator moves to the bin
(defconstant *Action1* 

	 (&&

	 	(<->
	 		(-P- Action1_Pre) 
	 		(&& 
	 			;;robot not moving
	 			([=](-V- ARM1) (yesterday(-V- ARM1)))
	 			([=](-V- ARM2) (yesterday(-V- ARM2)))
 			)

 		)

 		(<->
 			(-P- Action1_Post)
 			([=](-V- Body_Part 8) L_5)
		)

		(<->
			(-P- Action1_SafetyPro)
			(&& 
	 			;;robot not moving
	 			([=](-V- ARM1) (yesterday(-V- ARM1)))
	 			([=](-V- ARM2) (yesterday(-V- ARM2)))
 			)
		)

		(->
			(&& (yesterday (|| ([=] (-V- actions 1 1) executing) ([=] (-V- actions 1 1) parallel-executing))) (!! (-P- Action1_SafetyPro)))
			(until_ie ([=] (-V- actions 1 1) pause)(-P- Action1_SafetyPro))

		)
		
		(->
			(&& (yesterday ([=] (-V- actions 1 1) pause)) (-P- Action1_SafetyPro))
			(|| ([=] (-V- actions 1 1) executing) ([=] (-V- actions 1 1) parallel-executing))
		)

		;;;
	 	(->
			(&& ([=] (-V- actions 1 1) waiting) (yesterday([=] (-V- actions 1 1) notstarted)))
			(yesterday (-P- Action1_Pre))
		)

		(Alwf
			(->
				(|| 
					([=] (-V- actions 1 1) executing)
					([=] (-V- actions 1 1) parallel-executing)
				)
				(-P- Action1_SafetyPro)
			)
		)

		(->
			(&& ([=] (-V- actions 1 1) done) (yesterday (|| ([=] (-V- actions 1 1) executing) ([=](-V- actions 1 1) parallel-executing))))
			(-P- Action1_Post)
	 	)

	 )
)

;;2. he grasps a part
(defconstant *Action2* 
	(&&

		(<->
	 		(-P- Action2_Pre) 
	 		(&& 
	 			([=](-V- Body_Part 8) L_5)
	 			([=](-V- ARM1) (yesterday(-V- ARM1)))
	 			([=](-V- ARM2) (yesterday(-V- ARM2)))
 			)

 		)

 		(<->
 			(-P- Action2_Post)
 			(&& 
				([=](-V- ARM1) (yesterday(-V- ARM1)))
	 			([=](-V- ARM2) (yesterday(-V- ARM2)))
				(-P- partTaken)

		 	)
		)

		(<->
			(-P- Action2_SafetyPro)
			(&&
				([=](-V- ARM1) (yesterday(-V- ARM1)))
	 			([=](-V- ARM2) (yesterday(-V- ARM2)))
 			)
		)

		(->
			(&& (yesterday (|| ([=] (-V- actions 2 1) executing) ([=] (-V- actions 2 1) parallel-executing))) (!! (-P- Action2_SafetyPro)))
			(until_ie ([=] (-V- actions 2 1) pause)(-P- Action2_SafetyPro))

		)
		
		(->
			(&& (yesterday ([=] (-V- actions 2 1) pause)) (-P- Action2_SafetyPro))
			(|| ([=] (-V- actions 2 1) executing) ([=] (-V- actions 2 1) parallel-executing))
		)

		;;;

		(->
			(&& ([=] (-V- actions 2 1) waiting) (yesterday([=] (-V- actions 2 1) notstarted)))
			(yesterday (-P- Action2_Pre))
		)

		(Alwf
			(->
				(|| 
					([=] (-V- actions 2 1) executing)
					([=] (-V- actions 2 1) parallel-executing)
				)
				(-P- Action2_SafetyPro)
			)
		)	

		(->
			(&& ([=] (-V- actions 2 1) done) (yesterday (|| ([=] (-V- actions 2 1) executing)([=] (-V- actions 2 1) executing)))) 
			(-P- Action2_Post)
	 	)

	 	
 	)
)

;;3. he takes the part to the tombstone
(defconstant *Action3* 

	(&&

		(<->
	 		(-P- Action3_Pre) 
			(&& 
				([=](-V- ARM1) (yesterday(-V- ARM1)))
	 			([=](-V- ARM2) (yesterday(-V- ARM2)))
				(-P- partTaken)

		 	)	 		

 		)

 		(<->
 			(-P- Action3_Post)
 			(&& 
				([=](-V- Body_Part 8) L_6)	
				([=](-V- ARM1) (yesterday(-V- ARM1)))
	 			([=](-V- ARM2) (yesterday(-V- ARM2)))
				(-P- partTaken)
	 		)
 			
		)

		(<->
			(-P- Action3_SafetyPro)
			(&&

				([=](-V- ARM1) (yesterday(-V- ARM1)))
	 			([=](-V- ARM2) (yesterday(-V- ARM2)))
				(-P- partTaken)
			)

		)
		(->
			(&& (yesterday (|| ([=] (-V- actions 3 1) executing) ([=] (-V- actions 3 1) parallel-executing))) (!! (-P- Action3_SafetyPro)))
			(until_ie ([=] (-V- actions 3 1) pause)(-P- Action3_SafetyPro))

		)
		
		(->
			(&& (yesterday ([=] (-V- actions 3 1) pause)) (-P- Action3_SafetyPro))
			(|| ([=] (-V- actions 3 1) executing) ([=] (-V- actions 3 1) parallel-executing))
		)

		;;



		(->
			(&& ([=] (-V- actions 3 1) waiting) (yesterday([=] (-V- actions 3 1) notstarted)))
			(yesterday (-P- Action3_Pre))
		)

		(Alwf
			(->
				(|| 
					([=] (-V- actions 3 1) executing)
					([=] (-V- actions 3 1) parallel-executing)
				)
				(-P- Action3_SafetyPro)
			)
		)	

		(->
			(&& ([=] (-V- actions 3 1) done) (yesterday (|| ([=] (-V- actions 3 1) executing)([=] (-V- actions 3 1) executing))))
			(-P- Action3_Post)
			
	 	)
 )
	)

;;4. he puts the part on the stone
(defconstant *Action4* 
	(&&



		(<->
	 		(-P- Action4_Pre) 
	 		(&& 
				([=](-V- Body_Part 8) L_6)	
				([=](-V- ARM1) (yesterday(-V- ARM1)))
	 			([=](-V- ARM2) (yesterday(-V- ARM2)))
				(-P- partTaken)
	 		)

 		)

 		(<->
 			(-P- Action4_Post)
 			(&& 
				([=](-V- Body_Part 8) L_6)	
				([=](-V- ARM1) (yesterday(-V- ARM1)))
	 			([=](-V- ARM2) (yesterday(-V- ARM2)))
				(-P- partFixed)
	 		)
		)

		(<->
			(-P- Action4_SafetyPro)
			(&&

				([=](-V- ARM1) (yesterday(-V- ARM1)))
	 			([=](-V- ARM2) (yesterday(-V- ARM2)))

			)

		)

		(->
			(&& (yesterday (|| ([=] (-V- actions 4 1) executing) ([=] (-V- actions 4 1) parallel-executing))) (!! (-P- Action4_SafetyPro)))
			(until_ie ([=] (-V- actions 4 1) pause)(-P- Action4_SafetyPro))

		)
		
		(->
			(&& (yesterday ([=] (-V- actions 4 1) pause)) (-P- Action4_SafetyPro))
			(|| ([=] (-V- actions 4 1) executing) ([=] (-V- actions 4 1) parallel-executing))
		)

		;;

		(->
			(&& ([=] (-V- actions 4 1) waiting) (yesterday([=] (-V- actions 4 1) notstarted)))
			(yesterday (-P- Action4_Pre))
		)

		(Alwf
			(->
				(|| 
					([=] (-V- actions 4 1) executing)
					([=] (-V- actions 4 1) parallel-executing)
				)
				(-P- Action4_SafetyPro)
			)
		)	

		(->
			(&& ([=] (-V- actions 4 1) done) (yesterday (|| ([=] (-V- actions 4 1) executing)([=] (-V- actions 4 1) executing)))) 
			(-P- Action4_Post)
	 	)

	 )
 )

;;5. robot moves from home to stone/ operator holds the part
(defconstant *Action5* 
	(&&


		(<->
	 		(-P- Action5_Pre) 
			(&& 
				([=](-V- Body_Part 8) L_6)	
				(-P- partFixed)
	 		)
	

 		)

 		(<->
 			(-P- Action5_Post)
 			(&& 
				([=](-V- Body_Part 8) L_6)	
				(-P- partFixed)
				([=](-V- ARM1) (yesterday(-V- ARM1)))
	 			([=](-V- ARM2) (yesterday(-V- ARM2)))
	 			([=](-V- End_Eff_B) L_6)

	 		)	
		)

		(<->
			(-P- Action5_SafetyPro)
			(&&
				([=](-V- Body_Part 8) L_6)	
				(-P- partFixed)

				(-A- i body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] i 6)
						([!=](-V- Body_Part i) L_6)
					)
				)
			)
					

		)

		(->
			(&& (yesterday (|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))) (!! (-P- Action5_SafetyPro)))
			(until_ie ([=] (-V- actions 5 1) pause)(-P- Action5_SafetyPro))

		)
		
		(->
			(&& (yesterday ([=] (-V- actions 5 1) pause)) (-P- Action5_SafetyPro))
			(|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))
		)

		;;

		(->
			(&& ([=] (-V- actions 5 1) waiting) (yesterday([=] (-V- actions 5 1) notstarted)))
			(yesterday (-P- Action5_Pre))
		)

		(Alwf
			(->
				(|| 
					([=] (-V- actions 5 1) executing)
					([=] (-V- actions 5 1) parallel-executing)
				)
				(-P- Action5_SafetyPro)
			)
		)	


		(->
			(&& ([=] (-V- actions 5 1) done) (yesterday (|| ([=] (-V- actions 5 1) executing)([=] (-V- actions 5 1) executing))))
			(-P- Action5_SafetyPro)

	 	)
	 )
 )

;6.operator prepares a jig
(defun Action6(i) 
	(&&
		  

		(defvar j (+ (* i 6) 6))



		(<->
	 		(-P- Action6_Pre) 
	 		(||
	 			(&& 
					([=](-V- Body_Part 8) L_6)	
					(-P- partFixed)
					([=](-V- ARM1) (yesterday(-V- ARM1)))
		 			([=](-V- ARM2) (yesterday(-V- ARM2)))
		 			([=](-V- End_Eff_B) L_6)
		 		)

		 		(&& 
					([=](-V- Body_Part 8) L_6)	
					(-P- partFixed)
					([=](-V- ARM1) (yesterday(-V- ARM1)))
		 			([=](-V- ARM2) (yesterday(-V- ARM2)))
		 			([=](-V- End_Eff_B) L_6)
		 			(-P- NewIteration)
		 		)
	 		)	

 		)

 		(<->
 			(-P- Action6_Post)
 			(&& 
				([=](-V- Body_Part 8) L_6)	
				(-P- partFixed)
				([=](-V- ARM1) (yesterday(-V- ARM1)))
	 			([=](-V- ARM2) (yesterday(-V- ARM2)))
	 			([=](-V- End_Eff_B) L_6)
	 			(-P- preparedJig)
	 			(!! (-P- NewIteration))


	 		)	
		)


		(<->
			(-P- preparedjig)
			(&& ([=](-V- actions j 1) done) (!! ([=](-V- actions (+ (* i 6) 8) 1) done)))
			)

		(<->
			(-P- Action6_SafetyPro)
			(&&
				([=](-V- Body_Part 8) L_6)	
				(-P- partFixed)
				([=](-V- ARM1) (yesterday(-V- ARM1)))
	 			([=](-V- ARM2) (yesterday(-V- ARM2)))
	 			([=](-V- End_Eff_B) L_6)
	 			(!! ([=] (-V- actions (+ (* i 6) 7) 1) executing))
	 			(-A- i body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] i 6)
						([!=](-V- Body_Part i) L_6)
					)
				)
			)
		)


		(->
			(&& (yesterday (|| ([=] (-V- actions j 1) executing) ([=] (-V- actions j 1) parallel-executing))) (!! (-P- Action6_SafetyPro)))
			(until_ie ([=] (-V- actions j 1) pause)(-P- Action6_SafetyPro))

		)
		
		(->
			(&& (yesterday ([=] (-V- actions j 1) pause)) (-P- Action6_SafetyPro))
			(|| ([=] (-V- actions j 1) executing) ([=] (-V- actions j 1) parallel-executing))
		)

		;;

		(->
			(&& ([=] (-V- actions j 1) waiting) (yesterday([=] (-V- actions j 1) notstarted)))
			(yesterday (-P- Action6_Pre))
		)
		
		(Alwf
			(->
				(|| 
					([=] (-V- actions j 1) executing)
					([=] (-V- actions j 1) parallel-executing)
				)
				(-P- Action6_SafetyPro)
			)
		)	
		
	 )
)

;; 7. robot moves toward stone/ operator holds the part
(defun Action7(i)
	(&&
		  
		(defvar j (+ (* i 6) 7))
		
		(<->
	 		(-P- Action7_Pre) 
	 		(&& 
		 		([=](-V- Body_Part 8) L_6)	
				(-P- partFixed)
	 			([=](-V- End_Eff_B) L_6)
	 			(-P- preparedjig)
 			)
 		)

 		(<->
 			(-P- Action7_Post)
 			(&&
 				([=](-V- Body_Part 8) L_6)	
				(-P- partFixed)
	 			([=](-V- End_Eff_B) L_6)
	 			(!! ([=] (-V- actions (+ (* i 6) 7) 1) executing))
	 			(-A- i body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] i 6)
						([!=](-V- Body_Part i) L_6)
					)
				)
				(-P- ScrewDriveReady)
				(-P- preparedjig)
			)
		)
 			
		(<->
			(-P- Action7_SafetyPro)
			(&&
				([=](-V- Body_Part 8) L_6)	
				(-P- partFixed)
	 			([=](-V- End_Eff_B) L_6)
	 			(-P- preparedjig)
	 			(-A- i body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] i 6)
						([!=](-V- Body_Part i) L_6)
					)
				)
			)

		)

		(->
			(&& (yesterday (|| ([=] (-V- actions j 1) executing) ([=] (-V- actions j 1) parallel-executing))) (!! (-P- Action7_SafetyPro)))
			(until_ie ([=] (-V- actions j 1) pause) (-P- Action7_SafetyPro))

		)
		
		(->
			(&& (yesterday ([=] (-V- actions j 1) pause)) (-P- Action7_SafetyPro))
			(|| ([=] (-V- actions j 1) executing) ([=] (-V- actions j 1) parallel-executing))
		)

		;;

		(Alwf
			(->
				(|| 
					([=] (-V- actions j 1) executing)
					([=] (-V- actions j 1) parallel-executing)
				)
				(-P- Action7_SafetyPro)
			)
		)
	 	
		(->
			(&& ([=] (-V- actions j 1) done) (yesterday (|| ([=] (-V- actions j 1) executing)([=] (-V- actions j 1) executing))))
			(-P- Action7_Post)
	 	)

	 )
)

;;8. robot screws the prepared jig of a part/ operator holds the part
(defun Action8(i) 
	(&&
		  
		(defvar j (+ (* i 6) 8))

		(<->
	 		(-P- Action8_Pre) 
	 		(&& 
	 			(-P- preparedjig)

	 			([=](-V- Body_Part 8) L_6)	
				(-P- partFixed)
	 			([=](-V- End_Eff_B) L_6)
	 		
	 			(-A- i body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] i 6)
						([!=](-V- Body_Part i) L_6)
					)
				)
	 			(-P- ScrewDriveReady)
 			)

 		)


 		(<->
 			(-P- ScrewDriveReady)
 			(&& ([=] (-V- actions (+ (* i 6) 7) 1) done) (!!([=] (-V- actions j 1) done)))
 			)

 		

 		(<->
 			(-P- Action8_Post)
 			(&&
				([=](-V- Body_Part 8) L_6)	
				(-P- partFixed)
	 			([=](-V- End_Eff_B) L_6)
	 		
	 			(-A- i body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] i 6)
						([!=](-V- Body_Part i) L_6)
					)
				)
				(defvar jigs (1- jigs))
			)
 			
		)

		(<->
			(-P- Action8_SafetyPro)
			
			(&&
				([=](-V- Body_Part 8) L_6)	
				(-P- partFixed)
	 			([=](-V- End_Eff_B) L_6)
	 		
	 			(-A- i body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] i 6)
						([!=](-V- Body_Part i) L_6)
					)
				)
			)
		)

		(->
			(&& (yesterday (|| ([=] (-V- actions j 1) executing) ([=] (-V- actions j 1) parallel-executing))) (!! (-P- Action8_SafetyPro)))
			(until_ie ([=] (-V- actions j 1) pause)(-P- Action8_SafetyPro))

		)
		
		(->
			(&& (yesterday ([=] (-V- actions 8 1) pause)) (-P- Action8_SafetyPro))
			(|| ([=] (-V- actions j 1) executing) ([=] (-V- actions j 1) parallel-executing))
		)

		;;

		(->
			(&& ([=] (-V- actions j 1) waiting) (yesterday([=] (-V- actions j 1) notstarted)))
			(yesterday (-P- Action8_Pre))
		)

		

		(Alwf
			(->
				(|| 
					([=] (-V- actions j 1) executing)
					([=] (-V- actions j 1) parallel-executing)
				)
				(-P- Action8_SafetyPro)
			)
		)

	 

	 )
 )

;;9. robot moves backward from the stone/ operator holds the part
(defun Action9(i) 
	(&&
		  
		(defvar j (+ (* i 6) 9))

		(<->
	 		(-P- Action9_Pre) 
	 		(&&
				([=](-V- Body_Part 8) L_6)	
				(-P- partFixed)
	 			([=](-V- End_Eff_B) L_6)
	 		
	 			(-A- i body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] i 6)
						([!=](-V- Body_Part i) L_6)
					)
				)
			)

 		)

 		(<->
 			(-P- Action9_Post)
 			(&&
				([=](-V- Body_Part 8) L_6)	
				(-P- partFixed)
	 			([=](-V- End_Eff_B) L_6)
	 		
	 			(-A- i body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] i 6)
						([!=](-V- Body_Part i) L_6)
					)
				)
			)
 			
		)

		(<->
			(-P- Action9_SafetyPro)
			(&&
				([=](-V- Body_Part 8) L_6)	
				(-P- partFixed)
	 			([=](-V- End_Eff_B) L_6)
	 		
	 			(-A- i body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] i 6)
						([!=](-V- Body_Part i) L_6)
					)
				)
			)

		)

		(->
			(&& (yesterday (|| ([=] (-V- actions j 1) executing) ([=] (-V- actions j 1) parallel-executing))) (!! (-P- Action9_SafetyPro)))
			(until_ie ([=] (-V- actions j 1) pause)(-P- Action9_SafetyPro))

		)
		
		(->
			(&& (yesterday ([=] (-V- actions j 1) pause)) (-P- Action9_SafetyPro))
			(|| ([=] (-V- actions j 1) executing) ([=] (-V- actions j 1) parallel-executing))
		)

		;;

		(->
			(&& ([=] (-V- actions j 1) waiting) (yesterday([=] (-V- actions j 1) notstarted)))
			(yesterday (-P- Action9_Pre))
			
		)

		(Alwf
			(->
				(|| 
					([=] (-V- actions j 1) executing)
					([=] (-V- actions j 1) parallel-executing)
					
				)
				(-P- Action9_SafetyPro)
			)
		)

	 	;;
		(->
			(&& ([=] (-V- actions j 1) done) (yesterday (|| ([=] (-V- actions j 1) executing)([=] (-V- actions j 1) executing))))
			(-P- Action9_Post)

	 	)
	)
 )

;;10. robot checks the number of jigs/ operator holds the part
(defun Action10(i) 
	(&&

		  
		(defvar j (+ (* i 6) 10))

		(<->
	 		(-P- Action10_Pre) 
	 		(&&
				([=](-V- Body_Part 8) L_6)	
				(-P- partFixed)
	 			([=](-V- End_Eff_B) L_6)
	 		
	 			(-A- i body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] i 6)
						([!=](-V- Body_Part i) L_6)
					)
				)
			)

 		)



 		(<->
 			(-P- Action10_Post)
 			(&&
				([=](-V- Body_Part 8) L_6)	
				(-P- partFixed)
	 			([=](-V- End_Eff_B) L_6)
	 		
	 			(-A- i body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] i 6)
						([!=](-V- Body_Part i) L_6)
					)
				)
			)

 			
		)

		(<->
			(-P- Action10_SafetyPro)
			(&&
				([=](-V- Body_Part 8) L_6)	
				(-P- partFixed)
	 			([=](-V- End_Eff_B) L_6)
	 		
	 			(-A- i body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] i 6)
						([!=](-V- Body_Part i) L_6)
					)
				)
			)		

		)

		(->
			(&& (yesterday (|| ([=] (-V- actions j 1) executing) ([=] (-V- actions j 1) parallel-executing))) (!! (-P- Action10_SafetyPro)))
			(until_ie ([=] (-V- actions j 1) pause)(-P- Action10_SafetyPro))

		)
		
		(->
			(&& (yesterday ([=] (-V- actions j 1) pause)) (-P- Action10_SafetyPro))
			(|| ([=] (-V- actions j 1) executing) ([=] (-V- actions j 1) parallel-executing))
		)

		;;

		(->
			(&& ([=] (-V- actions j 1) waiting) (yesterday([=] (-V- actions j 1) notstarted)))
			(yesterday (-P- Action10_Pre))
		)

		(Alwf
			(->
				(|| 
					([=] (-V- actions j 1) executing)
					([=] (-V- actions j 1) parallel-executing)
					
				)
				(-P- Action10_SafetyPro)
			)
		)
		
	 	
	 )
)

;11. go back to action6
(defun Action11(i)

	(&&

		(defvar j (+ (* i 6) 11))

		(<->

	 		(-P- Action11_Pre) 
	 		(&&
	 			([>] jigs 0)
				([=](-V- Body_Part 8) L_6)	
				(-P- partFixed)
	 			([=](-V- End_Eff_B) L_6)
	 			([=](-V- ARM1) (yesterday(-V- ARM1)))
	 			([=](-V- ARM2) (yesterday(-V- ARM2)))
	 		
	 			(-A- i body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] i 6)
						([!=](-V- Body_Part i) L_6)
					)
				)
			)

 		)

		(<->
	 		(-P- Action11_Post) 
	 		(next (-P- NewIteration))
	 		

 		)

 		)
	)
;;12. else operator releases the part and moves back
(defconstant *Action12* 
	 (&&

	

 		(<->
 			(-P- Action12_Post)
 			(&& 
 				([=] jigs 0)
				
				(!! (-P- partTaken))
				(!! (-P- partHold))
				(-A- i body_indexes 
					  ; no part on pallet
						([!=](-V- Body_Part i) L_6)
					
				)

				
			)	
		)
			;;no pre cond defined yet
			; (<->

		 ; 		(-P- Action12_Pre) 
		 		;;number of jigs

	 	; 	)

		(<->
			(-P- Action12_SafetyPro)
			(&&
				([=](-V- ARM1) (yesterday(-V- ARM1)))
	 			([=](-V- ARM2) (yesterday(-V- ARM2)))
	 			([=](-V- End_Eff_B) (yesterday(-V- End_Eff_B)))
 			)

		)

		(->
			(&& (yesterday (|| ([=] (-V- actions 12 1) executing) ([=] (-V- actions 12 1) parallel-executing))) (!! (-P- Action12_SafetyPro)))
			(until_ie ([=] (-V- actions 12 1) pause)(-P- Action12_SafetyPro))

		)
		
		(->
			(&& (yesterday ([=] (-V- actions 12 1) pause)) (-P- Action12_SafetyPro))
			(|| ([=] (-V- actions 12 1) executing) ([=] (-V- actions 12 1) parallel-executing))
		)

		;;

		(Alwf
			(->
				(|| 
					([=] (-V- actions 12 1) executing)
					([=] (-V- actions 12 1) parallel-executing)
				)
				(-P- Action12_SafetyPro)
			)
		)
	 	
		(->
			(&& ([=] (-V- actions 12 1) done) (yesterday (|| ([=] (-V- actions 12 1) executing)([=] (-V- actions 12 1) executing))))
			(-P- Action12_Post)
	 	)
 	)
)

;;13. robot moves from stone to the home
(defconstant *Action13* 
	(&&


		(<->
	 		(-P- Action13_Pre) 
	 		(-P- Action12_Post)

 		)


 		(<->
	 		(-P- Action13_SafetyPro) 
	 		(-P- Action12_Post)

 		)

 		(<->
 			(-P- Action13_Post)
				(&& 
					([=](-V- ARM1) L_1)
 					([=](-V- ARM2) L_2)
 					([=](-V- End_Eff_B) L_2)
				)
			
		)

		(<->
			(-P- Action13_SafetyPro)
			(until_ii (&& (!! (-P- partTaken)) (!! (-P- partHold)) (!! ([=] (-V- opZone) 4))) ([=] (-V- actions 13 1) done))

		)

		(->
			(&& (yesterday (|| ([=] (-V- actions 13 1) executing) ([=] (-V- actions 13 1) parallel-executing))) (!! (-P- Action13_SafetyPro)))
			(until_ie ([=] (-V- actions 13 1) pause)(-P- Action13_SafetyPro))

		)
		
		(->
			(&& (yesterday ([=] (-V- actions 13 1) pause)) (-P- Action13_SafetyPro))
			(|| ([=] (-V- actions 13 1) executing) ([=] (-V- actions 13 1) parallel-executing))
		)

		;;


		(->
			(&& ([=] (-V- actions 13 1) waiting) (yesterday([=] (-V- actions 13 1) notstarted)))
			(yesterday (-P- Action13_Pre))
		)

		

		(Alwf
			(->
				(|| 
					([=] (-V- actions 13 1) executing)
					([=] (-V- actions 13 1) parallel-executing)
					
				)
				(-P- Action13_SafetyPro)
			)
		)

	 	(->
			(&& ([=] (-V- actions 13 1) done) (yesterday (|| ([=] (-V- actions 13 1) executing)([=] (-V- actions 13 1) executing))))
			(-P- Action13_Post)
		)
 	)
)

;;14. Operator holding the part
(defconstant *Action14*

	(&&

		 	(<->
		 		(-P- Action14_Pre) 
		 		(&&
		 			([=](-V- Body_Part 8) L_6)	
					(-P- partFixed)
		 			([=](-V- End_Eff_B) L_6)
		 			(!!(-P- partHold))
	 			)
		 		
	 		)

	 		(<->
	 			(-P- Action14_Post)
	 			(!!(-P- partFixed))
			)

			(<->
				(-P- Action14_SafetyPro)
				(&&
		 			([=](-V- Body_Part 8) L_6)	
					(-P- partFixed)
		 			([=](-V- End_Eff_B) L_6)
	 			)
			)

			(->
				(&& (yesterday (|| ([=] (-V- actions 14 1) executing) ([=] (-V- actions 14 1) parallel-executing))) (!! (-P- Action14_SafetyPro)))
				(until_ie ([=] (-V- actions 14 1) pause)(-P- Action1_SafetyPro))

			)
			
			(->
				(&& (yesterday ([=] (-V- actions 14 1) pause)) (-P- Action14_SafetyPro))
				(|| ([=] (-V- actions 14 1) executing) ([=] (-V- actions 14 1) parallel-executing))
			)

			;;;
		 	(->
				(&& ([=] (-V- actions 14 1) waiting) (yesterday([=] (-V- actions 14 1) notstarted)))
				(yesterday (-P- Action14_Pre))
			)

			(Alwf
				(->
					(|| 
						([=] (-V- actions 14 1) executing)
						([=] (-V- actions 14 1) parallel-executing)
					)
					(-P- Action14_SafetyPro)
				)
			)

			(alwf 
				(<->
					(-P- partFixed)
					([=] (-V- actions 14 1) executing)
					)
				)

			(->
				(&& ([=] (-V- actions 14 1) done) (yesterday (|| ([=] (-V- actions 14 1) executing) ([=](-V- actions 14 1) parallel-executing))))
				(-P- Action14_Post)
		 	)

		 )

)


(defconstant *LoopManager*

	(&&
		; (setq iteration_index 0)
		(-A- k jigs_indexes

			;(->
				;([<=] iteration_index jigs)
				(&& 
					(Action6 k)
					(Action7 k)
					(Action8 k)
					(Action9 k)
					(Action10 k)
					(Action11 k)
					; (setq iteration_index (1+ iteration_index))
				)
			;)
		)
	)
)




