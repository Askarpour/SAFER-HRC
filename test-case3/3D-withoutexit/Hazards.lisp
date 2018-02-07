;;Hazards
(define-item Risk '(0 1 2))
(defvar hazard_indexes (loop for i from 1 to 28 collect i))

(loop for i in hazard_indexes collect
  (progn 
        (eval `(define-item ,(read-from-string (format nil "Hazard_CI_~A" i)) `(9)))
        (eval `(define-item ,(read-from-string (format nil "Hazard_Se_~A" i)) `(0 1 2 3 4)))
        (eval `(define-item ,(read-from-string (format nil "Hazard_Risk_~A" i)) `(0 1 2)))))

(defun init_hazards (hazard_indexes)
  (eval (append `(&&) (loop for hazard_id in hazard_indexes collect
  `(&&
    (Risk= 0)
    ,(read-from-string (format nil "(Hazard_Se_~A= 1)" hazard_id))
    ,(read-from-string (format nil "(Hazard_Risk_~A= 0)" hazard_id)))))))

(defun hazard_hit ( hazard_id bodypart robotpart  opID other_robotpart_1 other_robotpart_2)
 (eval`(&&
    (<->
        (-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id))) 
        (&&
            (In_same_L ,(read-from-string (format nil "`operator_~A_~A" opID bodypart)) ,(read-from-string (format nil "`~A" robotpart)))
            (|| (-P- ,(read-from-string (format nil "~D_Moving" robotpart))) (-P- ,(read-from-string (format nil "operator_~A_~A_Moving" opID bodypart))))
            (!! (occluded ,(read-from-string (format nil "`~A" robotpart))))
            )))))

(defun hazard_entg (hazard_id bodypart robotpart opId other_robotpart_1 other_robotpart_2)
 (eval
   `(&&
    (<->
        (-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id))) 
        (&& 
             (In_same_L ,(read-from-string (format nil "`operator_~A_~A" opID bodypart)) ,(read-from-string (format nil "`~A" robotpart)))
             (occluded ,(read-from-string (format nil "`~A" robotpart)))
        ))))) 


(defun hazardous_sit()
  (eval (append `(||) (loop for hazard_id in hazard_indexes collect
    `(-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id)))))))

(setq formula1 "(SomF_e (&& (-P- hazardous_sit) (SomF_e (-P- hazardous_sit))))")
(setq formula2 "(SomF_e (&& (-P- hazardous_sit)")
(setq formula3 "(-P- hazardous_sit)")
(setq formula formula1)

(defun min_hazardous_sit(n)
   (cond ((= n 1)(setq formula formula3))
         ((= n 2)(setq formula formula1))
      (t
        (loop for i from 3 to n collect (setq formula (concatenate 'string formula2 formula ")")))
        (loop repeat (- n 1) do (setq formula (concatenate 'string formula  ")")))
      )
   )formula)

(defun hazard_counter(n)
  (&&
    (eval `,(read-from-string (format nil (min_hazardous_sit n))))
    (Alwf(!!(eval `,(read-from-string (format nil (min_hazardous_sit (+ n 1)))))))
)) 

(defconstant *Hazardslist*
 (alwf(&&
    ;;*** hits
    (hazard_hit 1 `head_area `EndEff_1 1 `LINK1_1 `LINK2_1)
    (hazard_hit 2 `chest_area `EndEff_1 1 `LINK1_1 `LINK2_1)
    (hazard_hit 3 `arm_area `EndEff_1 1 `LINK1_1 `LINK2_1)
    ; (hazard_hit 4 `leg_area `EndEff_1 1 `LINK1_1 `LINK2_1)
    (hazard_hit 5 `head_area `LINK1_1 1 `EndEff_1 `LINK2_1)
    (hazard_hit 6 `chest_area `LINK1_1 1 `EndEff_1 `LINK2_1)
    (hazard_hit 7 `arm_area `LINK1_1 1 `EndEff_1 `LINK2_1)
    ; (hazard_hit 8 `leg_area `LINK1_1 1 `EndEff_1 `LINK2_1)
    (hazard_hit 9 `head_area `LINK2_1 1 `LINK1_1 `EndEff_1)
    (hazard_hit 10 `chest_area `LINK2_1 1 `LINK1_1 `EndEff_1)
    (hazard_hit 11 `arm_area `LINK2_1 1 `LINK1_1 `EndEff_1)
    ; (hazard_hit 12 `leg_area `LINK2_1 1 `LINK1_1 `EndEff_1)
    (hazard_hit 13 `head_area `BASE_1 1 `LINK1_1 `LINK2_1)
    (hazard_hit 14 `chest_area `BASE_1 1 `LINK1_1 `LINK2_1)
    (hazard_hit 15 `arm_area `BASE_1 1 `LINK1_1 `LINK2_1)
    (hazard_hit 16 `leg_area `BASE_1 1 `LINK1_1 `LINK2_1)
    
    (hazard_entg 17 `head_area `EndEff_1 1 `LINK1_1 `LINK2_1)
    (hazard_entg 18 `chest_area `EndEff_1 1 `LINK1_1 `LINK2_1)
    (hazard_entg 19 `arm_area `EndEff_1 1 `LINK1_1 `LINK2_1)
    ; (hazard_entg 20 `leg_area `EndEff_1 1 `LINK1_1 `LINK2_1)
    (hazard_entg 21 `head_area `LINK1_1 1 `EndEff_1 `LINK2_1)
    (hazard_entg 22 `chest_area `LINK1_1 1 `EndEff_1 `LINK2_1)
    (hazard_entg 23 `arm_area `LINK1_1 1 `EndEff_1 `LINK2_1)
    ; (hazard_entg 24 `leg_area `LINK1_1 1 `EndEff_1 `LINK2_1)
    (hazard_entg 25 `head_area `LINK2_1 1 `LINK1_1 `EndEff_1)
    (hazard_entg 26 `chest_area `LINK2_1 1 `LINK1_1 `EndEff_1)
    (hazard_entg 27 `arm_area `LINK2_1 1 `LINK1_1 `EndEff_1)
    ; (hazard_entg 28 `leg_area `LINK2_1 1 `LINK1_1 `EndEff_1)

    (<->  (-P- hazardous_sit) (hazardous_sit))
)))
