;;Operator grasps and Robot Screw-drives
(defvar actions-indexes (loop for i from 1 to (+ 8 (* 6 ind)) collect i))
(defvar T1 1)
(defun T1(ind)
	(&&
		(alwf *ActionInitT1*)
		(alwf *Action1T1*)
		(alwf *Action2T1*)
		(alwf *Action3T1*)
		(alwf *Action4T1*)
		(alwf *Action5T1*)
		(alwf *Action6T1*)
		(alwf (ActionBeforeLastT1 (+ 6 1 (* 6 ind))))
		(alwf (ActionLastT1 (+ 6 2 (* 6 ind))))

		(loop for i from 0 to (- ind 1) collect 			
			 (Action7T1 (+ (* i 6) 7)))
		(loop for i from 0 to (- ind 1) collect 			
			 (Action8T1 (+ (* i 6) 8)))
		(loop for i from 0 to (- ind 1) collect 			
			 (Action9T1 (+ (* i 6) 9)))
		(loop for i from 0 to (- ind 1) collect 			
			 (Action10T1 (+ (* i 6) 10)))	
		(loop for i from 0 to (- ind 1) collect 			
			 (Action11T1 (+ (* i 6) 11)))	  			 
		(loop for i from 0 to (- ind 1) collect 			
			 (Action12T1 (+ (* i 6) 12)))

		)
	)
	; (format t "****~S****" (T1 jigs))

(defconstant *ActionInitT1*

 (alwf 

 	(&&
 		
 			 (-A- i actions-indexes
 			 	; (&& 
	 	 		; Initialization of exe-time
		 	 	 ([=] (-V- actions i 2 T1) 3)
		 	 	;  ([=] (-V- actions i 4 T1) 0)
	 	 	 ; )
		 	)


 	 	 ; Initialization of subject
 	 	 		 ([=] (-V- actions 1 3 T1) operator)
		 	 	 ([=] (-V- actions 2 3 T1) operator)
		 	 	 ([=] (-V- actions 3 3 T1) operator)
		 	 	 ([=] (-V- actions 4 3 T1) operator)
		 	 	 ([=] (-V- actions 5 3 T1) operator)
		 	 	 ([=] (-V- actions 6 3 T1) robot)
		 	 	
		 	 	 (-A- k jigs_indexes

			 	 (&&
			 	 	 ([=] (-V- actions (+  (* k 6) 7) 3 T1) operator)
			 	     ([=] (-V- actions (+  (* k 6) 8) 3 T1) robot)
		    	     ([=] (-V- actions (+  (* k 6) 9) 3 T1) robot)
			 	 	 ([=] (-V- actions (+  (* k 6) 10) 3 T1) robot)
			 	 	 ([=] (-V- actions (+  (* k 6) 11) 3 T1) robot)
			 	 	 ([=] (-V- actions (+  (* k 6) 12) 3 T1) robot)
		 	 	 )

		 	 	 )
		 	 	 ([=] (-V- actions (+  (* (- jigs 1) 6) 13) 3 T1) operator)
		 	 	 ([=] (-V- actions (+  (* (- jigs 1) 6) 14) 3 T1) robot)
		 	 	 
	 	 		
	 	 	 )
		)	 	 
	)
;;1. the operator moves to the bin
(defconstant *Action1T1* 

	 (&&

	 	(<->
	 		([=] (-V- Action_Pre 1 T1) 1) 
	 		(&& 
	 			; ([=](-V- End_Eff_B_Position) L_6)
	 			(-P- Robot_Homing)
 			)

 		)

 		(<->
 			([=] (-V- Action_Post 1 T1) 1)
 			(&&
 				; (!! (-P- End_Eff_facing_Operator))
 				(|| ([=](-V- Body_Part_pos hand) L_5_a) ([=](-V- Body_Part_pos hand) L_5_b))

 				(-P- Robot_Homing)
 			)
		)

	 )
)

