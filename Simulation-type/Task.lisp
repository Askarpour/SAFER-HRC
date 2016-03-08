; actions(i 0) -->priority
; actions(i 1) -->status
; actions(i 2) -->exeTime
; actions(i 3) -->subject
;; Task Parameters
	(define-tvar actions *int* *int* *int*)
	(defvar actions-indexes (loop for i from 1 to 14 collect i))
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
	;screw driving Parameters
		(define-var preparedJigs *int*)
		(defconstant jigs 5)

	;subject identifier
		
		(defconstant operator 1)
		(defconstant robot 2)
	




(defconstant *ActionInit*

 (alwf 

 	(&&

 		; ;status among 1 to 5
	  ;      (-A- i actions-indexes
	  ;     	 (&& ([>=] (-V- actions i 1) 0) ([<=] (-V- actions i 1) 5))

	  ;      )

	     ; Initialization of priority
	     
	 	    
	 	     	 ([=] (-V- actions 1 0) 13)
		 	 	 ([=] (-V- actions 2 0) 12)
		 	 	 ([=] (-V- actions 3 0) 11)
		 	 	 ([=] (-V- actions 4 0) 10)
		 	 	 ([=] (-V- actions 5 0) 9)
		 	 	 ([=] (-V- actions 6 0) 8)
		 	     ([=] (-V- actions 7 0) 7)
	    	     ([=] (-V- actions 8 0) 6)
		 	 	 ([=] (-V- actions 9 0) 5)
		 	 	 ([=] (-V- actions 10 0) 4)
		 	 	 ([=] (-V- actions 11 0) 3)
		 	 	 ([=] (-V- actions 12 0) 2)
		 	 	 ([=] (-V- actions 13 0) 1)
 		 	 	 ([=] (-V- actions 14 0) 1)
	 	 	 	
	 	    
	 	  

	 	 ; Initialization of exe-time
	 	    
	 	    
		 	 	 ([=] (-V- actions 1 2) 3)
		 	 	 ([=] (-V- actions 2 2) 3)
		 	 	 ([=] (-V- actions 3 2) 3)
		 	 	 ([=] (-V- actions 4 2) 3)
		 	 	 ([=] (-V- actions 5 2) 3)
		 	 	 ([=] (-V- actions 6 2) 3)
		 	     ([=] (-V- actions 7 2) 3)
	    	     ([=] (-V- actions 8 2) 3)
		 	 	 ([=] (-V- actions 9 2) 3)
		 	 	 ([=] (-V- actions 10 2) 3)
		 	 	 ([=] (-V- actions 11 2) 3)
		 	 	 ([=] (-V- actions 12 2) 3)
		 	 	 ([=] (-V- actions 13 2) 3)
		 	 	 ([=] (-V- actions 14 2) 3)


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

	      		(->

	      			([=] (-V- actions i 1) pause) 
	      			(&& 
	      				([=](-V- Arm1 2)0)
	      				([=](-V- Arm1 3)0)
	      				([=](-V- Arm2 2)0)
	      				([=](-V- Arm2 3)0)
	      				([=](-V- End_Eff_F 2)0)
	      				([=](-V- End_Eff_F 3)0)
	      				([=](-V- End_Eff_B 2)0)
	      				([=](-V- End_Eff_B 3)0)
      				)

      			)



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
	            			;when a Action is done it remains done
	            			(alwf ([=] (-V- actions i 1) done))
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


;;;;;;;pre/post conditions in executing mode
;;1. the operator moves to the bin
(defconstant *Action1* 

	 (&&

	 	; (<->
	 	; 	(-P- Action1_Pre) 
	 	; 	(&& 
	 	; 		(InHome (-V- ARM1 0) (-V- ARM1 0))
	 	; 		(InHome (-V- ARM2 0) (-V- ARM2 0))
	 	; 		(InHome (-V- End_Eff_F 0) (-V- End_Eff_F 0))
	 	; 		(InHome (-V- End_Eff_F 0) (-V- End_Eff_F 0))
 		; 	)

 		; )

 		(<->
 			(-P- Action1_Post)
 			(|| ([=] (-V- opZone) 1) ([=] (-V- opZone) 2) ([=] (-V- opZone) 3))
		)

		(<->
			(-P- Action1_SafetyPro)
			(-P- idle)
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
	 		(&& ([=] (-V- opZone) 2) ([=] (-V- roZone) 0))

 		)

 		(<->
 			(-P- Action2_Post)
 			(&& 
				([=] (-V- opZone) 2)
				(-P- partTaken)
		 	)
		)

		(<->
			(-P- Action2_SafetyPro)
			(-P- idle)
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
			(&& (-P- partTaken) ([=] (-V- roZone) 0))	 		

 		)

 		(<->
 			(-P- Action3_Post)
 			(&& 
				([=] (-V- opZone) 4)
	 		)
 			
		)

		(<->
			(-P- Action3_SafetyPro)
			(&&

				(-P- idle)
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
	 		(&& ([=] (-V- opZone) 4) ([=] (-V- roZone) 0) (-P- partTaken))

 		)

 		(<->
 			(-P- Action4_Post)
 			(&& (-P- partHold) (-P- moving))
		)

		(<->
			(-P- Action4_SafetyPro)
			(&&

				(-P- idle)
				(-P- partTaken)
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
			(&& ([=] (-V- opZone) 4) (-P- partHold))
	

 		)

 		(<->
 			(-P- Action5_Post)
 			(&& ([=] (-V- roZone) 4) (!! (-P- moving)))	
		)

		(<->
			(-P- Action5_SafetyPro)
			(&&
				(-P- partHold)
				(!! (-P- clamping))
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

;;6. if no available jig then operator prepares a jig
(defconstant *Action6* 
	(&&


		(<->
	 		(-P- Action6_Pre) 
	 		(&& ([=] (-V- opZone) 4)([=] (-V- roZone) 4) (-P- partHold))

 		)
;;no post cond defined yet
 	; 	(<->
 	; 		(-P- Action6_Post)
 			
		; )

		(<->
			(-P- Action6_SafetyPro)
			(&&
				(-P- partHold)
				(!! (-P- clamping))
			)

		)

		(->
			(&& (yesterday (|| ([=] (-V- actions 6 1) executing) ([=] (-V- actions 6 1) parallel-executing))) (!! (-P- Action6_SafetyPro)))
			(until_ie ([=] (-V- actions 6 1) pause)(-P- Action6_SafetyPro))

		)
		
		(->
			(&& (yesterday ([=] (-V- actions 6 1) pause)) (-P- Action6_SafetyPro))
			(|| ([=] (-V- actions 6 1) executing) ([=] (-V- actions 6 1) parallel-executing))
		)

		;;

		(->
			(&& ([=] (-V- actions 6 1) waiting) (yesterday([=] (-V- actions 6 1) notstarted)))
			(yesterday (-P- Action6_Pre))
		)
		
		(Alwf
			(->
				(|| 
					([=] (-V- actions 6 1) executing)
					([=] (-V- actions 6 1) parallel-executing)
				)
				(-P- Action6_SafetyPro)
			)
		)	
		; (->
		; 	([=] (-V- actions 6) executing)
		; 		(until_ii (&& ([=] (-V- opZone) 4) ([=] (-V- roZone) 4)) ([=] (-V- actions 6) done))
	 ; 	)

		;;
		; (->
		; 	(&& ([=] (-V- actions 6) done) (yesterday ([=] (-V- actions 6) executing))) 
		; 	([=] (next (-V- preparedJigs)) ([+] (-V- preparedJigs) 1))

	 ; 	)
	 )
 )

;;7. robot moves toward stone/ operator holds the part
(defconstant *Action7* 
	(&&

		;;no pre condition defined yet	
		; (<->
	 ; 		(-P- Action7_Pre) 
	 		

 	; 	)

 		(<->
 			(-P- Action7_Post)
 			(-P- screw)
 			
		)

		(<->
			(-P- Action7_SafetyPro)
			(&&
				(-P- partHold)
				(!! (-P- clamping))
			)

		)

		(->
			(&& (yesterday (|| ([=] (-V- actions 7 1) executing) ([=] (-V- actions 7 1) parallel-executing))) (!! (-P- Action7_SafetyPro)))
			(until_ie ([=] (-V- actions 7 1) pause)(-P- Action7_SafetyPro))

		)
		
		(->
			(&& (yesterday ([=] (-V- actions 7 1) pause)) (-P- Action7_SafetyPro))
			(|| ([=] (-V- actions 7 1) executing) ([=] (-V- actions 7 1) parallel-executing))
		)

		;;

		(Alwf
			(->
				(|| 
					([=] (-V- actions 7 1) executing)
					([=] (-V- actions 7 1) parallel-executing)
				)
				(-P- Action7_SafetyPro)
			)
		)
	 	
		(->
			(&& ([=] (-V- actions 7 1) done) (yesterday (|| ([=] (-V- actions 7 1) executing)([=] (-V- actions 7 1) executing))))
			(-P- Action7_Post)
	 	)

	 )
 )

;;8. robot screws the prepared jig of a part/ operator holds the part
(defconstant *Action8* 
	(&&


		(<->
	 		(-P- Action8_Pre) 
	 		(&& ([=] (-V- opZone) 4) (yesterday (-P- partHold)))

 		)

 		;;no post cond defined yet

 	; 	(<->
 	; 		(-P- Action8_Post)
 			
		; )

		(<->
			(-P- Action8_SafetyPro)
			
			(&&
				(-P- partHold)
				(!! (-P- clamping))
			)
		)

		(->
			(&& (yesterday (|| ([=] (-V- actions 8 1) executing) ([=] (-V- actions 8 1) parallel-executing))) (!! (-P- Action8_SafetyPro)))
			(until_ie ([=] (-V- actions 8 1) pause)(-P- Action8_SafetyPro))

		)
		
		(->
			(&& (yesterday ([=] (-V- actions 8 1) pause)) (-P- Action8_SafetyPro))
			(|| ([=] (-V- actions 8 1) executing) ([=] (-V- actions 8 1) parallel-executing))
		)

		;;

		(->
			(&& ([=] (-V- actions 8 1) waiting) (yesterday([=] (-V- actions 8 1) notstarted)))
			(yesterday (-P- Action8_Pre))
		)

		

		(Alwf
			(->
				(|| 
					([=] (-V- actions 8 1) executing)
					([=] (-V- actions 8 1) parallel-executing)
				)
				(-P- Action8_SafetyPro)
			)
		)

	 

	 )
 )

;;9. robot moves backward from the stone/ operator holds the part
(defconstant *Action9* 
	(&&


		(<->
	 		(-P- Action9_Pre) 
	 		(&& ([=] (-V- opZone) 4) (-P- partHold) (!! (-P- clamping)))

 		)

 		(<->
 			(-P- Action9_Post)
 			(&& (!! (-P- screw)) (!! (-P- moveBackward)))
 			
		)

		(<->
			(-P- Action9_SafetyPro)
			(&&
				(-P- partHold)
				(!! (-P- clamping))
			)

		)

		(->
			(&& (yesterday (|| ([=] (-V- actions 9 1) executing) ([=] (-V- actions 9 1) parallel-executing))) (!! (-P- Action9_SafetyPro)))
			(until_ie ([=] (-V- actions 9 1) pause)(-P- Action9_SafetyPro))

		)
		
		(->
			(&& (yesterday ([=] (-V- actions 9 1) pause)) (-P- Action9_SafetyPro))
			(|| ([=] (-V- actions 9 1) executing) ([=] (-V- actions 9 1) parallel-executing))
		)

		;;

		(->
			(&& ([=] (-V- actions 9 1) waiting) (yesterday([=] (-V- actions 9 1) notstarted)))
			(yesterday (-P- Action9_Pre))
			
		)

		(Alwf
			(->
				(|| 
					([=] (-V- actions 9 1) executing)
					([=] (-V- actions 9 1) parallel-executing)
					
				)
				(-P- Action9_SafetyPro)
			)
		)

	 	;;
		(->
			(&& ([=] (-V- actions 9 1) done) (yesterday (|| ([=] (-V- actions 9 1) executing)([=] (-V- actions 9 1) executing))))
			(-P- Action9_Post)

	 	)
	)
 )

;;10. robot checks the number of jigs/ operator holds the part
(defconstant *Action10* 
	(&&

		(<->
	 		(-P- Action10_Pre) 
	 		(&& ([=] (-V- opZone) 4) (-P- partHold))

 		)
;;no post cond defined yet

 	; 	(<->
 	; 		(-P- Action10_Post)
 			
		; )

		(<->
			(-P- Action10_SafetyPro)
			(-P- idle)			

		)

		(->
			(&& (yesterday (|| ([=] (-V- actions 10 1) executing) ([=] (-V- actions 10 1) parallel-executing))) (!! (-P- Action10_SafetyPro)))
			(until_ie ([=] (-V- actions 10 1) pause)(-P- Action10_SafetyPro))

		)
		
		(->
			(&& (yesterday ([=] (-V- actions 10 1) pause)) (-P- Action10_SafetyPro))
			(|| ([=] (-V- actions 10 1) executing) ([=] (-V- actions 10 1) parallel-executing))
		)

		;;

		(->
			(&& ([=] (-V- actions 10 1) waiting) (yesterday([=] (-V- actions 10 1) notstarted)))
			(yesterday (-P- Action10_Pre))
		)

		(Alwf
			(->
				(|| 
					([=] (-V- actions 10 1) executing)
					([=] (-V- actions 10 1) parallel-executing)
					
				)
				(-P- Action10_SafetyPro)
			)
		)
		
	 	
	 )
)

;;12. else operator releases the part and moves back
(defconstant *Action12* 
	 (&&

	

 		(<->
 			(-P- Action12_Post)
 			(&& 
			
			
				(!! ([=] (-V- opZone) 4))
				(!! (-P- partTaken))
				(!! (-P- partHold))
				(-P- moving)
			)	
		)
			;;no pre cond defined yet
			; (<->
		 ; 		(-P- Action12_Pre) 
		 		

	 	; 	)

		(<->
			(-P- Action12_SafetyPro)
			(-P- idle)

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
	 		(&& (!! ([=] (-V- opZone) 4)) (!! (-P- partHold)))

 		)

 		(<->
 			(-P- Action13_Post)
				(&& 
					([=] (-V- roZone) 0)
					(!! (-P- partTaken))
					(!! (-P- partHold))
					(-P- idle)
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


(defconstant *Action14*

	(&&

		 ; 	(<->
		 ; 		(-P- Action14_Pre) 
		 		
	 	; 	)

	 	; 	(<->
	 	; 		(-P- Action14_Post)
	 			
			; )

			; (<->
			; 	(-P- Action14_SafetyPro)
				
			; )

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

			(->
				(&& ([=] (-V- actions 14 1) done) (yesterday (|| ([=] (-V- actions 14 1) executing) ([=](-V- actions 14 1) parallel-executing))))
				(-P- Action14_Post)
		 	)

		 )

)


(defconstant *ActionEndIt*
	
	(->
		(-A- i actions-indexes
		       ([=] (-V- actions i 1) done)
		)
		(&&
			;(next (!! (-P- readyToScrew)))
			(next (!! (-P- partHold)))
			(next (!! (-P- partTaken)))
			;(next ([=] (-V- preparedJigs) 0))
			(next (!! (-P- clamping)))
			([=] (-V- roZone) 0)
			(-A- i actions-indexes
		       ([=] (-V- actions i 1) notstarted)
			)
		)
	)
)


;;;pre/post conditions parallel executing mode 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

