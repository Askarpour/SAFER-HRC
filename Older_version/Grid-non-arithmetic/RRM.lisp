


(defconstant rrm_full_stop
	(&&
		(!! (-E- j actions-indexes
<<<<<<< HEAD
		 	 (&&  (actions-subj= j robot) (actions-status= j executing))
=======
		 	 (&&  ([=] (-V- actions j 3) robot) ([=] (-V- actions j 1) executing))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

		 	)
		 	
		)
		(!! (-P- LINK1_Moving))
		(!! (-P- LINK2_Moving))
		(!! (-P- End_Eff_Moving))
	)

)

(defconstant rrm_LINK1_stop
	(&&

		(!! (-P- LINK1_Moving))
		(!! (-E- j actions-indexes
<<<<<<< HEAD
		 	 (&&  (actions-subj= j robot) (actions-status= j executing))
=======
		 	 (&&  ([=] (-V- actions j 3) robot) ([=] (-V- actions j 1) executing))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

		 	)
		 	
		)
		)
		
)

(defconstant rrm_LINK2_stop
	(&&
	
		(!! (-P- LINK2_Moving))
		(!! (-E- j actions-indexes
<<<<<<< HEAD
		 	 (&&  (actions-subj= j robot) (actions-status= j executing))
=======
		 	 (&&  ([=] (-V- actions j 3) robot) ([=] (-V- actions j 1) executing))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

		 	)
		 	
		)
	)

)


(defconstant rrm_End_Eff_stop
	(&&
	
		(!! (-P- End_Eff_Moving))
		(!! (-E- j actions-indexes
<<<<<<< HEAD
		 	 (&&  (actions-subj= j robot) (actions-status= j executing))
=======
		 	 (&&  ([=] (-V- actions j 3) robot) ([=] (-V- actions j 1) executing))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

		 	)
		 	
		)
	)

)