;;2. he grasps a part
(defconstant *Action2T1* 
	(&&

		(<->
	 		([=] (-V- Action_Pre 2 T1) 1)
	 		(&& 
	 			([=] (-V- actions 1 1 T1) done)
	 			(|| ([=](-V- Body_Part_pos hand) L_5_a) ([=](-V- Body_Part_pos hand) L_5_b))
	 			(-P- Robot_Homing)
	 			; (!! (-P- End_Eff_facing_Operator))
 			)

 		)

 		(<->
 			([=] (-V- Action_Post 2 T1) 1)
 			(&& 
				(-P- partTaken)
				(-P- Robot_Homing)
				; (!! (-P- End_Eff_facing_Operator))

		 	)
		)
	 	
 	)
)

;;3. he takes the part to the tombstone
(defconstant *Action3T1* 

	(&&

		(<->
	 		([=] (-V- Action_Pre 3 T1) 1)
			(&& 
				([=] (-V- actions 2 1 T1) done)
				(-P- partTaken)
				(-P- Robot_Homing)
				; (!! (-P- End_Eff_facing_Operator))

		 	)	 		

 		)

 		(<->
 			([=] (-V- Action_Post 3 T1) 1)
 			(&& 
				(|| ([=](-V- Body_Part_pos hand) L_7) ([=](-V- Body_Part_pos hand) L_1))	

				(-P- partTaken)
				(-P- Robot_Homing)
				; (!! (-P- End_Eff_facing_Operator))
	 		)
 			
		)

	)
)

;;4. he puts the part on the stone
(defconstant *Action4T1* 
	(&&
		(<->
	 		([=] (-V- Action_Pre 4 T1) 1)
	 		(&& 
	 			([=] (-V- actions 3 1 T1) done)
				([=](-V- Body_Part_pos hand) L_1)	

				(-P- partTaken)
				(-P- Robot_Homing)
				; (!! (-P- End_Eff_facing_Operator))
	 		)

 		)

 		(<->
 			([=] (-V- Action_Post 4 T1) 1)
 			(&& 
				([=](-V- Body_Part_pos hand) L_1)	

				; (-P- partFixed)
				(-P- partTaken)
				(-P- Robot_Homing)
				; (!! (-P- End_Eff_facing_Operator))
	 		)
		)
		
	 )
 )

;;5. Operator holding the part
(defconstant *Action5T1*

	(&&

	 	(<->
	 		([=] (-V- Action_Pre 5) 1)
	 		(&&
	 			([=] (-V- actions 4 1) done)
	 			(-P- partTaken)
	 			([=](-V- Body_Part_pos hand) L_1)	
				; (-P- partFixed)
	 			([=](-V- End_Eff_B_Position) L_1)

	 			; (!! (-P- End_Eff_facing_Operator))
	 			; (!!(-P- partHold))
 			)
	 		
 		)
 		(->
 			(||
 				([=] (-V- actions 6 1 T1) executing)
 				([=] (-V- actions 7 1 T1) executing)
 				([=] (-V- actions 8 1 T1) executing)
 				([=] (-V- actions 9 1 T1) executing)
 				([=] (-V- actions 10 1 T1) executing)
 				([=] (-V- actions 11 1 T1) executing)
 				([=] (-V- actions 12 1 T1) executing)
 				([=] (-V- actions 6 1 T1) exrm)
 				([=] (-V- actions 7 1 T1) exrm)
 				([=] (-V- actions 8 1 T1) exrm)
 				([=] (-V- actions 9 1 T1) exrm)
 				([=] (-V- actions 10 1 T1) exrm)
 				([=] (-V- actions 11 1 T1) exrm)
 				([=] (-V- actions 12 1 T1) exrm)

			)
			([=] (-V- actions 5 1 T1) executing)
		)

 	

	)
)

;;6. robot moves from home to stone/ operator holds the part
(defconstant *Action6T1* 
	(&&


		(<->
	 		([=] (-V- Action_Pre 6 T1) 1)
			(&& 
				; (|| 
				([=] (-V- actions 5 1 T1) executing)
				 ; ([=] (-V- actions 5 1) parallel-executing))

				([=](-V- Body_Part_pos hand) L_1)	

	 		)
	

 		)

 		(<->
 			([=] (-V- Action_Post 6 T1) 1)
 			(&& 

				; ([=](-V- Body_Part_pos hand) L_6)

				; (|| 
				([=] (-V- actions 5 1 T1) executing) 
				; ([=] (-V- actions 5 1) parallel-executing))

				; (-P- partFixed)
				(!! (-P- LINK1_Moving))
				(!! (-P- LINK2_Moving))

	 			([=](-V- End_Eff_B_Position) L_1)

	 		)	
		)
		
	 )
 )

