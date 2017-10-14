(defvar RRMnum 6)
	
(defconstant *RRMProperties*
 (alw(&&

	(->(-P- RRM_1)(Next(&&(-P- relativeVelocity_low) (-P- relativeForce_low))))
	; (->(-P- RRM_2)(Next(&&(-P- relativeVelocity_low) (-P- relativeForce_low))))
	; (->(-P- RRM_3)(Next(&&(-P- relativeVelocity_low) (-P- relativeForce_low))))
	; (->(-P- RRM_4)(Next(&&(-P- relativeVelocity_low) (-P- relativeForce_low))))
	; (->(-P- RRM_5)(Next(&&(-P- relativeVelocity_low) (-P- relativeForce_low))))
	; (->(-P- RRM_6)(Next(&&(-P- relativeVelocity_low) (-P- relativeForce_low))))


	;;velocity kept low
	(->(-P- RRM_2) (Next(&&(-P- relativeVelocity_low) (-P- relativeForce_normal))))
	
	;;force kept low
	(->(-P- RRM_3)(Next (-P- relativeForce_low)))

 	;;velocity and force kept medium
	(->(-P- RRM_4)(Next(&& (-P- relativeForce_normal) (|| (-P- relativeVelocity_normal) (-P- relativeVelocity_low) ))))

	;;velocity decrease
	(->(-P- RRM_5)(Next(&& (-P- relativeVelocity_low) (|| (-P- relativeForce_normal) (-P- relativeForce_low)))))

	 ;;force decrease
	 (->(-P- RRM_6)(Next(|| (-P- relativeForce_normal) (-P- relativeForce_low))))

	(<->(-P- no_RRM) (&& (!! (-P- RRM_1)) (!! (-P- RRM_2)) (!! (-P- RRM_3)) (!! (-P- RRM_4)) (!! (-P- RRM_5)) (!! (-P- RRM_6))))
)))