(defconstant rrm_full_Move_Back
	(&&
<<<<<<< HEAD
		(-A- x L_indexes
			(&&
			(<-> (next (LINK1_Position= x)) (yesterday (LINK1_Position= x)))
			(<-> (next (LINK2_Position= x)) (yesterday (LINK2_Position= x)))
			; ([=] (next (-V- LINK2_Position)) (yesterday (-V- LINK2_Position)))
			(<-> (next (End_Eff_F_Position= x)) (yesterday (End_Eff_F_Position= x)))
			; ([=] (next (-V- End_Eff_F_Position)) (yesterday (-V- End_Eff_F_Position)))
		)
			)
		(!! (-E- j actions-indexes
		 	 (&& (actions-subj= j robot) (actions-status= j executing))
=======

		([=] (next (-V- LINK1_Position)) (yesterday (-V- LINK1_Position)))
		([=] (next (-V- LINK2_Position)) (yesterday (-V- LINK2_Position)))
		([=] (next (-V- End_Eff_F_Position)) (yesterday (-V- End_Eff_F_Position)))
		(!! (-E- j actions-indexes
		 	 (&&  ([=] (-V- actions j 3) robot) ([=] (-V- actions j 1) executing))

>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
		 	)
		 	
		)
	)

)

<<<<<<< HEAD
(defconstant rrm_LINK1_Move_Back	
	(&&
	  (-A- x L_indexes
		(<-> (next (LINK1_Position= x)) (yesterday (LINK1_Position= x))))
		(!! (-E- j actions-indexes
		 	 (&& (actions-subj= j robot) (actions-status= j executing))
		 	)
		)
	)	
=======
(defconstant rrm_LINK1_Move_Back
	
	(&&
		([=] (next (-V- LINK1_Position)) (yesterday (-V- LINK1_Position)))
		(!! (-E- j actions-indexes
		 	 (&&  ([=] (-V- actions j 3) robot) ([=] (-V- actions j 1) executing))

		 	)
		 	
		))
		
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
)

(defconstant rrm_LINK2_Move_Back
	(&&
		; ([=] (next (-V- LINK2_Position)) (yesterday (-V- LINK2_Position)))

		(->
<<<<<<< HEAD
			(LINK2_Position= L_3_a) 
			(withinf_ee (LINK2_Position= L_3_b)  3)
		)
		(->
			(LINK2_Position= L_3_b) 
			(withinf_ee (|| (LINK2_Position= L_3_a) (LINK2_Position= L_3_c))  3)
		)
		(->
			(LINK2_Position= L_3_c) 
			(withinf_ee (LINK2_Position= L_3_b)  3)
		)

		(!! 
			(-E- j actions-indexes
		 	 (&&  (actions-subj= j robot) (actions-status= j executing))
=======
			([=] (-V- LINK2_Position) L_3_a) 
			(withinf_ee ([=] (-V- LINK2_Position) L_3_b)  3)
		)
		(->
			([=] (-V- LINK2_Position) L_3_b) 
			(withinf_ee (|| ([=] (-V- LINK2_Position) L_3_a) ([=] (-V- LINK2_Position) L_3_c))  3)
		)
		(->
			([=] (-V- LINK2_Position) L_3_c) 
			(withinf_ee ([=] (-V- LINK2_Position) L_3_b)  3)
		)



		(!! 
			(-E- j actions-indexes
		 	 (&&  ([=] (-V- actions j 3) robot) ([=] (-V- actions j 1) executing))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243

		 	)
		 	
		)
	)	
)

(defconstant rrm_End_Eff_F_Move_Back
	(&&
<<<<<<< HEAD
		(-A- x L_indexes
			(<-> (next (End_Eff_F_Position= x)) (yesterday (End_Eff_F_Position= x))))
			(!! (-E- j actions-indexes
				 (&&  (actions-subj= j robot) (actions-status= j executing))
			 	)
		 	)
		)
	)
=======

		
			([=] (next (-V- End_Eff_F_Position)) (yesterday (-V- End_Eff_F_Position)))
			(!! (-E- j actions-indexes
		 	 (&&  ([=] (-V- actions j 3) robot) ([=] (-V- actions j 1) executing))

		 	)
		 	
		)
	)
)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243


(<->

<<<<<<< HEAD
	(-P- LINK1_Moving)
	(-A- x L_indexes 	
		(<->
			(LINK1_Position= x) 
			(!! (yesterday (LINK1_Position= x)))
		)
	)
=======
	(-P- LINK1_Moving)	
	(!!([=] (-V- LINK1_Position) (yesterday (-V- LINK1_Position))))
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
)

(<->

	(-P- LINK2_Moving)
<<<<<<< HEAD
	(-A- x L_indexes 	
	(<->
	(LINK2_Position= x) 
		(!! (yesterday (LINK2_Position= x)))))
=======
	(!!([=] (-V- LINK2_Position) (yesterday (-V- LINK2_Position))))
	
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
)

(<->

	(-P- End_Eff_Moving)
<<<<<<< HEAD
	(-A- x L_indexes 	
	(<->
	(End_Eff_B_Position= x) 
		(!! (yesterday (End_Eff_B_Position= x)))))
)

	; (!!(End_Eff_B_Position= (yesterday (End_Eff_B_Position))))

		
=======
	(!!([=] (-V- End_Eff_B_Position) (yesterday (-V- End_Eff_B_Position))))

		
)
>>>>>>> 43463f386e0ab475cfc302c93f29b65b85876243
; (defun moveback(x y)
; 	;;x the position variable
; 	;;y hazard id
; 		(->
; 			([=] x L_1) 
; 			(withinf_ee ([=] x L_7)  3)
; 		)
; 		(->
; 			([=] x L_7) 
; 			(withinf_ee ([=] x L_2) 3)
; 		)
; 		(->
; 			([=] x L_2) 
; 			(withinf_ee (|| ([=] x L_3_c) ([=] x L_4_a))  3)
; 		)
; 		(->
; 			([=] x L_3_a) 
; 			(withinf_ee ([=] x L_3_b) 3)
; 		)
; 		(->
; 			([=] x L_3_b) 
; 			(withinf_ee (|| ([=] x L_3_a) ([=] x L_3_c))  3)
; 		)
; 		(->
; 			([=] x L_3_c) 

; 			(withinf_ee ([=] x L_3_b) 3)

; 		)

; 		(->
; 			([=] x L_4_a) 
; 			(withinf_ee (|| ([=] x L_5_b) ([=] x L_4_b))  3)
; 		)
; 		(->
; 			([=] x L_4_b) 
; 			(withinf_ee ([=] x L_4_a) 3)
; 		)
; 		(->
; 			([=] x L_5_a) 
; 			(withinf_ee ([=] x L_5_b) 3)
; 		)
; 		(->
; 			([=] x L_5_b) 
; 			(withinf_ee ([=] x L_4_a) 3)

; 		)
; )
