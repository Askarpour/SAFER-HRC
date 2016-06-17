;;Property one asks for identification of hazards
(defconstant noHazard
	(somf 
		(!! (-E- i hazards-indexes 
			([=] (-V- hazards i 0) 1) 
			)
		)
	)
)


;;Property for identifying new hazards

; (Som 
; 	(-E- i actions-indexes
; 		(&&
; 			([=] (-V- actions i 1) pause)
; 			(||
; 				(-A- x hazards-indexes
; 					([=] (-V- hazards i 0) 0) 
; 				)

; 				(-E- x hazards-indexes
; 					(&&
; 						([=] (-V- hazards x 0) 1) 
; 						(&&
; 							(->
; 								(&& ([>=] x 10) ([<=] x 15))
; 								rrm_full_stop
; 							)
; 							(->
; 								(&& ([>=] x 1) ([<=] x 9))
									
; 							)
; 						)
; 					)
; 				)
; 			)
; 		)

; 	)
; )