; ;;7.operator prepares a jig
(defun Action7T1(i)
 	(&&
	   

		(<->
	 		; (-P- Action7_Pre) 
	 		([=] (-V- Action_Pre i T1) 1)
	 		; (||
	 			(&& 
	 				
	 				([=] (-V- actions 6 1 T1) done)
	 				([=] (-V- actions (- i 1) 1 T1) done)
	 				; (|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))
	 				([=] (-V- actions 5 1 T1) executing)
					([=](-V- Body_Part_pos hand) L_1)	
					; (-P- partFixed)
					(!! (-P- LINK1_Moving))
					(!! (-P- LINK2_Moving))
		 			([=](-V- End_Eff_B_Position) L_1)
		 		)
		 		
 		)	

 		(<->
 			; (-P- Action7_Post)
 			([=] (-V- Action_Post i T1) 1)
 			(&& 
				([=](-V- Body_Part_pos hand) L_1)	
				; (|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))
				([=] (-V- actions 5 1 T1) executing)
				; (-P- partFixed)
				(!! (-P- LINK1_Moving))
					(!! (-P- LINK2_Moving))
	 			([=](-V- End_Eff_B_Position) L_1)
	 			(-P- preparedJig)
	 			; (!! (-P- NewIteration))


	 		)	
		)



		
		
	 )
	)

; ;; 8. robot moves toward stone/ operator holds the part
(defun Action8T1(i)
 ;   (->
	; (&& ([=] ([%] i 6 ) 2) (!!([=] i (+ (* (- jigs 1) 6) 14))) ([>] i 6))

	(&&
		
		(<->
	 		([=] (-V- Action_Pre i T1) 1)
	 		(&& 
	 			
	 			([=] (-V- actions (- i 1) 1 T1) done)
	 			([=] (-V- actions 5 1 T1) executing)
	 			; (|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))
		 		([=](-V- Body_Part_pos hand) L_1)	
				; (-P- partFixed)
	 			([=](-V- End_Eff_B_Position) L_1)
	 			(-P- preparedjig)
 			)
 		)

 		(<->
 			([=] (-V- Action_Post i T1) 1)
 			(&&
 				([=](-V- Body_Part_pos hand) L_1)	
				; (-P- partFixed)
	 			([=](-V- End_Eff_B_Position) L_1)
	 			([=] (-V- actions 5 1 T1) executing)
	 			;(|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))
	 			; (!! ([=] (-V- actions (+ i 1) executing))
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) L_1)
					)
				)
				; (-P- ScrewDriveReady)
				(-P- preparedjig)
			)
		)
 			
		

		

	 )
   )

; ;;9. robot screws the prepared jig of a part/ operator holds the part
(defun Action9T1(i) 
 ; (->
	; (&& ([=] ([%] i 6 ) 3) ([>] i 6))
	(&&
		(<->
	 		([=] (-V- Action_Pre i T1) 1)
	 		(&& 
	 			(-P- preparedjig)
	 			([=] (-V- actions (- i 1) 1 T1) done)
	 			
	 			([=] (-V- actions 5 1 T1) executing)
	 			;(|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))

	 			([=](-V- Body_Part_pos hand) L_1)	
				; (-P- partFixed)
	 			([=](-V- End_Eff_B_Position) L_1)

	 		
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) L_1)
					)
				)
	 			; (-P- ScrewDriveReady)
 			)

 		)


 		; (<->
 		; 	(-P- ScrewDriveReady)
 		; 	(&& ([=] (-V- actions (- i 1) 1) done) (!!([=] (-V- actions i 1) done)))
 		; 	)

 		

 		(<->
 			([=] (-V- Action_Post i T1) 1)
 			(&&
				([=](-V- Body_Part_pos hand) L_1)	
				; (-P- partFixed)
	 			([=](-V- End_Eff_B_Position) L_1)
	 			([=] (-V- actions 5 1 T1) executing)
	 			;(|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))
	 		
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) L_1)
					)
				)
				
			)
 			
		)

		
	 )
 )

