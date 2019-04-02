(defvar RRMnum 4)

(defun RRMProperties (roId opId)
(eval (list `alwf (append `(&&

;;RRM_zone
(-> (-P- RRM_1) 
	;ro cannot be in upper layer
	(&&(forbiden_for_ro_help 1 7) (forbiden_for_ro_help 1 8) (forbiden_for_ro_help 1 9))
)
;;RRM_perim
(-> (-P- RRM_2) 
	(&&
	 (-P- RELATIVESEPARATION_BASE_OPERATOR_1_head_area_VERY_FAR)
	 (-P- RELATIVESEPARATION_LINK1_OPERATOR_1_head_area_VERY_FAR)
	 (-P- RELATIVESEPARATION_LINK2_OPERATOR_1_head_area_VERY_FAR)
	 (-P- RELATIVESEPARATION_ENDEFF_OPERATOR_1_head_area_FAR)

	 (-P- RELATIVESEPARATION_BASE_OPERATOR_1_arm_area_VERY_FAR)
	 (-P- RELATIVESEPARATION_LINK1_OPERATOR_1_arm_area_VERY_FAR)
	 (-P- RELATIVESEPARATION_LINK2_OPERATOR_1_arm_area_VERY_FAR)
	 (-P- RELATIVESEPARATION_ENDEFF_OPERATOR_1_arm_area_FAR)

	 (-P- RELATIVESEPARATION_BASE_OPERATOR_1_CHEST_AREA_VERY_FAR)
	 (-P- RELATIVESEPARATION_LINK1_OPERATOR_1_CHEST_AREA_VERY_FAR)
	 (-P- RELATIVESEPARATION_LINK2_OPERATOR_1_CHEST_AREA_VERY_FAR)
	 (-P- RELATIVESEPARATION_ENDEFF_OPERATOR_1_CHEST_AREA_FAR)

	 (-P- RELATIVESEPARATION_BASE_OPERATOR_1_leg_area_VERY_FAR)
	 (-P- RELATIVESEPARATION_LINK1_OPERATOR_1_leg_area_VERY_FAR)
	 (-P- RELATIVESEPARATION_LINK2_OPERATOR_1_leg_area_VERY_FAR)
	 (-P- RELATIVESEPARATION_ENDEFF_OPERATOR_1_leg_area_FAR)
))
;;RRM_SSM
(-> (-P- RRM_3) (&&
	(-> (-P- RELATIVEVELOCITY_1_1_mid) (&&
		(-P- RELATIVESEPARATION_LINK1_OPERATOR_1_arm_AREA_FAR)
		(-P- RELATIVESEPARATION_LINK2_OPERATOR_1_arm_AREA_FAR)
		(-P- RELATIVESEPARATION_ENDEFF_OPERATOR_1_arm_AREA_FAR)

		(-P- RELATIVESEPARATION_LINK1_OPERATOR_1_head_AREA_FAR)
		(-P- RELATIVESEPARATION_LINK2_OPERATOR_1_head_AREA_FAR)
		(-P- RELATIVESEPARATION_ENDEFF_OPERATOR_1_head_AREA_FAR)

		(-P- RELATIVESEPARATION_LINK1_OPERATOR_1_chest_AREA_FAR)
		(-P- RELATIVESEPARATION_LINK2_OPERATOR_1_chest_AREA_FAR)
		(-P- RELATIVESEPARATION_ENDEFF_OPERATOR_1_chest_AREA_FAR)
	))

	(-> (-P- RELATIVEVELOCITY_1_1_high) (&&
		(-P- RELATIVESEPARATION_LINK1_OPERATOR_1_arm_AREA_VERY_FAR)
		(-P- RELATIVESEPARATION_LINK2_OPERATOR_1_arm_AREA_VERY_FAR)
		(-P- RELATIVESEPARATION_ENDEFF_OPERATOR_1_arm_AREA_VERY_FAR)

		(-P- RELATIVESEPARATION_LINK1_OPERATOR_1_head_AREA_VERY_FAR)
		(-P- RELATIVESEPARATION_LINK2_OPERATOR_1_head_AREA_VERY_FAR)
		(-P- RELATIVESEPARATION_ENDEFF_OPERATOR_1_head_AREA_VERY_FAR)

		(-P- RELATIVESEPARATION_LINK1_OPERATOR_1_chest_AREA_VERY_FAR)
		(-P- RELATIVESEPARATION_LINK2_OPERATOR_1_chest_AREA_VERY_FAR)
		(-P- RELATIVESEPARATION_ENDEFF_OPERATOR_1_chest_AREA_VERY_FAR)
	))

	(->
		(||
			(-P- RELATIVESEPARATION_LINK1_OPERATOR_1_ARM_AREA_CLOS)
			(-P- RELATIVESEPARATION_LINK2_OPERATOR_1_ARM_AREA_CLOS)
			(-P- RELATIVESEPARATION_ENDEFF_OPERATOR_1_ARM_AREA_CLOS)

			(-P- RELATIVESEPARATION_LINK1_OPERATOR_1_HEAD_AREA_CLOS)
			(-P- RELATIVESEPARATION_LINK2_OPERATOR_1_HEAD_AREA_CLOS)
			(-P- RELATIVESEPARATION_ENDEFF_OPERATOR_1_HEAD_AREA_CLOS)

			(-P- RELATIVESEPARATION_LINK1_OPERATOR_1_CHEST_AREA_CLOS)
			(-P- RELATIVESEPARATION_LINK2_OPERATOR_1_CHEST_AREA_CLOS)
			(-P- RELATIVESEPARATION_ENDEFF_OPERATOR_1_CHEST_AREA_CLOS)
		)
   			(-P- hold)
	)
))
;;RRM_PFL
(-> (-P- RRM_4) 
	(->
		(|| (In_same_L `OPERATOR_1_HEAD_AREA `Link1_1)
			(In_same_L `OPERATOR_1_HEAD_AREA `Link2_1)
			(In_same_L `OPERATOR_1_HEAD_AREA `endeff_1)

			(In_same_L `OPERATOR_1_ARM_AREA `Link1_1)
			(In_same_L `OPERATOR_1_ARM_AREA `Link2_1)
			(In_same_L `OPERATOR_1_ARM_AREA `endeff_1)

			(In_same_L `OPERATOR_1_CHEST_AREA `Link1_1)
			(In_same_L `OPERATOR_1_CHEST_AREA `Link2_1)
			(In_same_L `OPERATOR_1_CHEST_AREA `endeff_1) )
		(-P- hold)
	)
)

(alwf
	(<->
		(-P- hold)
		(|| (-P- RRM_4) (-P- RRM_3))
		)
	)
;no RRM
(<->(-P- no_RRM) (&& (!! (-P- RRM_1)) (!! (-P- RRM_2)) (!! (-P- RRM_3))(!! (-P- RRM_4))))

;the final line for parser with spaces! dont change!!
  )))))