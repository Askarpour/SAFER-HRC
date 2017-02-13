 ;;Risk Evaluation


; (-A- i hazards-indexes
; 	(-A- j actions-indexes

; 	(->
; 		([>=] (-V- hazards i 0) 1)  

; 	 	(until RRMij ([<] (-V- hazards i 1) 0)))
; )
; 	)
;;risk <= Threshold means that or there is no hazard or if there is,
;;then its relevant RRM is working 



		(->
			([=] (-V- hazards 1 0) 1)

			(moveback (-V- End_Eff_F_Position) ([=] (-V- hazards 1 0) 1))
			

			; (until_ee rrm_End_Eff_F_Move_Back ([=] (-V- hazards 1 0) 0))
		)

		(->
			([=] (-V- hazards 2 0) 1)
			(moveback (-V- End_Eff_F_Position) ([=] (-V- hazards 2 0) 1))

			; (until_ee rrm_End_Eff_F_Move_Back ([=] (-V- hazards 2 0) 0))
		)
		(->
			([=] (-V- hazards 3 0) 1)
			(moveback (-V- End_Eff_F_Position) ([=] (-V- hazards 3 0) 1))

			; (until_ee rrm_End_Eff_F_Move_Back ([=] (-V- hazards 3 0) 0))
		)
		(->
			([=] (-V- hazards 4 0) 1)
			(moveback (-V- LINK1_Position) ([=] (-V- hazards 4 0) 1))

			; (until_ee rrm_LINK1_Move_Back ([=] (-V- hazards 4 0) 0))
		)

		(->
			([=] (-V- hazards 5 0) 1)
			(moveback (-V- LINK1_Position) ([=] (-V- hazards 5 0) 1))
		)

		(->
			([=] (-V- hazards 6 0) 1)
			(moveback (-V- LINK1_Position) ([=] (-V- hazards 6 0) 1))
		)
		(->
			([=] (-V- hazards 7 0) 1)
			; moveback ((-V- LINK2_Position))
			(moveback (-V- LINK2_Position) ([=] (-V- hazards 7 0) 1))
			; (until_ee rrm_LINK2_Move_Back ([=] (-V- hazards 7 0) 0))
		)

		(->
			([=] (-V- hazards 8 0) 1)
			(moveback (-V- LINK2_Position) ([=] (-V- hazards 8 0) 1))
			; rrm_LINK2_Move_Back
			; (until_ee rrm_LINK2_Move_Back ([=] (-V- hazards 8 0) 0))
		)
		(->
			([=] (-V- hazards 9 0) 1)
			(moveback (-V- LINK2_Position) ([=] (-V- hazards 9 0) 1))
			; rrm_LINK2_Move_Back
			; (until_ee rrm_LINK2_Move_Back ([=] (-V- hazards 9 0) 0))
		)
			(->
			([=] (-V- hazards 10 0) 1)
			(until_ee rrm_full_stop ([=] (-V- hazards 10 0) 0))
		)
		(->
			([=] (-V- hazards 11 0) 1)
			(until_ee rrm_full_stop ([=] (-V- hazards 11 0) 0))
		)
		(->
			([=] (-V- hazards 12 0) 1)
			(until_ee rrm_full_stop ([=] (-V- hazards 12 0) 0))
		)
			(->
			([=] (-V- hazards 13 0) 1)
			(until_ee rrm_full_stop ([=] (-V- hazards 13 0) 0))
		)
		(->
			([=] (-V- hazards 14 0) 1)
			(until_ee rrm_full_stop ([=] (-V- hazards 14 0) 0))
		)
		(->
			([=] (-V- hazards 15 0) 1)
			(until_ee rrm_full_stop ([=] (-V- hazards 15 0) 0))
		)