;;10. robot moves backward from the stone/ operator holds the part
(defun Action10T1(i) 
 ; (->
	; (&& ([=] ([%] i 6 ) 4) ([>] i 6))
	(&&
		  
		
		(<->
	 		([=] (-V- Action_Pre i T1) 1)
	 		(&&
	 			([=] (-V- actions (- i 1) 1 T1) done)
	 			([=] (-V- actions 5 1 T1) executing)
	 			;(|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))

				([=](-V- Body_Part_pos hand) L_1)	
				; (-P- partFixed)
	 			([=](-V- End_Eff_B_Position) L_1)
	 		
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) L_1)
					)
				)
			)

 		)

 		(<->
 			([=] (-V- Action_Post i T1) 1)
 			(&&
				([=](-V- Body_Part_pos hand) L_1)	
				([=] (-V- actions 5 1 T1) executing)
				;(|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))
				; (-P- partFixed)
	 			([=](-V- End_Eff_B_Position) L_1)
	 		
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) L_1)
					)
				)
			)
 			
		)

		
		
	)
 )

;;11. robot checks the number of jigs/ operator holds the part
(defun Action11T1(i) 
 ; (->
	; (&& ([=] ([%] i 6 ) 5) ([>] i 6))
	(&&
		(<->
	 		([=] (-V- Action_Pre i T1) 1)
	 		(&&

	 			([=] (-V- actions (- i 1) 1 T1) done)
	 			([=] (-V- actions 5 1 T1) executing)
	 			;(|| ([=] (-V- actions 5 1) executing) ([=] (-V- actions 5 1) parallel-executing))
				([=](-V- Body_Part_pos hand) L_1)	
				; (-P- partFixed)
	 			([=](-V- End_Eff_B_Position) L_1)
	 		
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) L_1)
					)
				)
			)

 		)

 		(<->
 			([=] (-V- Action_Post i T1) 1)
 			(&&
				([=](-V- Body_Part_pos hand) L_1)	
				; (-P- partFixed)
				; ([=] (-V- actions 5 1) executing)
	 			([=](-V- End_Eff_B_Position) L_1)
	 		
	 			(-A- j body_indexes 
					(->  ; no part allowed on pallet except hand
						([!=] j hand)
						([!=](-V- Body_Part_pos j) L_1)
					)
				)
			)
		)

		

		
	 )
)

;12. go back to action7
(defun Action12T1(i)
 ; (->
	; (&& ([=] ([%] i 6 ) 0) ([>] i 6))

	(&&

		(<->

	 		([=] (-V- Action_Pre i T1) 1)

	 			([=] (-V- actions (- i 1) 1 T1) done)
		
 		)



	)
)

; ;;13. else operator releases the part and moves back
(defun ActionBeforeLastT1(i)
	 (&&

		
		(<->

		 		([=] (-V- Action_Pre i T1) 1)
		 		([=] (-V- actions (- i 1) 1 T1) done)

	 		)

 		(<->

 			([=] (-V- Action_Post i T1) 1)
 			(&& 
				
				(!! (-P- partTaken))
				(!! (-P- partHold))
				(-A- i body_indexes 
					  ; no part on pallet
						([!=](-V- Body_Part_pos i) L_1)
					
				)

				
			)	
		)
			

		

 	)
)

; ;;14. robot moves from stone to the home
 (defun ActionLastT1 (i)
	(&&


		(<->
	 		([=] (-V- Action_Pre i T1) 1 )
	 		
	 			([=] (-V- actions (- i 1) 1 T1) done)
		 

 		)


 		(<->
 			([=] (-V- Action_Post i T1) 1)
				(&& 
					; ([=](-V- LINK1_Position) L_1)
 				; 	([=](-V- LINK2) L_2)
 					(!!([=](-V- End_Eff_B_Position) L_1))
				)
			
		)

		
		
 	)
)

