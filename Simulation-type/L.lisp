; LayOut
;; Layout Parameters
	;Current Positions
		
		(define-tvar roZone *int*)
		(define-tvar opZone *int*)

	;Pallet sharp dges
		
		(define-tvar Pallet_Angle1 *int* *int*)
		(define-tvar Pallet_Angle2 *int* *int*)	
		; (define-tvar Pallet_Angle3 *int* *int*)	
		; (define-tvar Pallet_Angle4 *int* *int*)	
	;Pallet bump points
		
		(define-tvar Pallet_Bump1 *int* *int*)
		(define-tvar Pallet_Bump2 *int* *int*)		

	;Bin Area

		; (defun InBin (z)
		
		; 	(&&

		; 		(->
		; 			([=] z operator)
		; 			((-A- i body-indexes)

		; 					 (&& ([<] (-V- Body_Part i 1) 1500)
		; 					 	 (-V- Body_Part i 1) 1000)
		; 					 	 ([>] (-V- End_Eff_F 1) 0)
		; 					 	 ([<] (-V- End_Eff_F 1) 500)
		; 				 	 )
		; 	 	 )
		; 		(->
		; 			([=] z robot)

		; 					 (&& ([<] (-V- End_Eff_F 0) 1500)
		; 					 	 ([>] (-V- End_Eff_F 0) 1000)
		; 					 	 ([>] (-V- End_Eff_F 1) 0)
		; 					 	 ([<] (-V- End_Eff_F 1) 500)
		; 				 	 )
		; 	 	 )



		;  	)		
	 ; 	 )				


	; ;Home area

	; 	(defun InPallet (x y)

	; 			 (&& ([<] x 1500)
	; 			 	 ([>] x 1000)
	; 			 	 ([>] y 1000)
	; 			 	 ([<] y 1200)
	; 		 	 )
	;  	 )	


	; 	;Pallet area

	; 	(defun  InHome (x y)

	; 			 (&& ([<] x 500)
	; 			 	 ([>] x 0)
	; 			 	 ([>] y 0)
	; 			 	 ([<] y 500)
	; 		 	 )
	;  	 )	
		



;;Presence sensing devices (light curtains, single beam lights, laser scanning devices, pressure sensitive mats)
(defconstant *LayOutSegments*
	
	(&&
		(Alwf (|| ([=] (-V- roZone) 0) ([=] (-V- roZone) 4)))
		(Alwf  (&& ([>=] (-V- opZone) 1) ([<=] (-V- opZone) 4)))
	 )
 )


(defconstant *partStatus*
	
	(Alwf 
		(&&
			(->
				(-P- partTaken)
				(&& 
					
					(withinp_ie ([=] (-V- actions 2 1) done) 2) 
					(since_ei (!! ([=] (-V- actions 12 1) done)) ([=] (-V- actions 2 1) done))
				)
			)

			(->
				(-P- partHold)
				(since_ei (!! ([=] (-V- actions 12 1) done)) ([=] (-V- actions 4 1) done))
			)
		)
	)
)
