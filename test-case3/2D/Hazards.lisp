;;Hazards
(defvar hazard_indexes (loop for i from 1 to 28 collect i))

(loop for i in hazard_indexes collect
  (progn 
        (eval `(define-tvar ,(read-from-string (format nil "Hazard_CI_~A" i)) *int*))
        (eval `(define-tvar ,(read-from-string (format nil "Hazard_Se_~A" i)) *int*))
        (eval `(define-tvar ,(read-from-string (format nil "Hazard_Risk_~A" i)) *int*))))

(defun HazardsInit ()
 (eval (list `alwf (append `(&&) (loop for i in hazard_indexes collect `(&&
    ;;
    ([<=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" i))(loop for x = (read in nil nil) while x collect x)))) 16)
    ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" i))(loop for x = (read in nil nil) while x collect x)))) 1)
    ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" i))(loop for x = (read in nil nil) while x collect x)))) 9) ;temp
    ;;
    ([<=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" i))(loop for x = (read in nil nil) while x collect x)))) 4)
    ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" i))(loop for x = (read in nil nil) while x collect x)))) 1)
    ;;
    ([<=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Risk_~A" i))(loop for x = (read in nil nil) while x collect x)))) 2)
    ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Risk_~A" i))(loop for x = (read in nil nil) while x collect x)))) 0)))))))


(defun hazard_hit ( hazard_id bodypart robotpart  opID other_robotpart_1 other_robotpart_2)
 (eval`(&&
    (<->
        (-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id))) 
        (&&
            (In_same_L ,(read-from-string (format nil "`operator_~A_~A" opID bodypart)) ,(read-from-string (format nil "`~A" robotpart)))
            (|| (-P- ,(read-from-string (format nil "~D_Moving" robotpart))) (-P- ,(read-from-string (format nil "operator_~A_~A_Moving" opID bodypart))))
            ; (!!(-P- occluded))
            (!! (occluded ,(read-from-string (format nil "`~A" robotpart))))
            ; (!!
            ;     (||
            ;         (-P- occluded)
            ;         (In_same_L ,(read-from-string (format nil "`operator_~A_~A" opID bodypart)) ,(read-from-string (format nil "`~A" other_robotpart_1)))
            ;         (In_same_L ,(read-from-string (format nil "`operator_~A_~A" opID bodypart)) ,(read-from-string (format nil "`~A" other_robotpart_2)))
            ;     ))
            )))))

(defun hazard_entg (hazard_id bodypart robotpart opId other_robotpart_1 other_robotpart_2)
 (eval
   `(&&
    (<->
        (-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id))) 
        (&& 
             (In_same_L ,(read-from-string (format nil "`operator_~A_~A" opID bodypart)) ,(read-from-string (format nil "`~A" robotpart)))
             ; (-P- occluded)
             (occluded ,(read-from-string (format nil "`~A" robotpart)))
            ; (||
            ;     (-P- occluded)
                
            ;     (&&
            ;         (In_same_L ,(read-from-string (format nil "`operator_~A_~A" opID bodypart)) ,(read-from-string (format nil "`~A" other_robotpart_1)))
            ;         (-P- ,(read-from-string (format nil "~D_Moving" other_robotpart_1))) 
            ;     )

            ;     (&&
            ;        (In_same_L ,(read-from-string (format nil "`operator_~A_~A" opID bodypart)) ,(read-from-string (format nil "`~A" other_robotpart_2)))
            ;         (-P- ,(read-from-string (format nil "~D_Moving" other_robotpart_2))) 
            ;     )                        
            ; )
            ; (||
            ;     (-P- ,(read-from-string (format nil "~D_Moving" robotpart))) 
            ;     (!! (-P- ,(read-from-string (format nil "OperatorStill_~A" opId))))
            ; )
        ))))) 


(defconstant *Hazards*
 (alwf(&&
    ;;*** hits
    (hazard_hit 1 `head_area `EndEff_1 1 `LINK1_1 `LINK2_1)
    (hazard_hit 2 `chest_area `EndEff_1 1 `LINK1_1 `LINK2_1)
    (hazard_hit 3 `arm_area `EndEff_1 1 `LINK1_1 `LINK2_1)
    (hazard_hit 4 `leg_area `EndEff_1 1 `LINK1_1 `LINK2_1)
    (hazard_hit 5 `head_area `LINK1_1 1 `EndEff_1 `LINK2_1)
    (hazard_hit 6 `chest_area `LINK1_1 1 `EndEff_1 `LINK2_1)
    (hazard_hit 7 `arm_area `LINK1_1 1 `EndEff_1 `LINK2_1)
    (hazard_hit 8 `leg_area `LINK1_1 1 `EndEff_1 `LINK2_1)
    (hazard_hit 9 `head_area `LINK2_1 1 `LINK1_1 `EndEff_1)
    (hazard_hit 10 `chest_area `LINK2_1 1 `LINK1_1 `EndEff_1)
    (hazard_hit 11 `arm_area `LINK2_1 1 `LINK1_1 `EndEff_1)
    (hazard_hit 12 `leg_area `LINK2_1 1 `LINK1_1 `EndEff_1)
    (hazard_hit 13 `head_area `BASE 1 `LINK1_1 `LINK2_1)
    (hazard_hit 14 `chest_area `BASE 1 `LINK1_1 `LINK2_1)
    (hazard_hit 15 `arm_area `BASE 1 `LINK1_1 `LINK2_1)
    (hazard_hit 16 `leg_area `BASE 1 `LINK1_1 `LINK2_1)
    (hazard_entg 17 `head_area `EndEff_1 1 `LINK1_1 `LINK2_1)
    (hazard_entg 18 `chest_area `EndEff_1 1 `LINK1_1 `LINK2_1)
    (hazard_entg 19 `arm_area `EndEff_1 1 `LINK1_1 `LINK2_1)
    (hazard_entg 20 `leg_area `EndEff_1 1 `LINK1_1 `LINK2_1)
    (hazard_entg 21 `head_area `LINK1_1 1 `EndEff_1 `LINK2_1)
    (hazard_entg 22 `chest_area `LINK1_1 1 `EndEff_1 `LINK2_1)
    (hazard_entg 23 `arm_area `LINK1_1 1 `EndEff_1 `LINK2_1)
    (hazard_entg 24 `leg_area `LINK1_1 1 `EndEff_1 `LINK2_1)
    (hazard_entg 25 `head_area `LINK2_1 1 `LINK1_1 `EndEff_1)
    (hazard_entg 26 `chest_area `LINK2_1 1 `LINK1_1 `EndEff_1)
    (hazard_entg 27 `arm_area `LINK2_1 1 `LINK1_1 `EndEff_1)
    (hazard_entg 28 `leg_area `LINK2_1 1 `LINK1_1 `EndEff_1)
)))
